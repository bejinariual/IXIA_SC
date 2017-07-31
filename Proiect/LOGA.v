module LOGA(Address_OUT, H_Sync, V_Sync, R_OUT, G_OUT, B_OUT, Chip_EN, Out_EN, Write_EN, LB, UB, Image_Data_IN, LED_SEG_1, LED_SEG_2, CLOCK, RESET, SDA, SCL, Switch_IN, CH_INPUT);
	output reg [18:0] Address_OUT;
	output [6:0] LED_SEG_1, LED_SEG_2;
	output [3:0] R_OUT, G_OUT, B_OUT;
	output Chip_EN, Out_EN, Write_EN, LB, UB;
	output H_Sync, V_Sync;
	
	input [15:0] Image_Data_IN;
	input [7:0] Switch_IN, CH_INPUT;
	input CLOCK, RESET, SDA, SCL;
	
	reg [15:0] Pixel_Data, Read_CNT;
	reg [7:0] key_buffer;
	reg [2:0] ch_sel = 0, 	ch1_trig_mode = 0, 
									ch2_trig_mode = 0,
									ch3_trig_mode = 0,
									ch4_trig_mode = 0,
									ch5_trig_mode = 0,
									ch6_trig_mode = 0,
									ch7_trig_mode = 0,
									ch8_trig_mode = 0;
	reg trig_mode = 0;

	wire [18:0] Pixel_NR;
	wire [9:0] X_pos, Y_pos;
	wire [7:0] Sample_Reg_Data_OUT, Key_Reg, output_buffer;
	
	always @(posedge CLOCK)
	begin
		key_buffer <= Key_Reg;

///Trigger event selection		
		ch1_trig_mode <= (Switch_IN[0] && ch_sel == 0) ? (key_buffer == 8'hf0 && Key_Reg == 8'h2c) ? (ch1_trig_mode == 5) ? 0 : ch1_trig_mode + 1 : ch1_trig_mode : ch1_trig_mode; 
		ch2_trig_mode <= (Switch_IN[1] && ch_sel == 1) ? (key_buffer == 8'hf0 && Key_Reg == 8'h2c) ? (ch2_trig_mode == 5) ? 0 : ch2_trig_mode + 1 : ch2_trig_mode : ch2_trig_mode;
		ch3_trig_mode <= (Switch_IN[2] && ch_sel == 2) ? (key_buffer == 8'hf0 && Key_Reg == 8'h2c) ? (ch3_trig_mode == 5) ? 0 : ch3_trig_mode + 1 : ch3_trig_mode : ch3_trig_mode;
		ch4_trig_mode <= (Switch_IN[3] && ch_sel == 3) ? (key_buffer == 8'hf0 && Key_Reg == 8'h2c) ? (ch4_trig_mode == 5) ? 0 : ch4_trig_mode + 1 : ch4_trig_mode : ch4_trig_mode;
		ch5_trig_mode <= (Switch_IN[4] && ch_sel == 4) ? (key_buffer == 8'hf0 && Key_Reg == 8'h2c) ? (ch5_trig_mode == 5) ? 0 : ch5_trig_mode + 1 : ch5_trig_mode : ch5_trig_mode;
		ch6_trig_mode <= (Switch_IN[5] && ch_sel == 5) ? (key_buffer == 8'hf0 && Key_Reg == 8'h2c) ? (ch6_trig_mode == 5) ? 0 : ch6_trig_mode + 1 : ch6_trig_mode : ch6_trig_mode;
		ch7_trig_mode <= (Switch_IN[6] && ch_sel == 6) ? (key_buffer == 8'hf0 && Key_Reg == 8'h2c) ? (ch7_trig_mode == 5) ? 0 : ch7_trig_mode + 1 : ch7_trig_mode : ch7_trig_mode;
		ch8_trig_mode <= (Switch_IN[7] && ch_sel == 7) ? (key_buffer == 8'hf0 && Key_Reg == 8'h2c) ? (ch8_trig_mode == 5) ? 0 : ch8_trig_mode + 1 : ch8_trig_mode : ch8_trig_mode;
//////////////////////////
		
//Input channel selection
		ch_sel <= (key_buffer == 8'hf0 && Key_Reg == 8'h72) ? ch_sel + 1 : (key_buffer == 8'hf0 && Key_Reg == 8'h75) ? (ch_sel == 0) ? 7 : ch_sel - 1 : ch_sel;
