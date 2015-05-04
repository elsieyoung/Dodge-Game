module collision_detect
		  (clk,
		   goose_column_begin, goose_column_end,
			pillow_column_begin, pillow_column_end,
			pillow_row_begin, pillow_row_end,
			fail, start, scan_code);
			
			initial fail <=0;
			
			input clk, start;
			input [7:0] scan_code;
			input [10:0] goose_column_begin, goose_column_end;
			input [10:0] pillow_column_begin, pillow_column_end, pillow_row_begin, pillow_row_end;
			output reg fail;
			
			parameter ENTER = 8'h5A;
			
			always @ (posedge clk) begin
			if (scan_code == ENTER)
				fail <= 0;
			else if (pillow_column_begin >= goose_column_begin && pillow_column_begin <= goose_column_end && pillow_row_end >= 11'd480 && pillow_row_begin <= 11'd540) 
				fail <= 1;
			else if (pillow_column_end >= goose_column_begin && pillow_column_end <= goose_column_end && pillow_row_end >= 11'd480 && pillow_row_begin <= 11'd540)
				fail <= 1;

			end
		


endmodule
