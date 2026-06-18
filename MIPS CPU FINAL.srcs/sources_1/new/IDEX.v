`timescale 1ns / 1ps

module  IDEX(
    input   clk,
    input   flush,
    
    input   [25:0] IFID_target_address,
    input   [4:0] IFID_rs, IFID_rt, IFID_dst_reg,
    input   [31:0] IFID_reg1, IFID_reg2,
    input   [31:0] IFID_imm,
    input   IFID_ALU_src,
    input   [5:0] IFID_func,
    input   [3:0] IFID_branch,
    input   [1:0] IFID_jump,
    input   IFID_mem_read,
    input   IFID_mem_write,
    input   [1:0] IFID_data_size,
    input   IFID_data_sign,
    input   [1:0] IFID_wb_src,
    input   IFID_reg_write, 
    input   IFID_PC,

    output  reg [25:0] IDEX_target_address,
    output  reg [4:0] IDEX_rs, IDEX_rt, IDEX_dst_reg,
    output  reg [31:0] IDEX_reg1, IDEX_reg2,
    output  reg [31:0] IDEX_imm,
    output  reg IDEX_ALU_src,
    output  reg [5:0] IDEX_func,
    output  reg [3:0] IDEX_branch,
    output  reg [1:0] IDEX_jump,
    output  reg IDEX_mem_read,
    output  reg IDEX_mem_write,
    output  reg [1:0] IDEX_data_size,
    output  reg IDEX_data_sign,
    output  reg [1:0] IDEX_wb_src,
    output  reg IDEX_reg_write, 
    output  reg IDEX_PC
    );
    
    always@(posedge clk) begin
        if (flush)
            begin
                IDEX_branch <= 0;
                IDEX_jump <= 0;
                IDEX_mem_read <= 0;
                IDEX_mem_write <= 0;
                IDEX_reg_write <= 0;
            end
        else  
            begin
                IDEX_target_address <= IFID_target_address;
                IDEX_rs <= IFID_rs;
                IDEX_rt <= IFID_rt; 
                IDEX_dst_reg <= IFID_dst_reg;
                IDEX_reg1 <= IFID_reg1;
                IDEX_reg2 <= IFID_reg2;
                IDEX_imm <= IFID_imm;
                IDEX_ALU_src <= IFID_ALU_src;
                IDEX_func <= IFID_func;
                IDEX_branch <= IFID_branch;
                IDEX_jump <= IFID_jump;
                IDEX_mem_read <= IFID_mem_read;
                IDEX_mem_write <= IFID_mem_write;
                IDEX_data_size <= IFID_data_size;
                IDEX_data_sign<= IFID_data_sign;
                IDEX_wb_src <= IFID_wb_src;
                IDEX_reg_write <= IFID_reg_write; 
                IDEX_PC <= IFID_PC;
            end
    end
     
endmodule