module LOGA_core(Data_OUT, Data_IN, CLOCK, RESET, Read_CNT, trig_mode, trig_event_1, trig_event_2, trig_event_3, trig_event_4, trig_event_5, trig_event_6, trig_event_7, trig_event_8);
	output [7:0] Data_OUT;
	
	input [15:0] Read_CNT;
	input [7:0] Data_IN;
	input [3:0] trig_event_1, 
					trig_event_2, 
					trig_event_3, 
					trig_event_4, 
					trig_event_5, 
					trig_event_6, 
					trig_event_7, 
					trig_event_8;
					
	input CLOCK, RESET, trig_mode;
	
	reg [7:0] Sample_REG [0 : 65535]; // 64K sample memory
	
	reg [15:0] Sample_CNT = 0;
	reg FULL = 1; //flag to indicate that the input buffer is full
	
	wire [7:0] Trigger_Buffer; //Register to store all channels trig events
	wire EMPTY, Trigger_IN, or_trig, and_trig;
	
	always @(posedge CLOCK)
	begin
		Sample_REG[Sample_CNT] = FULL ? Sample_REG[Sample_CNT] : Data_IN;
		FULL = (Trigger_IN && EMPTY)? 0 : (Sample_CNT == 65535) ? 1 : FULL; 
		Sample_CNT = (FULL && RESET) ? 0 : RESET ? Sample_CNT + 1 : 0;
	end
	
	assign Data_OUT = Sample_REG[Read_CNT];
	assign EMPTY = (Read_CNT == 65535) ? 1 : 0;
	assign Trigger_IN = trig_mode ? and_trig : or_trig; 
	
	or or_mode(or_trig, Trigger_Buffer);
	and and_mode(and_trig, Trigger_Buffer);
	
	Trigger CH1_Trig(.HIT(Trigger_Buffer[0]), .IN(Data_OUT[0]), .trig_event(trig_event_1), .CLOCK(CLOCK), .RESET(RESET));
	Trigger CH2_Trig(.HIT(Trigger_Buffer[1]), .IN(Data_OUT[1]), .trig_event(trig_event_2), .CLOCK(CLOCK), .RESET(RESET));
	Trigger CH3_Trig(.HIT(Trigger_Buffer[2]), .IN(Data_OUT[2]), .trig_event(trig_event_3), .CLOCK(CLOCK), .RESET(RESET));
	Trigger CH4_Trig(.HIT(Trigger_Buffer[3]), .IN(Data_OUT[3]), .trig_event(trig_event_4), .CLOCK(CLOCK), .RESET(RESET));
	Trigger CH5_Trig(.HIT(Trigger_Buffer[4]), .IN(Data_OUT[4]), .trig_event(trig_event_5), .CLOCK(CLOCK), .RESET(RESET));
	Trigger CH6_Trig(.HIT(Trigger_Buffer[5]), .IN(Data_OUT[5]), .trig_event(trig_event_6), .CLOCK(CLOCK), .RESET(RESET));
	Trigger CH7_Trig(.HIT(Trigger_Buffer[6]), .IN(Data_OUT[6]), .trig_event(trig_event_7), .CLOCK(CLOCK), .RESET(RESET));
	Trigger CH8_Trig(.HIT(Trigger_Buffer[7]), .IN(Data_OUT[7]), .trig_event(trig_event_8), .CLOCK(CLOCK), .RESET(RESET));
	
endmodule 
	
	