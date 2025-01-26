module top_module( 
    input [254:0] in,
    output [7:0] out );
    int i;
    always@(*) begin 
        out = 0;
        for(i=0;i<=254; i= i+1)begin 
            out = (in[i]==1)? (out+1):out;
        end
    end
endmodule
