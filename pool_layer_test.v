// Code your testbench here
// or browse Examples
module test;
  reg [15:0] [31:0] input_data;
  wire [3:0][31:0] pool_output;
  
  integer i,j;
  
  initial
  begin
     $dumpfile("test.vcd");
    $dumpvars(1);
    $monitor("%h,%h\n",pool_output,input_data);
  end
  
  initial
  begin
    for(i=0; i<4;i=i+1)  begin
      for(j=0;j<4;j=j+1) begin
        $display("%d\t%d\n",(i*4+j),j);
        
        if((i%2)==0)
          input_data[i*4+j] = j+1;
        else
          input_data[i*4+j] = 4-(j);
      end
    end
    #100
    $finish();
  end
  
  pooling_layer #(4,2) dut(  input_data, pool_output );
  
endmodule

/*module test;
  reg [3:0] [31:0] input_data;
  wire [31:0] pool_output;
  
  integer i;
  
  initial
  begin
     $dumpfile("test.vcd");
    $dumpvars(1);
    $monitor("%d,%h\n",pool_output,input_data);
  end
  
  initial
  begin
    for(i=0; i<4;i=i+1)  begin
      input_data[i] = i%4 + 1;
    end
    #1000
    $finish();
  end
  
  max_pool #(2) dut(  input_data, pool_output );
  
endmodule*/
