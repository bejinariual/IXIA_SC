module SIPO(PAR_OUT, CLK, DATA_IN, C_PH);
	output [D_Pack-1:0] PAR_OUT;
	
	input CLK, DATA_IN, C_PH;
	
	reg [D_Pack-1:0] temp_pos, temp_neg;
	reg [D_Pack - 1:0] par_pos, par_neg;
	
	parameter D_Pack = 8;
	parameter TEMP = 0;
	
	integer index_pos = 0;
	integer index_neg = 0;
	
	always @(posedge CLK)
	begin
		temp_pos[index_pos] <= DATA_IN;
		if(index_pos < D_Pack - 1)
			index_pos <= index_pos + 1;
		else
			begin
				par_pos <= temp_pos;
				index_pos <= 0;
			end
	end
	
	always @(negedge CLK)
	begin
		temp_neg[index_neg] <= DATA_IN;
		if(index_neg < D_Pack - 1)
			index_neg <= index_neg + 1;
		else
			begin
				par_neg <= temp_neg;
				index_neg <= 0;
			end
	end
	
	assign PAR_OUT = TEMP ? temp_neg : temp_pos;
/*	always @(posedge CLK)
	begin
		if(~C_PH)
			begin
				temp[index] <= DATA_IN;
				if(index < D_Pack - 1)
					index <= index + 1;
				else 
					begin
						PAR_OUT <= temp;
						index <= 0;
					end
			end
	end
	
	always @(negedge CLK)
	begin
		if(C_PH)
			begin
				temp[index] <= DATA_IN;
				if(index < D_Pack - 1)
					index <= index + 1;
				else 
					begin
						PAR_OUT <= temp;
						index <= 0;
					end
			end
	end
*/				
endmodule 