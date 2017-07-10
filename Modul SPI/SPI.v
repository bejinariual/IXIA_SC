module SPI(SCK, SS, MOSI, MISO, BUSY, CLOCK, RST, ENABLE, C_POL, C_PH, CLK_DIV, ADDR, TX_DATA, RX_DATA);
	parameter  D_Pack = 8;
	parameter Freq_Div = 3;

	output SCK, SS, MOSI, BUSY;
	output [D_Pack-1:0] RX_DATA;
	
	input MISO, CLOCK, RST, ENABLE, C_POL, C_PH, ADDR;
	input [D_Pack-1:0] TX_DATA; 
	input [Freq_Div-1:0] CLK_DIV;
	
	parameter   RST_state = 0,
					IDLE_state = 1,
					RUNNING_state = 2;
					
	reg [1:0] state;
	
	always @(posedge CLOCK)
	begin
		case(state)
			RST_state: state <= RST ? IDLE_state : RST_state;
			IDLE_state: state <= !RST ? RST_state : ENABLE ? IDLE_state : RUNNING_state;
			RUNNING_state: state <= !RST ? RST_state : ENABLE ? IDLE_state : RUNNING_state;
			default: state <= IDLE_state;
		endcase	
	end
	
	assign SS = (state == RUNNING_state) ? ADDR : 1;
	assign BUSY = ((state == RST_state) | (~SS)) ? 1 : 0;
	assign SCK = (state == RST_state) ? SCK : 1'bz;
	
	FREQ_DIV CLKM_1 (.SCK(SCK), .CLK(CLOCK), .SCK_ENABLE(SS), .DIV(CLK_DIV), .C_POL(C_POL));
	PISO SR_1 (.SER_OUT(MOSI), .CLK(SCK), .DATA_IN(TX_DATA), .C_PH(C_PH), .ENABLE(SS));
	SIPO SR_2 (.PAR_OUT(RX_DATA), .CLK(SCK), .DATA_IN(MISO), .C_PH(C_PH));
	
endmodule 
	
	