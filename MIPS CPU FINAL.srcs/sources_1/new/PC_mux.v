`timescale 1ns / 1ps

module  PC_mux(
    input [1:0] PC_src,
    input [31:0] PC_plus4,
    input [25:0] IDEX_target_address,
    input [31:0] jr_address,
    input [31:0] branch_address,
    output reg [31:0] PC_next
    );
    
    
    always@(*) begin
        case (PC_src)
            2'b00: PC_next = PC_plus4;
            2'b01: PC_next = {PC_plus4[31:28], IDEX_target_address, 2'b00};
            2'b10: PC_next = jr_address;
            2'b11: PC_next = branch_address;  
            default: PC_next = PC_plus4;
        endcase
    end
     
endmodule