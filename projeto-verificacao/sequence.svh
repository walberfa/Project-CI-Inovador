class sqrt_int_sequence extends uvm_sequence #(sqrt_int_trans);
    `uvm_object_utils(sqrt_int_sequence)
    
    function new(string name = "sqrt_int_sequence");
        super.new(name);
    endfunction: new

    task body;
        sqrt_int_trans tr;

        // Criação da transação
        tr = sqrt_int_trans::type_id::create("tr");

        // Loop para gerar transações
        forever begin
            // Randomiza os campos de entrada
            if (!tr.randomize()) begin
                `uvm_error("SEQUENCE", "Falha ao randomizar a transacao")
            end

            // Envia a transação para o driver
            start_item(tr);
            finish_item(tr);
        end
    endtask: body
   
endclass