//Mohammed Obied 1210093
//Malik Arqoup 1211686


`ifndef IRQ_SEQUENCE_SVH
`define IRQ_SEQUENCE_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "irq_seq_item"

class irq_sequence extends uvm_sequence #(irq_seq_item);
  `uvm_object_utils(irq_sequence)
  
  function new(string name = "irq_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    irq_seq_item tr;
    int active_count;
    int wait_cycles;
    
    repeat(40) begin
      tr = irq_seq_item::type_id::create("tr");
      
      if (!tr.randomize() with {
        rstn == 1;                 
      }) begin
        `uvm_error("RAND_FAIL", "Randomization failed")
      end
      active_count = $countones(tr.irq & ~tr.mask_in);
      
      start_item(tr);
      finish_item(tr);
      
      wait_cycles = active_count;
      if (wait_cycles > 0) begin
        `uvm_info("SEQ", $sformatf("Waiting %0d cycles", wait_cycles), UVM_MEDIUM)
        repeat(wait_cycles) #10;
      end
      
      get_response(tr);
      
      
    end
  endtask
endclass

`endif 

`ifndef TWO_TR_SEQ_SV
`define TWO_TR_SEQ_SV
`include "uvm_macros.svh"
`include "irq_seq_item"

class directed_seq extends uvm_sequence#(irq_seq_item);
  `uvm_object_utils(directed_seq)

  function new(string name = "two_tr_seq");
    super.new(name);
  endfunction

  virtual task body();
    irq_seq_item tr;
    
    
    // --- Transaction 2: all IRQ lines on ---

    
    tr = irq_seq_item::type_id::create("tr_all_on");
tr.irq     = 8'hFF;     
tr.mask_in = 8'h00;     
tr.rstn    = 1'b1;
tr.ack     = 1'b1;
start_item(tr);
finish_item(tr);
#70;

// --- Transaction 2: all IRQ lines off ---
tr = irq_seq_item::type_id::create("tr_all_off");
tr.irq     = 8'h00;     
    tr.mask_in = 8'h00;
tr.rstn    = 1'b1;
tr.ack     = 1'b1;
start_item(tr);
finish_item(tr);
#70;

// --- Transaction 3: IRQ5, IRQ6, IRQ7 high ---
    tr = irq_seq_item::type_id::create("tr_all_high");
    tr.irq     = 8'b11100000;  
    tr.mask_in = 8'h00;   
    tr.rstn    = 1'b1;    
    tr.ack     = 1'b1;    
    start_item(tr);
    finish_item(tr);

   #10;
// --- Transaction 4: IRQ0, IRQ1 high ---

    tr = irq_seq_item::type_id::create("tr_all_zero");
    tr.irq     = 8'b00000011;    // no IRQs
    tr.mask_in = 8'h00;
    tr.rstn    = 1'b1;
    tr.ack     = 1'b1;
    start_item(tr);
    finish_item(tr);
    #20

// --- Transaction 5: Mask test (mask IRQ0) ---
tr = irq_seq_item::type_id::create("tr_mask0_test");
tr.irq     = 8'b0000_0110; 
tr.mask_in = 8'b0000_0011; 
tr.rstn    = 1'b1;
tr.ack     = 1'b1;
start_item(tr);
finish_item(tr);
#20;

    
    
    
    
 

    
    
    // --- Mask all 1: all IRQs disabled ---
tr = irq_seq_item::type_id::create("tr_mask_all_one");
tr.irq     = 8'hFF; 
tr.mask_in = 8'hFF;  
tr.rstn    = 1'b1;
tr.ack     = 1'b1;
start_item(tr);
finish_item(tr);

    

   
    
    #30;
  endtask
endclass

`endif 
