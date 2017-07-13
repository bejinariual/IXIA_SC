module Mem(Address_OUT, Data_OUT, Write_EN, Chip_EN, Out_EN, LB, UB, Done, CLOCK);
	input CLOCK;
	
	output reg [18:0] Address_OUT;
	output reg [15:0] Data_OUT;
	output reg Write_EN;
	output Chip_EN, Out_EN, LB, UB, Done;
	
	assign LB = Address_OUT[18];
	assign UB = !Address_OUT[18];
	
	assign Chip_EN = 0;
	assign Out_EN = 1;
	
	integer	stop = 0,
				Addr_index = 0,
				Data_index = 0;
	
	always @(posedge CLOCK)
	begin
		Write_EN = 1;
		Address_OUT = Addr_index;
		
		if(!LB) begin
			Data_OUT[7:0] = Data_index; end
		else begin
			Data_OUT[15:8] = Data_index; end
		
		Write_EN = (!stop) ? 0 : 1;
		Addr_index = (Addr_index < 480000) ? Addr_index + 1 : 0;
		Data_index = (Data_index < 255) ? Data_index + 1 : 0;
		stop = (Addr_index == 0) ? 1 : stop;
	end
	
	assign Done = stop ? 1 : 0;
	
endmodule 