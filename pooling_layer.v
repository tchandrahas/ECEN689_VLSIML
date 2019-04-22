module pooling_layer #(parameter input_size, parameter pooling_size)
(
  input [input_size*input_size-1:0] input_data,
  /*input [31:0] pooling_multiplier*/,
  output [((input_size/pooling_size)*(input_size/pooling_size))-1:0][31:0] pooling_output;
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
          // qmult #(15,32) qmult_i(.i_multiplicand(pooling_multiplier),.i_multiplier(input_data[(k*input_size)+l]),.o_result(multiplied_output));
          assign sub_input_data[(k-i)*(pooling_size)+(l-j)] = /*multiplied_output*/ input_data[(k*input_size)+l];
        end
      end
      max_pool #(.window_size(pooling_size)) max_pool_i(.pool_input(sub_input_data),.pool_output(pooling_output[((i/pooling_size)*(input_size/pooling_size))+(j/pooling_size)]));
    end
  end
endgenerate
endmodule