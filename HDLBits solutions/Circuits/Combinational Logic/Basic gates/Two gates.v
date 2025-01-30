module top_module (
    input in1,
    input in2,
    input in3,
    output out);
    assign out = (in1^~in2)^in3; // use combination of XOR and XNOR gates
endmodule
