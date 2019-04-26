module fully_connected_layer #(parameter input_size = 32)
(
  input [31:0] input_data [input_size-1:0],
  input [31:0] weight [input_size-1:0],
  output [31:0]   output_data
);
genvar i;
generate
  for(i=0;i<input_size;i=i+1)
  begin: fma_generate_loop
    wire [31:0] fma_result;
    if(i == 0)
    begin
      fma #(15,32) fma_i0(.a(0),.b(weight[0]),.c(input_data[0]),.fma_result(fma_result));
    end
    if(i > 0)
    begin
       fma #(15,32) fma_i(.a(fma_generate_loop[i-1].fma_result),.b(weight[i]),.c(input_data[i]),.fma_result(fma_result));
    end
  end
endgenerate
assign output_data = fma_generate_loop[input_size-1].fma_result;
endmodule
