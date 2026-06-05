`timescale 1ns / 1ps

module  instruction_decode(
    input   [31:0] instruction,
    output  [5:0] opcode,
    output  [4:0] rs, rt, rd,
    output  [5:0] func, 
    output  [15:0] imm
    );
    
    assign opcode = instruction[31:26];
    assign rs = instruction[25:21];
    assign rt = instruction[20:16];
    assign rd = instruction[15:11];
    assign funct = instruction[5:0];
    assign imm = instruction[15:0];
 
endmodule