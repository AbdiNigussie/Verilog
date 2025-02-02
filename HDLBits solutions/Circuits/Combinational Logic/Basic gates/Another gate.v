module top_module (
    input in1,
    input in2,
    output out
);
    assign out = in1 & ~in2; // use AND gate  and NOR gate
endmodule
