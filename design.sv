//Mohammed Obied 1210093
//Malik Arqoup 1211686

module interrupt_controller (
    input  logic        clk,      
    input  logic        Rstn,     
    input  logic [7:0]  IRQ,       
    input  logic        ACK,       // CPU acknowledge signal
    input  logic [7:0]  mask_in,
    output logic        IRQ_OUT,   
    output logic [2:0]  IRQ_ID    
);
    
  
  
    logic [7:0] pending_reg;  
    logic [7:0] active_irqs; 
    logic [7:0] irq_prev;    
  logic [7:0] irq_changed;
  logic [7:0] mask_reg;
  logic [7:0] ack_id;
  
  
  
    always_ff @(posedge clk or negedge Rstn) begin
        if (!Rstn) begin
            pending_reg <= 8'b0;
            irq_prev <= 8'b0;
        end else begin
            irq_prev <= IRQ;
             ack_id <= IRQ_ID;
                      
            if (ACK) begin
                pending_reg[IRQ_ID] = 1'b0;
              
            end
            
              irq_changed = (IRQ != irq_prev);
          
                       // Check if any bit in IRQ changed
             irq_changed = (IRQ != irq_prev);
            
            if (irq_changed) begin
              pending_reg = (IRQ & ~mask_in) | pending_reg;
                
            end

        end
    end
    
  
   always_ff @(posedge clk or negedge Rstn) begin
  if (!Rstn) mask_reg <= 8'b0;
  else       mask_reg <= mask_in;
end

assign active_irqs = pending_reg & ~mask_reg;
    
   
    always_comb begin
        IRQ_ID  = 3'd0;
        IRQ_OUT = 1'b0;
        if (active_irqs[0]) begin
            IRQ_ID  = 3'd0;
            IRQ_OUT = 1'b1;
        end else if (active_irqs[1]) begin
            IRQ_ID  = 3'd1;
            IRQ_OUT = 1'b1;
        end else if (active_irqs[2]) begin
            IRQ_ID  = 3'd2;
            IRQ_OUT = 1'b1;
        end else if (active_irqs[3]) begin
            IRQ_ID  = 3'd3;
            IRQ_OUT = 1'b1;
        end else if (active_irqs[4]) begin
            IRQ_ID  = 3'd4;
            IRQ_OUT = 1'b1;
        end else if (active_irqs[5]) begin
            IRQ_ID  = 3'd5;
            IRQ_OUT = 1'b1;
        end else if (active_irqs[6]) begin
            IRQ_ID  = 3'd6;
            IRQ_OUT = 1'b1;
        end else if (active_irqs[7]) begin
            IRQ_ID  = 3'd7;
            IRQ_OUT = 1'b1;
        end
    end
endmodule

