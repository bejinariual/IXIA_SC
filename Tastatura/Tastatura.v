module Tastatura(LED_SEG_1, LED_SEG_2, SDA, SCL, CLOCK, RESET);
	output [6:0] LED_SEG_1, LED_SEG_2;
	
	input SDA, SCL, CLOCK, RESET;
	
	wire [3:0] DATA_SEG_1, DATA_SEG_2;
	
	wire VALID;
	wire [7:0] DATA_IN;
	
	assign DATA_SEG_1 = (VALID & RESET) ? DATA_IN[3:0] : RESET ? DATA_SEG_1 : 5;
	assign DATA_SEG_2 = (VALID & RESET) ? DATA_IN[7:4] : RESET ? DATA_SEG_2 : 5;
	
	PS2 CM_1 (.RX_DATA(DATA_IN), .DATA_VALID(VALID), .CLOCK(CLOCK), .RESET(RESET), .SDA(SDA), .SCL(SCL));
	Transcodor TM_1 (.LED_SEG(LED_SEG_1), .DATA_IN(DATA_SEG_1));
	Transcodor TM_2 (.LED_SEG(LED_SEG_2), .DATA_IN(DATA_SEG_2));
	
endmodule 
	