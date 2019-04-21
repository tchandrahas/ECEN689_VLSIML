module comparator #(parameter Q=16, parameter N=32)
(
  input [N-1:0] a ,
  input [N-1:0] b,
  output [N-1:0] c
 );
 
  always@(*) 
    begin
    if(a[N-1] == b[N-1])
    begin
        if(a[N-1] == 1)
        begin
         if( a[N-2:0] > b[N-2:0] )
           c=b;
         else
           c=a;
        end
        else 
        begin
         if( a[N-2:0] > b[N-2:0] )
           c=a;
         else
           c=b;        
        end
    end
    else if(a[N-1] > b[N-1])
      c=a
    else if(a[N-1] < b[N-1])
      c=b;
  end

endmodule
