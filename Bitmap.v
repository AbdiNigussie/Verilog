`define __DEBUG__

module Bitmap #(
   parameter AREA_ROW = 32,
   parameter AREA_COL = 16,
   parameter ROW_ADDR_W = 5,
   parameter COL_ADDR_W = 4,
   parameter SPEED_FREQ = 50_000_000
)
(
   input                            clk, 
   input                            rstn,
   input                            falling_update,// block falling signal
   output                           game_over,     // game over
   output    reg [9:0]              game_score,
   input    [ROW_ADDR_W-1:0]        mv_blk_row,    // current moving block
   input    [COL_ADDR_W-1:0]        mv_blk_col,    //             : top-left position
   input    [15:0]                  mv_blk_data,   //             : block 4x4 bitmap
   output                           mv_down_enable,//             : is still on active (enable to move down)
   input    [ROW_ADDR_W-1:0]        tst_blk_row,   // testing block
   input    [COL_ADDR_W-1:0]        tst_blk_col,   //             : top-left position
   input    [15:0]                  tst_blk_data,  //             : block 4x4 bitmap
   output                           tst_blk_overl, //             : is overlapping with current fixed blocks
   input    [ROW_ADDR_W-1:0]        r1_row,        // output channel #1
   output   [AREA_COL*2-1:0]        r1_data,       //         : data
   input    [ROW_ADDR_W-1:0]        r2_row,        // output channel #1
   output   [AREA_COL*2-1:0]        r2_data         //         : data
);


//==========================================================================
// bitmap content
//==========================================================================

reg [AREA_COL - 1 : 0] bitmap_h [AREA_ROW - 1 : 0];
reg [AREA_COL - 1 : 0] bitmap_l [AREA_ROW - 1 : 0];

// Game over detection
wire [3:0] top4_row_overlap;
assign top4_row_overlap[0] = |(bitmap_l[0] & bitmap_h[0]);
assign top4_row_overlap[1] = |(bitmap_l[1] & bitmap_h[1]);
assign top4_row_overlap[2] = |(bitmap_l[2] & bitmap_h[2]);
assign top4_row_overlap[3] = |(bitmap_l[3] & bitmap_h[3]);
assign game_over = |top4_row_overlap;

`ifdef __DEBUG__
wire [AREA_COL - 1 : 0] bitmap_h24 = bitmap_h[24];
wire [AREA_COL - 1 : 0] bitmap_h25 = bitmap_h[25];
wire [AREA_COL - 1 : 0] bitmap_h26 = bitmap_h[26];
wire [AREA_COL - 1 : 0] bitmap_h27 = bitmap_h[27];
wire [AREA_COL - 1 : 0] bitmap_h28 = bitmap_h[28];
wire [AREA_COL - 1 : 0] bitmap_h29 = bitmap_h[29];
wire [AREA_COL - 1 : 0] bitmap_h30 = bitmap_h[30];
wire [AREA_COL - 1 : 0] bitmap_h31 = bitmap_h[31];

