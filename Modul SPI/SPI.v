module SPI(SCK, SS, MOSI, MISO, BUSY, CLOCK, RST, ENABLE, C_POL, C_PH, CLK_DIV, ADR, TX_DATA, RX_DATA);
	output SCK, MOSI, SS, BUSY;
	
	input [D_Pack-1:0] TX_DATA, RX_DATA; 
	input [Freq_Div-1:0] CLK_DIV;
	input MISO, CLOCK, RST, ENABLE, C_POL, C_PH, ADR;
	
	parameter  D_Pack = 8;
	parameter Freq_Div = 3;
	
	parameter   RST_state = 0,
					IDLE_state = 1,
					RUNNING_state = 2;
					
	reg [1:0] state;
	
	
	
endmodule 
	
	