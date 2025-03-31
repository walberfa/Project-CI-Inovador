class sqrt_int_trans extends uvm_sequence_item;

  parameter int WIDTH = 8;

  // Campos da transação correspondentes ao DUT
  rand bit [WIDTH-1:0] rad;           // Radicando (entrada)
  bit [WIDTH-1:0] root;               // Raiz calculada (saída)
  bit [WIDTH-1:0] rem;                // Resto calculado (saída)

  // Construtor
  `uvm_object_utils_begin(sqrt_int_trans)
    `uvm_field_int(rad, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(root, UVM_CHECK | UVM_COMPARE)
    `uvm_field_int(rem, UVM_CHECK | UVM_COMPARE)
  `uvm_object_utils_end

  // Construtor
  function new(string name = "sqrt_int_trans");
    super.new(name);
  endfunction

endclass