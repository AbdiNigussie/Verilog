module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    // the given K map is different from conventional k_map. check the order of ab and cd.

    assign out = a | (~b & c);

endmodule
