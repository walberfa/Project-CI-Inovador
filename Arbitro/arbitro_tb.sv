`timescale  1 ps / 1 ps

module tb;
  logic [3:0] Req;
  logic [3:0] Grant;
  logic Av;
  logic [1:0] Grant_num;

  arbitro arbitro_inst(.R(Req), .Av(Av), .Grant(Grant), .Grant_num(Grant_num));
  
  initial
    begin
      
      Req[0]=1'b0;
      Req[1]=1'b0;
      Req[2]=1'b0;
      Req[3]=1'b0;
      #5;
      
      Req[0]=1'b1;
      Req[1]=1'b0;
      Req[2]=1'b0;
      Req[3]=1'b0;
      #5;
      
      Req[0]=1'b0;
      Req[1]=1'b1;
      Req[2]=1'b0;
      Req[3]=1'b0;
      #5;
      
      Req[0]=1'b1;
      Req[1]=1'b1;
      Req[2]=1'b0;
      Req[3]=1'b0;
      #5;
      
      Req[0]=1'b0;
      Req[1]=1'b0;
      Req[2]=1'b1;
      Req[3]=1'b0;
      #5;
      
      Req[0]=1'b1;
      Req[1]=1'b0;
      Req[2]=1'b1;
      Req[3]=1'b0;
      #5;
      
      Req[0]=1'b0;
      Req[1]=1'b1;
      Req[2]=1'b1;
      Req[3]=1'b0;
      #5;
      
      Req[0]=1'b1;
      Req[1]=1'b1;
      Req[2]=1'b1;
      Req[3]=1'b0;
      #5;
      
      Req[0]=1'b0;
      Req[1]=1'b0;
      Req[2]=1'b0;
      Req[3]=1'b1;
      #5;
      
      Req[0]=1'b1;
      Req[1]=1'b0;
      Req[2]=1'b0;
      Req[3]=1'b1;
      #5;
      
      Req[0]=1'b0;
      Req[1]=1'b1;
      Req[2]=1'b0;
      Req[3]=1'b1;
      #5;
      
      Req[0]=1'b1;
      Req[1]=1'b1;
      Req[2]=1'b0;
      Req[3]=1'b1;
      #5;
      
      Req[0]=1'b0;
      Req[1]=1'b0;
      Req[2]=1'b1;
      Req[3]=1'b1;
      #5;
      
      Req[0]=1'b1;
      Req[1]=1'b0;
      Req[2]=1'b1;
      Req[3]=1'b1;
      #5;
      
      Req[0]=1'b0;
      Req[1]=1'b1;
      Req[2]=1'b1;
      Req[3]=1'b1;
      #5;
      
      Req[0]=1'b1;
      Req[1]=1'b1;
      Req[2]=1'b1;
      Req[3]=1'b1;
      #5;
      
      Req[0]=1'b0;
      Req[1]=1'b0;
      Req[2]=1'b0;
      Req[3]=1'b0;
      #5;
      
      
      end
  
   initial
    begin
      $display("                Tempo    Devices Request              Saidas");
      $display("                         R3  R2  R1  R0   Availabe  GRANT   Grant_number");
      $display("                ====   ================   ================================");
      $monitor($time,"     %b   %b   %b   %b       %b       %b      %b", Req[3], Req[2], Req[1], Req[0], Av, Grant, Grant_num);
    end
  
endmodule
