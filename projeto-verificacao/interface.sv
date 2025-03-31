// UVM Interface for sqrt_int module

`ifndef INTERFACE_SV
`define INTERFACE_SV

`timescale 1ns / 1ps

interface sqrt_int_if #(parameter WIDTH = 8) (input logic clk);

    // Signals matching the DUT ports
    logic start;                     // start signal
    logic busy;                      // calculation in progress
    logic valid;                     // root and rem are valid
    logic [WIDTH-1:0] rad;           // radicand
    logic [WIDTH-1:0] root;          // root
    logic [WIDTH-1:0] rem;           // remainder


    // Modport definitions for UVM components
    modport DUT (input clk, input start, input rad, output busy, input valid, output root, output rem);
    modport TB (input clk, input start, input rad, input busy, input valid, input root, input rem);

endinterface

`endif