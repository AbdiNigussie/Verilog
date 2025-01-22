module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] sum1, sum2, sum3,sum2i;
    wire [15:0] mux1;
    wire cout1;
    add16 A1(
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(0),
        .cout(cout1),
        .sum(sum1)
    );
    add16 A2(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(0),
        .sum(sum2)
    );
    add16 A3(
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(1),
        .sum(sum3)
    );    
    always@(*) begin 
        case(cout1)
            1'b0: sum2i=sum2;
            1'b1: sum2i=sum3;
        endcase    
    end
    assign sum = {sum2i, sum1};
endmodule
