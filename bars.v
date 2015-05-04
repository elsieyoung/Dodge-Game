module bars(input [9:0] column_addr, input [9:0] row_addr,
	output [9:0] red, output [9:0] green, output [9:0] blue, input VGA_CLK, input gameover, output fail_out,

    input ready, input [7:0] scan_code, input start, output [9:1]LEDR);
	
	 reg [2:0] idx;
	      
	wire [10:0] end_row1;  // coords of pillow 1.
	wire [10:0] end_row2;  // coords of pillow 2.
	wire [10:0] end_row3;  // coords of pillow 3.
	wire [10:0] end_row4;  // coords of pillow 4.
	wire [10:0] end_row5;  // coords of pillow 5.
	wire [10:0] end_row6;  // coords of pillow 6.
	wire [10:0] end_row7;  // coords of pillow 7.
	wire [10:0] end_row8;  // coords of pillow 8.
	wire [10:0] end_row9;  // coords of pillow 9.
	wire [10:0] end_row10;  // coords of pillow 10.
	
	wire [10:0] begin_row1;  // coords of pillow 1.
	wire [10:0] begin_row2;  // coords of pillow 2.
	wire [10:0] begin_row3;  // coords of pillow 3.
	wire [10:0] begin_row4;  // coords of pillow 4.
	wire [10:0] begin_row5;  // coords of pillow 5.
	wire [10:0] begin_row6;  // coords of pillow 6.
	wire [10:0] begin_row7;  // coords of pillow 7.
	wire [10:0] begin_row8;  // coords of pillow 8.
	wire [10:0] begin_row9;  // coords of pillow 9.
	wire [10:0] begin_row10;  // coords of pillow 10.
	
	
	wire [10:0] begin_column, end_column; // coords of the goose.
	wire fail1, fail2, fail3, fail4, fail5, fail6, fail7, fail8, fail9;
	wire fail = fail1 || fail2 || fail3 || fail4 || fail5 || fail6 || fail7 || fail8 || fail9;
	assign fail_out = fail;
	
//	assign LEDR[1] = fail1;
//	assign LEDR[2] = fail2;
//	assign LEDR[3] = fail3;
//	assign LEDR[4] = fail4;
//	assign LEDR[5] = fail5;
//	assign LEDR[6] = fail6;
//	assign LEDR[7] = fail7;
//	assign LEDR[8] = fail8;
//	assign LEDR[9] = fail9;

	assign LEDR[1] = fail;
	assign LEDR[2] = start;
	assign LEDR[3] = gameover;

