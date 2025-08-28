//Mohammed Obied 1210093
//Malik Arqoup 1211686



`ifndef IRQ_IF_SVH
`define IRQ_IF_SVH

interface irq_if(input logic clk);
  
  logic [7:0] irq;     
  logic       ack;      
  logic       rstn;      
  
  logic       irq_out;   
  logic [2:0] irq_id;    
  
  logic [7:0] mask_in; 

  clocking drv_cb @(posedge clk);
    default output #0;  
    output irq, ack, rstn, mask_in;
    input  irq_out, irq_id;
  endclocking
  
  clocking mon_cb @(posedge clk);
    default input #0;  
    input irq, ack, rstn, mask_in, irq_out, irq_id;
  endclocking
  
  modport DRIVER(input  clk, clocking drv_cb);
  modport MONITOR(clocking mon_cb);
  

endinterface

`endif