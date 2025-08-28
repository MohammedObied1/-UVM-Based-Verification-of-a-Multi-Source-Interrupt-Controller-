//Mohammed Obied 1210093
//Malik Arqoup 1211686


`ifndef IRQ_SEQ_ITEM_SV
`define IRQ_SEQ_ITEM_SV
`include "uvm_macros.svh"
class irq_seq_item extends uvm_sequence_item;
  

  rand bit [7:0] irq;      
  rand bit       ack;     
  rand bit       rstn;    

  bit            irq_out;  
  bit [2:0]      irq_id;    

  rand bit [7:0] mask_in;  

  constraint valid_transaction {
    rstn == 0 -> ack == 0;
  
    rstn == 1 -> mask_in != 8'hFF;
  }
  
      
    constraint ack_zero {
    ack == 1;
  }
   
  function new(string name = "irq_seq_item");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(irq_seq_item)
    `uvm_field_int(irq,  UVM_DEFAULT)
    `uvm_field_int(ack,  UVM_DEFAULT)
    `uvm_field_int(rstn,  UVM_DEFAULT)
    `uvm_field_int(irq_out,  UVM_DEFAULT)
    `uvm_field_int(irq_id,  UVM_DEFAULT)
  `uvm_field_int(mask_in,  UVM_DEFAULT)
  `uvm_object_utils_end

  function string convert2string();
    return $sformatf("IRQ=%02h ACK=%b RSTn=%b MASK=%02h OUT=%b ID=%0d", 
                    irq, ack, rstn, mask_in, irq_out, irq_id);
  endfunction

endclass

`endif 