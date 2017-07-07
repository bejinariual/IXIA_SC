module PS2(RX_DATA, DATA_VALID, CLOCK, RESET, SDA, SCL);
	output reg [DP_size - 1:0] RX_DATA;
	output DATA_VALID;
	
	input CLOCK, RESET, SDA, SCL;
	
	parameter DP_size = 8; // Data Pack size parameter 
	
	parameter	RST_state = 0,
					IDLE_state = 1,
					RUNNING_state = 2,
					VALID_state = 3;
					
	reg [DP_size - 1:0] RX_TEMP; // Auxiliary register used to store data before output
	reg [1:0] state; 
	reg parity; 
	reg valid;
	
	integer index = 0;
	
	always @(negedge SCL)
		case(state)
			RST_state: state <= RESET ? IDLE_state : RST_state;
			IDLE_state: state <= ((!SDA) && RESET) ? RUNNING_state : RESET ? RST_state : IDLE_state;
			RUNNING_state: begin 
									RX_TEMP[index] = (index <= 7) ? SDA : RX_TEMP;
									index = (index < 9) ? index + 1 : 0;
									RX_DATA <= (index == 7) ? RX_TEMP : RX_DATA;
									parity <= (index == 8) ? SDA : parity;
									valid <= ((^RX_DATA) == parity) ? 1 : 0;
									state <= (index == 9 && SDA) ? valid ? VALID_state : IDLE_state : IDLE_state;
								end
			VALID_state: state <= IDLE_state;
			default: state <= IDLE_state;
		endcase
		
endmodule 