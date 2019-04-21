module sum_pool #(parameter window_size = 4 , parameter N = 32)
  (
    input [window_size*window_size-1:0][N-1:0] pool_input  ,
    output [N-1:0] pool_output
  );

  wire [N-1:0] output_wires [size*size-2:0];

  assign pool_output = add_output_wires[size*size-1];
  
  comparator #(16,32) add_i0(.a(pool_input[0]),.b(pool_input[1]),.c(output_wires[0]));

genvar i;

generate

  for(i=2;i<window_size*window_size;i=i+1)

  begin: fma_generate_loop

    qadd #(16,32) add_i(.a(output_wires[i-2]),.b(pool_input[i]),.c(output_wires[i-1]));

  end

endgenerate
endmodule
