`include "mult.v"
`include "memory.v"
module controller(
  input clk,
  input enable,
  input reset,
  input [31:0] operation,
  input [31:0] in_data
);
  
  // operation [3:0] = mode
  
  // mode 1: perform calculation
  // operation [7:4] = xaddr
  // operation [11:8] = waddr
  // operation [15:9] = yaddr
  // operation [16] = use ReLU
  // operation [17] = store B
  
  // mode 2: write data
  // operation [7:4] = addr
  
  // mode
  // 1: perform calculation
  // 2: write w
  // 3: write x

  //addresses:
  // 0000: X[0]
  // 0001: X[1]
  // 0010: X[2]
  // 0011: X[3]
  // 1000: W[0]
  // 1001: W[1]
  // 1010: W[2]
  // 1011: W[3]

  wire [8:0] wsize = 9'b000011111; //TODO
  wire [8:0] xsize = 9'b001001111; //TODO
  
  wire [3:0] mode = operation[3:0];
  wire [3:0] op_a = operation[7:4];
  wire [3:0] op_b = operation[11:8];
  wire [3:0] op_c = operation[15:12];
  
  wire [3:0] wwe = mode == 2 ? op_a[3] == 1 ? 1 : 0 : 0;
  wire [3:0] xwe = mode == 2 ? op_a[3] == 0 ? 1 : 0 : mode == 1 ? op_c[3] == 0 ? 2 : 0 : 0;
  
  wire [1:0] rws = mode == 1 ? op_b[3] == 0 ? op_b[1:0] : 0 : 0;
  wire [1:0] wws = mode == 2 ? op_a[3] == 1 ? op_a[1:0] : 0 : 0;
  wire [1:0] rxs = mode == 1 ? op_a[3] == 0 ? op_a[1:0] : 0 : 0;
  wire [1:0] wxs = mode == 1 ? op_c[3] == 0 ? op_c[1:0] : 0 : mode == 2 ? op_a[3] == 0 ? op_a[1:0] : 0 : 0;
  
  wire en;
  reg [8:0] ind_w;
  reg [2:0] ind_x;
  
  wire [31:0] w_in [7:0];
  wire [31:0] x_in [7:0];
  wire [7:0] clear_in;
  wire [31:0] y_out [7:0];
  wire [7:0] clear_out;
  reg [7:0] y_valid;
  wire wlr;
  
  // empty wires as placeholder for unused ports
  wire [31:0] t0 [7:0];
  wire [7:0] t1;
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
  
  w_blockmem wmem(clk, enable, reset, en, wwe, in_data, wsize, w_in, wlr, 2'b00, 2'b00);
  x_blockmem xmem(clk, enable, reset, en, xwe, in_data, xsize, x_in, clear_in, y_out, y_valid, wlr, rxs, wxs);
  
  m8x8 mult(w_in, x_in, zeros, clear_in, enable, clear_out, clk, reset, t2, t3, y_out, clear_out);

  reg old_en;
  assign en = mode == 1 && !old_en || ind_w > 0 || ind_x > 0;
  
  
  always @(posedge clk) begin
    if(reset) begin
        ind_w <= 0;
        ind_x <= 0;
      	y_valid <= 0;
      	old_en <= 0;
    end else if(enable) begin
      if(en) begin
        ind_w <= ind_w == wsize[8:0] ? 0 : ind_w + 1;
        ind_x <= ind_w == wsize[8:0] ? ind_x == xsize[8:6] ? 0 : ind_x + 1 : ind_x;
      end
      y_valid <= clear_out;
      old_en <= mode == 1;
    end
  end
  
endmodule