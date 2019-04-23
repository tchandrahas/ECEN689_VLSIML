`include "cnn.v"
module cnn_tb();
parameter input_size = 28;
parameter cnn_filter_size = 3;
parameter cnn_num_filters = 16;
parameter cnn_stride = 2;
reg clk;
reg rstb;
reg [31:0] input_data [input_size*input_size-1:0] ;
reg [31:0] conv_filter_weight [cnn_num_filters-1:0][(cnn_filter_size*cnn_filter_size)-1:0];
cnn #(.input_size(input_size)) cnn_i(.clk(clk),.rstb(rstb),.input_data(input_data),.conv_filter_weight(conv_filter_weight));
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
  $readmemb("binaryoutput.mem",input_data);
end
//output [9:0] [31:0] probability
endmodule
