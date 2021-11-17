`include "mult.v"
`include "blockmem.v"

/*
Author: Arthur Wang
Creation Date: Nov 14 
Last Modified: Nov 17

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
  chunk[4] = configuration {0, 0, use ReLU, Transpose}
op code == 2:
  chunk[1] = destination page number (to write in serial)
  chunk[2] = write operation
*/

module controller(
  input clk,
  input enable,
  input reset,
  input [31:0] operation,
  input [31:0] in_data
);

  wire [8:0] wsize = 9'b001001111; //TODO
  wire [8:0] xsize = 9'b001001111; //TODO
  
  // decode wire
  wire [3:0] opcode = operation[3:0];
  wire [3:0] op_a = operation[7:4];
  wire [3:0] op_b = operation[11:8];
  wire [3:0] op_c = operation[15:12];
  wire [3:0] op_d = operation[19:16];

  wire transpose = opcode == 1 && op_d[0];
  
  // write enable for register file W
  wire [3:0] wwe = opcode == 2 ? op_a[3] == 1 ? op_b : 0 : opcode == 1 ? op_c[3] == 1 ? 2 : 0 : 0;
  // write enable for register file X
  wire [3:0] xwe = opcode == 2 ? op_a[3] == 0 ? op_b : 0 : opcode == 1 ? op_c[3] == 0 ? 2 : 0 : 0;
  
  // write address for register file W
  wire [1:0] wws = opcode == 1 ? op_c[3] == 1 ? op_c[1:0] : 0 : opcode == 2 ? op_a[3] == 1 ? op_a[1:0] : 0 : 0;
  // write address for register file X
  wire [1:0] wxs = opcode == 1 ? op_c[3] == 0 ? op_c[1:0] : 0 : opcode == 2 ? op_a[3] == 0 ? op_a[1:0] : 0 : 0;
  
  // read address for register file W
  wire [1:0] rws = opcode == 1 ? op_a[3] == 1 ? op_a[1:0] : op_b[3] == 1 ? op_b[1:0] : 0 : 0;
  // read address for register file X
  wire [1:0] rxs = opcode == 1 ? op_a[3] == 0 ? op_a[1:0] : op_b[3] == 1 ? op_b[1:0] : 0 : 0;
  
  


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
  


  // wires connecting memory and multiplier
  wire [31:0] w_in [7:0];
  wire [31:0] x_in [7:0];
  wire [7:0] x_clear_in;
  wire [7:0] w_clear_in;
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
  
  blockmem wrf(clk, enable, reset, en, wwe, in_data, wsize, w_in, w_clear_in, y_out, y_valid, transpose ? x_switch : w_switch, rws, wws);
  blockmem xrf(clk, enable, reset, en, xwe, in_data, xsize, x_in, x_clear_in, y_out, y_valid, transpose ? w_switch : x_switch, rxs, wxs);
  
  m8x8 mult(w_in, x_in, zeros, transpose ? w_clear_in : x_clear_in, enable, clear_out, clk, reset, t2, t3, y_out, clear_out, op_d, b_out);

  // filter out the upper edge of <opcode == 1> and persist only when memory is still shifting data out.
  assign en = opcode == 1 && !old_en || ind_wc > 0 || ind_wl > 0 || ind_xl > 0;
  
  assign w_switch = ind_wc == wsize[5:0];
  assign x_switch = w_switch && ind_wl == wsize[8:6];

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
        ind_wl <= w_switch ? ind_wl == wsize[8:6] ? 0 : ind_wl + 1 : ind_wl; 
        ind_xl <= x_switch ? ind_xl == xsize[8:6] ? 0 : ind_xl + 1 : ind_xl;
      end
      // delay <clear_out> for writing memory in bulk
      y_valid <= clear_out;
      // delay <op_code == 1>
      old_en <= opcode == 1;
    end
  end
  
endmodule