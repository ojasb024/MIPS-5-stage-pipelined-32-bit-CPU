`timescale 1ns / 1ps

module mux_2to1_A_operand(
    input   [1:0] src,
    input   [31:0] IDEX_read_reg1,
    input   [4:0] IDEX_shamt,
    output  reg [31:0] f
    );
    
    always@(*) begin
        case(src) 
            2'b10: f = IDEX_shamt;
            default: f = IDEX_read_reg1;
        endcase
    end

endmodule