/////////////////////////
		
		if(X_pos >= 0 && X_pos <= 6 && Y_pos >= 0 && Y_pos <= 70)
		begin
			if(!Switch_IN[0])
				Pixel_Data <= 0;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		//Channel 2 active LED condition
		if(X_pos >= 0 && X_pos <= 6 && Y_pos >= 72 && Y_pos <= 140)
		begin
			if(!Switch_IN[1])
				Pixel_Data <= 0;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		//Channel 3 active LED condition
		if(X_pos >= 0 && X_pos <= 6 && Y_pos >= 142 && Y_pos <= 210)
		begin
			if(!Switch_IN[2])
				Pixel_Data <= 0;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		//Channel 4 active LED condition
		if(X_pos >= 0 && X_pos <= 6 && Y_pos >= 212 && Y_pos <= 280)
		begin
			if(!Switch_IN[3])
				Pixel_Data <= 0;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		//Channel 5 active LED condition
		if(X_pos >= 0 && X_pos <= 6 && Y_pos >= 282 && Y_pos <= 350)
		begin
			if(!Switch_IN[4])
				Pixel_Data <= 0;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		//Channel 6 active LED condition
		if(X_pos >= 0 && X_pos <= 6 && Y_pos >= 352 && Y_pos <= 420)
		begin
			if(!Switch_IN[5])
				Pixel_Data <= 0;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		//Channel 7 active LED condition
		if(X_pos >= 0 && X_pos <= 6 && Y_pos >= 422 && Y_pos <= 490)
		begin
			if(!Switch_IN[6])
				Pixel_Data <= 0;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		//Channel 7 active LED condition
		if(X_pos >= 0 && X_pos <= 6 && Y_pos >= 492 && Y_pos <= 560)
		begin
			if(!Switch_IN[7])
				Pixel_Data <= 0;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else 

////Channel selection LED
		
		if(X_pos >= 17 && X_pos <= 51 && Y_pos >= 18 && Y_pos <= 38)
		begin
			if(ch_sel == 0 && Image_Data_IN == 0)
				Pixel_Data <= 16'hf8f8;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		if(X_pos >= 17 && X_pos <= 56 && Y_pos >= 88 && Y_pos <= 108)
		begin
			if(ch_sel == 1 && Image_Data_IN == 0)
				Pixel_Data <= 16'hf8f8;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		if(X_pos >= 17 && X_pos <= 55 && Y_pos >= 158 && Y_pos <= 178)
		begin
			if(ch_sel == 2 && Image_Data_IN == 0)
				Pixel_Data <= 16'hf8f8;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 17 && X_pos <= 56 && Y_pos >= 228 && Y_pos <= 248)
		begin
			if(ch_sel == 3 && Image_Data_IN == 0)
				Pixel_Data <= 16'hf8f8;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 17 && X_pos <= 56 && Y_pos >= 298 && Y_pos <= 318)
		begin
			if(ch_sel == 4 && Image_Data_IN == 0)
				Pixel_Data <= 16'hf8f8;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 17 && X_pos <= 56 && Y_pos >= 368 && Y_pos <= 388)
		begin
			if(ch_sel == 5 && Image_Data_IN == 0)
				Pixel_Data <= 16'hf8f8;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 17 && X_pos <= 56 && Y_pos >= 438 && Y_pos <= 458)
		begin
			if(ch_sel == 6 && Image_Data_IN == 0)
				Pixel_Data <= 16'hf8f8;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 17 && X_pos <= 56 && Y_pos >= 508 && Y_pos <= 528)
		begin
			if(ch_sel == 7 && Image_Data_IN == 0)
				Pixel_Data <= 16'hf8f8;
			else 
				Pixel_Data <= Image_Data_IN;
		end
		else //Pixel_Data <= Image_Data_IN;

//////////////
///Trigger LED		
		
		if(X_pos >= 18 && X_pos <= 21 && Y_pos >= 67 && Y_pos <= 70)
		begin
			if(ch1_trig_mode == 0)
				Pixel_Data <= 0;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else
	
		if(X_pos >= 18 && X_pos <= 21 && Y_pos >= 137 && Y_pos <= 140)
		begin
			if(ch2_trig_mode == 0)
				Pixel_Data <= 0;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else
	
		if(X_pos >= 18 && X_pos <= 21 && Y_pos >= 207 && Y_pos <= 210)
		begin
			if(ch3_trig_mode == 0)
				Pixel_Data <= 0;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		if(X_pos >= 18 && X_pos <= 21 && Y_pos >= 277 && Y_pos <= 280)
		begin
			if(ch4_trig_mode == 0)
				Pixel_Data <= 0;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		if(X_pos >= 18 && X_pos <= 21 && Y_pos >= 347 && Y_pos <= 350)
		begin
			if(ch5_trig_mode == 0)
				Pixel_Data <= 0;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		if(X_pos >= 18 && X_pos <= 21 && Y_pos >= 417 && Y_pos <= 420)
		begin
			if(ch6_trig_mode == 0)
				Pixel_Data <= 0;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		if(X_pos >= 18 && X_pos <= 21 && Y_pos >= 487 && Y_pos <= 490)
		begin
			if(ch7_trig_mode == 0)
				Pixel_Data <= 0;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else 
		
		if(X_pos >= 18 && X_pos <= 21 && Y_pos >= 557 && Y_pos <= 560)
		begin
			if(ch8_trig_mode == 0)
				Pixel_Data <= 0;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else // Pixel_Data <= Image_Data_IN;
		
