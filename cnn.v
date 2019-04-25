`include "conv_layer.v"
`include "pooling_single.v"
`include "relu_layer.v"
// declare the parameters for each layer
parameter conv_filter_size = 7;
parameter conv_num_filters = 16;
parameter conv_stride = 2;
parameter pooling_size = 2;
module cnn #(parameter input_size = 28)
(
  input clk,
  input rstb,
  input [31:0] input_data [input_size*input_size-1:0] ,
  input [31:0] conv_filter_weight [conv_num_filters-1:0] [(conv_filter_size*conv_filter_size)-1:0]
  //output [9:0] [31:0] probability
);


// declare the wires for each layers outputs
wire [31:0] conv_layer_output [conv_num_filters-1:0] [(((input_size-conv_filter_size)/conv_stride)+1)*(((input_size-conv_filter_size)/conv_stride)+1)-1:0];
wire [31:0] relu_layer_output [conv_num_filters-1:0] [(((input_size-conv_filter_size)/conv_stride)+1)*(((input_size-conv_filter_size)/conv_stride)+1)-1:0];
wire [31:0] pooling_layer_output [conv_num_filters-1:0] [((((input_size-conv_filter_size)/conv_stride)+1)/pooling_size)*((((input_size-conv_filter_size)/conv_stride)+1)/pooling_size)-1:0];
// instantiate the cnn layer
conv_layer #(.num_filters(conv_num_filters),.input_size(input_size),.filter_size(conv_filter_size),.stride(conv_stride))     conv_layer_i0(.input_data(input_data),.filter_weights(conv_filter_weight),.conv_layer_output(conv_layer_output));
// generate to instantiate the relu_layer
genvar i;
generate
  for(i=0;i<conv_num_filters;i++)
  begin
    relu_layer #(.input_size((((input_size-conv_filter_size)/conv_stride)+1))) relu_layer_i(.input_data(conv_layer_output[i]),.relu_layer_output(relu_layer_output[i]));
  end
 // generate to instantiate the pooling layer
endgenerate

generate
  for(i=0;i<conv_num_filters;i++)
  begin
    pooling_single #(.input_size((((input_size-conv_filter_size)/conv_stride)+1)),.pooling_size(pooling_size)) pooling_single_i(.input_data(relu_layer_output[i]),.pooling_output(pooling_layer_output[i]));
  end
endgenerate
always@(posedge clk or negedge rstb)
begin
  if(rstb == 0)
  begin
  end
  else
  begin
    // positive edge of clock occured
  end
end
endmodule
