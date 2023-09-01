module top_module (
    input clk,
    input [7:0] d,
    input [1:0] sel,
    output [7:0] q
);

  wire [7:0] q1;
  wire [7:0] q2;
  wire [7:0] q3;

  my_dff8 i1 (
      clk,
      d,
      q1
  );
  my_dff8 i2 (
      clk,
      q1,
      q2
  );
  my_dff8 i3 (
      clk,
      q2,
      q3
  );

  always @(*) begin
    if (sel == 0) q = d;
    else if (sel == 1) q = q1;
    else if (sel == 2) q = q2;
    else if (sel == 3) q = q3;
    else q = d;
  end

endmodule
