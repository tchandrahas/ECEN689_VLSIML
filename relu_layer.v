`include "relu.v"
module relu_layer #(parameter input_size = 64)
(
  input [31:0] input_data [input_size*input_size-1:0],
  output [31:0] relu_layer_output  [input_size*input_size-1:0]
);
  genvar i;
  generate
  for(i=0;i<input_size*input_size;i=i+1)
  begin
    relu relu_i(.input_data(input_data[i]),.output_value(relu_layer_output[i]));
  end
  endgenerate
endmodule
