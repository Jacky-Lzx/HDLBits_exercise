module top_module (
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] sum
);  //

  wire cout;
  wire not_used;
  add16 i1 (
      a[15:0],
      b[15:0],
      0,
      sum[15:0],
      cout
  );
  add16 i2 (
      a[31:16],
      b[31:16],
      cout,
      sum[31:16],
      not_used
  );

endmodule

module add1 (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);

  // Full adder module here
  assign sum  = (a + b + cin) % 2;
  assign cout = (a + b + cin) >= 2 ? 1 : 0;

endmodule
