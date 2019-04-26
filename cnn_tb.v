`include "cnn.v"
module cnn_tb();
parameter input_size = 28;
parameter conv_filter_size = 7;
parameter conv_num_filters = 16;
parameter conv_stride = 3;
parameter pooling_size = 2;
parameter fully_connected_num_layers = 10;
parameter conv_layer_output_size = (((input_size-conv_filter_size)/conv_stride)+1);
parameter pooling_layer_input_size = (((input_size-conv_filter_size)/conv_stride)+1);
parameter relu_layer_input_size = (((input_size-conv_filter_size)/conv_stride)+1);
parameter pooling_layer_output_size = (((pooling_layer_input_size-pooling_size)/pooling_size)+1);
parameter fully_connected_layer_input_size = conv_num_filters*pooling_layer_output_size*pooling_layer_output_size;
reg clk;
reg rstb;
reg [31:0] input_data [input_size*input_size-1:0] ;
reg [31:0] conv_filter_weight [conv_num_filters-1:0] [(conv_filter_size*conv_filter_size)-1:0];
reg [31:0] fully_connected_layer_weights [fully_connected_num_layers-1:0][fully_connected_layer_input_size-1:0];
reg [31:0] cnn_filter_bias [conv_num_filters-1:0];
reg [31:0] fully_connected_layer_bias [fully_connected_num_layers-1:0];
cnn #(.input_size(input_size)) cnn_i(.clk(clk),.rstb(rstb),.input_data(input_data),.conv_filter_weight(conv_filter_weight),.cnn_filter_bias(cnn_filter_bias),.fully_connected_layer_weights(fully_connected_layer_weights),.fully_connected_layer_bias(fully_connected_layer_bias));
initial
begin
  clk = 0;
  forever
  begin
     #10 clk = ~clk;
  end
end

initial
begin
  rstb = 0;
  #15 rstb = 1;
end

initial
begin
  $readmemb("mnist_test_values.mem",input_data);
  $readmemb("conv_weights.mem",conv_filter_weight);
  $readmemb("conv_bias.mem",cnn_filter_bias);
  $readmemb("fully_connected_weights.mem",fully_connected_layer_weights);
  $readmemb("fully_connected_bias.mem",fully_connected_layer_bias);
  $monitor("%d\n",input_data[202]);
end
initial
begin
    #100;
    $finish();
end
initial
begin
  $dumpfile("waveform.dump");
  $dumpvars(0);
end
//output [9:0] [31:0] probability
endmodule
