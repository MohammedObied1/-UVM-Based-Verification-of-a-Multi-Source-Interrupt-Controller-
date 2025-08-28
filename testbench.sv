//Mohammed Obied 1210093
//Malik Arqoup 1211686

`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "irq_if"
`include "irq_base_test"
`include "irq_random_test"
`include "irq_directed_test"

module top;

  logic clk;
  logic rstn;

  irq_if intf(.clk(clk));

  interrupt_controller dut (
    .clk     (clk),
    .Rstn    (rstn),
    .IRQ     (intf.irq),
    .ACK     (intf.ack),
    .mask_in (intf.mask_in),
    .IRQ_OUT (intf.irq_out),
    .IRQ_ID  (intf.irq_id)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rstn = 1'b0;  
    repeat(1) @(posedge clk);
    rstn = 1'b1;  
  end

  initial begin
    uvm_config_db#(virtual irq_if.DRIVER)::set(
      null, "", "vif", intf
    );
    uvm_config_db#(virtual irq_if.MONITOR)::set(
      null, "", "vif", intf
    );

    run_test("directed_test");
  end


endmodule