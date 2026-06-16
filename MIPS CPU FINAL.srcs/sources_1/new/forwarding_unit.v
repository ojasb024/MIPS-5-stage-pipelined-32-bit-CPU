`timescale 1ns / 1ps

module  forwarding_unit(
    input   [4:0] IDEX_rs, IDEX_rt,
    input   [4:0] EXMEM_destreg, MEMWB_destreg,
    input   EXMEM_rw, MEMWB_rw,
    input   [31:0] EXMEM_result, MEMWB_result,
    output  reg [31:0] forward_A, forward_B,
    output  reg A_src, B_src
    );

    always@(*) begin 
        forward_A = 0;
        forward_B = 0;
        A_src = 0;
        B_src = 0;

        if ((EXMEM_destreg == IDEX_rs)
        && EXMEM_rw && (EXMEM_destreg != 0))                 
            begin
                forward_A = EXMEM_result;
                A_src = 1;
            end
        else if ((MEMWB_destreg == IDEX_rs)
        && MEMWB_rw && (MEMWB_destreg != 0))                
            begin
                forward_A = MEMWB_result;
                A_src = 1;
            end

        if ((EXMEM_destreg == IDEX_rt)
        && EXMEM_rw && (EXMEM_destreg != 0))                 
            begin
                forward_B = EXMEM_result;
                B_src = 1;
            end
        else if ((MEMWB_destreg == IDEX_rt)
        && MEMWB_rw && (MEMWB_destreg != 0))                
            begin
                forward_B = MEMWB_result;
                B_src = 1;
            end    
    end

endmodule