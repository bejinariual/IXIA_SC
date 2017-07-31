module Sync(H_Sync, V_Sync, Active_Zone, X_pos, Y_pos, CLOCK, RESET);
	input CLOCK, RESET;
	
	output reg H_Sync, V_Sync, Active_Zone;
	output [9:0] X_pos, Y_pos;
	
	// 800 x 600 @72Hz => 50MHz clock
	
	parameter	H_Visible_Area = 800,
					H_Front_Porch = 56,
					H_Back_Porch = 64,
					H_Sync_Pulse = 120,
					H_Total_Pixels = 1040;
					
	parameter	V_Visible_Area = 600,
					V_Front_Porch = 37,
					V_Back_Porch = 23,
					V_Sync_Pulse = 6,
					V_Total_Pixels = 666;
					
	integer	H_index = 0,
				V_index = 0;			
				
	always @(posedge CLOCK)
	begin
		H_Sync <= ((H_index < (H_Visible_Area + H_Front_Porch)) | (H_index > (H_Visible_Area + H_Front_Porch + H_Sync_Pulse))) ?  1 : 0;
		V_Sync <= ((V_index < (V_Visible_Area + V_Front_Porch)) | (V_index > (V_Visible_Area + V_Front_Porch + V_Sync_Pulse))) ?  1 : 0;
		Active_Zone <= ((H_index < H_Visible_Area) & (V_index < V_Visible_Area)) ? 1 : 0;
		H_index = ((H_index < H_Total_Pixels - 1) & RESET) ? H_index + 1 : 0;
		V_index = (H_index == 0 & RESET) ? (V_index < V_Total_Pixels - 1) ? V_index + 1 : 0 : RESET ? V_index : 0;
	end
	
	assign X_pos = Active_Zone ? H_index : 0;
	assign Y_pos = Active_Zone ? V_index : 0;

endmodule 
	