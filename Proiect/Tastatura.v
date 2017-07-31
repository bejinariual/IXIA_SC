module Tastatura(LED_SEG_1, LED_SEG_2, Key, SDA, SCL, CLOCK, RESET);
	output [6:0] LED_SEG_1, LED_SEG_2;
	output [7:0] Key;
	input SDA, SCL, CLOCK, RESET;
	
	wire [3:0] DATA_SEG_1, DATA_SEG_2;
	
	wire VALID;
	wire [7:0] DATA_IN;
	
	assign Key = DATA_IN;
	assign DATA_SEG_1 = DATA_IN[3:0];
	assign DATA_SEG_2 = DATA_IN[7:4];
	
	PS2 CM_1 (.RX_data(DATA_IN), .CLOCK(CLOCK), .SDA(SDA), .SCL(SCL));
	Transcodor TM_1 (.LED_SEG(LED_SEG_1), .DATA_IN(DATA_SEG_1));
	Transcodor TM_2 (.LED_SEG(LED_SEG_2), .DATA_IN(DATA_SEG_2));
	
endmodule 
	