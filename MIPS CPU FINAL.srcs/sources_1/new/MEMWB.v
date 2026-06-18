`timescale 1ns / 1ps

module  MEMWB(
    input   clk;

    input   [4:0] EXMEM_dst_reg,
    input   [31:0] EXMEM_ALU_result,
    input   [31:0] EXMEM_link_address,
    input   [31:0] EXMEM_load_data,
    input   [1:0] EXMEM_wb_src,
    input   EXMEM_reg_write,

    output  reg [4:0] MEMWB_dst_reg,
    output  reg [31:0] MEMWB_ALU_result,
    output  reg [31:0] MEMWB_link_address,
    output  reg [31:0] MEMWB_load_data,
    output  reg [1:0] MEMWB_wb_src,
    output  reg MEMWB_reg_write,
    );
    
    always@(posedge clk) begin
        MEMWB_dst_reg <= EXMEM_dst_reg;
        MEMWB_ALU_result <= EXMEM_ALU_result;
        MEMWB_link_address <= EXMEM_link_address;
        MEMWB_load_data <= EXMEM_load_data;
        MEMWB_wb_src <= EXMEM_wb_src;
        MEMWB_reg_write <= EXMEM_reg_write;
    end
     
endmodule