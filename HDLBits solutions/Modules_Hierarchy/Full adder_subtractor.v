module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [15:0] sum1, sum2;
    wire cout1;
    wire [31:0] b_sub;
    assign b_sub = b ^ {32{sub}};
    add16 A1(
        .a(a[15:0]),
        .b(b_sub[15:0]),
        .cout(cout1),
        .cin(sub),
        .sum(sum1)
    );
    add16 A2(
        .a(a[31:16]),
        .b(b_sub[31:16]),
        .cin(cout1),
        .sum(sum2)
    );    
    assign sum = {sum2, sum1};
endmodule

