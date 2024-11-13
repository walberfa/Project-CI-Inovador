`timescale  1 ps / 1 ps

module LUTQ3_tb;
  
  logic S, Cout, O1, O2, O3, A, B, Cin;
  
  LUT2 #(.INIT(4'h8)) LUT2_AND1( .I0(A), .I1(B), .O(O1));
  LUT2 #(.INIT(4'h8)) LUT2_AND2( .I0(A), .I1(Cin), .O(O2));
  LUT2 #(.INIT(4'h8)) LUT2_AND3( .I0(B), .I1(Cin), .O(O3));
  LUT3 #(.INIT(8'h96))LUT3_XOR( .I0(A), .I1(B), .I2(Cin), .O(S));
  LUT3 #(.INIT(8'hFE)) LUT3_OR( .I0(O1), .I1(O2), .I2(O3), .O(Cout));
  
  initial
    begin
      
      $dumpfile("dump.vcd");
      $dumpvars;
      
      A = 1'b0;
      B = 1'b0;
      Cin = 1'b0;
      #5;
      
      A = 1'b0;
      B = 1'b0;
      Cin = 1'b1;
      #5;

      A = 1'b0;
      B = 1'b1;
      Cin = 1'b0;
      #5;
      
      A = 1'b0;
      B = 1'b1;
      Cin = 1'b1;
      #5;

      A = 1'b1;
      B = 1'b0;
      Cin = 1'b0;
      #5;
      
      A = 1'b1;
      B = 1'b0;
      Cin = 1'b1;
      #5;

      A = 1'b1;
      B = 1'b1;
      Cin = 1'b0;
      #5;
      
      A = 1'b1;
      B = 1'b1;
      Cin = 1'b1;
      #5;
      
      end
  
    initial
    begin
      $display("                Tempo   Entradas LUTs      Saida");
      $display("                         A   B  Cin       S  Cout");
      $display("                ====   ==============  ==========");
      $monitor($time,"     %b   %b    %b        %b   %b", A, B, Cin, S, Cout);
    end
  
endmodule
