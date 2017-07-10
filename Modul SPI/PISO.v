module PISO(SER_OUT, CLK, DATA_IN, C_PH, ENABLE);
	parameter D_Pack = 8;

	output SER_OUT;
	
	input CLK, C_PH, ENABLE;
	input [D_Pack - 1:0] DATA_IN;
	
	reg ser_pos, ser_neg;
	
//	parameter TEMP = 0;
	
	integer index_pos = 7;
	integer index_neg = 7;
	
	always @(posedge CLK or negedge ENABLE)
	begin
		if(!ENABLE)
		begin
				ser_pos = DATA_IN[index_pos];
				if(index_pos > 0) begin 
					index_pos = index_pos - 1; end
				else begin
					index_pos = 7; end
		end
		else index_pos = 7;
	end
	
	always @(negedge CLK or negedge ENABLE)
	begin
		if(!ENABLE)
		begin
			ser_neg = DATA_IN[index_neg];
			if(index_neg > 0) begin
				index_neg = index_neg - 1; end
			else begin
				index_neg = 7; end
		end 
		else index_neg = 7;
	end			

	assign SER_OUT = C_PH ? ser_pos : ser_neg;

endmodule 



			