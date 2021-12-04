`include "control.v"
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

*/

module data_interface(
    input clk,
    input clear,
    input [31:0] data_in,
    input enable,
    output reg [31:0] data_out,
    output reg y_valid,
    output reg [31:0] out_count,
    output reg out_count_valid,
    output reg ready
);

  reg [31:0] counter;
  reg [31:0] operation;
  reg [31:0] data;

  wire [31:0] out_data;

  controller main(clk, clear, enable, operation, data, out_data);

  always @(posedge clk) begin
    if(clear) begin
      counter <= 0;
      operation <= 0;
      data <= 0;
      ready <= 1;
    end else if(enable) begin
      if(counter == 0) begin
        counter <= data_in;
        operation <= 0;
        data <= 0;
        ready <= 1;
      end else if(operation == 0) begin
        operation <= data_in;
        data <= 0;
        ready <= data_in[3:0] == 2;
      end else begin
        data <= data_in;
        counter <= counter - 1;    
        ready <= data_in[3:0] == 2;
      end
      data_out <= out_data;
      y_valid <= operation[3:0] == 3;
    end
  end

endmodule