`timescale 1ns / 1ps

module mux_3to1_B_operand(
    input   [1:0] src,
    input   [31:0] IDEX_read_reg2, IDEX_imm,
    input   [4:0] IDEX_shamt,
    output  reg [31:0] f
    );
    
    always@(*) begin
        case(src) 
            2'b00: f = IDEX_read_reg2;
            2'b01: f = IDEX_imm;
            2'b10: f = IDEX_shamt;
            default: f = IDEX_read_reg2;
        endcase
    end

endmodule