wire [AREA_COL - 1 : 0] bitmap_l0 = bitmap_l[0];
wire [AREA_COL - 1 : 0] bitmap_l1 = bitmap_l[1];
wire [AREA_COL - 1 : 0] bitmap_l2 = bitmap_l[2];
wire [AREA_COL - 1 : 0] bitmap_l3 = bitmap_l[3];
wire [AREA_COL - 1 : 0] bitmap_l10 = bitmap_l[10];
wire [AREA_COL - 1 : 0] bitmap_l11 = bitmap_l[11];
wire [AREA_COL - 1 : 0] bitmap_l12 = bitmap_l[12];
wire [AREA_COL - 1 : 0] bitmap_l13 = bitmap_l[13];
wire [AREA_COL - 1 : 0] bitmap_l20 = bitmap_l[20];
wire [AREA_COL - 1 : 0] bitmap_l21 = bitmap_l[21];
wire [AREA_COL - 1 : 0] bitmap_l22 = bitmap_l[22];
wire [AREA_COL - 1 : 0] bitmap_l23 = bitmap_l[23];
wire [AREA_COL - 1 : 0] bitmap_l28 = bitmap_l[28];
wire [AREA_COL - 1 : 0] bitmap_l29 = bitmap_l[29];
wire [AREA_COL - 1 : 0] bitmap_l30 = bitmap_l[30];
wire [AREA_COL - 1 : 0] bitmap_l31 = bitmap_l[31];
`endif



// check moving block detection
reg can_move_down;
always @(*) begin
    can_move_down = 1'b1; // Default to allow moving down at the begining
    // Check if block would go out of bounds
    if (mv_blk_row == 31) begin
        can_move_down = 1'b0;
    end
    else if (mv_blk_row == 30) begin 
        // Check each row of the moving block
      if ((bitmap_h[mv_blk_row+1] & bitmap_l[mv_blk_row]) 
                                || (bitmap_l[mv_blk_row + 1] != 0))begin
            can_move_down = 1'b0;
      end
    end
    else if (mv_blk_row == 28) begin 
        // Check each row of the moving block
      if ((bitmap_h[mv_blk_row+1] & bitmap_l[mv_blk_row]) ||
            (bitmap_h[mv_blk_row + 2] & bitmap_l[mv_blk_row+1]) ||
            (bitmap_h[mv_blk_row + 3] & bitmap_l[mv_blk_row+2]) || 
                                       (bitmap_l[mv_blk_row + 3] != 0)) begin
            can_move_down = 1'b0;
      end
    end
    else if (mv_blk_row == 29) begin 
        // Check each row of the moving block
      if ((bitmap_h[mv_blk_row+1] & bitmap_l[mv_blk_row]) ||
            (bitmap_h[mv_blk_row + 2] & bitmap_l[mv_blk_row+1]) || 
                                       (bitmap_l[mv_blk_row + 2] != 0))begin
            can_move_down = 1'b0;
      end
    end
    else if (mv_blk_row <= 27) begin 
        // Check each row of the moving block
      if ((bitmap_h[mv_blk_row+1] & bitmap_l[mv_blk_row]) ||
            (bitmap_h[mv_blk_row + 2] & bitmap_l[mv_blk_row+1]) ||
            (bitmap_h[mv_blk_row + 3] & bitmap_l[mv_blk_row+2]) ||
            (bitmap_h[mv_blk_row + 4] & bitmap_l[mv_blk_row+3])) begin
            can_move_down = 1'b0;
      end
    end
end

assign mv_down_enable = can_move_down;

reg is_overlap;
always @(*) begin
    is_overlap = 1'b0;   
    // Check bounds of bottom, right and left boundary respectively
    if ((tst_blk_row + 3 >= AREA_ROW - 1) || 
        (tst_blk_col + 3 >= AREA_COL)) begin   
        is_overlap = 1'b1;
    end
    
    // Check collision with fixed blocks
    else begin
        if ((bitmap_h[tst_blk_row] & (({12'b0, tst_blk_data[3:0]} << tst_blk_col))) ||
            (bitmap_h[tst_blk_row + 1] & (({12'b0, tst_blk_data[7:4]} << tst_blk_col))) ||
            (bitmap_h[tst_blk_row + 2] & (({12'b0, tst_blk_data[11:8]} << tst_blk_col))) ||
            (bitmap_h[tst_blk_row + 3] & (({12'b0, tst_blk_data[15:12]} << tst_blk_col)))) begin
            is_overlap = 1'b1;
        end
    end
end

assign tst_blk_overl = is_overlap;


//  handle bitmap_h updates
reg [AREA_ROW-1:0] row_full;  // Track which rows are full
reg [3:0] lines_cleared;  // Counter for number of lines cleared at once
integer l,m,i,k; // integers used in the for loops 
reg [9:0] game_score_r=0;


always @(posedge clk) begin  
    if (~rstn) begin
        game_score_r <= 16'h0;
        lines_cleared <= 4'h0;
        row_full <= 0; 
        
        for (i = 0; i < AREA_ROW; i = i + 1) begin
        bitmap_h[i] <= 16'h0;                
        end 
        
    end
  
    else begin                     
            // Detect full rows
            for (k = 0; k < AREA_ROW; k = k + 1) begin
                if (bitmap_h[k] == {AREA_COL{1'b1}}) begin
                    row_full[k] <= 1'b1;                 
                end          
            end                        
        
        if (~rstn) begin
            for (i = 0; i < AREA_ROW; i = i + 1) begin
            bitmap_h[i] <= 16'h0;                
            end 
        end
        else if (~mv_down_enable) begin
            // Handle block placement                               
                    bitmap_h[mv_blk_row] <= bitmap_h[mv_blk_row] | ({12'b0, mv_blk_data[3:0]} << mv_blk_col);
                    bitmap_h[mv_blk_row+1] <= bitmap_h[mv_blk_row+1] | ({12'b0, mv_blk_data[7:4]} << mv_blk_col);
                    bitmap_h[mv_blk_row + 2] <= bitmap_h[mv_blk_row+2] | ({12'b0, mv_blk_data[11:8]} << mv_blk_col);
                    bitmap_h[mv_blk_row +3] <= bitmap_h[mv_blk_row+3] | ({12'b0, mv_blk_data[15:12]} << mv_blk_col);                            
        end        
        else begin                    
                if (row_full[0]) begin
                    bitmap_h[0] <= 16'h0;
                end
               else if (row_full[31:1]!=0) begin // Cascade down from rows above 
                    lines_cleared<=0;                      
                    for (m = 0; m < AREA_ROW; m = m + 1) begin
                       if(bitmap_h[m] == {AREA_COL{1'b1}})begin
                           for ( l = m; l > 0; l = l - 1) begin            
                               bitmap_h[l] <= bitmap_h[l-1];
                                lines_cleared<=lines_cleared+1;
                           end
                            bitmap_h[0] <= bitmap_h[0];  
                       end 
                   end
              end
              if (lines_cleared != 0) begin
                case (lines_cleared)
                    4'h1: game_score_r <= game_score_r + 16'd1;
                    4'h2: game_score_r <= game_score_r + 16'd3;
                    4'h3: game_score_r <= game_score_r + 16'd5;
                    4'h4: game_score_r <= game_score_r + 16'd8;
                    default: game_score_r <= game_score_r;
                endcase
                
             end                                                   
        end
    end      
end

always@(*) begin 
     game_score <= game_score_r;
end

//==========================================================================
// moving block, 
//==========================================================================

generate
genvar j;
for (j = 0; j < AREA_ROW; j = j+1) begin
   always @(posedge clk) begin
      if (~rstn) begin
         bitmap_l[j] <= 0;
      end 
      else begin
         if (j == mv_blk_row) begin
            bitmap_l[j] <= {12'b0, mv_blk_data[3:0]} << mv_blk_col;
         end 
         else if (j == mv_blk_row + 1) begin
            bitmap_l[j] <= {12'b0, mv_blk_data[7:4]} << mv_blk_col;
         end 
         else if (j == mv_blk_row + 2) begin
            bitmap_l[j] <= {12'b0, mv_blk_data[11:8]} << mv_blk_col;
         end
         else if (j == mv_blk_row + 3) begin
            bitmap_l[j] <= {12'b0, mv_blk_data[15:12]} << mv_blk_col;
         end
         else begin
            bitmap_l[j] <= 0;
         end  
      end 
   end
end 
endgenerate


//==========================================================================
// output channel #1,
//==========================================================================

wire [AREA_COL-1:0] r1_data_h = bitmap_h[r1_row];
wire [AREA_COL-1:0] r1_data_l = bitmap_l[r1_row];

assign r1_data = {r1_data_h, r1_data_l};


//==========================================================================
// output channel #2, 
//==========================================================================

reg [2*AREA_COL-1:0] r2_data_r;
assign r2_data = r2_data_r;

always @(*) begin
   r2_data_r <= {bitmap_h[r2_row], bitmap_l[r2_row]};
end 

endmodule