//Object class


class sqrt_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(sqrt_sequence_item)

  //--------------------------------------------------------
  //Instantiation
  //--------------------------------------------------------
  rand logic start;
  rand logic [7:0] rad;
  
  logic [7:0] root; //output
  logic [7:0] rem; //output
  bit busy; // output
  bit valid;
  
  //--------------------------------------------------------
  //Default Constraints
  //--------------------------------------------------------
  constraint ram {rad inside {[0:100]};}

  
  
  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "sqrt_sequence_item");
    super.new(name);

  endfunction: new

endclass: sqrt_sequence_item