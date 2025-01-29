module top_module (input x, input y, output z);
wire z1, z2, z3, z4, a, b;
    assign z = (((x^y) & x)|(x~^y)) ^ (((x^y) & x)&(x~^y));
   
endmodule
