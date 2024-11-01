module invgate_tb;
  logic a;
  logic b;
  
  // instantiating the module to map connections
  invgate invg( .a(a), .b(b));
  
  initial
    begin
      a = 1'b0;

      #5
      a = 1'b1;
      
      #5;
    end
  
    initial
    begin
      $display("                Tempo   Entradas    Saídas");
      $display("                            a         b");
      $display("                ====   ==========  =======");
      $monitor($time,"         %b        %b", a, b);
    end
  
endmodule

