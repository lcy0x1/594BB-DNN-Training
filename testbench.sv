// Code your testbench here
// or browse Examples
module testbench();
  
  parameter CLK = 4;
  
  reg enable;
  reg clk;
  reg reset;
  reg [31:0] mode;
  reg signed [31:0] in_data;
  wire signed [31:0] out_data;
  
  controller main(clk, enable, reset, mode, in_data, out_data);
  
  initial begin
    #1;
    forever begin
      clk = ~clk;
      #2;
    end
  end
  
  initial begin
    $dumpfile ("dump.vcd");
    $dumpvars;
    clk = 0;
    reset = 0;
    enable = 0;
    mode = 0;
    in_data = 0;
    #(CLK);
    reset = 1;
    #(CLK);
    reset = 0;
    enable = 1;
    #(CLK);

mode = 32'h02;
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
mode = 32'h42;
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
mode = 32'h12;
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
mode = 32'h52;
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);



// multiplication of W1 and X is W1X'
// here it means transpose X, W1=#0, X=#5, answer is W1*X
//A1 = W1X
mode = 32'h962501;
#(CLK*128);
mode = 0;
#(CLK);

// A2 = W2*A1
mode = 32'hc66241;
#(CLK*128);
mode = 0;
#(CLK);

// Y = W3 * A2
mode = 32'h86d611;
#(CLK*128);
mode = 0;
#(CLK);

mode = 32'h182;
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
in_data = 0;
#(CLK);
in_data = 1;
#(CLK);
in_data = 1;
#(CLK);
mode = 0;
#(CLK*128);




    
    $finish;
  end

  
endmodule
