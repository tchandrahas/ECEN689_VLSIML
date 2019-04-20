// Code your testbench here
// or browse Examples
module conv_filter_tb;
  parameter filter_size = 5;
  parameter input_size = 7;
  parameter stride = 2;
  reg [filter_size*filter_size-1:0][31:0] filter ;
  reg [input_size*input_size-1:0] [31:0] input_data ;
  wire [(((input_size-filter_size)/stride)+1)*(((input_size-filter_size)/stride)+1)-1:0] [31:0] output_data;
  integer i;
  conv_filter #(.input_size(input_size),.filter_size(filter_size),.stride(stride)) dut(.filter(filter),.input_data(input_data), .output_data(output_data));
  initial
  begin

  end

  initial
  begin
     $dumpfile("test.vcd");
     $dumpvars(0,conv_filter_tb);
    $monitor("%d,%d,%d\n",output_data,filter,input_data);
  end

  initial
  begin
    #100;
    for (i = 0; i < filter_size*filter_size; i = i +1)
    begin
      if(i%2==1)
        filter[i] = {1'b0,16'b1,15'b0};
      else
        filter[i] = {1'b0,16'b0,15'b0};
    end
    for (i = 0; i < input_size*input_size; i = i +1)
    begin
      if(i%2==1)
        input_data[i] = {1'b0,16'b1,15'b0};
      else
        input_data[i] = {1'b0,16'b0,15'b0};
    end
    # 1000
    $finish();
  end

  initial
  begin

  end

endmodule
