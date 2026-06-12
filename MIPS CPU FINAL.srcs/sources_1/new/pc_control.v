`timescale 1ns / 1ps

module  pc_control(
    input   [3:0] branch,
    input   [1:0] jump,
    input   [31:0] ALU_result, 
    output  reg [1:0] PC_src
    );


    always@(*) begin
        PC_src = 0;

        case (branch)
            // beq
            4'b0001:
                begin
                    if (ALU_result == 0) 
                        PC_src = 2'b11;                 
                end
            // bne 
            4'b0010:
                begin
                    if (ALU_result != 0) 
                        PC_src = 2'b11;                 
                end
            // blez 
            4'b0011:
                begin
                    if (ALU_result <= 0)
                        PC_src = 2'b11;
                end
            // bgtz
            4'b0100:
                begin
                    if (ALU_result > 0)
                        PC_src = 2'b11;
                end
            // bltz, bltzal
            4'b0101, 4'b0111:
                begin
                    if (ALU_result < 0)
                        PC_src = 2'b11;
                end
            // bgez, bgezal
            4'b0110, 4'b1000:
                begin
                    if (ALU_result >= 0)
                        PC_src = 2'b11;
                end
        endcase

        case (jump) 
            // j, jal 
            2'b01, 2'b10: PC_src = 2'b01;
            // jr, jalr
            2'b11: PC_src = 2'b10;
        endcase
    end 

endmodule