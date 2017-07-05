module PISO(SER_OUT, CLK, DATA_IN, C_PH, ENABLE);
	output SER_OUT;
	
	input CLK, C_PH, ENABLE;
	input [D_Pack-1:0] DATA_IN;
	
	reg ser_pos, ser_neg;
	
	parameter D_Pack = 8;
	
	integer index_pos = 0;
	integer index_neg = 0;
	
/*	always @(negedge ENABLE)
	begin
		ser_pos <= DATA_IN[0];
		ser_neg <= DATA_IN[0];
	end
*/	
	always @(posedge CLK)
	begin
	//	if(C_PH) 
	//		begin 
				ser_pos <= DATA_IN[index_pos];
				if(index_pos < D_Pack - 1)
					index_pos <= index_pos + 1;
				else
					index_pos <= 0;
	//		end
	end
	
	always @(negedge CLK)
	begin
	//	if(~C_PH) 
	//		begin 
				ser_neg <= DATA_IN[index_neg];
				if(index_neg < D_Pack - 1)
					index_neg <= index_neg + 1;
				else
					index_neg <= 0;
	//		end
	end			

	assign SER_OUT = C_PH ? ser_pos : ser_neg;

endmodule 


			