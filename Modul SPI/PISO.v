module PISO(SER_OUT, CLK, DATA_IN, DATA_ENABLE, C_PH);
	output reg SER_OUT;
	
	input CLK, DATA_ENABLE, C_PH;
	input [7:0] DATA_IN;
	
	integer index;
	
	always @(posedge CLK) 
		if(~DATA_ENABLE)
			for(index = 0; index < SPI.D_Pack; index = index + 1)
				SER_OUT <= DATA_IN[index];
				
endmodule 
			