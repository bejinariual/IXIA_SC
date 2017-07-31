module PS2 (
  input CLOCK,
  input SDA,
  input SCL,
  output reg [7:0] RX_data
);


parameter idle    = 2'b01;
parameter receive = 2'b10;
parameter ready   = 2'b11;


reg [1:0]  state=idle;
reg [15:0] rxtimeout=16'b0000000000000000;
reg [10:0] rxregister=11'b11111111111;
reg [1:0]  datasr=2'b11;
reg [1:0]  clksr=2'b11;
reg [7:0]  rxdata;


reg datafetched;
reg rxactive;
reg dataready;


always @(posedge CLOCK ) 
begin 
  if(datafetched==1)
    RX_data <=rxdata;
end  
  
always @(posedge CLOCK ) 
begin 
  rxtimeout<=rxtimeout+1;
  datasr <= {datasr[0],SDA};
  clksr  <= {clksr[0],SCL};


  if(clksr==2'b10)
    rxregister<= {datasr[1],rxregister[10:1]};


  case (state) 
    idle: 
    begin
      rxregister <=11'b11111111111;
      rxactive   <=0;
      dataready  <=0;
      rxtimeout  <=16'b0000000000000000;
      if(datasr[1]==0 && clksr[1]==1)
      begin
        state<=receive;
        rxactive<=1;
      end   
    end
    
    receive:
    begin
      if(rxtimeout==50000)
        state<=idle;
      else if(rxregister[0]==0)
      begin
        dataready<=1;
        rxdata<=rxregister[8:1];
        state<=ready;
        datafetched<=1;
      end
    end
    
    ready: 
    begin
      if(datafetched==1)
      begin
        state     <=idle;
        dataready <=0;
        rxactive  <=0;
      end  
    end  
  endcase
end 
endmodule 