always @(posedge VGA_CLK)
	begin
			if (column_addr >= 11'd0 && column_addr < 11'd800 &&  row_addr >= 540 && row_addr < 600) // Grass
					idx <= 3'b010;
			else if (~start) begin
				if (column_addr >= begin_column && column_addr < end_column &&  row_addr >= 11'd480 && row_addr < 11'd540 && 
							~(column_addr >= ((end_column - begin_column)/2 + begin_column - 11'd15 ) && column_addr < ((end_column - begin_column)/2 + begin_column + 11'd15 ) &&  row_addr >= 11'd505 && row_addr < 11'd515) && 
							~((column_addr >= (end_column -(end_column - begin_column)/2 - 11'd15 ) && column_addr < (end_column -(end_column - begin_column)/2  - 11'd10 ) &&  row_addr >= 11'd495 && row_addr < 11'd500)) && 
							~((column_addr >= ((end_column - begin_column)/2 + begin_column + 11'd10 ) && column_addr < ((end_column - begin_column)/2 + begin_column + 11'd15 ) &&  row_addr >= 11'd495 && row_addr < 11'd500)))
					idx <= 3'b111;
				else if (column_addr >= ((end_column - begin_column)/2 + begin_column - 11'd15 ) && column_addr < ((end_column - begin_column)/2 + begin_column + 11'd15 ) &&  row_addr >= 11'd505 && row_addr < 11'd515)
					idx <= 3'b011;
				else if (column_addr >= ((end_column - begin_column)/2 + begin_column + 11'd10 ) && column_addr < ((end_column - begin_column)/2 + begin_column + 11'd15 ) &&  row_addr >= 11'd495 && row_addr < 11'd500)
					idx <= 3'b000;
				else if (column_addr >= (end_column -(end_column - begin_column)/2 - 11'd15 ) && column_addr < (end_column -(end_column - begin_column)/2  - 11'd10 ) &&  row_addr >= 11'd495 && row_addr < 11'd500)
					idx <= 3'b000;
				else
					idx <= 3'b110;
				end
			else if (start && ~fail && ~gameover) begin // Game starts
				// play the game
					if (column_addr >= 11'd160 && column_addr < 11'd190 &&  row_addr >= begin_row1 && row_addr < end_row1)
						idx <= 3'b111;
					else if (column_addr >= 11'd120 && column_addr < 11'd150 &&  row_addr >= begin_row2 && row_addr < end_row2)
						idx <= 3'b101;	
					else if (column_addr >= 11'd500 && column_addr < 11'd530 &&  row_addr >= begin_row3 && row_addr < end_row3)
						idx <= 3'b011;
					else if (column_addr >= 11'd600 && column_addr < 11'd630 &&  row_addr >= begin_row4 && row_addr < end_row4)
						idx <= 3'b111;
					else if (column_addr >= 11'd0 && column_addr < 11'd30 &&  row_addr >= begin_row5 && row_addr < end_row5)
						idx <= 3'b111;
					else if (column_addr >= 11'd430 && column_addr < 11'd460 &&  row_addr >= begin_row6 && row_addr < end_row6)
						idx <= 3'b111;
					else if (column_addr >= 11'd300 && column_addr < 11'd330 &&  row_addr >= begin_row7 && row_addr < end_row7)
						idx <= 3'b011;
					else if (column_addr >= 11'd90 && column_addr < 11'd120 &&  row_addr >= begin_row8 && row_addr < end_row8)
						idx <= 3'b101;
					else if (column_addr >= 11'd200 && column_addr < 11'd230 &&  row_addr >= begin_row9 && row_addr < end_row9)
						idx <= 3'b111;

					else if (column_addr >= begin_column && column_addr < end_column &&  row_addr >= 11'd480 && row_addr < 11'd540 && 
								~(column_addr >= ((end_column - begin_column)/2 + begin_column - 11'd15 ) && column_addr < ((end_column - begin_column)/2 + begin_column + 11'd15 ) &&  row_addr >= 11'd505 && row_addr < 11'd515) && 
								~((column_addr >= (end_column -(end_column - begin_column)/2 - 11'd15 ) && column_addr < (end_column -(end_column - begin_column)/2  - 11'd10 ) &&  row_addr >= 11'd495 && row_addr < 11'd500)) && 
								~((column_addr >= ((end_column - begin_column)/2 + begin_column + 11'd10 ) && column_addr < ((end_column - begin_column)/2 + begin_column + 11'd15 ) &&  row_addr >= 11'd495 && row_addr < 11'd500)))
						idx <= 3'b111;
					else if (column_addr >= ((end_column - begin_column)/2 + begin_column - 11'd15 ) && column_addr < ((end_column - begin_column)/2 + begin_column + 11'd15 ) &&  row_addr >= 11'd505 && row_addr < 11'd515)
						idx <= 3'b011;
					else if (column_addr >= ((end_column - begin_column)/2 + begin_column + 11'd10 ) && column_addr < ((end_column - begin_column)/2 + begin_column + 11'd15 ) &&  row_addr >= 11'd495 && row_addr < 11'd500)
						idx <= 3'b000;
					else if (column_addr >= (end_column -(end_column - begin_column)/2 - 11'd15 ) && column_addr < (end_column -(end_column - begin_column)/2  - 11'd10 ) &&  row_addr >= 11'd495 && row_addr < 11'd500)
						idx <= 3'b000;
					else
						idx <= 3'b110;
				end
				
				else if (start && fail) begin // fail		
					if (column_addr >= 11'd310 && column_addr < 11'd330 && row_addr >= 200 && row_addr < 210)
						idx <= 3'b111;
					else if (column_addr >= 11'd300 && column_addr < 11'd310  &&  row_addr >= 210 && row_addr < 250)
						idx <= 3'b111;
					else if (column_addr >= 11'd310 && column_addr < 11'd330 && row_addr >= 250 && row_addr < 260)
						idx <= 3'b111;
					else if (column_addr >= 11'd320 && column_addr < 11'd330 &&  row_addr >= 200 && row_addr < 210)  // G
						idx <= 3'b111;
					else if (column_addr >= 11'd320 && column_addr < 11'd330 &&  row_addr >= 230 && row_addr < 240)
						idx <= 3'b111;
					else if (column_addr >= 11'd320 && column_addr < 11'd330 &&  row_addr >= 250 && row_addr < 260)
						idx <= 3'b111;
					else if (column_addr >= 11'd330 && column_addr < 11'd340 &&  row_addr >= 230 && row_addr < 260)
						idx <= 3'b111;
						
					else if (column_addr >= 11'd350 && column_addr < 11'd360 &&  row_addr >= 250 && row_addr < 260) // Dot
						idx <= 3'b111;
						
					else if (column_addr >= 11'd380 && column_addr < 11'd400 &&  row_addr >= 200 && row_addr < 210) 
						idx <= 3'b111;
					else if (column_addr >= 11'd370 && column_addr < 11'd380 &&  row_addr >= 210 && row_addr < 250) // O
						idx <= 3'b111;
					else if (column_addr >= 11'd400 && column_addr < 11'd410 &&  row_addr >= 210 && row_addr < 250) 
						idx <= 3'b111;
					else if (column_addr >= 11'd380 && column_addr < 11'd400 &&  row_addr >= 250 && row_addr < 260) 
						idx <= 3'b111;
					
					else if (column_addr >= 11'd410 && column_addr < 11'd420 &&  row_addr >= 250 && row_addr < 260) // Dot
						idx <= 3'b111;

						// Goose
					else if (column_addr >= (begin_column+11'd10) && column_addr < (begin_column+11'd15) &&  row_addr >= 11'd490 && row_addr < 11'd495)
						idx <= 3'b000;
					else if (column_addr >= (begin_column+11'd10) && column_addr < (begin_column+11'd15) &&  row_addr >= 11'd500 && row_addr < 11'd505)
						idx <= 3'b000;
					else if (column_addr >= (begin_column+11'd15) && column_addr < (begin_column+11'd20) &&  row_addr >= 11'd495 && row_addr < 11'd500)
						idx <= 3'b000;
						
					else if (column_addr >= (begin_column+11'd20) && column_addr < (begin_column+11'd25) &&  row_addr >= 11'd490 && row_addr < 11'd495)
						idx <= 3'b000;
					else if (column_addr >= (begin_column+11'd20) && column_addr < (begin_column+11'd25) &&  row_addr >= 11'd520 && row_addr < 11'd525)
						idx <= 3'b000;
					else if (column_addr >= (begin_column+11'd20) && column_addr < (begin_column+11'd25) &&  row_addr >= 11'd500 && row_addr < 11'd505)
						idx <= 3'b000;
					else if (column_addr >= (begin_column+11'd20) && column_addr < (begin_column+11'd25) &&  row_addr >= 11'd530 && row_addr < 11'd535)
						idx <= 3'b000;
						
					else if (column_addr >= (begin_column+11'd10) && column_addr < (begin_column+11'd15) &&  row_addr >= 11'd520 && row_addr < 11'd525)
						idx <= 3'b000;
					else if (column_addr >= (begin_column+11'd10) && column_addr < (begin_column+11'd15) &&  row_addr >= 11'd530 && row_addr < 11'd535)
						idx <= 3'b000;
					else if (column_addr >= (begin_column+11'd15) && column_addr < (begin_column+11'd20) &&  row_addr >= 11'd525 && row_addr < 11'd530)
						idx <= 3'b000;
					
					else if (column_addr >= (begin_column+11'd50) && column_addr < (begin_column+11'd55) &&  row_addr >= 11'd500 && row_addr < 11'd520)
							idx <= 3'b011;
					else if (column_addr >= begin_column && column_addr < end_column &&  row_addr >= 11'd480 && row_addr < 11'd540)
							idx <= 3'b111;
					else
						idx <= 3'b000;
				end
				
				else if (start && gameover) begin // timeout	
					if (column_addr >= 11'd260 && column_addr < 11'd270 && row_addr >= 200 && row_addr < 250)
						idx <= 3'b111;
					else if (column_addr >= 11'd300 && column_addr < 11'd310  &&  row_addr >= 200 && row_addr < 250)    // H
						idx <= 3'b111;
					else if (column_addr >= 11'd270 && column_addr < 11'd300 && row_addr >= 220 && row_addr < 230)
						idx <= 3'b111;
					
					
					else if (column_addr >= 11'd320 && column_addr < 11'd360 && row_addr >= 200 && row_addr < 210)
						idx <= 3'b111;
					else if (column_addr >= 11'd320 && column_addr < 11'd360  &&  row_addr >= 240 && row_addr < 250)   //O
						idx <= 3'b111;
					else if (column_addr >= 11'd320 && column_addr < 11'd330 && row_addr >= 210 && row_addr < 240)
						idx <= 3'b111;
					else if (column_addr >= 11'd350 && column_addr < 11'd360 && row_addr >= 210 && row_addr < 240)
						idx <= 3'b111;
						
					else if (column_addr >= 11'd370 && column_addr < 11'd380 && row_addr >= 200 && row_addr < 250)
						idx <= 3'b111;
					else if (column_addr >= 11'd420 && column_addr < 11'd430  &&  row_addr >= 200 && row_addr < 250)
						idx <= 3'b111;
					else if (column_addr >= 11'd380 && column_addr < 11'd390 && row_addr >= 200 && row_addr < 210)   // N
						idx <= 3'b111;
					else if (column_addr >= 11'd390 && column_addr < 11'd400 && row_addr >= 210 && row_addr < 220)
						idx <= 3'b111;
					else if (column_addr >= 11'd400 && column_addr < 11'd410 && row_addr >= 220 && row_addr < 230)
						idx <= 3'b111;
					else if (column_addr >= 11'd410 && column_addr < 11'd420 && row_addr >= 230 && row_addr < 240)
						idx <= 3'b111;
		
					else if (column_addr >= 11'd440 && column_addr < 11'd450 && row_addr >= 200 && row_addr < 250)
						idx <= 3'b111;
					else if (column_addr >= 11'd470 && column_addr < 11'd480 && row_addr >= 200 && row_addr < 210)
						idx <= 3'b111;
					else if (column_addr >= 11'd460 && column_addr < 11'd470 && row_addr >= 210 && row_addr < 220)  //K
						idx <= 3'b111;
					else if (column_addr >= 11'd440 && column_addr < 11'd460 && row_addr >= 220 && row_addr < 230)
						idx <= 3'b111;
					else if (column_addr >= 11'd460 && column_addr < 11'd470 && row_addr >= 230 && row_addr < 240)
						idx <= 3'b111;
					else if (column_addr >= 11'd470 && column_addr < 11'd480 && row_addr >= 240 && row_addr < 250)
						idx <= 3'b111;
						
					else if (column_addr >= 11'd490 && column_addr < 11'd500 && row_addr >= 200 && row_addr < 230) // !
						idx <= 3'b111;
					else if (column_addr >= 11'd490 && column_addr < 11'd500 && row_addr >= 240 && row_addr < 250)
						idx <= 3'b111;
						
					// Goose
					
					else if (column_addr >= ((end_column - begin_column)/2 + begin_column - 11'd15 ) && column_addr < ((end_column - begin_column)/2 + begin_column + 11'd15 ) &&  row_addr >= 11'd505 && row_addr < 11'd515)
						idx <= 3'b011;
					else if (column_addr >= ((end_column - begin_column)/2 + begin_column + 11'd10 ) && column_addr < ((end_column - begin_column)/2 + begin_column + 11'd15 ) &&  row_addr >= 11'd495 && row_addr < 11'd500)
						idx <= 3'b000;
					else if (column_addr >= (end_column -(end_column - begin_column)/2 - 11'd15 ) && column_addr < (end_column -(end_column - begin_column)/2  - 11'd10 ) &&  row_addr >= 11'd495 && row_addr < 11'd500)
						idx <= 3'b000;
					else if (column_addr >= (begin_column+11'd10) && column_addr < (begin_column+11'd20) &&  row_addr >= 11'd500 && row_addr < 11'd510)
						idx <= 3'b001;
					else if (column_addr >= (end_column-11'd20) && column_addr < (end_column - 11'd10) &&  row_addr >= 11'd500 && row_addr < 11'd510)
						idx <= 3'b001;
					else if (column_addr >= begin_column && column_addr < end_column &&  row_addr >= 11'd480 && row_addr < 11'd540)
						idx <= 3'b111;

					else
						idx <= 3'b110;
				end
				
				
	end


