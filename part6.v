module part6(
	CLOCK_50,KEY,    // clk,rst_n,
	VGA_CLK,        //40MHZ
	VGA_HS,VGA_VS,   
	VGA_BLANK,    //ready
	VGA_SYNC,
	VGA_R, 
	VGA_G,
	VGA_B,
	PS2_DAT,
	PS2_CLK,
	GPIO_0, GPIO_1,
	HEX0,HEX1,
	LEDR,
	SW
	);
	
	input [0:0] SW;
	input    PS2_DAT;
	input    PS2_CLK;
	inout  [35:0]  GPIO_0, GPIO_1;
	input CLOCK_50; //clk;
	input [0:0] KEY; //rst_n;
	output [10:0] LEDR;
	output VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC;
	output [9:0] VGA_R, VGA_G, VGA_B;
	output [0:6]    HEX0,HEX1;  // Seven Segment Digits
	
	//  set all inout ports to tri-state
	assign  GPIO_0    =  36'hzzzzzzzzz;
	assign  GPIO_1    =  36'hzzzzzzzzz;
	

	assign VGA_SYNC = 1'b0;
	

   pll_module U1(
	.inclk0(CLOCK_50),
	.c0(VGA_CLK)
	);

	wire [10:0] column_addr;
	wire [10:0] row_addr;
	
   sync_module U2(
	.clk(VGA_CLK),
	.vsync(VGA_VS),
	.hsync(VGA_HS),
	.column_addr(column_addr),
	.row_addr(row_addr),
	.ready(VGA_BLANK)
	);
	
	oneshot pulser(
   .pulse_out(read),
   .trigger_in(scan_ready),
   .clk(CLOCK_50)
);

keyboard kbd(
  .keyboard_clk(PS2_CLK),
  .keyboard_data(PS2_DAT),
  .clock50(CLOCK_50),
  .reset(reset),
  .read(read),
  .scan_ready(scan_ready),
  .scan_code(scan_code)
);

wire [7:0] scan_code;
wire read, scan_ready;

wire start;
start_state st(CLOCK_50, start, scan_code);


reg gameover;
reg [25:0]counter; 
reg [7:0] timecount;

initial begin 
	gameover<=0;
	timecount<=0;
	end

	parameter ENTER = 8'h5A;
	parameter SPACE = 8'h29;
	
always @ (posedge CLOCK_50) begin
	if (scan_code == SPACE) 
		timecount <= 0;
	if(counter == 50000000) begin
		timecount <= timecount + 1; 
		counter <= 0; end
	else if (timecount < 30 && ~fail_out)	
		counter <= counter + 1;
end 

always @(posedge CLOCK_50) begin
	if (scan_code == ENTER)
			gameover <= 0;
	else if (timecount == 30)
			gameover <= 1;
end
		
	
char_7seg d1(timecount[3:0], HEX0);
char_7seg d2(timecount[7:4], HEX1);

wire red,green,blue;

	assign VGA_R = {10{red}},

         VGA_G = {10{green}},

         VGA_B = {10{blue}};
	
	wire fail_out; 
	

bars b (column_addr, row_addr,
	red, green, blue, VGA_CLK, gameover, fail_out, ready, scan_code, start,LEDR);
	
endmodule


module sync_module

