// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    always@(*) begin 
        case(in)                      
            4'd2: pos=1;            
            4'd4: pos=2;           
            4'd6: pos=1;            
            4'd8: pos=3;
            4'd10: pos =1;
            4'd12: pos=2;
            4'd14: pos=1;
            default: pos =0; // odd numbers all have in[0]=1 so can be simplified to default
        endcase    
    end

endmodule
