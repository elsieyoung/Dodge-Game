module start_state(clk, start, scan_code);
	
	 
	 input [7:0] scan_code; 
	 
    input clk;
	 output reg start;

	
	 
	initial start <= 0;
	parameter SPACE = 8'h29;
	parameter ENTER = 8'h5A;
	
	always @(posedge clk)
			begin
			if (scan_code == SPACE)
				start <= 1;
			else if (scan_code == ENTER)
				start <= 0;
			end

	

endmodule 