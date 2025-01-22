module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);//
 wire cin;
    wire [15:0] sum1, sum2;
    add16 A1(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(0),
        .sum(sum1),
        .cout(cin)
    );
    add16 A2(
        .a(a[31:16]),
        .b(b[31:16]),
        .sum(sum2),
        .cin(cin)             
    );
    assign sum = {sum2, sum1};
endmodule

module add1 ( input a, input b, input cin,   output sum, output cout );
	// Full adder module here
    assign sum = a^b^cin;
    assign cout = (a&b) | (cin&(a^b));
endmodule
