`timescale  1 ps / 1 ps

module arbitro(R, Av, Grant, Grant_num);
  input logic [3:0] R;
  output logic [3:0] Grant;
  output logic Av;
  output logic [1:0] Grant_num;
  
always_comb
  begin
    //Definição do Available
    Av = ~(R[3]|R[2]|R[1]|R[0]);
    
    //Definição do Grant
    Grant[0] = ~R[3]&~R[2]&~R[1]&R[0];
    Grant[1] = ~R[3]&~R[2]&R[1];
    Grant[2] = ~R[3]&R[2];
    Grant[3] = R[3];
    
    //Definição do Grant_num
    case(Av)
      1'b1 : Grant_num = 2'bxx;
    endcase
    
    case(R[3])
      1'b1 : Grant_num = 2'b11;
    endcase
    
    case(R[3:2])
      2'b01 : Grant_num = 2'b10;
    endcase
    
    case(R[3:1])
      3'b001 : Grant_num = 2'b01;
    endcase
    
    case(R)
      4'b0001 : Grant_num = 2'b00;
    endcase
    
  end
endmodule   
    
