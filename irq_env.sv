//Mohammed Obied 1210093
//Malik Arqoup 1211686



`ifndef IRQ_ENV_SVH
`define IRQ_ENV_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "irq_scoreboard"


`include "irq_agent"

class irq_env extends uvm_env;
  
  
  `uvm_component_utils(irq_env)

  irq_agent      agt;
  
  
  irq_scoreboard sb;

  
  function new(string name = "irq_env", uvm_component parent = null);
    
    super.new(name, parent);
    
    
  endfunction
  

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    
    agt = irq_agent::type_id::create("agt", this);
    
    
    sb  = irq_scoreboard::type_id::create("sb", this);
    
    
    
  endfunction

  function void connect_phase(uvm_phase phase);
    
    
    super.connect_phase(phase);
    
    
    agt.monitor.ap.connect(sb.item_collected_export);
  endfunction

endclass : irq_env

`endif 