(

    clk,

    vsync,hsync,ready,

    column_addr,row_addr

);




    input clk;

    output vsync;

    output hsync;

    output ready;

    output [9:0] column_addr;

    output [9:0] row_addr;




    reg [10:0] count_h;




    always @(posedge clk)


       if (count_h == 11'd1056)

            count_h <= 11'd0;

        else

            count_h <= count_h + 1'b1;

            

    reg [10:0] count_v;




    always @(posedge clk)
		if(count_v == 11'd628)

            count_v <= 11'd0;

        else if(count_h == 11'd1056)

            count_v <= count_v + 1'b1;

            

    reg isready;




    always @(posedge clk)


        if ((count_h > 11'd216 && count_h < 11'd1017) &&

                (count_v > 11'd27 && count_v < 11'd627))

            isready <= 1'b1;

        else

            isready <= 1'b0;

            

    assign vsync = (count_v <=11'd4) ? 1'b0: 1'b1;

    assign hsync = (count_h <= 11'd128) ? 1'b0: 1'b1;

    assign ready = isready;

    

    assign column_addr = isready ? count_h - 11'd217 : 11'd0;

    assign row_addr = isready ? count_v - 11'd28 : 11'd0;

    

endmodule



module square

(

    clk,speed, gameover, fail,

    ready,column_addr,row_addr,
	 p_begin_column, p_end_column,
	 begin_row, end_row

);




    input clk;
	 
	 input [30:0] speed;
	 
	 input[10:0] p_begin_column;
	 
	 input [10:0]p_end_column;

    input gameover, fail;

    input ready;

    input [10:0] column_addr;

    input [10:0] row_addr;
	 
	 
	 output [10:0]end_row;
	 output [10:0] begin_row; 
    

    reg [2:0]issquare;

    reg [10:0]begin_row = 11'd0;
	 reg [10:0]end_row = 11'd60;
	 reg [30:0]counter ;

	always @(posedge clk)
	begin
		if (counter == speed) 
			begin
			counter <= 0;
			if (~gameover && ~fail) begin
				if(end_row==11'd600)begin
					begin_row <= 11'd0;
					end_row <= 11'd60;
				end
				else begin
					begin_row <= begin_row + 1;
					end_row <= end_row + 1;
				end 
				end
			else if (gameover || fail) begin
					begin_row <= 11'd0;
					end_row <= 11'd60;
			end
			end
		else 
			begin
			counter <= counter + 1;
			end 
	end
endmodule


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module pll_module (
   
    inclk0,
    c0,
    );


    input      inclk0;
    output      c0;
   

    wire [5:0] sub_wire0;
    wire [0:0] sub_wire6 = 1'h0;
    wire [2:2] sub_wire3 = sub_wire0[2:2];
    wire [1:1] sub_wire2 = sub_wire0[1:1];
    wire [0:0] sub_wire1 = sub_wire0[0:0];
    wire  c0 = sub_wire1;
    wire  sub_wire4 = inclk0;
    wire [1:0] sub_wire5 = {sub_wire6, sub_wire4};

    altpll    altpll_component (
                .inclk (sub_wire5),
                .clk (sub_wire0),
                .activeclock (),
                .clkbad (),
                .clkena ({6{1'b1}}),
                .clkloss (),
                .clkswitch (1'b0),
                .configupdate (1'b0),
                .enable0 (),
                .enable1 (),
                .extclk (),
                .extclkena ({4{1'b1}}),
                .fbin (1'b1),
                .fbmimicbidir (),
                .fbout (),
                .locked (),
                .pfdena (1'b1),
                .phasecounterselect ({4{1'b1}}),
                .phasedone (),
                .phasestep (1'b1),
                .phaseupdown (1'b1),
                .pllena (1'b1),
                .scanaclr (1'b0),
                .scanclk (1'b0),
                .scanclkena (1'b1),
                .scandata (1'b0),
                .scandataout (),
                .scandone (),
                .scanread (1'b0),
                .scanwrite (1'b0),
                .sclkout0 (),
                .sclkout1 (),
                .vcooverrange (),
                .vcounderrange ());
    defparam
        altpll_component.clk0_divide_by = 15,
        altpll_component.clk0_duty_cycle = 50,
        altpll_component.clk0_multiply_by = 14,
        altpll_component.clk0_phase_shift = "0",
        altpll_component.clk1_divide_by = 3,
        altpll_component.clk1_duty_cycle = 50,
        altpll_component.clk1_multiply_by = 2,
        altpll_component.clk1_phase_shift = "0",
        altpll_component.clk2_divide_by = 15,
        altpll_component.clk2_duty_cycle = 50,
        altpll_component.clk2_multiply_by = 14,
        altpll_component.clk2_phase_shift = "-9921",
        altpll_component.compensate_clock = "CLK0",
        altpll_component.inclk0_input_frequency = 37037,
        altpll_component.intended_device_family = "Cyclone II",
        altpll_component.lpm_type = "altpll",
        altpll_component.operation_mode = "NORMAL",
        altpll_component.port_activeclock = "PORT_UNUSED",
        altpll_component.port_areset = "PORT_USED",
        altpll_component.port_clkbad0 = "PORT_UNUSED",
        altpll_component.port_clkbad1 = "PORT_UNUSED",
        altpll_component.port_clkloss = "PORT_UNUSED",
        altpll_component.port_clkswitch = "PORT_UNUSED",
        altpll_component.port_configupdate = "PORT_UNUSED",
        altpll_component.port_fbin = "PORT_UNUSED",
        altpll_component.port_inclk0 = "PORT_USED",
        altpll_component.port_inclk1 = "PORT_UNUSED",
        altpll_component.port_locked = "PORT_UNUSED",
        altpll_component.port_pfdena = "PORT_UNUSED",
        altpll_component.port_phasecounterselect = "PORT_UNUSED",
        altpll_component.port_phasedone = "PORT_UNUSED",
        altpll_component.port_phasestep = "PORT_UNUSED",
        altpll_component.port_phaseupdown = "PORT_UNUSED",
        altpll_component.port_pllena = "PORT_UNUSED",
        altpll_component.port_scanaclr = "PORT_UNUSED",
        altpll_component.port_scanclk = "PORT_UNUSED",
        altpll_component.port_scanclkena = "PORT_UNUSED",
        altpll_component.port_scandata = "PORT_UNUSED",
        altpll_component.port_scandataout = "PORT_UNUSED",
        altpll_component.port_scandone = "PORT_UNUSED",
        altpll_component.port_scanread = "PORT_UNUSED",
        altpll_component.port_scanwrite = "PORT_UNUSED",
        altpll_component.port_clk0 = "PORT_USED",
        altpll_component.port_clk1 = "PORT_USED",
        altpll_component.port_clk2 = "PORT_USED",
        altpll_component.port_clk3 = "PORT_UNUSED",
        altpll_component.port_clk4 = "PORT_UNUSED",
        altpll_component.port_clk5 = "PORT_UNUSED",
        altpll_component.port_clkena0 = "PORT_UNUSED",
        altpll_component.port_clkena1 = "PORT_UNUSED",
        altpll_component.port_clkena2 = "PORT_UNUSED",
        altpll_component.port_clkena3 = "PORT_UNUSED",
        altpll_component.port_clkena4 = "PORT_UNUSED",
        altpll_component.port_clkena5 = "PORT_UNUSED",
        altpll_component.port_extclk0 = "PORT_UNUSED",
        altpll_component.port_extclk1 = "PORT_UNUSED",
        altpll_component.port_extclk2 = "PORT_UNUSED",
        altpll_component.port_extclk3 = "PORT_UNUSED";


endmodule

// implements a 7-segment decoder
module char_7seg (C, Display);

	input [3:0] C; // input code
	output reg [0:6] Display; // output 7-seg code
	
   always @ (C)
	   case (C)
		  4'b0000: Display = 7'b0000001;
		  4'b0001: Display = 7'b1001111;
		  4'b0010: Display = 7'b0010010;
		  4'b0011: Display = 7'b0000110;
		  4'b0100: Display = 7'b1001100;
		  4'b0101: Display = 7'b0100100;
		  4'b0110: Display = 7'b0100000;
		  4'b0111: Display = 7'b0001111;
		  4'b1000: Display = 7'b0000000;
		  4'b1001: Display = 7'b0000100;
		  4'b1010: Display = 7'b0001000;
		  4'b1011: Display = 7'b1100000;
		  4'b1100: Display = 7'b0110001;
		  4'b1101: Display = 7'b1000010;
		  4'b1110: Display = 7'b0110000;
		  4'b1111: Display = 7'b0111000;
		 endcase
endmodule 	