assign red = (idx[0]? 10'h3ff: 10'h000);
assign green = (idx[1]? 10'h3ff: 10'h000);
assign blue = (idx[2]? 10'h3ff: 10'h000);


	square s1(
	.clk(VGA_CLK),
	.speed(380000),
	.gameover(gameover),
	.fail(fail),
	.ready(VGA_BLANK),
	.column_addr(column_addr),
	.row_addr(row_addr),
	.p_begin_column(11'd160), 
	.p_end_column(11'd190),
	.begin_row(begin_row1),
	.end_row(end_row1)
	);
	
	square s2(
	.clk(VGA_CLK),
	.speed(480000),
	.gameover(gameover),
	.fail(fail),
	.ready(VGA_BLANK),
	.column_addr(column_addr),
	.row_addr(row_addr),
	.p_begin_column(11'd120), 
	.p_end_column(11'd150),
	.begin_row(begin_row2),
	.end_row(end_row2)
	);
	
	square s3(
	.clk(VGA_CLK),
	.speed(270000),
	.gameover(gameover),
	.fail(fail),
	.ready(VGA_BLANK),
	.column_addr(column_addr),
	.row_addr(row_addr),
	.p_begin_column(11'd500), 
	.p_end_column(11'd530),
	.begin_row(begin_row3),
	.end_row(end_row3)
	);
	
	square s4(
	.clk(VGA_CLK),
	.speed(900000),
	.gameover(gameover),
	.fail(fail),
	.ready(VGA_BLANK),
	.column_addr(column_addr),
	.row_addr(row_addr),
	.p_begin_column(11'd600), 
	.p_end_column(11'd630),
	.begin_row(begin_row4),
	.end_row(end_row4)
	);
	
		square s5(
	.clk(VGA_CLK),
	.speed(690450),
	.gameover(gameover),
	.fail(fail),
	.ready(VGA_BLANK),
	.column_addr(column_addr),
	.row_addr(row_addr),
	.p_begin_column(11'd0), 
	.p_end_column(11'd30),
	.begin_row(begin_row5),
	.end_row(end_row5)
	);
	
		square s6(
	.clk(VGA_CLK),
	.speed(700670),
	.gameover(gameover),
	.fail(fail),
	.ready(VGA_BLANK),
	.column_addr(column_addr),
	.row_addr(row_addr),
	.p_begin_column(11'd430), 
	.p_end_column(11'd460),
	.begin_row(begin_row6),
	.end_row(end_row6)
	);
	
		square s7(
	.clk(VGA_CLK),
	.speed(600000),
	.gameover(gameover),
	.fail(fail),
	.ready(VGA_BLANK),
	.column_addr(column_addr),
	.row_addr(row_addr),
	.p_begin_column(11'd300), 
	.p_end_column(11'd330),
	.begin_row(begin_row7),
	.end_row(end_row7)
	);
	
		square s8(
	.clk(VGA_CLK),
	.speed(100000),
	.gameover(gameover),
	.fail(fail),
	.ready(VGA_BLANK),
	.column_addr(column_addr),
	.row_addr(row_addr),
	.p_begin_column(11'd90), 
	.p_end_column(11'd120),
	.begin_row(begin_row8),
	.end_row(end_row8)
	);
	
		square s9(
	.clk(VGA_CLK),
	.speed(980000),
	.gameover(gameover),
	.fail(fail),
	.ready(VGA_BLANK),
	.column_addr(column_addr),
	.row_addr(row_addr),
	.p_begin_column(11'd700), 
	.p_end_column(11'd730),
	.begin_row(begin_row9),
	.end_row(end_row9)
	);

	
	goose g(
	.scan_code(scan_code),
	.clk(VGA_CLK),
	.gameover(gameover),
	.fail(fail),
	.ready(VGA_BLANK),
	.column_addr(column_addr),
	.row_addr(row_addr),
	.begin_column(begin_column),
	.end_column(end_column)
	);

	collision_detect c1
		  (VGA_CLK,
		   begin_column, end_column,
			11'd160, 11'd190,
			begin_row1, end_row1,
			fail1, start, scan_code);
			
	collision_detect c2
		  (VGA_CLK,
		   begin_column, end_column,
			11'd120, 11'd150,
			begin_row2, end_row2,
			fail2, start, scan_code);
			
	collision_detect c3
		  (VGA_CLK,
		   begin_column, end_column,
			11'd500, 11'd530,
			begin_row3, end_row3,
			fail3, start, scan_code);
			
	collision_detect c4
		  (VGA_CLK,
		   begin_column, end_column,
			11'd600, 11'd630,
			begin_row4, end_row4,
			fail4, start, scan_code);
			
		collision_detect c5
		  (VGA_CLK,
		   begin_column, end_column,
			11'd0, 11'd30,
			begin_row5, end_row5,
			fail5, start, scan_code);
			
				collision_detect c6
		  (VGA_CLK,
		   begin_column, end_column,
			11'd430, 11'd460,
			begin_row6, end_row6,
			fail6, start, scan_code);
			
				collision_detect c7
		  (VGA_CLK,
		   begin_column, end_column,
			11'd300, 11'd330,
			begin_row7, end_row7,
			fail7, start, scan_code);
			
				collision_detect c8
		  (VGA_CLK,
		   begin_column, end_column,
			11'd90, 11'd120,
			begin_row8, end_row8,
			fail8, start, scan_code);
			
				collision_detect c9
		  (VGA_CLK,
		   begin_column, end_column,
			11'd200, 11'd230,
			begin_row9, end_row9,
			fail9, start, scan_code);

endmodule
