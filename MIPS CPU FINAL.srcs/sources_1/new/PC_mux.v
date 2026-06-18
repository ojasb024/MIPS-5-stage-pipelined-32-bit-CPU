`timescale 1ns / 1ps

module  PC_mux(
    input [1:0] PC_src;
    input [31:0] PC_plus4;
    input [25:0] IDEX_target_address;
    input [31:0] jr_address;
    input [31:0] branch_address;
    output reg [31:0] next_PC; 
    );
    
    always@(*) begin
        case (PC_src)
            2'b0: next_PC = PC_plus4;
            2'b01: next_PC = {PC_plus4[31:28], IDEX_target_address, 2'b0};
            2'b10: next_PC = jr_address;
            2'b11: next_PC = branch_address;  
        endcase
    end
     
endmodule