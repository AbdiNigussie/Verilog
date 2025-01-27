module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum 
);
    wire [99:0] carry;
    bcd_fadd bcd_1(a[3:0], b[3:0], cin, carry[0], sum[3:0]); 
    
    genvar i;
    generate begin
        for(i = 4; i < 400; i = i + 4) begin:gen
            bcd_fadd bcd1(a[i+3:i], b[i+3:i], carry[(i/4)-1], carry[i/4], sum[i+3:i]);
        end:gen
      end
    endgenerate
    
    assign cout=carry[99];
endmodule
