module pooling_layer #(parameter input_size, parameter pooling_size)
(
  input [input_size*input_size-1:0] input_data,
  input [31:0] pooling_multiplier,
  output [((input_size*input_size)/(pooling_size*pooling_size))-1:0][31:0] pooling_output;
 );
genvar i;
genvar j;
genvar k;
genvar l;
generate
  for(i=0;i+(pooling_size-1)<input_size;i=i+pooling_size)
  begin
    for(j=0;j+(pooling_size-1)<input_size;j=j+pooling_size)
    begin
      wire [pooling_size*pooling_size-1:0] [31:0] sub_input_data;
      for(k=i;k<(i+pooling_size);k=k+1)
      begin
        for(l=j;l<(j+pooling_size);l=l+1)
        begin
          wire [31:0] multiplied_output;
          qmult #(15,32) qmult_i(.i_multiplicand(pooling_multiplier),.i_multiplier(input_data[(k*input_size)+l]),.o_result(multiplied_output));
          assign sub_input_data[(k-i)*(pooling_size)+(l-j)] = multiplied_output;
        end
      end
      conv #(filter_size) conv_i(.filter(filter),.conv_input(sub_input_data),.conv_output(output_data[(i/stride)*((((input_size-filter_size)/stride)+1))+(j/stride)]));
    end
  end
endgenerate
endmodule
