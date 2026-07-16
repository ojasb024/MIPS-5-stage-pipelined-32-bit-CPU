`timescale 1ns / 1ps

module cpu_top(
    input   clk
    );

    /**************************************** WIRES *****************************************/

    // FETCH 
    wire [31:0] PC, PC_next, PC_plus4;
    wire [31:0] instruction;

    // DECODE
    wire [31:0] IFID_instruction;
    wire [5:0] opcode = IFID_instruction[31:26];
    wire [4:0] rs = IFID_instruction[25:21];
    wire [4:0] rt = IFID_instruction[20:16];
    wire [4:0] rd = IFID_instruction[15:11];
    wire [5:0] funct = IFID_instruction[5:0];
    wire [25:0] target_address = IFID_instruction[25:0];
    wire [15:0] imm = IFID_instruction[15:0];
    wire [4:0] shamt = IFID_instruction[10:6];
    wire [31:0] imm_se;
    wire [1:0] ALU_src;
    wire [4:0] dst_reg;
    wire [1:0] dst_reg_src;
    wire [31:0] read_reg1, read_reg2;
    wire [3:0] ALU_op;
    wire [3:0] branch;
    wire [1:0] jump;
    wire mem_read;
    wire mem_write;
    wire [1:0] data_size;
    wire data_sign;
    wire [1:0] wb_src;
    wire reg_write;
    wire [31:0] IFID_PC_plus4;

    // EXECUTE
    wire [4:0] IDEX_rt, IDEX_rs, IDEX_dst_reg;
    wire [31:0] IDEX_read_reg1, IDEX_read_reg2;
    wire [31:0] A, B;
    wire [31:0] A_operand;
    wire [31:0] B_operand;
    wire [31:0] IDEX_imm;
    wire [4:0] IDEX_shamt;
    wire [1:0] IDEX_ALU_src;
    wire [5:0] IDEX_funct;
    wire [3:0] IDEX_ALU_op;
    wire [3:0] ALU_cont;
    wire [31:0] ALU_result;
    wire [31:0] branch_address;
    wire [25:0] IDEX_target_address;
    wire [3:0] IDEX_branch;
    wire [1:0] IDEX_jump;
    wire [1:0] PC_src;
    wire [31:0] IDEX_PC_plus4;
    wire IDEX_mem_read;
    wire IDEX_mem_write;
    wire [1:0] IDEX_data_size;
    wire IDEX_data_sign;
    wire [1:0] IDEX_wb_src;
    wire IDEX_reg_write;

    // MEMORY ACCESS
    wire [4:0] EXMEM_dst_reg;
    wire [31:0] EXMEM_read_reg2;
    wire [31:0] EXMEM_ALU_result;
    wire [31:0] EXMEM_PC_plus4;
    wire [31:0] load_data;
    wire EXMEM_mem_read;
    wire EXMEM_mem_write;
    wire [1:0] EXMEM_data_size;
    wire EXMEM_data_sign;
    wire [1:0] EXMEM_wb_src;
    wire EXMEM_reg_write;

    // WRITE BACK
    wire [4:0] MEMWB_dst_reg;
    wire [31:0] MEMWB_ALU_result;
    wire [31:0] MEMWB_PC_plus4;
    wire [31:0] MEMWB_load_data;
    wire [1:0] MEMWB_wb_src;
    wire MEMWB_reg_write;
    wire [31:0] write_back_data;

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
    wire [31:0] forward_A, forward_B;
    
    // Modifications 
    wire [31:0] read_reg1_rf, read_reg2_rf;

    /******************************** MODULE INSTANTIATIONS *********************************/

    // FETCH 
    PC_mux m0(PC_src, PC_plus4, IDEX_target_address, ALU_result, branch_address, PC_next);
    adder_32b a0(PC, 32'd4, PC_plus4);
    PC g0(clk, PC_en, PC_next, PC);
    instruction_memory g1(PC, instruction);

    // IF/ID
    IFID p0(clk, IFID_en, IFID_flush, instruction, PC_plus4, IFID_instruction, IFID_PC_plus4);

    // DECODE  
    control_unit g2(opcode, funct, rt, reg_write, dst_reg_src, mem_read, mem_write, wb_src, 
        data_size, data_sign, branch, jump, ALU_src, ALU_op);
    regfile g3(clk, MEMWB_reg_write, MEMWB_dst_reg, rs, rt, write_back_data, read_reg1_rf, 
        read_reg2_rf);
    sign_extend g4(imm, imm_se);
    dst_reg_mux m1(dst_reg_src, 31, rd, rt, dst_reg);

    // Modifications
    assign read_reg1 =
    (MEMWB_reg_write && (MEMWB_dst_reg == rs) && (MEMWB_dst_reg != 0))
        ? write_back_data : read_reg1_rf;
        
    assign read_reg2 =
    (MEMWB_reg_write && (MEMWB_dst_reg == rt) && (MEMWB_dst_reg != 0))
        ? write_back_data : read_reg2_rf;

    // ID/EX
    IDEX p1(clk, IDEX_flush, hazard_IDEX_flush, target_address, rs, rt, dst_reg, read_reg1, 
        read_reg2, imm_se, shamt, ALU_src, funct, ALU_op, branch, jump, mem_read, mem_write, 
        data_size, data_sign, wb_src, reg_write, IFID_PC_plus4, IDEX_target_address, IDEX_rs, 
        IDEX_rt, IDEX_dst_reg, IDEX_read_reg1, IDEX_read_reg2, IDEX_imm, IDEX_shamt, IDEX_ALU_src, 
        IDEX_funct, IDEX_ALU_op, IDEX_branch, IDEX_jump, IDEX_mem_read, IDEX_mem_write, 
        IDEX_data_size, IDEX_data_sign, IDEX_wb_src, IDEX_reg_write, IDEX_PC_plus4);

    // EXECUTE
    mux_2to1_A_operand m_A(IDEX_ALU_src, IDEX_read_reg1, IDEX_shamt, A_operand);    
    mux_2to1_32b m_B(IDEX_ALU_src, IDEX_read_reg2, IDEX_imm, B_operand);
    
    mux_2to1_32b m_fA(A_src, A_operand, forward_A, A);
    mux_2to1_32b m_fB(B_src, B_operand, forward_B, B);
    
    ALU_control g5(IDEX_funct, IDEX_ALU_op, ALU_cont);
    ALU g6(A, B, ALU_cont, ALU_result);
    
    adder_32b a1((IDEX_imm << 2), IDEX_PC_plus4, branch_address);
    pc_control g7(IDEX_branch, IDEX_jump, ALU_result, PC_src);

    // EX/MEM
    EXMEM p2(clk, IDEX_dst_reg, IDEX_read_reg2, ALU_result, IDEX_mem_read, IDEX_mem_write, 
        IDEX_data_size, IDEX_data_sign, IDEX_wb_src, IDEX_reg_write, IDEX_PC_plus4, 
        EXMEM_dst_reg, EXMEM_read_reg2, EXMEM_ALU_result, EXMEM_mem_read, EXMEM_mem_write, 
        EXMEM_data_size, EXMEM_data_sign, EXMEM_wb_src, EXMEM_reg_write, EXMEM_PC_plus4);

    // MEMORY ACCESS
    data_memory g8(clk, EXMEM_mem_read, EXMEM_mem_write, EXMEM_data_size, EXMEM_data_sign, 
        EXMEM_ALU_result, EXMEM_read_reg2, load_data);

    // MEM/WB
    MEMWB p3(clk, EXMEM_dst_reg, EXMEM_ALU_result, EXMEM_PC_plus4, load_data, 
        EXMEM_wb_src, EXMEM_reg_write, MEMWB_dst_reg, MEMWB_ALU_result, MEMWB_PC_plus4, 
        MEMWB_load_data, MEMWB_wb_src, MEMWB_reg_write);

    // WRITE BACK
    mux_3to1_32b m5(MEMWB_wb_src, MEMWB_ALU_result, MEMWB_PC_plus4, MEMWB_load_data, 
        write_back_data);

    // External modules 
    
    // Flush control
    flush_control g9(PC_src, hazard_IDEX_flush, IFID_flush, IDEX_flush);

    // Forwarding unit
    forwarding_unit g10(IDEX_rs, IDEX_rt, EXMEM_dst_reg, MEMWB_dst_reg, EXMEM_reg_write, 
        MEMWB_reg_write, EXMEM_ALU_result, write_back_data, forward_A, forward_B,
        A_src, B_src);

    // Hazard detection unit
    hazard_detection_unit g11(rs, rt, IDEX_mem_read, IDEX_rt, PC_en, IFID_en, 
        hazard_IDEX_flush);

endmodule
