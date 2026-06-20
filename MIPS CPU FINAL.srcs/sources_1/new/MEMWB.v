`timescale 1ns / 1ps

module  MEMWB(
    input   clk,

    input   [4:0] EXMEM_dst_reg,
    input   [31:0] EXMEM_ALU_result,
    input   [31:0] EXMEM_PC_plus4,
    input   [31:0] EXMEM_load_data,
    input   [1:0] EXMEM_wb_src,
    input   EXMEM_reg_write,

    output  reg [4:0] MEMWB_dst_reg,
    output  reg [31:0] MEMWB_ALU_result,
    output  reg [31:0] MEMWB_PC_plus4,
    output  reg [31:0] MEMWB_load_data,
    output  reg [1:0] MEMWB_wb_src,
    output  reg MEMWB_reg_write
    );

    initial begin
        MEMWB_dst_reg = 0;
        MEMWB_ALU_result = 0;
        MEMWB_PC_plus4 = 0;
        MEMWB_load_data = 0;
        MEMWB_wb_src = 0;
        MEMWB_reg_write = 0;
    end
    
    always@(posedge clk) begin
        MEMWB_dst_reg <= EXMEM_dst_reg;
        MEMWB_ALU_result <= EXMEM_ALU_result;
        MEMWB_PC_plus4 <= EXMEM_PC_plus4;
        MEMWB_load_data <= EXMEM_load_data;
        MEMWB_wb_src <= EXMEM_wb_src;
        MEMWB_reg_write <= EXMEM_reg_write;
    end
     
endmodule