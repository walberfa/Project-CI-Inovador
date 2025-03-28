
class sqrt_test extends uvm_test;
  `uvm_component_utils(sqrt_test)

  sqrt_env env;
  sqrt_base_sequence reset_seq;
  sqrt_test_sequence test_seq;

  
  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "sqrt_test", uvm_component parent);
    super.new(name, parent);
    `uvm_info("TEST_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new

  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TEST_CLASS", "Build Phase!", UVM_HIGH)

    env = sqrt_env::type_id::create("env", this);

  endfunction: build_phase

  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST_CLASS", "Connect Phase!", UVM_HIGH)

  endfunction: connect_phase

  
  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("TEST_CLASS", "Run Phase!", UVM_HIGH)

    phase.raise_objection(this);

    //reset_seq
    reset_seq = sqrt_base_sequence::type_id::create("reset_seq");
    reset_seq.start(env.agnt.seqr);
    #10;

    repeat(100) begin
      //test_seq
      test_seq = sqrt_test_sequence::type_id::create("test_seq");
      test_seq.start(env.agnt.seqr);
      #10;
    end
    
    phase.drop_objection(this);

  endtask: run_phase


endclass: sqrt_test