///Trigger event LED 
///CH1
		if(X_pos >= 24 && X_pos <= 34 && Y_pos >= 58 && Y_pos <= 68)
		begin
			if(ch1_trig_mode == 1 && Image_Data_IN[7:0] == 8'hd6)
				Pixel_Data <= 16'hf8f8;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 39 && X_pos <= 49 && Y_pos >= 58 && Y_pos <= 68)
		begin
			if(ch1_trig_mode == 2 && Image_Data_IN[7:0] == 8'hd6)
				Pixel_Data <= 16'hf8f8;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 54 && X_pos <= 64 && Y_pos >= 58 && Y_pos <= 68)
		begin
			if(ch1_trig_mode == 3 && Image_Data_IN[7:0] == 8'hd6)
				Pixel_Data <= 16'hf8f8;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 69 && X_pos <= 79 && Y_pos >= 58 && Y_pos <= 68)
		begin
			if(ch1_trig_mode == 4 && Image_Data_IN[7:0] == 8'hd6)
				Pixel_Data <= 16'hf8f8;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 84 && X_pos <= 98 && Y_pos >= 58 && Y_pos <= 68)
		begin
			if(ch1_trig_mode == 5 && Image_Data_IN[7:0] == 8'hd6)
				Pixel_Data <= 16'hf8f8;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else 

///CH2

		if(X_pos >= 24 && X_pos <= 34 && Y_pos >= 128 && Y_pos <= 138)
		begin
			if(ch1_trig_mode == 1 && Image_Data_IN[7:0] == 8'hd6)
				Pixel_Data <= 16'hf8f8;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 39 && X_pos <= 49 && Y_pos >= 128 && Y_pos <= 138)
		begin
			if(ch1_trig_mode == 2 && Image_Data_IN[7:0] == 8'hd6)
				Pixel_Data <= 16'hf8f8;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 54 && X_pos <= 64 && Y_pos >= 128 && Y_pos <= 138)
		begin
			if(ch1_trig_mode == 3 && Image_Data_IN[7:0] == 8'hd6)
				Pixel_Data <= 16'hf8f8;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 69 && X_pos <= 79 && Y_pos >= 128 && Y_pos <= 138)
		begin
			if(ch1_trig_mode == 4 && Image_Data_IN[7:0] == 8'hd6)
				Pixel_Data <= 16'hf8f8;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else
		
		if(X_pos >= 84 && X_pos <= 98 && Y_pos >= 128 && Y_pos <= 138)
		begin
			if(ch1_trig_mode == 5 && Image_Data_IN[7:0] == 8'hd6)
				Pixel_Data <= 16'hf8f8;
			else
				Pixel_Data <= Image_Data_IN;
		end
		else Pixel_Data <= Image_Data_IN;
		
		Address_OUT <= Pixel_NR;
		
	end
	
	LOGA_core core(.Data_OUT(output_buffer), .Data_IN(CH_INPUT), .CLOCK(CLOCK), .RESET(RESET), .Read_CNT(Read_CNT), .trig_mode(trig_mode), .trig_event_1(ch1_trig_mode), .trig_event_2(ch2_trig_mode), .trig_event_3(ch3_trig_mode), .trig_event_4(ch4_trig_mode), .trig_event_5(ch5_trig_mode), .trig_event_6(ch6_trig_mode), .trig_event_7(ch7_trig_mode), .trig_event_8(ch8_trig_mode));
	Tastatura PS2_Keyboard(.LED_SEG_1(LED_SEG_1), .LED_SEG_2(LED_SEG_2), .Key(Key_Reg), .SDA(SDA), .SCL(SCL), .CLOCK(CLOCK), .RESET(RESET));
	VGA Display(.H_Sync(H_Sync), .V_Sync(V_Sync), .R_out(R_OUT), .G_out(G_OUT), .B_out(B_OUT), .CLOCK(CLOCK), .RESET(RESET), .Pixel_NR(Pixel_NR), .Pixel_Data(Pixel_Data), .Chip_EN(Chip_EN), .Write_EN(Write_EN), .Out_EN(OUT_EN), .LB(LB), .UB(UB), .Pixel_X_pos(X_pos), .Pixel_Y_pos(Y_pos));
	
endmodule 