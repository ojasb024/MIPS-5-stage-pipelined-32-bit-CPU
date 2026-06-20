`timescale 1ns / 1ps

module  EXMEM(
    input   clk,
    
    input [4:0] IDEX_dst_reg,
    input [31:0] IDEX_read_reg2,
    input [31:0] ALU_result,
    input IDEX_mem_read,
    input IDEX_mem_write, 
    input [1:0] IDEX_data_size,
    input IDEX_data_sign,
    input [1:0] IDEX_wb_src,
    input IDEX_reg_write, 
    input [31:0] IDEX_PC_plus4,

    output reg [4:0] EXMEM_dst_reg,
    output reg [31:0] EXMEM_read_reg2,
    output reg [31:0] EXMEM_ALU_result,
    output reg EXMEM_mem_read,
    output reg EXMEM_mem_write, 
    output reg [1:0] EXMEM_data_size,
    output reg EXMEM_data_sign,
    output reg [1:0] EXMEM_wb_src,
    output reg EXMEM_reg_write, 
    output reg [31:0] EXMEM_PC_plus4  
    );

    initial begin
        EXMEM_dst_reg = 0;
        EXMEM_read_reg2 = 0;
        EXMEM_ALU_result = 0;
        EXMEM_mem_read = 0;
        EXMEM_mem_write = 0;
        EXMEM_data_size = 0;
        EXMEM_data_sign = 0;
        EXMEM_wb_src = 0;
        EXMEM_reg_write = 0;
        EXMEM_PC_plus4 = 0;
    end
    
    always@(posedge clk) begin
        EXMEM_dst_reg <= IDEX_dst_reg;
        EXMEM_read_reg2 <= IDEX_read_reg2;
        EXMEM_ALU_result <= ALU_result;
        EXMEM_mem_read <= IDEX_mem_read;
        EXMEM_mem_write <= IDEX_mem_write;
        EXMEM_data_size <= IDEX_data_size;
        EXMEM_data_sign <= IDEX_data_sign;
        EXMEM_wb_src <= IDEX_wb_src;
        EXMEM_reg_write <= IDEX_reg_write;
        EXMEM_PC_plus4 <= IDEX_PC_plus4;
    end
     
endmodule