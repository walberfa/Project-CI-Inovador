module norgate (a,b,c);
  input logic a,b;
  output logic c;
  
  assign c=~(a|b);

endmodule
