`timescale 1ns / 1ps

module pc_control(
    input [3:0] branch,
    input [1:0] jump,
    input signed [31:0] ALU_result,
    output reg [1:0] PC_src
);

    always @(*) begin
        // Default: PC = PC + 4
        PC_src = 2'b00;
        case (branch)
            // beq
            4'b0001:
                if (ALU_result == 0)
                    PC_src = 2'b11;
            // bne
            4'b0010:
                if (ALU_result != 0)
                    PC_src = 2'b11;
            // blez
            4'b0011:
                if (ALU_result <= 0)
                    PC_src = 2'b11;
            // bgtz
            4'b0100:
                if (ALU_result > 0)
                    PC_src = 2'b11;
            // bltz, bltzal
            4'b0101, 4'b0111:
                if (ALU_result < 0)
                    PC_src = 2'b11;
            // bgez, bgezal
            4'b0110, 4'b1000:
                if (ALU_result >= 0)
                    PC_src = 2'b11;
            default: ;
        endcase

        case (jump)
            // j, jal
            2'b01, 2'b10:
                PC_src = 2'b01;
            // jr, jalr
            2'b11:
                PC_src = 2'b10;
            default: ;
        endcase
    end

endmodule