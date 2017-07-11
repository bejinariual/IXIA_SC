module VGA(H_Sync, V_Sync, R_out, G_out, B_out, CLOCK, RESET);
	input CLOCK, RESET;
	
	output [3:0] R_out, G_out, B_out;
	output H_Sync, V_Sync;
	
	wire Active_Zone;
	wire [9:0] X_pos, Y_pos;
	
	assign R_out = Active_Zone ? 15 : 0;
	assign G_out = 0;
	assign B_out = 0;	
	
	Sync SM_1 (.H_Sync(H_Sync), .V_Sync(V_Sync), .CLOCK(CLOCK), .RESET(RESET), .Active_Zone(Active_Zone), .X_pos(X_pos), .Y_pos(Y_pos));
	
endmodule 