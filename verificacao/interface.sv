

interface sqrt_interface(input logic clk);

  logic [7:0] rad;
  logic [7:0] root;
  logic [7:0] rem;
  bit busy, valid, start;

endinterface: sqrt_interface