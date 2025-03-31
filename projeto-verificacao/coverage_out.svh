class coverage_out extends bvm_cover #(sqrt_int_trans);
   `uvm_component_utils(coverage_out)

   // Covergroup para monitorar as transações de saída
   covergroup transaction_covergroup;
      option.per_instance = 1;

      // Cobertura do sinal 'root' (raiz calculada)
      coverpoint coverage_transaction.root {
         bins root_bins[] = {[0:15], [16:31], [32:63], [64:127], [128:255]}; // Faixas de valores para a raiz
         option.at_least = 5; // Pelo menos 5 ocorrências em cada bin
      }

      // Cobertura do sinal 'rem' (resto calculado)
      coverpoint coverage_transaction.rem {
         bins rem_bins[] = {[0:15], [16:31], [32:63], [64:127], [128:255]}; // Faixas de valores para o resto
         option.at_least = 5; // Pelo menos 5 ocorrências em cada bin
      }
   endgroup

   // Macro para facilitar a integração com bvm_cover
   `bvm_cover_utils(sqrt_int_trans)

endclass