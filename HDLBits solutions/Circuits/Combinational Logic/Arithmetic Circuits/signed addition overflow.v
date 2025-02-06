module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
    assign s = a + b;
    // to check for overflow, create a truth table for a[7], b[7] and s[7] and go through when overflow happens.
    assign overflow = ~a[7] & ~b[7]& s[7] | a[7] & b[7]& ~s[7]; 

endmodule
