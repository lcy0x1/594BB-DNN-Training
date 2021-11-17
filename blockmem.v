`include "memory.v"

/*
Author: Arthur Wang
Creation Date: Nov 14 
Last Modified: Nov 16

TODO: merge w_blockmem and x_blockmem

basic wires:
->  clk: clock
->  enable: global enable. If it is low, nothing should be done
->  reset: global reset
      It only reset states. It does not clear memory 
->  size: size of data

Read related flags:
->  en: read enable starter signal. It should only be on for 1 cycle
->  page_read: page address to read
->  switch: signal to switch line
<-  x_out: output bus
<-  clear_out: For matrix multiplier unit. 
      It is on one cycle after the last data on the respective line

Write related flags:
->  write_mode: see below
->  in_data: input port for serial write mode
->  bus_in: input port for bulk write mode
->  bus_valid: input valid port for bulk write mode
->  page_write: page address to write

Write Mode:
0: idle
1: serial write, one data at a time. The size of input MUST match <size>
    Implementation: The <x_memory> block will iterate through every cell on a line.
    When the last value is written, one of the <lw> flags will be on and <ind> will increment
    so that it will write to the next slice. After the last slice is written,
    the <lw[7]> flag will be on and the <waddr> will increase, so that is is writing the next line
    of each slices. Basically for(line) for(slice) for(cell)
2: bulk write, 8 data at a time. 
    It should be on for the entire duration of write.
    To be safe, it should be on before operation occurs and off after all operation ceases.
    <bus_valid> signal is on for only 1 cycle at a time, signaling the beginning of 8 data.
    It should not be on for the entire duration of 8 valid data.

Addressing:
size[5:0] tells the number of data per line
size[8:6] tells the number of line per page
page_read and page_write tells the page address of read and write operation

*/
module w_blockmem(
  input clk,
  input enable,
  input reset,
  input en,
  input [3:0] mode,
  input [31:0] in_data,
  input [8:0] size,
  output [31:0] w_out [7:0],
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

  x_memory wmem0(clk, enable, reset, mode == 1 && ind == 0 ? 4'b1 : 4'b0, en,        in_data, size, mraddr, mwaddr, w_out[0], mem_en[0], t1[0], lw[0], t2[0], t3[0]);
  x_memory wmem1(clk, enable, reset, mode == 1 && ind == 1 ? 4'b1 : 4'b0, mem_en[0], in_data, size, mraddr, mwaddr, w_out[1], mem_en[1], t1[1], lw[1], t2[1], t3[1]);
  x_memory wmem2(clk, enable, reset, mode == 1 && ind == 2 ? 4'b1 : 4'b0, mem_en[1], in_data, size, mraddr, mwaddr, w_out[2], mem_en[2], t1[2], lw[2], t2[2], t3[2]);
  x_memory wmem3(clk, enable, reset, mode == 1 && ind == 3 ? 4'b1 : 4'b0, mem_en[2], in_data, size, mraddr, mwaddr, w_out[3], mem_en[3], t1[3], lw[3], t2[3], t3[3]);
  x_memory wmem4(clk, enable, reset, mode == 1 && ind == 4 ? 4'b1 : 4'b0, mem_en[3], in_data, size, mraddr, mwaddr, w_out[4], mem_en[4], t1[4], lw[4], t2[4], t3[4]);
  x_memory wmem5(clk, enable, reset, mode == 1 && ind == 5 ? 4'b1 : 4'b0, mem_en[4], in_data, size, mraddr, mwaddr, w_out[5], mem_en[5], t1[5], lw[5], t2[5], t3[5]);
  x_memory wmem6(clk, enable, reset, mode == 1 && ind == 6 ? 4'b1 : 4'b0, mem_en[5], in_data, size, mraddr, mwaddr, w_out[6], mem_en[6], t1[6], lw[6], t2[6], t3[6]);
  x_memory wmem7(clk, enable, reset, mode == 1 && ind == 7 ? 4'b1 : 4'b0, mem_en[6], in_data, size, mraddr, mwaddr, w_out[7], mem_en[7], t1[7], lw[7], t2[7], t3[7]);
  
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
  input [31:0] bus_in [7:0],
  input [7:0] bus_valid,
  input switch,
  input [1:0] page_read,
  input [1:0] page_write
);

  // read related variables
  wire [7:0] mem_en; // read enable, on once, effective for <size> clocks
  reg [2:0] raddr; // address of line to read
  wire [4:0] mid_raddr [7:0]; // cached read address

  // write related variables
  wire [7:0] lw; // flags for last write, for updating <ind>
  reg [2:0] ind; // index of currently active writing slice. Only for Write Mode 1
  reg [2:0] waddr; // address of line to write
  wire [4:0] mid_waddr [7:0]; // cached waddr

  x_memory xmem0(clk, enable, reset, write_mode == 2 && bus_valid[0] ? 4'b10 : write_mode == 1 && ind == 0 ? 4'b1 : 4'b00, en,        write_mode == 2 ? bus_in[0] : in_data, {3'b0, size[5:0]}, {page_read, raddr}, {page_write, waddr}, x_out[0], mem_en[0], clear_out[0], lw[0], mid_raddr[0], mid_waddr[0]);
  x_memory xmem1(clk, enable, reset, write_mode == 2 && bus_valid[1] ? 4'b10 : write_mode == 1 && ind == 1 ? 4'b1 : 4'b00, mem_en[0], write_mode == 2 ? bus_in[1] : in_data, {3'b0, size[5:0]}, mid_raddr[0],       mid_waddr[0],        x_out[1], mem_en[1], clear_out[1], lw[1], mid_raddr[1], mid_waddr[1]);
  x_memory xmem2(clk, enable, reset, write_mode == 2 && bus_valid[2] ? 4'b10 : write_mode == 1 && ind == 2 ? 4'b1 : 4'b00, mem_en[1], write_mode == 2 ? bus_in[2] : in_data, {3'b0, size[5:0]}, mid_raddr[1],       mid_waddr[1],        x_out[2], mem_en[2], clear_out[2], lw[2], mid_raddr[2], mid_waddr[2]);
  x_memory xmem3(clk, enable, reset, write_mode == 2 && bus_valid[3] ? 4'b10 : write_mode == 1 && ind == 3 ? 4'b1 : 4'b00, mem_en[2], write_mode == 2 ? bus_in[3] : in_data, {3'b0, size[5:0]}, mid_raddr[2],       mid_waddr[2],        x_out[3], mem_en[3], clear_out[3], lw[3], mid_raddr[3], mid_waddr[3]);
  x_memory xmem4(clk, enable, reset, write_mode == 2 && bus_valid[4] ? 4'b10 : write_mode == 1 && ind == 4 ? 4'b1 : 4'b00, mem_en[3], write_mode == 2 ? bus_in[4] : in_data, {3'b0, size[5:0]}, mid_raddr[3],       mid_waddr[3],        x_out[4], mem_en[4], clear_out[4], lw[4], mid_raddr[4], mid_waddr[4]);
  x_memory xmem5(clk, enable, reset, write_mode == 2 && bus_valid[5] ? 4'b10 : write_mode == 1 && ind == 5 ? 4'b1 : 4'b00, mem_en[4], write_mode == 2 ? bus_in[5] : in_data, {3'b0, size[5:0]}, mid_raddr[4],       mid_waddr[4],        x_out[5], mem_en[5], clear_out[5], lw[5], mid_raddr[5], mid_waddr[5]);
  x_memory xmem6(clk, enable, reset, write_mode == 2 && bus_valid[6] ? 4'b10 : write_mode == 1 && ind == 6 ? 4'b1 : 4'b00, mem_en[5], write_mode == 2 ? bus_in[6] : in_data, {3'b0, size[5:0]}, mid_raddr[5],       mid_waddr[5],        x_out[6], mem_en[6], clear_out[6], lw[6], mid_raddr[6], mid_waddr[6]);
  x_memory xmem7(clk, enable, reset, write_mode == 2 && bus_valid[7] ? 4'b10 : write_mode == 1 && ind == 7 ? 4'b1 : 4'b00, mem_en[6], write_mode == 2 ? bus_in[7] : in_data, {3'b0, size[5:0]}, mid_raddr[6],       mid_waddr[6],        x_out[7], mem_en[7], clear_out[7], lw[7], mid_raddr[7], mid_waddr[7]);
  
  always @(posedge clk) begin
    if(reset) begin // reset behaior: clear al registers
        ind <= 0;
        raddr <= 0;
        waddr <= 0;
    end else if(enable) begin
      // the waddr update logic is different in write mode 1 and write mode 2
      if(write_mode == 1) begin
        // increase slice index <ind> on finishing a line on current slice
      	ind <= |lw ? ind == 7 ? 0 : ind + 1 : ind;
        // increase line index <waddr> on finishing a line on all slices
        waddr <= lw[7] ? waddr == size[8:6] ? 0 : waddr + 1 : waddr;
      end else begin 
        // increase the line index <waddr> on finishing a line, all slices are written together
        waddr <= lw[0] ? waddr == size[8:6] ? 0 : waddr + 1 : waddr;
      end

      // read address increment by 1 when <switch> is on
      raddr <= switch ? raddr == size[8:6] ? 0 : raddr + 1 : raddr;
    end
  end
    
endmodule