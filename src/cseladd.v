module top_module (
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] sum
);

  wire cout;
  wire not_used_1;
  wire not_used_2;

  add16 isel (
      a[15:0],
      b[15:0],
      0,
      sum[15:0],
      cout
  );

  wire [15:0] sum1;
  wire [15:0] sum2;
  add16 i1 (
      a[31:16],
      b[31:16],
      0,
      sum1,
      not_used_1
  );
  add16 i2 (
      a[31:16],
      b[31:16],
      1,
      sum2,
      not_used_1
  );

  assign sum[31:16] = cout == 0 ? sum1 : sum2;

endmodule
