module conv_filter #(parameter input_size=7,parameter filter_size=3,parameter stride=2)
(
  input [input_size*input_size-1:0] [31:0] input_data,
  input [filter_size*filter_size-1:0] [31:0] filter,
  output [(((input_size-filter_size)/stride)+1)*(((input_size-filter_size)/stride)+1)-1:0] [31:0] output_data
);
genvar i;
genvar j;
genvar k;
genvar l;
generate
  for(i=0;i+(filter_size-1)<input_size;i=i+stride)
  begin
    for(j=0;j+(filter_size-1)<input_size;j=j+stride)
    begin
      wire [filter_size*filter_size-1:0] [31:0] sub_input_data;
      for(k=i;k<(i+filter_size);k=k+1)
      begin
        for(l=j;l<(j+filter_size);l=l+1)
        begin
          assign sub_input_data[(k-i)*(filter_size)+(l-j)] = input_data[(k*input_size)+l];
        end
      end
      conv #(filter_size) conv_i(.filter(filter),.conv_input(sub_input_data),.conv_output(output_data[(i/stride)*((((input_size-filter_size)/stride)+1))+(j/stride)]));
    end
  end
endgenerate
endmodule
