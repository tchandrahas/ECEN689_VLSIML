`include "conv_filter.v"
module conv_layer #(parameter num_filters=16, parameter input_size=28, parameter filter_size=7, parameter stride=2)
(
  input [31:0] input_data [input_size*input_size-1:0] ,
  input [31:0] filter_weights [num_filters-1:0][filter_size*filter_size-1:0],
  input [31:0] bias [num_filters-1:0],
  output [31:0] conv_layer_output [num_filters-1:0] [(((input_size-filter_size)/stride)+1)*(((input_size-filter_size)/stride)+1)-1:0]
);
genvar i;
generate
  for(i=0;i<num_filters;i=i+1)
  begin
    wire [31:0] sub_filter_weights [filter_size*filter_size-1:0];
   assign sub_filter_weights[filter_size*filter_size-1:0] = filter_weights[i][filter_size*filter_size-1:0];
    conv_filter #(.input_size(input_size),.stride(stride),.filter_size(filter_size)) conv_filter_i(.input_data(input_data),.filter(sub_filter_weights),.bias(bias[i]),.output_data(conv_layer_output[i]));
  end
endgenerate
endmodule
