`include "conv_layer.v"
`include "pooling_single.v"
`include "relu_layer.v"
`include "fully_connected_layer.v"
// declare the parameters for each layer
parameter conv_filter_size = 7;
parameter conv_num_filters = 16;
parameter conv_stride = 3;
parameter pooling_size = 2;
parameter fully_connected_num_layers = 10;
module cnn
#(
  parameter input_size = 28,
  parameter conv_layer_output_size = (((input_size-conv_filter_size)/conv_stride)+1),
  parameter pooling_layer_input_size = (((input_size-conv_filter_size)/conv_stride)+1),
  parameter relu_layer_input_size = (((input_size-conv_filter_size)/conv_stride)+1),
  parameter pooling_layer_output_size = (((pooling_layer_input_size-pooling_size)/pooling_size)+1),
  parameter fully_connected_layer_input_size = conv_num_filters*pooling_layer_output_size*pooling_layer_output_size
  )
(

  input clk,
  input rstb,
  input [31:0] input_data [input_size*input_size-1:0] ,
  input [31:0] conv_filter_weight [conv_num_filters-1:0] [(conv_filter_size*conv_filter_size)-1:0],
  input [31:0] fully_connected_layer_weights [fully_connected_num_layers-1:0][fully_connected_layer_input_size-1:0],
  input [31:0] cnn_filter_bias [conv_num_filters-1:0],
  input [31:0] fully_connected_layer_bias [fully_connected_num_layers-1:0]
  //output [9:0] [31:0] probability
);

// declare the wires for each layers outputs
wire [31:0] conv_layer_output [conv_num_filters-1:0] [conv_layer_output_size*conv_layer_output_size-1:0];
wire [31:0] relu_layer_output [conv_num_filters-1:0] [relu_layer_input_size*relu_layer_input_size-1:0];
wire [31:0] pooling_layer_output [conv_num_filters-1:0] [pooling_layer_output_size*pooling_layer_output_size-1:0];
wire [31:0] pooling_layer_output_straightened [fully_connected_layer_input_size-1:0];
wire [31:0] fully_connected_layer_output [fully_connected_num_layers-1:0];
// instantiate the cnn layer
conv_layer #(.num_filters(conv_num_filters),.input_size(input_size),.filter_size(conv_filter_size),.stride(conv_stride))     conv_layer_i0(.input_data(input_data),.filter_weights(conv_filter_weight),.bias(cnn_filter_bias),.conv_layer_output(conv_layer_output));
// generate to instantiate the relu_layer
genvar i;
generate
  for(i=0;i<conv_num_filters;i=i+1)
  begin
    relu_layer #(.input_size(relu_layer_input_size)) relu_layer_i(.input_data(conv_layer_output[i]),.relu_layer_output(relu_layer_output[i]));
  end
endgenerate
 // generate to instantiate the pooling layer
generate
  for(i=0;i<conv_num_filters;i=i+1)
  begin
    pooling_single #(.input_size(pooling_layer_input_size),.pooling_size(pooling_size)) pooling_single_i (.input_data(relu_layer_output[i]),.pooling_output(pooling_layer_output[i]));
  end
endgenerate
// generate loop to straighten the pooling_layer output
generate
  for(i=0;i<conv_num_filters;i=i+1)
  begin
    assign pooling_layer_output_straightened[((i+1)*pooling_layer_output_size*pooling_layer_output_size)-1:(i)*pooling_layer_output_size*pooling_layer_output_size] = pooling_layer_output[i];
  end
endgenerate
// generate to instantiate fully dense layer
generate
  for(i=0;i<fully_connected_num_layers;i=i+1)
  begin
   fully_connected_layer #(.input_size(fully_connected_layer_input_size)) fully_connected_layer_i(.input_data(pooling_layer_output_straightened),.weight(fully_connected_layer_weights[i]),.bias(fully_connected_layer_bias[i]),.output_data(fully_connected_layer_output[i]));
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
