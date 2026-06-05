`timescale 1ns / 1ps

module  instruction_memory(
    input   [31:0] pc,
    output  reg [31:0] instruction
    );
    
    always@(*) begin
        case(pc) 
            32'd0: instruction = {6'b111111, /*G*/ 6'b000000, 5'b00001, 15'b000000000000100};
            32'd1: instruction = {6'b111111, /*G*/ 6'b000000, 5'b00010, 15'b000000000000111};
            32'd2: instruction = {6'b000000, 5'b00001, 5'b00010, 5'b00011, /*G*/ 5'b000000, 6'b100000};
        endcase
    end 
 
endmodule