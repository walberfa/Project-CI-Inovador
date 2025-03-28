class sqrt_scoreboard extends uvm_test;
  `uvm_component_utils(sqrt_scoreboard)

  uvm_analysis_imp #(sqrt_sequence_item, sqrt_scoreboard) scoreboard_port;

  sqrt_sequence_item transactions[$];

  //--------------------------------------------------------
  // Constructor
  //--------------------------------------------------------
  function new(string name = "sqrt_scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("SCB_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new

  //--------------------------------------------------------
  // Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SCB_CLASS", "Build Phase!", UVM_HIGH)

    scoreboard_port = new("scoreboard_port", this);
  endfunction: build_phase

  //--------------------------------------------------------
  // Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SCB_CLASS", "Connect Phase!", UVM_HIGH)
  endfunction: connect_phase

  //--------------------------------------------------------
  // Write Method
  //--------------------------------------------------------
  function void write(sqrt_sequence_item item);
    transactions.push_back(item);
  endfunction: write

  //--------------------------------------------------------
  // Run Phase
  //--------------------------------------------------------
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SCB_CLASS", "Run Phase!", UVM_HIGH)

    forever begin
      sqrt_sequence_item curr_trans;
      wait((transactions.size() != 0));
      curr_trans = transactions.pop_front();
      compare(curr_trans);
    end
  endtask: run_phase

  //--------------------------------------------------------
  // Compare : Generate Expected Result and Compare with Actual
  //--------------------------------------------------------
  task compare(sqrt_sequence_item curr_trans);
    logic [7:0] expected_root;
    logic [7:0] expected_rem;
    logic [7:0] actual_root;
    logic [7:0] actual_rem;

    // Método iterativo para calcular a raiz quadrada inteira
    expected_root = 0;
    expected_rem = curr_trans.rad;
    for (int i = 7; i >= 0; i--) begin
      if ((expected_rem - ((expected_root << 1) + (1 << i))) >= 0) begin
        expected_rem -= ((expected_root << 1) + (1 << i));
        expected_root = (expected_root << 1) | 1;
      end else begin
        expected_root = expected_root << 1;
      end
    end

    // Valores reais do DUT
    actual_root = curr_trans.root;
    actual_rem = curr_trans.rem;

    // Verificação
    if ((actual_root != expected_root) || (actual_rem != expected_rem)) begin
      `uvm_error("COMPARE", $sformatf("Falha na transação! ACT_ROOT=%d, EXP_ROOT=%d | ACT_REM=%d, EXP_REM=%d",
                                       actual_root, expected_root, actual_rem, expected_rem))
    end else begin
      `uvm_info("COMPARE", $sformatf("Transação válida! ACT_ROOT=%d, EXP_ROOT=%d | ACT_REM=%d, EXP_REM=%d",
                                      actual_root, expected_root, actual_rem, expected_rem), UVM_LOW)
    end
  endtask: compare

endclass: sqrt_scoreboard
