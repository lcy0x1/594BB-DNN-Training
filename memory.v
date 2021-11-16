module x_memory(
  input clk,
  input enable,
  input reset,
  input [3:0] write_mode,
  input en,
  input [31:0] in_data,
  input [8:0] size,
  input [4:0] raddr,
  input [4:0] waddr,
  output reg [31:0] out_data,
  output reg out_en,
  output reg out_first,
  output reg last_write,
  output reg last_read,
  output reg [4:0] out_raddr,
  output reg [4:0] out_waddr
);
  
  // write mode:
  // 0: idle
  // 1: write data serially
  // 2: write 8 consecutive value
  // 3: additive write
  
  reg [8:0] rind;
  reg [8:0] wind;
  reg [3:0] cont_write;
  reg [31:0] data [2047:0];
  
  wire [10:0] read_index = {raddr, 6'b0} | {2'b0, rind};
  wire [10:0] write_index = {waddr, 6'b0} | {2'b0, wind};

  always @(posedge clk) begin
    if(reset) begin
      rind <= 0;
      wind <= 0;
      out_data <= 0;
      out_en <= 0;
      out_first <= 0;
      last_write <= 0;
      last_read <= 0;
      cont_write <= 0;
    end else if(enable) begin
      rind <= en ? rind == size ? 0 : rind + 1 : rind;
      wind <= |write_mode || cont_write ? wind == size ? 0 : wind + 1 : wind;
      out_data <= en ? data[read_index] : 0;
      cont_write <= write_mode == 2 ? 7 : cont_write > 0 ? cont_write - 1 : 0;

      if(write_mode == 1 || write_mode == 2 || cont_write > 0) begin
        data[write_index] <= in_data;
      end else if(write_mode == 3) begin
        data[write_index] <= data[write_index] + in_data;
      end
      out_en <= en;
      out_first <= out_en && rind == 0;
      last_write <= write_mode == 1 && wind == size - 1 || (|cont_write) && wind == size - 1;
      last_read <= en && (rind == size - 1);
      out_raddr <= raddr;
      out_waddr <= waddr;
    end
  end
  
endmodule


