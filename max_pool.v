`include "comparator.v"
module max_pool #(parameter window_size = 4)
  (
    input  [31:0] pool_input [window_size*window_size-1:0] ,
    output [31:0] pool_output
  );

  wire [31:0] output_wires [window_size*window_size-1:0];
  assign pool_output = output_wires[window_size*window_size-1];

  comparator #(16,32) comp_i0(.a(pool_input[0]),.b(pool_input[1]),.c(output_wires[0]));
genvar i;

generate
  for(i=2;i<window_size*window_size;i=i+1)

  begin: comparator_generate_loop

    comparator #(16,32) comp_i(.a(output_wires[i-2]),.b(pool_input[i]),.c(output_wires[i-1]));

  end

endgenerate
endmodule
