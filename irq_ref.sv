//Mohammed Obied 1210093
//Malik Arqoup 1211686






class irq_ref_model;
  bit [7:0] pending_reg;
  bit [7:0] irq_prev;
  bit [7:0] last_id;
  bit last_out ;

  function new();
    pending_reg = 8'h00;
    irq_prev    = 8'h00;
  endfunction

  function void cycle(
    input  bit [7:0] irq,
    input  bit [7:0] mask_in,
    
    input  bit       rstn,
    input  bit       ack,
    
    output bit       exp_out,
    output bit [2:0] exp_id
  );
    bit [7:0] active_irqs;
    
    bit       irq_changed;
    bit [7:0] prev_irq;

    if (!rstn) begin
      pending_reg = 8'h00;
      
      irq_prev    = 8'h00;
      exp_out     = 1'b0;
      exp_id      = 3'd0;
      return;
    end

    prev_irq    = irq_prev;
    irq_prev    = irq;
    
    irq_changed = (irq != prev_irq);


    if (irq_changed) begin
      pending_reg = (irq & ~mask_in) | pending_reg;
      
      
    end
    


    active_irqs = pending_reg & ~mask_in;
    if (active_irqs != 8'h00) begin
      exp_out = 1;
      if      (active_irqs[0]) exp_id = 3'd0;
      else if (active_irqs[1]) exp_id = 3'd1;
      
      else if (active_irqs[2]) exp_id = 3'd2;
      else if (active_irqs[3]) exp_id = 3'd3;
      
      else if (active_irqs[4]) exp_id = 3'd4;
      else if (active_irqs[5]) exp_id = 3'd5;
      
      else if (active_irqs[6]) exp_id = 3'd6;
      else                      exp_id = 3'd7;
    end else begin
      exp_out = 0;
      
      exp_id  = 3'd0;
    end

    if (ack) begin
      pending_reg[exp_id] = 1'b0;
    end
    last_id = exp_id;
    
    last_out = exp_out;
  endfunction

endclass
