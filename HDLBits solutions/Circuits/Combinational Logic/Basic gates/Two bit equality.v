module top_module ( input [1:0] A, input [1:0] B, output z ); 
    //assign z = (A==B)? 1:0; since this is a ciruit section let's use another approach.
    assign z = (A[1]~^B[1]) & (A[0]~^B[0]);
endmodule
