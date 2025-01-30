module top_module ( input x, input y, output z );
  // this cicuit checks if the two input, x and y, are equal
	assign z = x~^y; // use XNOR gate
endmodule
