`timescale 1ns / 1ps

module cpu_top(
    input   clk, reset
    );
    
    wire [31:0] curr_address;
    pc g0(clk, reset, curr_address);
    
    wire [31:0] instruction; 
    instruction_memory g1(curr_address, instruction);
    
    wire [1:0] instr_type;
    wire [4:0] rs, rt, rd;
    wire [31:0] const;
    wire [5:0] func;
    instruction_decode g2(instruction, instr_type, rs, rt, rd, const, func);
    
    wire [31:0] alu_B;
    wire [4:0] write_reg, read_reg1, read_reg2;
    wire [6:0] alu_op;
    control_unit g3(instr_type, func, rs, rt, rd, const, alu_B, write_reg, read_reg1, read_reg2, alu_op);
   
    mux3 g4();    
   
    wire [31:0] A, B;
    wire [31:0] result;
    alu g5();
    
    
    
    
    
    
    
    
    
endmodule
