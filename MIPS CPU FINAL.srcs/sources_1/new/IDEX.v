`timescale 1ns / 1ps

module  IDEX(
    input   clk,
    input   flush,
    input   hazard_IDEX_flush,
    
    input   [25:0] target_address,
    input   [4:0] rs, rt, dst_reg,
    input   [31:0] read_reg1, read_reg2,
    input   [31:0] imm_se,
    input   [4:0] shamt, 
    input   [1:0] ALU_src,
    input   [5:0] funct,
    input   [3:0] ALU_op,
    input   [3:0] branch,
    input   [1:0] jump,
    input   mem_read,
    input   mem_write,
    input   [1:0] data_size,
    input   data_sign,
    input   [1:0] wb_src,
    input   reg_write, 
    input   [31:0] IFID_PC_plus4,

    output  reg [25:0] IDEX_target_address,
    output  reg [4:0] IDEX_rs, IDEX_rt, IDEX_dst_reg,
    output  reg [31:0] IDEX_read_reg1, IDEX_read_reg2,
    output  reg [31:0] IDEX_imm,
    output  reg [4:0] IDEX_shamt,
    output  reg [1:0] IDEX_ALU_src,
    output  reg [5:0] IDEX_funct,
    output  reg [3:0] IDEX_ALU_op,
    output  reg [3:0] IDEX_branch,
    output  reg [1:0] IDEX_jump,
    output  reg IDEX_mem_read,
    output  reg IDEX_mem_write,
    output  reg [1:0] IDEX_data_size,
    output  reg IDEX_data_sign,
    output  reg [1:0] IDEX_wb_src,
    output  reg IDEX_reg_write, 
    output  reg [31:0] IDEX_PC_plus4
    );

    initial begin
        IDEX_target_address = 0;
        IDEX_rs = 0;
        IDEX_rt = 0;
        IDEX_dst_reg = 0;
        IDEX_read_reg1 = 0;
        IDEX_read_reg2 = 0;
        IDEX_imm = 0;
        IDEX_shamt = 0;
        IDEX_ALU_src = 0;
        IDEX_funct = 0;
        IDEX_ALU_op = 0;
        IDEX_branch = 0;
        IDEX_jump = 0;
        IDEX_mem_read = 0;
        IDEX_mem_write = 0;
        IDEX_data_size = 0;
        IDEX_data_sign = 0;
        IDEX_wb_src = 0;
        IDEX_reg_write = 0;
        IDEX_PC_plus4 = 0;
    end
    
    always@(posedge clk) begin
        if (flush || hazard_IDEX_flush)
            begin
                IDEX_branch <= 0;
                IDEX_jump <= 0;
                IDEX_mem_read <= 0;
                IDEX_mem_write <= 0;
                IDEX_reg_write <= 0;
            end
        else  
            begin
                IDEX_target_address <= target_address;
                IDEX_rs <= rs;
                IDEX_rt <= rt; 
                IDEX_dst_reg <= dst_reg;
                IDEX_read_reg1 <= read_reg1;
                IDEX_read_reg2 <= read_reg2;
                IDEX_imm <= imm_se;
                IDEX_shamt <= shamt;
                IDEX_ALU_src <= ALU_src;
                IDEX_funct <= funct;
                IDEX_ALU_op <= ALU_op;
                IDEX_branch <= branch;
                IDEX_jump <= jump;
                IDEX_mem_read <= mem_read;
                IDEX_mem_write <= mem_write;
                IDEX_data_size <= data_size;
                IDEX_data_sign<= data_sign;
                IDEX_wb_src <= wb_src;
                IDEX_reg_write <= reg_write; 
                IDEX_PC_plus4 <= IFID_PC_plus4;
            end
    end
     
endmodule