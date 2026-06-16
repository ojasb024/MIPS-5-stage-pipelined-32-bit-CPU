`timescale 1ns / 1ps

module  hazard_detection_unit(
    input   [4:0] IFID_rs, IFID_rt,
    input   IDEX_mem_read,
    input   [4:0] IDEX_rt,
    output  reg PC_enable,
    output  reg IFID_enable,
    output  reg IDEX_flush 
    );

    always@(*) begin
        if ((IDEX_rt == IFID_rs || IDEX_rt == IFID_rt) 
            && IDEX_mem_read && IDEX_rt != 0)
            begin
                PC_enable = 0;
                IFID_enable = 0;
                IDEX_flush = 1;
            end
        else
            begin
                PC_enable = 1;
                IFID_enable = 1;
                IDEX_flush = 0;
            end 
    end

endmodule