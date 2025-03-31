class sqrt_int_agent extends uvm_agent;
    `uvm_component_utils(sqrt_int_agent)
    
    // Porta de análise para enviar transações ao collector
    uvm_analysis_port #(sqrt_int_trans) out;
    
    // Handles para os componentes do agente
    uvm_sequencer #(sqrt_int_trans) sequencer_h;
    sqrt_int_driver driver_h;
    sqrt_int_monitor monitor_h;

    // Construtor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase: cria os componentes do agente
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        out = new("out", this);

        if (get_is_active() == UVM_ACTIVE) begin
            sequencer_h = uvm_sequencer#(sqrt_int_trans)::type_id::create("sequencer_h", this);
            driver_h = sqrt_int_driver::type_id::create("driver_h", this);
        end
        monitor_h = sqrt_int_monitor #(8)::type_id::create("monitor_h", this);
    endfunction

    // Connect phase: conecta os componentes do agente
    function void connect_phase(uvm_phase phase);
        monitor_h.out.connect(out); // Conecta a porta de análise do monitor ao collector

        if (get_is_active() == UVM_ACTIVE) begin
            driver_h.seq_item_port.connect(sequencer_h.seq_item_export); // Conecta o driver ao sequenciador
        end
    endfunction
endclass