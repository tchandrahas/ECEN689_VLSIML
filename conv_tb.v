// Code your testbench here
// or browse Examples
module conv_tb;
  parameter size = 7;
  parameter n=32;
  reg [size*size-1:0][n-1:0] filter ;
  reg [size*size-1:0] [n-1:0] conv_input ;
  wire [n-1:0] conv_output;
  integer i;
  conv #(7,32) dut(.filter(filter),.conv_input(conv_input), .conv_output(conv_output));
  initial
  begin

  end

  initial
  begin
     $dumpfile("test.vcd");
     $dumpvars(0,conv_tb);
    $monitor("%d,%d,%d\n",conv_output,filter,conv_input);
  end

  initial
  begin
    #100;
    for (i = 0; i < size*size; i = i +1)
    begin
      if(i%2==1)
        filter[i] = {1'b0,16'b1,15'b0};
      else
        filter[i] = {1'b0,16'b0,15'b0};
    end
    for (i = 0; i < size*size; i = i +1)
    begin
      if(i%2==1)
        conv_input[i] = {1'b0,16'b1,15'b0};
      else
        conv_input[i] = {1'b0,16'b0,15'b0};
    end
    # 1000
    $finish();
  end

  initial
  begin

  end

endmodule
