`include "mult.v"
`include "blockmem.v"

/*
Author: Arthur Wang
Creation Date: Nov 14 
Last Modified: Nov 18

TODO: read from memory
TODO: store b_out as output of matrix multiplication
TODO: hadamard product with b_out during matrix multiplication
TODO: additive update as configuration for op-code = 1
TODO: allow non-square and non 2^N size matrix multiplication

->  clk: clock
->  enable: global enable, nothing shall be done if it is low
->  reset: global reset, clears everything except memory
->  operation: operation to be done
->  in_data: input data, for reading matrix only

Page Addresses:
4 bits, highest bits tells which register file to use
  use XRF for low, use WRF for high
rest of it is for page number

Operations: typically segregated by chunk of 4 bits
chunk[0]: op code
op code == 0: idle
op code == 1:
  chunk[1] = x page number (to read)
  chunk[2] = w page number (to read)
  chunk[3] = y page number (to write in bulk)
  chunk[4] = configuration {use ReLU, Transpose}
op code == 2:
  chunk[1] = destination page number (to write in serial)
op code == 3:
  chunk[1] = source page number (to read in serial)

original:
  11 12 13 14
  21 22 23 24
  31 32 33 34
  41 42 43 44

only transpose mult
  11 21 13 23
  12 22 14 24
  31 41 33 43
  32 42 34 44

only transpose switch
  11 12 31 32
  21 22 41 42
  13 14 33 34
  23 24 43 44

both transpose
  11 21 31 41
  12 22 32 42
  13 23 33 43
  14 24 34 44

*/

