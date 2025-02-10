module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 
	// Sum of Products form from the K-map
    assign out_sop = ~c&~d&a | a&b;

    // Product of Sums form from the K-map
    assign out_pos = (c&(~a|d)&(~b|d));
endmodule
