module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    wire sum0, sum1, sum2;
    wire cout0, cout1, cout2;
    adder add1(
        .cin(cin), 
        .a(a[0]),
        .b(b[0]), 
        .sum(sum0), 
        .cout(cout0)
    );
    adder add2(
        .cin(cout0), 
        .a(a[1]),
        .b(b[1]), 
        .sum(sum1), 
        .cout(cout1)
    );
    adder add3(
        .cin(cout1), 
        .a(a[2]),
        .b(b[2]), 
        .sum(sum2), 
        .cout(cout2)
    );    
    assign sum = {sum2, sum1, sum0};
    assign cout = {cout2, cout1, cout0};
endmodule
module adder( 
    input a, b, cin,
    output cout, sum );
    
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b)); 

endmodule
