module objects
(
    VGA_CLK, gameover, fail_out,

    ready, column_addr, row_addr,

    red,green,blue, LEDR, scan_code 
);

	output [10:0]LEDR;
	
    input VGA_CLK;	 

	 input [7:0] scan_code;
    input gameover;

    input ready;
	 
	 output fail_out; 

    input [10:0] column_addr;

	 input [10:0] row_addr;
	 
    output red;
    output green;
    output blue;

    reg [2:0]issquare;

	 reg [30:0]counter;
	 
	 
assign LEDR[1] = fail1;
assign LEDR[2] = fail2;
assign LEDR[3] = fail3;
assign LEDR[4] = fail4;
assign LEDR[5] = fail5;
assign LEDR[6] = fail6;
assign LEDR[7] = fail7;
assign LEDR[8] = fail8;
assign LEDR[9] = fail9;

	 
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
//	
//	collision_detect c1
//		  (VGA_CLK,
//		   begin_column, end_column,
//			11'd320, 11'd350,
//			begin_row1, end_row1,
//			fail1);
//			
//	collision_detect c2
//		  (VGA_CLK,
//		   begin_column, end_column,
//			11'd120, 11'd150,
//			begin_row2, end_row2,
//			fail2);
//			
//	collision_detect c3
//		  (VGA_CLK,
//		   begin_column, end_column,
//			11'd500, 11'd530,
//			begin_row3, end_row3,
//			fail3);
//			
//	collision_detect c4
//		  (VGA_CLK,
//		   begin_column, end_column,
//			11'd600, 11'd630,
//			begin_row4, end_row4,
//			fail4);
//			
//		collision_detect c5
//		  (VGA_CLK,
//		   begin_column, end_column,
//			11'd570, 11'd600,
//			begin_row5, end_row5,
//			fail5);
//			
//				collision_detect c6
//		  (VGA_CLK,
//		   begin_column, end_column,
//			11'd430, 11'd460,
//			begin_row6, end_row6,
//			fail6);
//			
////				collision_detect c7
////		  (VGA_CLK,
////		   begin_column, end_column,
////			11'd30, 11'd60,
////			begin_row7, end_row7,
////			fail7);
////			
//				collision_detect c8
//		  (VGA_CLK,
//		   begin_column, end_column,
//			11'd90, 11'd120,
//			begin_row8, end_row8,
//			fail8);
//			
//				collision_detect c9
//		  (VGA_CLK,
//		   begin_column, end_column,
//			11'd300, 11'd330,
//			begin_row9, end_row9,
//			fail9);
			
	
	   always @(posedge VGA_CLK) begin
		  if (gameover || fail)
				issquare <= 1'b0; 
		  else begin
			if (column_addr >= 11'd320 && column_addr < 11'd350 &&  row_addr >= 11'd0 && row_addr < 11'd80)
				issquare <= 1'b1;
//			if (column_addr >= 11'd320 && column_addr < 11'd350 &&  row_addr >= begin_row1 && row_addr < end_row1)
//				issquare <= 1'b1;
//			else if (column_addr >= 11'd120 && column_addr < 11'd150 &&  row_addr >= begin_row2 && row_addr < end_row2)
//				issquare <= 1'b1;	
//			else if (column_addr >= 11'd500 && column_addr < 11'd530 &&  row_addr >= begin_row3 && row_addr < end_row3)
//				issquare <= 1'b1;
//			else if (column_addr >= 11'd600 && column_addr < 11'd630 &&  row_addr >= begin_row4 && row_addr < end_row4)
//				issquare <= 1'b1;
//			else if (column_addr >= 11'd570 && column_addr < 11'd600 &&  row_addr >= begin_row5 && row_addr < end_row5)
//				issquare <= 1'b1;
//			else if (column_addr >= 11'd430 && column_addr < 11'd460 &&  row_addr >= begin_row6 && row_addr < end_row6)
//				issquare <= 1'b1;
//			else if (column_addr >= 11'd300 && column_addr < 11'd330 &&  row_addr >= begin_row7 && row_addr < end_row7)
//				issquare <= 1'b1;
//			else if (column_addr >= 11'd90 && column_addr < 11'd120 &&  row_addr >= begin_row8 && row_addr < end_row8)
//				issquare <= 1'b1;
//			else if (column_addr >= 11'd200 && column_addr < 11'd230 &&  row_addr >= begin_row9 && row_addr < end_row9)
//				issquare <= 1'b1;
//			else if (column_addr >= begin_column && column_addr < end_column &&  row_addr >= 11'd0 && row_addr < 11'd80)
//				issquare <= 1'b1;				
         else
            issquare <= 1'b0;
		  end
		end

    assign red = ready && issquare ? 1'b1: 1'b0;

    assign green = ready && issquare ? 1'b1 : 1'b0;

    assign blue = ready && issquare ? 1'b1: 1'b0;
	
