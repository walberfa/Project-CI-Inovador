class coverage_in extends bvm_cover #(sqrt_int_trans);
   `uvm_component_utils(coverage_in)

   // Covergroup para monitorar as transações de entrada
   covergroup transaction_covergroup;
      option.per_instance = 1;
      
      // Cobertura do sinal 'rad' (radicando)
      coverpoint coverage_transaction.rad {
         bins rad_bins[] = {[0:15], [16:31], [32:63], [64:127], [128:255]}; // Faixas de valores para o radicando
         option.at_least = 5; // Pelo menos 5 ocorrências em cada bin
      }
   endgroup

   // Macro para facilitar a integração com bvm_cover
   `bvm_cover_utils(sqrt_int_trans)

endclass