/*
Author: Arthur Wang
Create Date: Nov 19

Outer Interface of verilog modules

->  clk: global clock
->  clear: global reset
->  enable: global enable for verilog modules
->  data_in: the only input bus
<-  data_out: the only output bus
<-  y_valid: valid flag for output data
<-  out_count: for every set of inputs, tells the expected number of output
<- out_count_valid: valid flag for out_count

Expected data format for data_interface:
number of operations
expected output length
data

data could be the following:
type 0: idle, not enabled
type 1: operation
type 2: data chunk
type 3: waiting, enabled

*/

module data_interface(
    input clk,
    input clear,
    input [31:0] data_in,
    input enable,
    output wire [31:0] data_out,
    output wire y_valid,
    output reg [31:0] out_count,
    output reg out_count_valid
);

endmodule