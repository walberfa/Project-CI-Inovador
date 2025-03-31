class sqrt_int_driver extends uvm_driver #(sqrt_int_trans);
    `uvm_component_utils(sqrt_int_driver)

    parameter int WIDTH = 8;

    // Virtual interface para conectar ao DUT
    virtual sqrt_int_if #(WIDTH) vif;

    // Construtor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase: obtém a interface virtual do banco de dados UVM
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual sqrt_int_if #(WIDTH))::get(this, "", "vif", vif)) begin
            `uvm_fatal("DRIVER", "Nao foi possivel obter a interface virtual")
        end
    endfunction

    // Run phase: dirige as transações para o DUT
    task run_phase(uvm_phase phase);
        vif.start <= 0;
        vif.rad <= 'x;

        // Loop para obter e dirigir transações
        get_and_drive();
    endtask

    // Task para obter transações e dirigir os sinais
    task get_and_drive();
        sqrt_int_trans tr; // Transação recebida do sequenciador

        forever begin
            // Obtém a próxima transação do sequenciador
            seq_item_port.get_next_item(tr);

            // Dirige os sinais de entrada para o DUT
            @(posedge vif.clk);
            vif.rad <= tr.rad;

            // Aguarda até que o DUT sinalize que a operação está concluída
            vif.start <= 1;
            @(posedge vif.clk);
            vif.start <= 0;

            @(posedge vif.clk iff (vif.valid == 1));  

            // Captura os sinais de saída do DUT
            vif.root <= tr.root;
            vif.rem <= tr.rem;          

            // Finaliza a transação
            @(posedge vif.clk);
            seq_item_port.item_done();

            // Reseta os sinais de entrada após a transação
            @(posedge vif.clk);
        end
    endtask
endclass