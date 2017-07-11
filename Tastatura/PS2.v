module PS2(RX_DATA, DATA_VALID, CLOCK, RESET, SDA, SCL);

	parameter DP_size = 8; // Data Pack size parameter 

	output reg [DP_size - 1:0] RX_DATA;
	output reg DATA_VALID;
	
	input CLOCK, RESET, SDA, SCL;
	
	parameter	RST_state = 0,
					IDLE_state = 1,
					RUNNING_state = 2,
					VALID_state = 3;
					
	reg [DP_size - 1:0] RX_TEMP; // Auxiliary register used to store data before output
	reg [1:0] state; 
	reg parity; 
	reg valid;
	
	integer index = 0;
	integer flag = 0;
	
	always @(negedge SCL)
	begin
		case(state)
			RST_state:	begin 
					state <= RESET ? IDLE_state : RST_state;
					index <= 0;
				  	end
			IDLE_state: begin state <= ((~SDA) & RESET) ? RUNNING_state : RESET ? IDLE_state : RST_state; index <= 0; end
			RUNNING_state: begin 
									RX_TEMP[index] = (index < 8) ? SDA : RX_TEMP;
									RX_DATA = (index == 7) ? RX_TEMP : RX_DATA;
									parity = (index == 8) ? SDA : parity;
									valid = ((^RX_DATA) == parity) ? 1 : 0;
									state = (index == 9 & SDA & RESET) ? valid ? VALID_state : IDLE_state : RESET ? RUNNING_state : RST_state;
									index = index + 1;
								end
			VALID_state: state <= IDLE_state;
			default: state <= IDLE_state;
		endcase
	end
	
	always @(posedge CLOCK)
	begin
		DATA_VALID = ((state == VALID_state) & (~flag) & RESET) ? 1 : 0;
		flag = DATA_VALID ? 1 : 0;
	end
				
endmodule 