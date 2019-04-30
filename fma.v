`include "qadd.v"
`include "qmult.v"
module fma #(parameter Q=16, parameter N=32)
(
  input [N-1:0] a ,
  input [N-1:0] b,
  input [N-1:0] c,
  output [N-1:0] fma_result
 );
 wire [N-1:0] multiplication_result;
 wire multiplication_overflow;
 // instantiate the multiplier
 qmult#(Q,N) qmult_i0(.i_multiplier(b),.i_multiplicand(c),.o_result(multiplication_result),.ovr(multiplication_overflow));
 // instantiate the adder
 qadd#(Q,N) qadd_i0(.c(fma_result),.b(multiplication_result),.a(a));
endmodule
