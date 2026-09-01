`timescale 1ns / 1ps

module  flushing_control(
    input   [1:0] pc_src,
    input   IDEX_hazard_flush,
    input   MDU_stall, 
    output  IFID_flush,
    output  IDEX_flush,
    output  EXMEM_flush
    );

    assign IFID_flush = (pc_src) ? 1 : 0;
    assign IDEX_flush = (pc_src || IDEX_hazard_flush) ? 1 : 0;
    assign EXMEM_flush = (MDU_stall) ? 1 : 0;
     
endmodule