module multiplier(
  input signed [31:0] a,
  input signed [31:0] b,
  output signed [31:0] y
);
  assign y = a*b;
endmodule

module adder(
  input signed [31:0] a,
  input signed [31:0] b,
  output signed [31:0] y
);
  assign y = a+b;
endmodule

module relu(
  input signed [31:0] a,
  output signed [31:0] y,
  output d
);
  assign y = a > 0 ? a : 0;
  assign d = a > 0;
endmodule