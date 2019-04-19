module fma
#(Q,N)
(
  input [N-1:0] a ,
  input [N-1:0] b,
  input [N-1:0] c,
  output [N-1:0] fma_result,
 );
 wire [N-1] multiplication_result;
 wire multiplication_overflow;
 // instantiate the multiplier
 qmult #(Q,N) qmult_i0(.i_multiplier(b),i_multiplicand(c),.o_result(multiplication_result),.ovr(multiplication_overflow));
 // instantiate the adder
 qadd #(Q,N) qadd_i0(.a(fma_result),.b(multiplication_result),.c(a));
endmodule
