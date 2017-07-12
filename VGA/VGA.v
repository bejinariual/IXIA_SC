module VGA(H_Sync, V_Sync, R_out, G_out, B_out, CLOCK, RESET, Address_OUT, Data_IO, Chip_EN, Write_EN, Out_EN, LB, UB);
	input CLOCK, RESET;
	
	output [18:0] Address_OUT;
	output [3:0] R_out, G_out, B_out;
	output H_Sync, V_Sync, Chip_EN;
	output Write_EN, Out_EN, LB, UB;
	
	inout [15:0] Data_IO;
	
	wire Active_Zone;
	wire [9:0] X_pos, Y_pos;
	
	assign LB = Address_OUT[18];
	assign UB = !Address_OUT[18];
	
	assign Chip_EN = 0;
	assign Write_EN = 1;
	assign Out_EN = 0;
	
	assign Address_OUT = Active_Zone ? (Y_pos > 0) ? ((Y_pos - 1)*800) + X_pos : X_pos : Address_OUT;
	
	assign R_out [3:1] = Active_Zone ? LB ? Data_IO[15:13] : Data_IO[7:5] : 0;
	assign G_out [3:2]= Active_Zone ? LB ? Data_IO[12:11] : Data_IO[4:3] : 0;
	assign B_out [3:1]= Active_Zone ? LB ? Data_IO[10:8] : Data_IO[2:0] : 0;
	
	Sync SM_1 (.H_Sync(H_Sync), .V_Sync(V_Sync), .CLOCK(CLOCK), .RESET(RESET), .Active_Zone(Active_Zone), .X_pos(X_pos), .Y_pos(Y_pos));
	
endmodule 