//Mohammed Obied 1210093
//Malik Arqoup 1211686





`ifndef IRQ_RANDOM_TEST_SVH


`define IRQ_RANDOM_TEST_SVH
 

import uvm_pkg::*;

`include "uvm_macros.svh"



`include "irq_base_test"

`include "irq_sequence"




class irq_random_test extends irq_base_test;
  
  
  `uvm_component_utils(irq_random_test)
  

  
  function new(string name = "irq_random_test", uvm_component parent = null);
    super.new(name, parent);
    
    
  endfunction

  virtual task run_phase(uvm_phase phase);
    
    irq_sequence seq;

    
    phase.raise_objection(this);
    
    

    
    seq = irq_sequence::type_id::create("seq");
    
    
    seq.start(env.agt.sequencer);

    
    phase.drop_objection(this);
  endtask

endclass : irq_random_test

`endif 