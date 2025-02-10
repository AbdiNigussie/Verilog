module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    // This is a  chess board like k-map which can be simplified using XOR gates
    assign out = a^b^c^d;

endmodule
