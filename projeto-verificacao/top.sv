module top;
   import uvm_pkg::*;
   import test_pkg::*;

   // Clock generator
   logic clock;
   initial begin
     clock = 0;
     forever #5 clock = ~clock;
   end

   // Input and output interface instances for DUT
   sqrt_int_if #(8) in_if(.clk(clock));  // Interface de entrada conectada ao clock
   sqrt_int_if #(8) out_if(.clk(clock)); // Interface de saída conectada ao clock

   // DUT instância
   sqrt_int #(8) dut (
      .clk(clock),
      .start(in_if.start),
      .rad(in_if.rad),
      .busy(out_if.busy),
      .valid(out_if.valid),
      .root(out_if.root),
      .rem(out_if.rem)
   );

   initial begin
      `ifdef XCELIUM
        $shm_open("waves.shm");
        $shm_probe("AS");
      `endif
      `ifdef VCS
        $vcdpluson;
      `endif
      `ifdef QUESTA
        $wlfdumpvars();
      `endif

      // Register the input and output interface instances in the UVM database
      uvm_config_db #(virtual sqrt_int_if #(8))::set(null, "uvm_test_top.env_h.agent_in_h.*", "vif", in_if);
      uvm_config_db #(virtual sqrt_int_if #(8))::set(null, "uvm_test_top.env_h.agent_out_h.*", "vif", out_if);

      // Start the UVM test
      run_test("sqrt_int_test");
   end
endmodule