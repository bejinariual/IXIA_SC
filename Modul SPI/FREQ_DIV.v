module FREQ_DIV(SCK, CLK, SCK_ENABLE, DIV, C_POL);
	output reg SCK;
	
	input CLK, SCK_ENABLE, DIV, C_POL;
	
	reg [7:0] COUNT = 0;
	
	always @(posedge CLK)
		if(~SCK_ENABLE)
			begin 
				SCK <= COUNT[DIV] + C_POL;
				COUNT <= COUNT + 1;
			end
		else 
			begin
				COUNT <= 0;
				SCK <= C_POL;
			end

endmodule 			
		
	