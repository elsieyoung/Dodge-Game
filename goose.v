module goose
(
	 scan_code,
    clk,gameover,
	fail,
    ready,column_addr,row_addr,
	 begin_column, end_column

);



	 input [7:0] scan_code;
	 
    input clk;

    input gameover, fail;

    input ready;

    input [10:0] column_addr;

    input [10:0] row_addr;

	 output [10:0]begin_column;
	 
	 output [10:0]end_column;

    parameter LEFT = 8'h6B;
	 parameter RIGHT = 8'h74;

    reg issquare;

    reg [10:0]begin_column = 11'd340;
	 reg [10:0]end_column = 11'd420;
	 reg [30:0]counter;
	 

	 initial counter <= 0;
	 

 always @(posedge clk)
	begin
		if (counter == 250000) 
			begin
			counter <= 0;
			end
		else 
			begin
			counter <= counter + 1;
			end 
	end 

	always @(posedge clk)
		if (fail || gameover) begin
			begin_column <= begin_column;
			end_column <= end_column;
			end
		else if (counter == 250000) 
			begin
			if (scan_code == LEFT) begin
			begin_column <= begin_column - 1; 
			end_column <= end_column - 1; 
			end
			else if (scan_code == RIGHT) begin
			begin_column <= begin_column + 1;
			end_column <= end_column + 1; end
			end
	

endmodule 