`default_nettype none
module top_module (
    input  a,
    input  b,
    input  c,
    input  d,
    output out,
    output out_n
);

  wire w_ab;
  wire w_cd;

  assign w_ab  = a & b;
  assign w_cd  = c & d;

  assign out   = w_ab | w_cd;
  assign out_n = ~out;

endmodule
