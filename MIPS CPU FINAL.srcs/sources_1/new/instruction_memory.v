`timescale 1ns / 1ps

module  instruction_memory(
    input   [31:0] PC,
    output  reg [31:0] instruction
    );
    
    parameter mem_size = 255;
    [7:0] intruction_mem [0:mem_size];

    always@(*) begin
        case(PC)
            instruction <= instruction_mem[PC];
        endcase
    end 
 
endmodule