`include "cnn.v"
module cnn_tb();
parameter input_size = 34;
parameter cnn_filter_size = 7;
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
  $readmemb("mnist_test_values.mem",input_data);
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
  $dumpvars(0,cnn_tb);

end
//output [9:0] [31:0] probability
endmodule
