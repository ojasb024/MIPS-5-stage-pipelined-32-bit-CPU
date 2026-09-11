`timescale 1ns / 1ps

module  hazard_detection_unit(
    input   [4:0] IFID_rs, IFID_rt,
    input   [4:0] IDEX_dst_reg,
    input   IDEX_mem_read,
    input   [2:0] IDEX_MDU_cont,
    output  reg hazard_stall,
    output  reg hazard_IDEX_flush
    );

    assign MDU_mf_haz = (IDEX_MDU_cont == 3'b101 ||  IDEX_MDU_cont == 3'b110);

    always@(*) begin
        hazard_stall = 0;
        hazard_IDEX_flush = 0;
    
        if ((IDEX_dst_reg == IFID_rs || IDEX_dst_reg == IFID_rt) 
            && (IDEX_mem_read || MDU_mf_haz))
            begin
                hazard_stall = 1;
                hazard_IDEX_flush = 1;
            end
    end

endmodule