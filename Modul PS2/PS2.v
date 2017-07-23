module PS2(RX_data, VALID_data, CLOCK, RESET, SDA, SCL);
	parameter Data_Pack_size = 8;
	parameter Frame_size = 11;
	
	output [Data_Pack_size - 1 : 0] RX_data;
	output reg VALID_data;

	input CLOCK, RESET, SDA, SCL;

	reg [Frame_size - 1 : 0] temp_reg = 11'b00000000000; //Register used to temporary store the i2c frame
	reg valid = 0;

	integer	index = 0,
				flag = 0;

	always @(posedge SCL)
	begin
		index <= (index < 10) ? index + 1 : 0;
	end	

	always @(negedge SCL)
	begin
		temp_reg[index] <= SDA;
		temp_reg[10] <= (~index) ? 0 : temp_reg[10];
		temp_reg[0] <= (index == 10) ? 1 : temp_reg[0]; 
	end
	
	always @(posedge CLOCK)
	begin
		flag = VALID_data ? 0 : (index == 9) ? 1 : flag;
		VALID_data = ((!temp_reg[0]) & ((^temp_reg[8:1]) == temp_reg[9]) & temp_reg[10] & flag & (index == 10)) ? 1 : 0;
	end  

	assign RX_data = (index == 9) ? temp_reg[8:1] : RX_data; 

endmodule
	
		