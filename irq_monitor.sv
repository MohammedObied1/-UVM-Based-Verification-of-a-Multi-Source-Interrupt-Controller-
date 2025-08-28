//Mohammed Obied 1210093
//Malik Arqoup 1211686



`ifndef IRQ_MONITOR_SVH
`define IRQ_MONITOR_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "irq_if"
`include "irq_seq_item"

class irq_monitor extends uvm_monitor;
  `uvm_component_utils(irq_monitor)

  virtual irq_if.MONITOR vif;
  uvm_analysis_port #(irq_seq_item) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual irq_if.MONITOR)::get(
           this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Monitor virtual interface not set");
  endfunction

  virtual task run_phase(uvm_phase phase);
    irq_seq_item tr;
    
    forever begin
      @(vif.mon_cb);
      
      tr = irq_seq_item::type_id::create("tr");
      tr.rstn     = vif.mon_cb.rstn;
      tr.irq      = vif.mon_cb.irq;
      tr.ack      = vif.mon_cb.ack;
      tr.mask_in = vif.mon_cb.mask_in;
      
      tr.irq_out  = vif.mon_cb.irq_out;
      tr.irq_id   = vif.mon_cb.irq_id;
      
      ap.write(tr);
    end
  endtask

endclass : irq_monitor

`endif 