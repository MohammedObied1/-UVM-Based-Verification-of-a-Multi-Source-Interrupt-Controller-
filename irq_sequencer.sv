//Mohammed Obied 1210093
//Malik Arqoup 1211686

`ifndef IRQ_SEQUENCER_SVH
`define IRQ_SEQUENCER_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "irq_seq_item"

class irq_sequencer extends uvm_sequencer#(irq_seq_item);
  `uvm_component_utils(irq_sequencer)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass

`endif 