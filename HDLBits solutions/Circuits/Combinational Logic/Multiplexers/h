module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );
    always@(*)begin 
        assign out = in[(sel*4 + 3) : (sel * 4)];
    end
endmodule
