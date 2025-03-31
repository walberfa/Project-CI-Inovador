class sqrt_int_refmod extends uvm_component;
    `uvm_component_utils(sqrt_int_refmod)

    // TLM Ports
    uvm_analysis_imp #(sqrt_int_trans, sqrt_int_refmod) in;
    uvm_analysis_port #(sqrt_int_trans) out;

    parameter int WIDTH = 8;

    // Construtor
    function new(string name, uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        out = new("out", this);
    endfunction

    // Função de análise (chamado automaticamente pelo `uvm_analysis_imp`)
    function void write(input sqrt_int_trans tr_in);
        sqrt_int_trans tr_out;

        `bvm_end_tr(tr_in);

        // Processa a transação
        tr_out = sqrt_int_trans::type_id::create("tr_out", this);
        tr_out.root = calculate_sqrt(tr_in.rad);
        tr_out.rem = tr_in.rad - (tr_out.root * tr_out.root);

        // Envia a transação processada
        `bvm_begin_tr(tr_out)

        out.write(tr_out);
    endfunction

    // Função para calcular a raiz quadrada inteira
    function logic [WIDTH-1:0] calculate_sqrt(input logic [WIDTH-1:0] rad);
        logic [WIDTH-1:0] root;
        logic [WIDTH-1:0] temp;
        root = 0;

        for (int i = WIDTH-1; i >= 0; i--) begin
            temp = root | (1 << i);
            if (temp * temp <= rad) begin
                root = temp;
            end
        end

        return root;
    endfunction
endclass