`timescale 1ns / 1ps

module cpu_top(
    input   clk
    );

    /**************************************** WIRES *****************************************/

    // FETCH 
    wire [31:0] PC, next_PC, PC_plus4;
    wire [31:0] instruction;

    // IF/ID
    wire [31:0] IFID_instruction;
    wire [5:0] IFID_opcode = IFID_instruction[31:26];
    wire [4:0] IFID_rs = IFID_instruction[25:21];
    wire [4:0] IFID_rt = IFID_instruction[20:16];
    wire [4:0] IFID_rd = IFID_instruction[15:11];
    wire [5:0] IFID_funct = IFID_instruction[5:0];
    wire [25:0] target_address = IFID_instruction[25:0];
    wire [15:0] IFID_imm = IFID_instruction[15:0];
    wire [31:0] IFID_imm_se;
    wire [4:0] IFID_dst_reg;
    wire [1:0] IFID_dst_reg_src;
    wire [4:0] IFID_ALU_op;
    wire [3:0] IFID_branch;
    wire [1:0] IFID_jump;
    wire IFID_mem_read;
    wire IFID_mem_write;
    wire [1:0] IFID_data_size;
    wire IFID_data_sign;
    wire [1:0] IFID_wb_src;
    wire IFID_reg_write;
    wire [31:0] IFID_PC;
    wire [31:0] IFID_reg1, IFID_reg2;

    // ID/EX
    wire [4:0] IDEX_rt, IDEX_rs, IDEX_dst_reg;
    wire [31:0] IDEX_reg1, IDEX_reg2;
    wire [31:0] A, B;
    wire [31:0] IDEX_imm;
    wire IDEX_ALU_src;
    wire IDEX_func;
    wire IDEX_ALU_op;
    wire [3:0] ALU_cont;
    wire [31:0] IDEX_ALU_result;
    wire [31:0] IDEX_branch_address;
    wire [31:0] IDEX_target_address;
    wire [3:0] IDEX_branch;
    wire [1:0] IDEX_jump;
    wire [1:0] PC_src;

    // EX/MEM
    wire [4:0] EXMEM_dst_reg;
    wire [31:0] EXMEM_ALU_result;
    wire [31:0] EXMEM_load_data;
    wire [31:0] EXMEM_link_address;
    wire EXMEM_mem_read;
    wire EXMEM_mem_write;
    wire [1:0] EXMEM_data_size;
    wire EXMEM_data_sign;
    wire [1:0] EXMEM_wb_src;
    wire EXMEM_reg_write;

    // MEM/WB
    wire [4:0] MEMWB_dst_reg;
    wire [31:0] MEMWB_ALU_result;
    wire [31:0] MEMWB_link_address;
    wire [31:0] MEMWB_load_data;
    wire [1:0] MEMWB_wb_src;
    wire MEMWB_reg_write;

    // External Modules

    // Flush control
    wire IFID_flush;
    wire IDEX_flush;

    // Hazard detection unit
    wire PC_en;
    wire IFID_en;
    wire hazard_IDEX_flush;

    // Forwarding module  
    wire A_src, B_src;
    wire [31:0] forward_A, forward_A;

    /******************************** MODULE INSTANTIATIONS *********************************/

    // FETCH 
    PC_mux g0(PC_src, PC_plus4, IDEX_target_address, IDEX_ALU_result, IDEX_branch_address);
    PC g1(clk, PC_en, PC_next, PC);
    adder_32bit g2(PC, 4, PC_plus4);
    instruction_memory g3(PC, instruction);

    // IF/ID
    IFID p0(clk, IFID_en, IFID_flush, instruction, PC, IFID_instruction, IFID_PC);

    // DECODE  
    control_unit g4(IFID_opcode, IFID_func, IFID_rt, IFID_reg_write, IFID_dst_reg_src, 
        IFID_mem_read, IFID_mem_write, IFID_wb_src, IFID_data_size, IFID_data_sign, 
        IFID_branch, IFID_jump, IFID_ALU_src, IFID_ALU_op);

    // ID/EX
    IDEX p1(clk, IDEX_flush, IFID_target_address, IFID_rs, IFID_rt, IFID_dst_reg,
        IFID_reg1, IFID_reg2, IFID_imm_se, IFID_ALU_src, IFID_func, IFID_branch, IFID_jump,
        IFID_mem_read, IFID_mem_write, IFID_data_size, IFID_data_sign, IFID_wb_src,   
        IFID_reg_write, IFID_PC, IDEX_target_address, IDEX_rs, IDEX_rt, IDEX_dst_reg,  
        IDEX_reg1, IDEX_reg2, IDEX_imm, IDEX_ALU_src, IDEX_func, IDEX_branch, IDEX_jump,
        IDEX_mem_read, IDEX_mem_write, IDEX_data_size, IDEX_data_sign, IDEX_wb_src,  
        IDEX_reg_write, IDEX_PC);

    // EXECUTE

    // EX/MEM

    // MEMORY ACCESS

    // MEM/WB

    // WRITE BACK
    
    
    
    
    
    
    
    
endmodule
