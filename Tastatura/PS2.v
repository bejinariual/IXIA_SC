module PS2(RX_DATA, DATA_VALID, CLOCK, RESET, SDA, SCL);

	parameter DP_size = 8; // Data Pack size parameter 

	output [DP_size - 1:0] RX_DATA;
	output reg DATA_VALID;
	
	input CLOCK, RESET, SDA, SCL;
	
	parameter	RST_state = 0,
					IDLE_state = 1,
					RUNNING_state = 2,
					VALID_state = 3;
					
	reg [10:0] temp_reg;
	
	integer index = 0;
	integer flag = 1;
	
	always @(negedge SCL)
	begin
		temp_reg[index] = SDA;
		index = (index < 10) ? index + 1 : 0;
	end
	
	always @(posedge CLOCK)
	begin
		DATA_VALID = ((!temp_reg[0]) & ((^RX_DATA) == temp_reg[9]) & temp_reg[10]) ? 1 : 0;
		flag = DATA_VALID ? 0 : 1;
	end
	
	assign RX_DATA = temp_reg[8:1];
	
endmodule 