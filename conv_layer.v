module conv_layer #(parameter num_filters=16, parameter input_size=28, parameter filter_size=7, parameter stride=2)
(
  input [input_size*input_size-1:0] input_data,
  input [num_filters-1:0][filter_size-1:0][31:0] filter_weights,
  output [num_filters-1:0] [(((input_size-filter_size)/stride)+1)*(((input_size-filter_size)/stride)+1)-1:0] [31:0] conv_layer_output
);
genvar i;
generate
  for(i=0;i<num_filters;i++)
  begin
    conv_filter #(.input_size(input_size),.stride(stride),.filter_size(filter_size)) conv_filter_i(.input_data(input_data),.filter(filter_weights[i]),.output_data(conv_layer_ouput[i]));
  end
endgenerate
endmodule
