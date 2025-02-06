// you can do this 
module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
   assign sum = x + y;
  
endmodule 
// or you can do this and follow the given circuit diagram 
/*
module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire [2:0] cout;
    FA add1(
        .cin(0), 
        .a(x[0]),
        .b(y[0]), 
        .sum(sum[0]), 
        .cout(cout[0]));
    FA add2(
        .cin(cout[0]), 
        .a(x[1]),
        .b(y[1]), 
        .sum(sum[1]), 
        .cout(cout[1]));

    FA add3(
        .cin(cout[1]), 
        .a(x[2]),
        .b(y[2]), 
        .sum(sum[2]), 
        .cout(cout[2]));
    FA add4(
        .cin(cout[2]), 
        .a(x[3]),
        .b(y[3]), 
        .sum(sum[3]), 
        .cout(sum[4])); 
    
endmodule

module FA( 
    input a, b, cin,
    output cout, sum );
    
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b)); 

endmodule

*/
