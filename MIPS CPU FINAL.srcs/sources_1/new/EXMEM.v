`timescale 1ns / 1ps

module  EXMEM(
    input   clk;
    
    input [4:0] IDEX_dst_reg,
    input [31:0] IDEX_ALU_result,
    input IDEX_mem_read,
    input IDEX_mem_write, 
    input [1:0] IDEX_data_size,
    input IDEX_data_sign,
    input [1:0] IDEX_wb_src,
    input IDEX_reg_write, 
    input [31:0] IDEX_PC,

    input reg [4:0] EXMEM_dst_reg,
    input reg [31:0] EXMEM_ALU_result,
    input reg EXMEM_mem_read,
    input reg EXMEM_mem_write, 
    input reg [1:0] EXMEM_data_size,
    input reg EXMEM_data_sign,
    input reg [1:0] EXMEM_wb_src,
    input reg EXMEM_reg_write, 
    input reg [31:0] EXMEM_PC,  
    );
    
    always@(posedge clk) begin
        EXMEM_dst_reg <= IDEX_dst_reg;
        EXMEM_ALU_result <= IDEX_ALU_result;
        EXMEM_mem_read <= IDEX_mem_read;
        EXMEM_mem_write <= IDEX_mem_write;
        EXMEM_data_size <= IDEX_data_size;
        EXMEM_data_sign <= IDEX_data_sign;
        EXMEM_wb_src <= IDEX_wb_src;
        EXMEM_reg_write <= IDEX_reg_write;
        EXMEM_PC <= IDEX_PC;
    end
     
endmodule