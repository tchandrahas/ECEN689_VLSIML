`include "conv_layer.v"
// declare the parameters for each layer
parameter conv_filter_size = 3;
parameter conv_num_filters = 16;
parameter conv_stride = 2;
module cnn #(parameter input_size = 28)
(
  input clk,
  input rstb,
  input [31:0] input_data [input_size*input_size-1:0] ,
  input [31:0] conv_filter_weight [conv_num_filters-1:0] [(conv_filter_size*conv_filter_size)-1:0]
  //output [9:0] [31:0] probability
);


// instantiate the cnn layer
wire [31:0] conv_layer_output [conv_num_filters-1:0] [(((input_size-conv_filter_size)/conv_stride)+1)*(((input_size-conv_filter_size)/conv_stride)+1)-1:0];

conv_layer #(.num_filters(conv_num_filters),.input_size(input_size),.filter_size(conv_filter_size),.stride(conv_stride))     conv_layer_i0(.input_data(input_data),.filter_weights(conv_filter_weight),.conv_layer_output(conv_layer_output));
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
