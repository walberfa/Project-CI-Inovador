class sqrt_int_comparator extends uvm_component;
    `uvm_component_utils(sqrt_int_comparator)

    // Portas de entrada para receber transações
    uvm_analysis_imp #(sqrt_int_trans, sqrt_int_comparator) from_refmod;
    uvm_analysis_imp #(sqrt_int_trans, sqrt_int_comparator) from_dut;

    // Transações recebidas
    sqrt_int_trans ref_tr;
    sqrt_int_trans dut_tr;

    // Construtor
    function new(string name, uvm_component parent);
        super.new(name, parent);
        from_refmod = new("from_refmod", this);
        from_dut = new("from_dut", this);
    endfunction

    // Função de análise para o modelo de referência
    function void write(input sqrt_int_trans tr);
        ref_tr = tr; // Transação do modelo de referência
        dut_tr = tr; // Transação do DUT

        // Compara as transações se ambas estiverem disponíveis
        compare_transactions();
    endfunction

    // Função para comparar as transações
    function void compare_transactions();
        if (ref_tr != null && dut_tr != null) begin
            if (ref_tr.root !== dut_tr.root || ref_tr.rem !== dut_tr.rem) begin
                `uvm_error("COMPARATOR", $sformatf("Mismatch: Expected root=%0d, rem=%0d | Got root=%0d, rem=%0d",
                                                  ref_tr.root, ref_tr.rem, dut_tr.root, dut_tr.rem))
            end else begin
                `uvm_info("COMPARATOR", $sformatf("Match: rad= %0d, root=%0d, rem=%0d", (dut_tr.root**2+dut_tr.rem), dut_tr.root, dut_tr.rem), UVM_LOW)
            end

            // Limpa as transações após a comparação
            ref_tr = null;
            dut_tr = null;
        end
    endfunction
endclass