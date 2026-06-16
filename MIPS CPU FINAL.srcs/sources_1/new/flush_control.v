`timescale 1ns / 1ps

module  flush_control(
    input   pc_control,
    output  IFID_flush,
    output  IDEX_flush,
    input   IDEX_hazard_flush
    );

    assign IFID_flush = (pc_control) ? 1 : 0;
    assign IDEX_flush = (pc_control || IDEX_hazard_flush) ? 1 : 0;
     
endmodule