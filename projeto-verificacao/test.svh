class sqrt_int_test extends uvm_test;  
   `uvm_component_utils(sqrt_int_test)

   // Handle para o ambiente
   sqrt_int_env env_h;

   // Construtor
   function new(string name, uvm_component parent);
     super.new(name, parent);
   endfunction

   // Build phase: cria o ambiente
   function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     env_h = sqrt_int_env::type_id::create("env_h", this);
   endfunction

   // Run phase: executa a sequência
   task run_phase(uvm_phase phase);
     sqrt_int_sequence seq;
     seq = sqrt_int_sequence::type_id::create("seq");
     seq.start(env_h.agent_in_h.sequencer_h); // Inicia a sequência no sequenciador do agente de entrada
   endtask

endclass