//	
//	square s1(
//	.clk(VGA_CLK),
//	.speed(50000000),
//	.gameover(gameover),
//	.fail(fail),
//	.ready(VGA_BLANK),
//	.column_addr(column_addr),
//	.row_addr(row_addr),
//	.p_begin_column(11'd320), 
//	.p_end_column(11'd350),
//	.begin_row(begin_row1),
//	.end_row(end_row1)
//	);
//	
//	square s2(
//	.clk(VGA_CLK),
//	.speed(50000000),
//	.gameover(gameover),
//	.fail(fail),
//	.ready(VGA_BLANK),
//	.column_addr(column_addr),
//	.row_addr(row_addr),
//	.p_begin_column(11'd120), 
//	.p_end_column(11'd150),
//	.begin_row(begin_row2),
//	.end_row(end_row2)
//	);
//	
//	square s3(
//	.clk(VGA_CLK),
//	.speed(20000000),
//	.gameover(gameover),
//	.fail(fail),
//	.ready(VGA_BLANK),
//	.column_addr(column_addr),
//	.row_addr(row_addr),
//	.p_begin_column(11'd500), 
//	.p_end_column(11'd530),
//	.begin_row(begin_row3),
//	.end_row(end_row3)
//	);
//	
//	square s4(
//	.clk(VGA_CLK),
//	.speed(7000000),
//	.gameover(gameover),
//	.fail(fail),
//	.ready(VGA_BLANK),
//	.column_addr(column_addr),
//	.row_addr(row_addr),
//	.p_begin_column(11'd600), 
//	.p_end_column(11'd630),
//	.begin_row(begin_row4),
//	.end_row(end_row4)
//	);
//	
//		square s5(
//	.clk(VGA_CLK),
//	.speed(60000000),
//	.gameover(gameover),
//	.fail(fail),
//	.ready(VGA_BLANK),
//	.column_addr(column_addr),
//	.row_addr(row_addr),
//	.p_begin_column(11'd570), 
//	.p_end_column(11'd600),
//	.begin_row(begin_row5),
//	.end_row(end_row5)
//	);
//	
//		square s6(
//	.clk(VGA_CLK),
//	.speed(70000000),
//	.gameover(gameover),
//	.fail(fail),
//	.ready(VGA_BLANK),
//	.column_addr(column_addr),
//	.row_addr(row_addr),
//	.p_begin_column(11'd430), 
//	.p_end_column(11'd460),
//	.begin_row(begin_row6),
//	.end_row(end_row6)
//	);
//	
//		square s7(
//	.clk(VGA_CLK),
//	.speed(50000),
//	.gameover(gameover),
//	.fail(fail),
//	.ready(VGA_BLANK),
//	.column_addr(column_addr),
//	.row_addr(row_addr),
//	.p_begin_column(11'd300), 
//	.p_end_column(11'd330),
//	.begin_row(begin_row7),
//	.end_row(end_row7)
//	);
//	
//		square s8(
//	.clk(VGA_CLK),
//	.speed(40000000),
//	.gameover(gameover),
//	.fail(fail),
//	.ready(VGA_BLANK),
//	.column_addr(column_addr),
//	.row_addr(row_addr),
//	.p_begin_column(11'd90), 
//	.p_end_column(11'd120),
//	.begin_row(begin_row8),
//	.end_row(end_row8)
//	);
//	
//		square s9(
//	.clk(VGA_CLK),
//	.speed(1000000),
//	.gameover(gameover),
//	.fail(fail),
//	.ready(VGA_BLANK),
//	.column_addr(column_addr),
//	.row_addr(row_addr),
//	.p_begin_column(11'd200), 
//	.p_end_column(11'd6230),
//	.begin_row(begin_row9),
//	.end_row(end_row9)
//	);
//
//	
//	goose g(
//	.scan_code(scan_code),
//	.clk(VGA_CLK),
//	.gameover(gameover),
//	.fail(fail),
//	.ready(VGA_BLANK),
//	.column_addr(column_addr),
//	.row_addr(row_addr),
//	.begin_column(begin_column),
//	.end_column(end_column)
//	);

endmodule 