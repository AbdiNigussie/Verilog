module top_module(
    input a,
    input b,
    input c,
    output out  ); 
  // Just simplify the K-map 
    assign out = a|b|c; 

endmodule
