// Code your testbench here
// or browse Examples
`include "conv.v"
module conv_tb;
  parameter size = 7;
  parameter n=32;
  reg [31:0] filter [size*size-1:0] ;
  reg [31:0] conv_input [size*size-1:0] ;
  wire [31:0] conv_output;
  integer i;
  conv #(7) dut(.filter(filter),.conv_input(conv_input), .bias(32'b0),.conv_output(conv_output));
  initial
  begin

  end

  initial
  begin
    $monitor("%d\n",conv_output);
  end

  initial
  begin
    #100;
    for (i = 0; i < size*size; i = i +1)
    begin
      if(i%2==1)
        filter[i] = {1'b0,15'b1,16'b0};
      else
        filter[i] = {1'b0,15'b1,16'b0};
    end
    for (i = 0; i < size*size; i = i +1)
    begin
      if(i%2==1)
        conv_input[i] = {1'b0,15'b1,16'b0};
      else
        conv_input[i] = {1'b0,15'b1,16'b0};
    end
    # 1000;
    $finish();
  end

  initial
  begin

  end

endmodule
