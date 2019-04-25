module relu
(
  input [31:0] input_data,
  output [31:0] output_value
);
assign output_value = (input_data[31]==1'b1)?32'b0:input_data;
endmodule
