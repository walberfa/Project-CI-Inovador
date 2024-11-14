`timescale  1 ps / 1 ps

module LUT3_tb;
  logic O, O1, O2, O3, O4, O5, A0, A1, A2, A3;

  //Instanciate LUT2 module as NOR, AND and OR
  LUT3 #(.INIT(8'h01)) LUT3_NOR1(.I0(A1), .I1(A2), .I2(A3), .O(O1));
  LUT3 #(.INIT(8'h01)) LUT3_NOR2(.I0(A0), .I1(A2), .I2(A3), .O(O2));
  LUT3 #(.INIT(8'h80)) LUT3_AND1(.I0(A1), .I1(A2), .I2(A3), .O(O3));
  LUT3 #(.INIT(8'h80)) LUT3_AND2(.I0(A0), .I1(A2), .I2(A3), .O(O4));
  LUT3 #(.INIT(8'hFE)) LUT3_OR1(.I0(O3), .I1(O4), .I2(O4), .O(O5));
  LUT3 #(.INIT(8'hFE)) LUT3_OR2(.I0(O1), .I1(O2), .I2(O5), .O(O));
  
  initial
    begin

      //Generate waveform
      $dumpfile("dump.vcd");
      $dumpvars;
	  
      //Create scenarios with 4 inputs
      A3 = 1'b0;
      A2 = 1'b0;
      A1 = 1'b0;
      A0 = 1'b0;
      #5;

      A3 = 1'b0;
      A2 = 1'b0;
      A1 = 1'b0;
      A0 = 1'b1;
      #5;
      
      A3 = 1'b0;
      A2 = 1'b0;
      A1 = 1'b1;
      A0 = 1'b0;
      #5;

      A3 = 1'b0;
      A2 = 1'b0;
      A1 = 1'b1;
      A0 = 1'b1;
      #5;

      A3 = 1'b0;
      A2 = 1'b1;
      A1 = 1'b0;
      A0 = 1'b0;
      #5;

      A3 = 1'b0;
      A2 = 1'b1;
      A1 = 1'b0;
      A0 = 1'b1;
      #5;
      
      A3 = 1'b0;
      A2 = 1'b1;
      A1 = 1'b1;
      A0 = 1'b0;
      #5;

      A3 = 1'b0;
      A2 = 1'b1;
      A1 = 1'b1;
      A0 = 1'b1;//Create scenarios with 4 inputs
      #5;
      
      A3 = 1'b1;
      A2 = 1'b0;
      A1 = 1'b0;
      A0 = 1'b0;
      #5;

      A3 = 1'b1;
      A2 = 1'b0;
      A1 = 1'b0;
      A0 = 1'b1;
      #5;
      
      A3 = 1'b1;
      A2 = 1'b0;
      A1 = 1'b1;
      A0 = 1'b0;
      #5;

      A3 = 1'b1;
      A2 = 1'b0;
      A1 = 1'b1;
      A0 = 1'b1;
      #5;
      
      A3 = 1'b1;
      A2 = 1'b1;
      A1 = 1'b0;
      A0 = 1'b0;
      #5;

      A3 = 1'b1;
      A2 = 1'b1;
      A1 = 1'b0;
      A0 = 1'b1;
      #5;
      
      A3 = 1'b1;
      A2 = 1'b1;
      A1 = 1'b1;
      A0 = 1'b0;
      #5;

      A3 = 1'b1;
      A2 = 1'b1;
      A1 = 1'b1;
      A0 = 1'b1;
      #5;

    end
  
    initial
    begin
      $display("                Tempo     Entradas LUTs     Saidas");
      $display("                         A3  A2  A1  A0      0");
      $display("                ====   ================   ======");
      $monitor($time,"     %b   %b   %b   %b      %b", A3, A2, A1, A0, O);
    end
  
endmodule
