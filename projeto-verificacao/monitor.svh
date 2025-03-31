class sqrt_int_monitor #(parameter int WIDTH = 8) extends uvm_monitor;  
    `uvm_component_utils(sqrt_int_monitor)

    // Porta de análise para enviar transações ao collector
    uvm_analysis_port #(sqrt_int_trans) out;

    // Interface virtual para conectar ao DUT
    virtual sqrt_int_if #(WIDTH) vif;

    // Construtor
    function new(string name, uvm_component parent);
        super.new(name, parent);
        out = new("out", this);
    endfunction: new
    
    // Build phase: obtém a interface virtual do banco de dados UVM
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual sqrt_int_if #(WIDTH))::get(this, "", "vif", vif)) begin
            `uvm_fatal("MONITOR", "Nao foi possivel obter a interface virtual")
        end
    endfunction
   
    // Run phase: monitora os sinais do DUT
    task run_phase(uvm_phase phase);
        sqrt_int_trans tr;

        forever begin
            // Cria uma nova transação
            tr = sqrt_int_trans::type_id::create("tr", this);
            @(posedge vif.clk);

            // Captura os sinais do DUT
            tr.rad = vif.rad;
            tr.root = vif.root;
            tr.rem = vif.rem;
            @(posedge vif.clk);

            // Aguarda até que o DUT sinalize que os dados estão válidos
            @(posedge vif.clk iff (vif.valid));
            @(posedge vif.clk);

            // Envia a transação para a porta de análise
            out.write(tr);
            @(posedge vif.clk);
        end
    endtask
endclass