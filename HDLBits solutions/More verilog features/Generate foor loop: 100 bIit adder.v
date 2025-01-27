module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    assign {cout[0], sum[0]} = a[0] + b[0] + cin;
    genvar i;
    generate  
        for(i=1; i<=99; i=i+1) begin:gen             
                full_adder  A1(
                    .in_a(a[i]),
                    .in_b(b[i]),
                    .c_in(cout[i-1]),
                    .c_out(cout[i]),
                    .sum_1(sum[i])
                );            
        end:gen    
    endgenerate
endmodule
module full_adder(
	input in_a, in_b,c_in,
    output c_out,
    output sum_1 );
    assign	{c_out, sum_1}= in_a + in_b + c_in;
endmodule
