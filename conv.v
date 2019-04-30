`include "fma.v"
module conv #(parameter size = 7)
(
  input  [31:0] filter [size*size-1:0]  ,
  input  [31:0] conv_input [size*size-1:0] ,
  input  [31:0] bias,
  output [31:0] conv_output
);
wire [31:0] dot_product_output;
genvar i;
generate
  for(i=0;i<size*size;i=i+1)
  begin: fma_generate_loop
    wire [31:0] fma_result;
    if(i == 0)
    begin
      fma #(16,32) fma_i0(.a(32'b0),.b(filter[0]),.c(conv_input[0]),.fma_result(fma_result));
    end
    if(i > 0)
    begin
       fma #(16,32) fma_i(.a(fma_generate_loop[i-1].fma_result),.b(filter[i]),.c(conv_input[i]),.fma_result(fma_result));
    end
  end
endgenerate
assign dot_product_output = fma_generate_loop[size*size-1].fma_result;
qadd #(16,32) qadd_i(.a(dot_product_output),.b(bias),.c(conv_output));
endmodule
