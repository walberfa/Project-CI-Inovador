`timescale  1 ps / 1 ps

module LUT2_tb;
  logic X, O1, O2, O3, A, B, C, D;
  
  LUT2 #(.INIT(4'b0111)) LUT2_NAND1( .I0(A), .I1(B), .O(O1) );
  LUT2 #(.INIT(4'b0111)) LUT2_NAND2( .I0(C), .I1(O1), .O(O2) );
  LUT2 #(.INIT(4'b0111)) LUT2_NAND3( .I0(C), .I1(D), .O(O3) );
  LUT2 #(.INIT(4'b0001)) LUT2_NOR( .I0(O2), .I1(O3), .O(X) );
  
  
  initial
    begin
      
      $dumpfile("dump.vcd");
      $dumpvars;
      
      
      A = 1'b0;
      B = 1'b0;
      C = 1'b0;
      D = 1'b0;
      #5;

      A = 1'b0;
      B = 1'b0;
      C = 1'b0;
      D = 1'b1;
      #5;
      
      A = 1'b0;
      B = 1'b0;
      C = 1'b1;
      D = 1'b0;
      #5;

      A = 1'b0;
      B = 1'b0;
      C = 1'b1;
      D = 1'b1;
      #5;

      A = 1'b0;
      B = 1'b1;
      C = 1'b0;
      D = 1'b0;
      #5;

      A = 1'b0;
      B = 1'b1;
      C = 1'b0;
      D = 1'b1;
      #5;
      
      A = 1'b0;
      B = 1'b1;
      C = 1'b1;
      D = 1'b0;
      #5;

      A = 1'b0;
      B = 1'b1;
      C = 1'b1;
      D = 1'b1;
      #5;
      
      A = 1'b1;
      B = 1'b0;
      C = 1'b0;
      D = 1'b0;
      #5;

      A = 1'b1;
      B = 1'b0;
      C = 1'b0;
      D = 1'b1;
      #5;
      
      A = 1'b1;
      B = 1'b0;
      C = 1'b1;
      D = 1'b0;
      #5;

      A = 1'b1;
      B = 1'b0;
      C = 1'b1;
      D = 1'b1;
      #5;
      
      A = 1'b1;
      B = 1'b1;
      C = 1'b0;
      D = 1'b0;
      #5;

      A = 1'b1;
      B = 1'b1;
      C = 1'b0;
      D = 1'b1;
      #5;
      
      A = 1'b1;
      B = 1'b1;
      C = 1'b1;
      D = 1'b0;
      #5;

      A = 1'b1;
      B = 1'b1;
      C = 1'b1;
      D = 1'b1;
      #5;

    end
  
    initial
    begin
      $display("                Tempo   Entradas LUTs      Saidas");
      $display("                         A   B  C  D     ");
      $display("                ====   ================  ==========");
      $monitor($time,"     %b   %b  %b   %b       %b", A, B, C, D, X);
    end
  
endmodule
