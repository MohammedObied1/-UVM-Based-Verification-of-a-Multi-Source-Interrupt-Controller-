//Mohammed Obied 1210093
//Malik Arqoup 1211686



`ifndef IRQ_AGENT_SVH
`define IRQ_AGENT_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "irq_driver"
`include "irq_monitor"
`include "irq_sequencer"

class irq_agent extends uvm_agent;
  `uvm_component_utils(irq_agent)

  
  
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  
  irq_sequencer sequencer;
  irq_driver    driver;
  irq_monitor   monitor;
  

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if (!uvm_config_db#(uvm_active_passive_enum)::get(
          this, "", "is_active", is_active)) begin
      `uvm_info(get_type_name(),
        "is_active not set, defaulting to UVM_ACTIVE", UVM_LOW)
      
    end

    monitor = irq_monitor::type_id::create("monitor", this);
    
    
    if (is_active == UVM_ACTIVE) begin
      sequencer = irq_sequencer::type_id::create("sequencer", this);
      
      driver = irq_driver::type_id::create("driver", this);
      
      
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    if (is_active == UVM_ACTIVE) begin
      
      driver.seq_item_port.connect(sequencer.seq_item_export);
      
    end
  endfunction

endclass : irq_agent

`endif 