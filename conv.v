module conv #(size,Q,N)
(
  input [N-1:0] filter [size*size-1:0] ,
  input [N-1:0] conv_input [size*size-1:0] ,
  output [N-1:0] conv_output
);
fma #(Q,N) mac_i0(.a(0),.b(filter[0][N-1:0]),.c(conv_input[0][N-1:0]),.fma_output(conv_output));
genvar i;
generate(i=1;i<=size*size;i++)
  fma #(Q,N) mac_i(.a(conv_output),.b(filter[i][N-1:0]),.c(conv_input[i][N-1:0]),.fma_output(conv_output));
endgenerate
endmodule
