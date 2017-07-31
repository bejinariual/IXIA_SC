module VGA(H_Sync, V_Sync, R_out, G_out, B_out, Pixel_X_pos, Pixel_Y_pos, CLOCK, RESET, Pixel_NR, Pixel_Data, Chip_EN, Write_EN, Out_EN, LB, UB);
	input CLOCK, RESET;
	
	output [18:0] Pixel_NR;
	output [9:0] Pixel_X_pos, Pixel_Y_pos;
	output [3:0] R_out, G_out, B_out;
	output H_Sync, V_Sync, Chip_EN;
	output Write_EN, Out_EN, LB, UB;
	
	input [15:0] Pixel_Data;
	
	wire Active_Zone;
	wire [9:0] X_pos, Y_pos;
	
	assign Pixel_X_pos = X_pos;
	assign Pixel_Y_pos = Y_pos;
	
	assign LB = Pixel_NR[18];
	assign UB = !Pixel_NR[18];
	
	assign Chip_EN = 0;
	assign Write_EN = 1;
	assign Out_EN = 0;
	
	assign Pixel_NR = Active_Zone ? (Y_pos > 0) ? ((Y_pos - 1)*800) + X_pos : X_pos : Pixel_NR;
	
	assign R_out [3:1] = Active_Zone ? LB ? Pixel_Data[15:13] : Pixel_Data[7:5] : 0;
	assign G_out [3:2]= Active_Zone ? LB ? Pixel_Data[12:11] : Pixel_Data[4:3] : 0;
	assign B_out [3:1]= Active_Zone ? LB ? Pixel_Data[10:8] : Pixel_Data[2:0] : 0;
	
	Sync SM_1 (.H_Sync(H_Sync), .V_Sync(V_Sync), .CLOCK(CLOCK), .RESET(RESET), .Active_Zone(Active_Zone), .X_pos(X_pos), .Y_pos(Y_pos));
	
endmodule 