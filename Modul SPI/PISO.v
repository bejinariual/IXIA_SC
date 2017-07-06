module PISO(SER_OUT, CLK, DATA_IN, C_PH, ENABLE);
	output SER_OUT;
	
	input CLK, C_PH, ENABLE;
	input [D_Pack - 1:0] DATA_IN;
	
	reg ser_pos, ser_neg;
	
	parameter D_Pack = 8;
	parameter TEMP = 0;
	
	integer index_pos = 7;
	integer index_neg = 7;
	
	always @(posedge CLK or negedge ENABLE)
	begin
		if(!ENABLE)
		begin
				ser_pos <= DATA_IN[index_pos];
				if(index_pos > 0) 
					index_pos <= index_pos - 1;
				else
					index_pos <= 7;
		end
		else index_pos <= 7;
	end
	
	always @(negedge CLK or negedge ENABLE)
	begin
		if(!ENABLE)
		begin
			ser_neg <= DATA_IN[index_neg];
			if(index_neg > 0)
				index_neg <= index_neg - 1;
			else
				index_neg <= 7;
		end 
		else index_neg <= 7;
	end			

	assign SER_OUT = TEMP ? ser_pos : ser_neg;

endmodule 



			