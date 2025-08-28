//Mohammed Obied 1210093
//Malik Arqoup 1211686




`include "irq_ref"
`include "irq_seq_item"

class irq_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(irq_scoreboard)
  

  uvm_analysis_imp #(irq_seq_item, irq_scoreboard) item_collected_export;
  irq_seq_item                        pkt_qu[$];

  
 irq_ref_model                       ref_model;

  function new(string name = "irq_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_collected_export = new("item_collected_export", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ref_model = new();
    if (ref_model == null)
      `uvm_fatal(get_type_name(),
                 "Failed to create irq_ref_model instance");
  endfunction

  function void write(irq_seq_item item);
    
    pkt_qu.push_back(item);
  endfunction

  task run_phase(uvm_phase phase);
    irq_seq_item actual;
    bit        ref_out;
    
    bit [2:0]  ref_id;
    bit [7:0]  irq;
    bit [7:0]  mask;
    
    bit        rstn;
    bit        ack;

    forever begin
      
      wait (pkt_qu.size() > 0);
      
      
      actual = pkt_qu.pop_front();
      

      
      `uvm_info("IRQ_SCBD", $sformatf(
        "Received TR: IRQ=%b, MASK=%b, RSTn=%b, ACK=%b, IRQ_OUT=%b, IRQ_ID=%0d", 
        
        
        actual.irq, actual.mask_in, actual.rstn, actual.ack,
        
        actual.irq_out, actual.irq_id
        
      ), UVM_MEDIUM)

      irq     = actual.irq;
      mask    = actual.mask_in;
      rstn    = actual.rstn;
      ack     = actual.ack;
      
      #10;
      ref_model.cycle(irq, mask, rstn, ack, ref_out, ref_id);
     // #30;

      if (actual.irq_out === ref_out && actual.irq_id === ref_id) begin
        `uvm_info("IRQ_SCBD",
                  
                  $sformatf("PASS DUT(OUT=%b,ID=%0d) == REF(OUT=%b,ID=%0d) ref reg %b",
                            
                    actual.irq_out, actual.irq_id,
                            
                    ref_out,ref_id,ref_model.pending_reg),
                  
          UVM_MEDIUM)
        
      end else begin
        `uvm_error("IRQ_SCBD",
          $sformatf("FAIL DUT(OUT=%b,ID=%0d) != REF(OUT=%b,ID=%0d)",
                    
                    actual.irq_out, actual.irq_id,
                    ref_out,       ref_id))
      end
    end
  endtask

endclass
