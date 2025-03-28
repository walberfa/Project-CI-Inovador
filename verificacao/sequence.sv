// Object class


class sqrt_base_sequence extends uvm_sequence;
  `uvm_object_utils(sqrt_base_sequence)
  
  sqrt_sequence_item reset_pkt;
  
  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name= "sqrt_base_sequence");
    super.new(name);
    `uvm_info("BASE_SEQ", "Inside Constructor!", UVM_HIGH)
  endfunction
  
  
  //--------------------------------------------------------
  //Body Task
  //--------------------------------------------------------
  task body();
    `uvm_info("BASE_SEQ", "Inside body task!", UVM_HIGH)
    
    reset_pkt = sqrt_sequence_item::type_id::create("reset_pkt");
    start_item(reset_pkt);
    reset_pkt.randomize() with {start==1;};
    finish_item(reset_pkt);
        
  endtask: body
  
  
endclass: sqrt_base_sequence



class sqrt_test_sequence extends sqrt_base_sequence;
  `uvm_object_utils(sqrt_test_sequence)
  
  sqrt_sequence_item item;
  
  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name= "sqrt_test_sequence");
    super.new(name);
    `uvm_info("TEST_SEQ", "Inside Constructor!", UVM_HIGH)
  endfunction
  
  
  //--------------------------------------------------------
  //Body Task
  //--------------------------------------------------------
  task body();
    `uvm_info("TEST_SEQ", "Inside body task!", UVM_HIGH)
    
    item = sqrt_sequence_item::type_id::create("item");
    start_item(item);
    item.randomize() with {start==0;};
    finish_item(item);
        
  endtask: body
  
  
endclass: sqrt_test_sequence