module comparator #(parameter Q=16, parameter N=32)
(
  input [N-1:0] a ,
  input [N-1:0] b,
  output reg [N-1:0] c
 );

always@(*)
  begin

    if(a[N-1] == b[N-1])
	begin
      if(a[N-1] == 1)
        begin
          if( a[N-2:0] > b[N-2:0] )
            begin
				        c = b;
            end
          else
            begin
              c = a;
            end
        end

      else
        begin
          if( a[N-2:0] > b[N-2:0] )
            begin
				        c = a;
            end
          else
            begin
				        c = b;
            end
        end

    end

    else if(a[N-1] > b[N-1])
      begin
		            c = a;
      end

    else if(a[N-1] < b[N-1])
      begin
		      c = b;
      end
  end

endmodule