module w_blockmem(
  input clk,
  input enable,
  input reset,
  input en,
  input [3:0] mode,
  input [31:0] in_data,
  input [8:0] size,
  output [31:0] w_out [7:0],
  output lr,
  input [1:0] raddr,
  input [1:0] waddr
);
  
  // mode:
  // 0: idle
  // 1: write data serially
  
  wire [7:0] mem_en;
  wire [7:0] lw;

  reg [8:0] ind;
  
  wire [7:0] t0;
  wire [7:0] t1;
  wire [4:0] t2 [7:0];
  wire [4:0] t3 [7:0];

  wire [4:0] mraddr = {raddr, 3'b0};
  wire [4:0] mwaddr = {waddr, 3'b0};

  x_memory wmem0(clk, enable, reset, mode == 1 && ind == 0 ? 4'b1 : 4'b0, en,        in_data, size, mraddr, mwaddr, w_out[0], mem_en[0], t1[0], lw[0], lr   , t2[0], t3[0]);
  x_memory wmem1(clk, enable, reset, mode == 1 && ind == 1 ? 4'b1 : 4'b0, mem_en[0], in_data, size, mraddr, mwaddr, w_out[1], mem_en[1], t1[1], lw[1], t0[1], t2[1], t3[1]);
  x_memory wmem2(clk, enable, reset, mode == 1 && ind == 2 ? 4'b1 : 4'b0, mem_en[1], in_data, size, mraddr, mwaddr, w_out[2], mem_en[2], t1[2], lw[2], t0[2], t2[2], t3[2]);
  x_memory wmem3(clk, enable, reset, mode == 1 && ind == 3 ? 4'b1 : 4'b0, mem_en[2], in_data, size, mraddr, mwaddr, w_out[3], mem_en[3], t1[3], lw[3], t0[3], t2[3], t3[3]);
  x_memory wmem4(clk, enable, reset, mode == 1 && ind == 4 ? 4'b1 : 4'b0, mem_en[3], in_data, size, mraddr, mwaddr, w_out[4], mem_en[4], t1[4], lw[4], t0[4], t2[4], t3[4]);
  x_memory wmem5(clk, enable, reset, mode == 1 && ind == 5 ? 4'b1 : 4'b0, mem_en[4], in_data, size, mraddr, mwaddr, w_out[5], mem_en[5], t1[5], lw[5], t0[5], t2[5], t3[5]);
  x_memory wmem6(clk, enable, reset, mode == 1 && ind == 6 ? 4'b1 : 4'b0, mem_en[5], in_data, size, mraddr, mwaddr, w_out[6], mem_en[6], t1[6], lw[6], t0[6], t2[6], t3[6]);
  x_memory wmem7(clk, enable, reset, mode == 1 && ind == 7 ? 4'b1 : 4'b0, mem_en[6], in_data, size, mraddr, mwaddr, w_out[7], mem_en[7], t1[7], lw[7], t0[7], t2[7], t3[7]);
  
  always @(posedge clk) begin
    if(reset) begin
        ind <= 0;
    end else if(enable) begin
      ind <= |lw ? ind == 7 ? 0 : ind + 1 : ind;
    end
  end
    
endmodule


module x_blockmem(
  input clk,
  input enable,
  input reset,
  input en,
  input [3:0] write_mode,
  input [31:0] in_data,
  input [8:0] size,
  output [31:0] x_out [7:0],
  output [7:0] clear_out,
  input [31:0] chunk_in [7:0],
  input [7:0] chunk_valid,
  input wlr,
  input [1:0] sraddr,
  input [1:0] swaddr
);

  // write mode:
  // 0: idle
  // 1: serial in
  // 2: bulk in
  
  // read related variables
  wire [7:0] mem_en; // read enable, on once, effective for <size> clocks
  wire [7:0] lr;
  reg [2:0] raddr; // address to read
  wire [4:0] mid_raddr [7:0]; // cached raddr

  // write related variables
  wire [7:0] lw; // flags for last write, for updating {ind}
  reg [8:0] ind; // index of currently active write
  reg [2:0] waddr; // address to write
  wire [4:0] mid_waddr [7:0]; // cached waddr

  x_memory xmem0(clk, enable, reset, write_mode == 2 && chunk_valid[0] ? 4'b10 : write_mode == 1 && ind == 0 ? 4'b1 : 4'b00, en,        write_mode == 2 ? chunk_in[0] : in_data, {3'b0, size[5:0]}, {sraddr, raddr}, {swaddr, waddr}, x_out[0], mem_en[0], clear_out[0], lw[0], lr[0], mid_raddr[0], mid_waddr[0]);
  x_memory xmem1(clk, enable, reset, write_mode == 2 && chunk_valid[1] ? 4'b10 : write_mode == 1 && ind == 1 ? 4'b1 : 4'b00, mem_en[0], write_mode == 2 ? chunk_in[1] : in_data, {3'b0, size[5:0]}, mid_raddr[0],    mid_waddr[0],    x_out[1], mem_en[1], clear_out[1], lw[1], lr[1], mid_raddr[1], mid_waddr[1]);
  x_memory xmem2(clk, enable, reset, write_mode == 2 && chunk_valid[2] ? 4'b10 : write_mode == 1 && ind == 2 ? 4'b1 : 4'b00, mem_en[1], write_mode == 2 ? chunk_in[2] : in_data, {3'b0, size[5:0]}, mid_raddr[1],    mid_waddr[1],    x_out[2], mem_en[2], clear_out[2], lw[2], lr[2], mid_raddr[2], mid_waddr[2]);
  x_memory xmem3(clk, enable, reset, write_mode == 2 && chunk_valid[3] ? 4'b10 : write_mode == 1 && ind == 3 ? 4'b1 : 4'b00, mem_en[2], write_mode == 2 ? chunk_in[3] : in_data, {3'b0, size[5:0]}, mid_raddr[2],    mid_waddr[2],    x_out[3], mem_en[3], clear_out[3], lw[3], lr[3], mid_raddr[3], mid_waddr[3]);
  x_memory xmem4(clk, enable, reset, write_mode == 2 && chunk_valid[4] ? 4'b10 : write_mode == 1 && ind == 4 ? 4'b1 : 4'b00, mem_en[3], write_mode == 2 ? chunk_in[4] : in_data, {3'b0, size[5:0]}, mid_raddr[3],    mid_waddr[3],    x_out[4], mem_en[4], clear_out[4], lw[4], lr[4], mid_raddr[4], mid_waddr[4]);
  x_memory xmem5(clk, enable, reset, write_mode == 2 && chunk_valid[5] ? 4'b10 : write_mode == 1 && ind == 5 ? 4'b1 : 4'b00, mem_en[4], write_mode == 2 ? chunk_in[5] : in_data, {3'b0, size[5:0]}, mid_raddr[4],    mid_waddr[4],    x_out[5], mem_en[5], clear_out[5], lw[5], lr[5], mid_raddr[5], mid_waddr[5]);
  x_memory xmem6(clk, enable, reset, write_mode == 2 && chunk_valid[6] ? 4'b10 : write_mode == 1 && ind == 6 ? 4'b1 : 4'b00, mem_en[5], write_mode == 2 ? chunk_in[6] : in_data, {3'b0, size[5:0]}, mid_raddr[5],    mid_waddr[5],    x_out[6], mem_en[6], clear_out[6], lw[6], lr[6], mid_raddr[6], mid_waddr[6]);
  x_memory xmem7(clk, enable, reset, write_mode == 2 && chunk_valid[7] ? 4'b10 : write_mode == 1 && ind == 7 ? 4'b1 : 4'b00, mem_en[6], write_mode == 2 ? chunk_in[7] : in_data, {3'b0, size[5:0]}, mid_raddr[6],    mid_waddr[6],    x_out[7], mem_en[7], clear_out[7], lw[7], lr[7], mid_raddr[7], mid_waddr[7]);
  
  always @(posedge clk) begin
    if(reset) begin
        ind <= 0;
        raddr <= 0;
        waddr <= 0;
    end else if(enable) begin
      if(write_mode == 1) begin
      	ind <= |lw ? ind == 7 ? 0 : ind + 1 : ind;
        waddr <= lw[7] ? waddr == size[8:6] ? 0 : waddr + 1 : waddr;
      end else begin 
        waddr <= lw[0] ? waddr == size[8:6] ? 0 : waddr + 1 : waddr;
      end
      raddr <= wlr ? raddr == size[8:6] ? 0 : raddr + 1 : raddr;
    end
  end
    
  
endmodule