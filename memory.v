/*
Author: Arthur Wang
Creation Date: Nov 14 
Last Modified: Nov 16

TODO:
split <size> into multiple parts, allowing w_blockmem to be merged with x_blockmem
debug and test additive write


this is a memory slice that has 1 input port and 1 output port
basic wires:
->  clk: clock
->  enable: global enable
      This is not read enable or write enable.
      If enable is low, it should do nothing.
->  reset: global reset
      This only resets the states of this memory.
      It does not reset memory content
->  size: size of one reading cycle

Read-related wires:
->  en: read enable
->  raddr: read address
<-  out_data: data output port
<-  out_en: delayed version of <en>, for next memory block to use
<-  out_first: only on the first cycle after all meaningful data are read
      For <clear_out> in matrix mult to clear content after calculation
<-  out_raddr: delayed version of <raddr>

Write-related wires:
->  write_mode: see below for meaning of each wire
->  in_data: data to save to memory
->  waddr: address to write
<-  last_write: signaling the last writing cycle, on DURING the last write
<-  out_waddr: delayed version of <waddr>

Address: The register file has 2048 words. It could be seen as 4x8x64
It means that one register has 4 pages, each page has 8 lines, and each line has 64 elements.

Write Mode:
0: Idle
1: Write data serially. The number of cycle for "1" MUST be a multiple of <size>.
2. Write 8 consecutive value. This is primarily for saving results from the 8x8 mult.
    It MUST be on for only 1 cycle, and then for the rest of the time it MUST be "0".
3. Instead of overwriting, it adds to the memory

*/
module memory(
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
  output reg [4:0] out_raddr,
  output reg [4:0] out_waddr
);
  
  reg [8:0] rind; // counter for read index
  reg [8:0] wind; // counter for write index
  reg [3:0] cont_write; // continuation countdown for Write Mode 2
  reg [31:0] data [2047:0]; // BRAM
  
  wire [10:0] read_index = {raddr, 6'b0} | {2'b0, rind}; // actual read index
  wire [10:0] write_index = {waddr, 6'b0} | {2'b0, wind}; // actual write index

  always @(posedge clk) begin
    if(reset) begin // reset behavior
      rind <= 0;
      wind <= 0;
      out_data <= 0;
      out_en <= 0;
      out_first <= 0;
      last_write <= 0;
      cont_write <= 0;
    end else if(enable) begin
      // increase read counter / write counter / continuation countdown if enabled
      rind <= en ? rind == size ? 0 : rind + 1 : rind;
      wind <= |write_mode || cont_write ? wind == size ? 0 : wind + 1 : wind;
      cont_write <= write_mode == 2 ? 7 : cont_write > 0 ? cont_write - 1 : 0;
      // perform read operation
      out_data <= en ? data[read_index] : 0;
      // perform write operation
      if(write_mode == 1 || write_mode == 2 || cont_write > 0) begin
        data[write_index] <= in_data;
      end else if(write_mode == 3) begin
        data[write_index] <= data[write_index] + in_data;
      end
      // delayed version of inputs
      out_en <= en;
      out_raddr <= raddr;
      out_waddr <= waddr;
      // ending flags. for last_write, use size - 1 because it has extra delay
      out_first <= out_en && rind == 0;
      last_write <= write_mode == 1 && wind == size - 1 || (|cont_write) && wind == size - 1;
    end
  end
  
endmodule