module controller(
  input clk,
  input enable,
  input reset,
  input [31:0] operation,
  input [31:0] in_data,
  output [31:0] out_data
);

  wire [8:0] size = 9'b001001111; //TODO
  
  // decode wire
  wire [3:0] opcode = operation[3:0];
  wire [3:0] op_a = operation[7:4];
  wire [3:0] op_b = operation[11:8];
  wire [3:0] op_c = operation[15:12];
  wire [3:0] op_d = operation[19:16];

  wire transpose = opcode == 1 && op_d[0];
  
  // write enable for register file
  wire [1:0] we_0 = opcode == 2 ? op_a[3:2] == 0 ? 1 : 0 : opcode == 1 ? op_c[3:2] == 0 ? 2 : 0 : 0;
  wire [1:0] we_1 = opcode == 2 ? op_a[3:2] == 1 ? 1 : 0 : opcode == 1 ? op_c[3:2] == 1 ? 2 : 0 : 0;
  wire [1:0] we_2 = opcode == 2 ? op_a[3:2] == 2 ? 1 : 0 : opcode == 1 ? op_c[3:2] == 2 ? 2 : 0 : 0;
  wire [1:0] we_3 = opcode == 2 ? op_a[3:2] == 3 ? 1 : 0 : opcode == 1 ? op_c[3:2] == 3 ? 2 : 0 : 0;
  
  // read mode 2nd bit for register file
  wire re_0 = opcode == 3 ? op_a[3:2] == 0 ? 1 : 0 : 0;
  wire re_1 = opcode == 3 ? op_a[3:2] == 1 ? 1 : 0 : 0;
  wire re_2 = opcode == 3 ? op_a[3:2] == 2 ? 1 : 0 : 0;
  wire re_3 = opcode == 3 ? op_a[3:2] == 3 ? 1 : 0 : 0;

  // write address for register file
  wire [1:0] wp_0 = opcode == 1 ? op_c[3:2] == 0 ? op_c[1:0] : 0 : opcode == 2 ? op_a[3:2] == 0 ? op_a[1:0] : 0 : 0;
  wire [1:0] wp_1 = opcode == 1 ? op_c[3:2] == 1 ? op_c[1:0] : 0 : opcode == 2 ? op_a[3:2] == 1 ? op_a[1:0] : 0 : 0;
  wire [1:0] wp_2 = opcode == 1 ? op_c[3:2] == 2 ? op_c[1:0] : 0 : opcode == 2 ? op_a[3:2] == 2 ? op_a[1:0] : 0 : 0;
  wire [1:0] wp_3 = opcode == 1 ? op_c[3:2] == 3 ? op_c[1:0] : 0 : opcode == 2 ? op_a[3:2] == 3 ? op_a[1:0] : 0 : 0;

  // read address for register file
  wire [1:0] rp_0 = opcode == 1 ? op_a[3:2] == 0 ? op_a[1:0] : op_b[3:2] == 0 ? op_b[1:0] : 0 : opcode == 3 ? op_a[3:2] == 0 ? op_a[1:0] : 0 : 0;
  wire [1:0] rp_1 = opcode == 1 ? op_a[3:2] == 1 ? op_a[1:0] : op_b[3:2] == 1 ? op_b[1:0] : 0 : opcode == 3 ? op_a[3:2] == 1 ? op_a[1:0] : 0 : 0;
  wire [1:0] rp_2 = opcode == 1 ? op_a[3:2] == 2 ? op_a[1:0] : op_b[3:2] == 2 ? op_b[1:0] : 0 : opcode == 3 ? op_a[3:2] == 2 ? op_a[1:0] : 0 : 0;
  wire [1:0] rp_3 = opcode == 1 ? op_a[3:2] == 3 ? op_a[1:0] : op_b[3:2] == 3 ? op_b[1:0] : 0 : opcode == 3 ? op_a[3:2] == 3 ? op_a[1:0] : 0 : 0;
  
  
  // enable flag for starting matrix multiplier (starting shifting data into multiplier)
  // it should be on only for the duration that is required for memory to shift data
  // so it is configured in such way that it is off BEFORE <opcode == 1> goes off
  wire en;
  // delayed flag ofr <op_code == 1>, so that we can know the upper edge
  reg old_en;
  // cell index for W matrix, incremented every cycle
  reg [8:0] ind_wc;
  // line index for W matrix, incremented only after <ind_wc> completes 1 cycle
  reg [2:0] ind_wl;
  // line index for X matrix, incremented only after <ind_wl> completes 1 cycle
  reg [2:0] ind_xl;
  
  wire [31:0] out_data_0;
  wire [31:0] out_data_1;
  wire [31:0] out_data_2;
  wire [31:0] out_data_3;
  wire [31:0] chunk_read_0 [7:0];
  wire [31:0] chunk_read_1 [7:0];
  wire [31:0] chunk_read_2 [7:0];
  wire [31:0] chunk_read_3 [7:0];
  wire [7:0] clear_in_0;
  wire [7:0] clear_in_1;
  wire [7:0] clear_in_2;
  wire [7:0] clear_in_3;
  wire switch_0;
  wire switch_1;
  wire switch_2;
  wire switch_3;

  // wires connecting memory and multiplier
  wire [31:0] w_in [7:0];
  wire [31:0] x_in [7:0];
  wire [7:0] clear_in;
  wire [31:0] y_out [7:0];
  wire [7:0] clear_out;
  wire [7:0] b_out;

  // output valid flag is 1 cycle delay of clear_out
  reg [7:0] y_valid;
  
  wire w_switch, x_switch;
  
  // empty wires as placeholder for unused ports
  wire [7:0] t0;
  wire [31:0] t2 [7:0];
  wire [31:0] t3 [7:0];
  wire [31:0] zeros [7:0];
  assign zeros[0] = 0;
  assign zeros[1] = 0;
  assign zeros[2] = 0;
  assign zeros[3] = 0;
  assign zeros[4] = 0;
  assign zeros[5] = 0;
  assign zeros[6] = 0;
  assign zeros[7] = 0;
  
  blockmem rf_0(clk, enable, reset, {re_0, en}, we_0, in_data, size, chunk_read_0, clear_in_0, y_out, y_valid, switch_0, rp_0, wp_0, out_data_0);
  blockmem rf_1(clk, enable, reset, {re_1, en}, we_1, in_data, size, chunk_read_1, clear_in_1, y_out, y_valid, switch_1, rp_1, wp_1, out_data_1);
  blockmem rf_2(clk, enable, reset, {re_2, en}, we_2, in_data, size, chunk_read_2, clear_in_2, y_out, y_valid, switch_2, rp_2, wp_2, out_data_2);
  blockmem rf_3(clk, enable, reset, {re_3, en}, we_3, in_data, size, chunk_read_3, clear_in_3, y_out, y_valid, switch_3, rp_3, wp_3, out_data_3);
  
  m8x8 mult(w_in, x_in, zeros, transpose ? clear_in_1 : clear_in_0, enable, clear_out, clk, reset, t2, t3, y_out, clear_out, op_d, b_out);

  assign out_data = opcode == 3 ? op_a[3] == 0 ? out_data_0 : op_a[3] == 1 ? out_data_1 : 0 : 0;

  // filter out the upper edge of <opcode == 1> and persist only when memory is still shifting data out.
  assign en = opcode == 1 && !old_en || ind_wc > 0 || ind_wl > 0 || ind_xl > 0;
  
  assign w_switch = ind_wc == size[5:0];
  assign x_switch = w_switch && ind_wl == size[8:6];

  always @(posedge clk) begin
    if(reset) begin // reset behavior: clear all registers
        ind_wc <= 0;
        ind_wl <= 0;
        ind_xl <= 0;
      	y_valid <= 0;
      	old_en <= 0;
    end else if(enable) begin
      if(en) begin
        // count the duration for memory to shift data out
        ind_wc <= w_switch ? 0 : ind_wc + 1;
        ind_wl <= w_switch ? ind_wl == size[8:6] ? 0 : ind_wl + 1 : ind_wl; 
        ind_xl <= x_switch ? ind_xl == size[8:6] ? 0 : ind_xl + 1 : ind_xl;
      end
      // delay <clear_out> for writing memory in bulk
      y_valid <= clear_out;
      // delay <op_code == 1>
      old_en <= opcode == 1;
    end
  end
  
endmodule