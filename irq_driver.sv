//Mohammed Obied 1210093
//Malik Arqoup 1211686



`ifndef IRQ_DRIVER_SVH
`define IRQ_DRIVER_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "irq_if"
`include "irq_seq_item"

class irq_driver extends uvm_driver #(irq_seq_item);
  `uvm_component_utils(irq_driver)

  virtual irq_if.DRIVER vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual irq_if.DRIVER)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "Driver virtual interface not set")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      irq_seq_item tr;
      
      seq_item_port.get_next_item(tr);
      
      @(vif.drv_cb);
      
      vif.drv_cb.rstn    <= tr.rstn;
      vif.drv_cb.irq     <= tr.irq;
      vif.drv_cb.ack     <= tr.ack;
      vif.drv_cb.mask_in<= tr.mask_in;
      
      repeat(1)
      @(posedge vif.clk);
        vif.drv_cb.ack <= 1; 
      
      
      seq_item_port.item_done();
      
      seq_item_port.put_response(tr);
    end
  endtask

endclass : irq_driver

`endif 