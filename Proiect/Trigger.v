module Trigger(HIT, IN, trig_event, CLOCK, RESET);
	output HIT;
	
	input [2:0] trig_event;
	input CLOCK, RESET, IN;
	
	reg input_buffer;
	
	wire Rising, Falling, zero, one, Rise_Fall;
	
	always @(posedge CLOCK)
	begin
		input_buffer <= (!RESET) ? IN : 0;
	end
	
	assign Rising = IN & (!input_buffer); 
	assign Falling = (!IN) & input_buffer;	
	assign zero = IN ? 0 : 1;
	assign one = IN ? 1: 0;
	assign Rise_Fall = Rising | Falling;
	
	assign HIT = (trig_event != 0) ? (trig_event == 1) ? Rising : (trig_event == 2) ? Falling : (trig_event == 3) ? zero : (trig_event == 4) ? one : (trig_event == 5) ? Rise_Fall : 1'bz : 1'bz; 
	
endmodule 