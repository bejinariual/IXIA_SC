module SIPO(PAR_OUT, CLK, DATA_IN, C_PH);
	parameter D_Pack = 8;

	output [D_Pack-1:0] PAR_OUT;
	
	input CLK, DATA_IN, C_PH;
	
	reg [D_Pack-1:0] temp_pos, temp_neg;
	reg [D_Pack - 1:0] par_pos, par_neg;
	
//	parameter TEMP = 0;
	
	integer index_pos = 7;
	integer index_neg = 7;
	
	always @(posedge CLK)
	begin
		temp_pos[index_pos] = DATA_IN;
		if(index_pos > 0)
			index_pos = index_pos - 1;
		else
			begin
				par_pos = temp_pos;
				index_pos = 7;
			end
	end
	
	always @(negedge CLK)
	begin
		temp_neg[index_neg] = DATA_IN;
		if(index_neg > 0)
			index_neg = index_neg - 1;
		else
			begin
				par_neg = temp_neg;
				index_neg = 7;
			end
	end
	
	assign PAR_OUT = C_PH ? temp_neg : temp_pos;

endmodule 