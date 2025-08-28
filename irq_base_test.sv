
//Mohammed Obied 1210093
//Malik Arqoup 1211686



`ifndef IRQ_BASE_TEST_SVH
`define IRQ_BASE_TEST_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "irq_env"

class irq_base_test extends uvm_test;
  
  
  `uvm_component_utils(irq_base_test)

  
  irq_env env;
  

  function new(string name = "irq_base_test", uvm_component parent = null);
    
    
    
    
    super.new(name, parent);
    
    
  endfunction
  

  function void build_phase(uvm_phase phase);
    
    
    
    
    super.build_phase(phase);
    
    
    env = irq_env::type_id::create("env", this);
    
    
    

    uvm_config_db#(uvm_active_passive_enum)::set(
      
      
      this, "env.agt", "is_active", UVM_ACTIVE
    );
  endfunction

  function void end_of_elaboration();
    
    
    
    super.end_of_elaboration();
    
    
    $display("\n=====  UVM COMPONENT HIERARCHY =====");
    
    
    this.print();
    
    
    $display("====================================\n");
    
    
    
  endfunction
  
  

  function void report_phase(uvm_phase phase);
    
    
    
    
    uvm_report_server svr;
    
    
    int err_count;
    
    

    super.report_phase(phase);
    
    svr = uvm_report_server::get_server();
    
    
    err_count = svr.get_severity_count(UVM_ERROR) 
    
    
              + svr.get_severity_count(UVM_FATAL);
    
    
    if (err_count > 0) begin
      `uvm_error("TEST_FAIL", $sformatf("%0d errors reported during test", err_count))
      
      
      
    end else begin
    
      `uvm_info("TEST_PASS", "Test completed successfully", UVM_LOW)
      
      
    end
    
  endfunction

  
endclass : irq_base_test

`endif 