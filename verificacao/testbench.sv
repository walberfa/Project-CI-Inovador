// Square Root Verification
// Date: 28 March 2025


`timescale 1ns/1ns

import uvm_pkg::*;
`include "bvm_macros.svh"


//--------------------------------------------------------
//Include Files
//--------------------------------------------------------
`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"


module top;
  
  //--------------------------------------------------------
  //Instantiation
  //--------------------------------------------------------

  logic clk;
  
  sqrt_interface intf(.clk(clk));
  
  sqrt_int dut(
    .clk(intf.clk),
    .start(intf.start),
    .busy(intf.busy),
    .valid(intf.valid),
    .rad(intf.rad),
    .root(intf.root),
    .rem(intf.rem)
  );
  
  
  //--------------------------------------------------------
  //Interface Setting
  //--------------------------------------------------------
  initial begin
    uvm_config_db #(virtual sqrt_interface)::set(null, "*", "vif", intf );
  end
  
  
  
  //--------------------------------------------------------
  //Start The Test
  //--------------------------------------------------------
  initial begin
    run_test("sqrt_test");
  end
  
  
  //--------------------------------------------------------
  //Clock Generation
  //--------------------------------------------------------
  initial begin
    clk = 0;
    #5;
    forever begin
      clk = ~clk;
      #2;
    end
  end
  
  
  //--------------------------------------------------------
  //Maximum Simulation Time
  //--------------------------------------------------------
  initial begin
    #5000;
    $display("Sorry! Ran out of clock cycles!");
    $finish();
  end
  
  
  //--------------------------------------------------------
  //Generate Waveforms
  //--------------------------------------------------------
  initial begin
    $dumpfile("d.vcd");
    $dumpvars();
  end
  
  
  
endmodule: top