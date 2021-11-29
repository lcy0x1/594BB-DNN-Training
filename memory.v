/*
Author: Arthur Wang
Creation Date: Nov 14 
Last Modified: Nov 18

this is a memory slice that has 1 input port and 1 output port
basic wires:
->  clk: clock
->  enable: global enable
      This is not read enable or write enable.
      If enable is low, it should do nothing.
->  reset: global reset
      This only resets the states of this memory.
      It does not reset memory content
->  size: length of one line

Read-related wires:
->  read_mode: read mode, see below
->  read_page_line: read address
<-  out_data: data output port
<-  next_read_mode: <read_mode> for next memory block to use
<-  read_finish: only on the first cycle after all meaningful data are read
      For <clear_out> in matrix mult to clear content after calculation
      Only in read mode 1
<-  last_read: last cycle of read of current line
      Only in read mode 2
<-  next_read_page_line: <read_page_line> for next memory block to use

Write-related wires:
->  write_mode: see below for meaning of each wire
->  in_data: data to save to memory
->  write_page_line: address to write
<-  last_write: signaling the last writing cycle, on DURING the last write
<-  next_write_page_line: <write_page_line>, delayed if in mode 2

Address: The register file has 2048 words. It could be seen as 4x8x64
It means that one register has 4 pages, each page has 8 lines, and each line has 64 elements.
page address: 2 bits
line address: 3 bits
cell address: 6 bits
read_index/write_index: {page address, line address, cell address}, 11 bits in total
read_page_line/write_page_line: {page address, line address}, 5 bits in total
read_cell/write_cell: {cell address}, 6 bits in total


Write Mode:
0: Idle
1: Write data serially. The number of cycle for "1" MUST be a multiple of <size>.
2. Write 8 consecutive value. This is primarily for saving results from the 8x8 mult.
    It MUST be on for only 1 cycle, and then for the rest of the time it MUST be "0".
3. Instead of overwriting, it adds to the memory

Read Mode:
0: Idle
1: Read data in bulk
2: Read data serially

*/
module memory(
  input clk,
  input enable,
  input reset,
  input [1:0] write_mode,
  input [1:0] read_mode,
  input [31:0] in_data,
  input [5:0] size,
  input [4:0] read_page_line,
  input [4:0] write_page_line,
  output reg [31:0] out_data,
  output [1:0] next_read_mode,
  output reg read_finish,
  output reg last_write,
  output reg last_read,
  output [4:0] next_read_page_line,
  output [4:0] next_write_page_line
);

  reg [5:0] read_cell; // counter for read index
  reg [5:0] write_cell; // counter for write index
  reg [3:0] cont_write; // continuation countdown for Write Mode 2
  reg [4:0] delay_write_page_line; // delayed version of write_page_line
  reg [4:0] delay_read_page_line; // delayed version of read_page_line
  reg delay_bulk_we;
  (* ram_style = "block" *) reg [31:0] data [2047:0]; // BRAM
  reg delay_read_mode;
  
  wire [10:0] read_index = {read_page_line, read_cell}; // actual read index
  wire [10:0] write_index = {write_page_line, write_cell}; // actual write index

  assign next_write_page_line = delay_bulk_we ? delay_write_page_line : write_page_line;
  assign next_read_page_line = read_mode == 2 ? read_page_line : delay_read_page_line;
  assign next_read_mode = read_mode == 2 ? 2 : delay_read_mode ? 1 : 0;

  wire bulk_we = write_mode == 2 || cont_write > 0;

  always @(posedge clk) begin
    if(reset) begin // reset behavior
      out_data <= 0;
      read_finish <= 0;
      last_write <= 0;
      last_read <= 0;
      delay_read_page_line <= 0;
      delay_write_page_line <= 0;
      read_cell <= 0;
      write_cell <= 0;
      cont_write <= 0;
      delay_read_mode <= 0;
    end else if(enable) begin
      // increase read counter / write counter / continuation countdown if enabled
      read_cell <= read_mode > 0 ? read_cell == size ? 0 : read_cell + 1 : read_cell;
      write_cell <= write_mode > 0 || cont_write > 0 ? write_cell == size ? 0 : write_cell + 1 : write_cell;
      cont_write <= write_mode == 2 ? 7 : cont_write > 0 ? cont_write - 1 : 0;
      // perform read operation
      out_data <= read_mode > 0 ? data[read_index] : 0;
      // perform write operation
      if(write_mode == 1 || bulk_we) begin
        data[write_index] <= in_data;
      end else if(write_mode == 3) begin
        data[write_index] <= data[write_index] + in_data;
      end
      // delayed version of inputs
      delay_read_mode <= read_mode[0];
      delay_read_page_line <= read_page_line;
      delay_write_page_line <= bulk_we ? write_page_line : 0;
      delay_bulk_we <= bulk_we;
      // ending flags. for last_write, use size - 1 because it has extra delay
      read_finish <= delay_read_mode && read_cell == 0;
      last_write <= write_mode == 1 && write_cell == size - 1 || bulk_we && write_cell == size - 1;
      last_read <= read_mode == 2 && read_cell == size - 1;
    end
  end
  
endmodule