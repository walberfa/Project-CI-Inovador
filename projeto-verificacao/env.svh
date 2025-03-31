class sqrt_int_env extends uvm_env;
    `uvm_component_utils(sqrt_int_env)

    // Agentes
    sqrt_int_agent agent_in_h;
    sqrt_int_agent agent_out_h;

    // Cobertura
    coverage_in coverage_in_h;
    coverage_out coverage_out_h;

    // FIFO e componentes de referência
    uvm_analysis_port #(sqrt_int_trans) agent_refmod;
    sqrt_int_refmod refmod_h;
    sqrt_int_comparator comparator_h;

    // Construtor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase: cria os componentes do ambiente
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Configura o agente de entrada como ativo
        set_config_int("agent_in_h", "is_active", UVM_ACTIVE);
        agent_in_h = sqrt_int_agent::type_id::create("agent_in_h", this);

        // Configura o agente de saída como passivo
        set_config_int("agent_out_h", "is_active", UVM_PASSIVE);
        agent_out_h = sqrt_int_agent::type_id::create("agent_out_h", this);

        // Criação dos componentes de cobertura
        coverage_in_h = coverage_in::type_id::create("coverage_in_h", this);
        coverage_out_h = coverage_out::type_id::create("coverage_out_h", this);

        // Criação do FIFO e componentes de referência
        agent_refmod = new("agent_refmod", this);
        refmod_h = sqrt_int_refmod::type_id::create("refmod_h", this);
        comparator_h = sqrt_int_comparator::type_id::create("comparator_h", this);
    endfunction

    // Connect phase: conecta os componentes do ambiente
    function void connect_phase(uvm_phase phase);
        // Conecta a saída do agente de entrada à cobertura e ao FIFO
        agent_in_h.out.connect(coverage_in_h.analysis_export);
        agent_in_h.out.connect(agent_refmod);

        // Conecta o FIFO ao modelo de referência
        // refmod_h.in.connect(agent_refmod);

        // Conecta a saída do modelo de referência ao comparador
        refmod_h.out.connect(comparator_h.from_refmod);

        // Conecta a saída do agente de saída ao comparador e à cobertura
        agent_out_h.out.connect(comparator_h.from_dut);
        agent_out_h.out.connect(coverage_out_h.analysis_export);
    endfunction
endclass