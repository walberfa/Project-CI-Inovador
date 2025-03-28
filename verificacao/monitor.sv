
class sqrt_monitor extends uvm_monitor;
  `uvm_component_utils(sqrt_monitor)
  
  virtual sqrt_interface vif;
  sqrt_sequence_item item;
  
  uvm_analysis_port #(sqrt_sequence_item) monitor_port;
  
  
  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "sqrt_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("MONITOR_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MONITOR_CLASS", "Build Phase!", UVM_HIGH)
    
    monitor_port = new("monitor_port", this);
    
    if(!(uvm_config_db #(virtual sqrt_interface)::get(this, "*", "vif", vif))) begin
      `uvm_error("MONITOR_CLASS", "Failed to get VIF from config DB!")
    end
    
  endfunction: build_phase
  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MONITOR_CLASS", "Connect Phase!", UVM_HIGH)
    
  endfunction: connect_phase
  
  
  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MONITOR_CLASS", "Inside Run Phase!", UVM_HIGH)
    
    forever begin
      item = sqrt_sequence_item::type_id::create("item");
      
      wait(!vif.start);
      
      //sample inputs
      @(posedge vif.clk);
      item.rad = vif.rad;
      item.start = vif.start;

      //sample output
      @(posedge vif.clk);
      item.busy = vif.busy;
      item.valid = vif.valid;
      item.root = vif.root;
      item.rem = vif.rem;
      
      // send item to scoreboard
      monitor_port.write(item);
    end
        
  endtask: run_phase
  
  
endclass: sqrt_monitor