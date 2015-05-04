module restart( scan_code, clk, restart);
	
	 input [7:0] scan_code;
	 
    input clk;
	 
	 output reg restart;
	 
	 parameter ENTER = 8'h5A;
	 
	initial restart <= 0;
	
	always @(posedge clk)
			begin
			if (scan_code == ENTER)
				restart <= 1;
			end

	

endmodule 