`timescale 1ns / 1ps

module  ALU_control(
    input   [3:0] alu_op,
    input   [5:0] func,
    output  reg [3:0] alu_cont
    );    
    
    always@(*) begin        
        alu_cont = 4'd0;
        case(alu_op)
            4'b0000:  alu_cont = 4'd1;
            4'b0001:  alu_cont = 4'd3;
            4'b0010:  
                begin
                    case(func)
                        6'b100001: alu_cont = 4'd1;
                        6'b100011: alu_cont = 4'd3;
                
                        6'b100100: alu_cont = 4'd4;
                        6'b100101: alu_cont = 4'd5;
                        6'b100110: alu_cont = 4'd6;
                        6'b100111: alu_cont = 4'd7;
                
                        6'b101010: alu_cont = 4'd11;
                        6'b101011: alu_cont = 4'd12;
                
                        6'b000000: alu_cont = 4'd9;
                        6'b000010: alu_cont = 4'd8;
                        6'b000011: alu_cont = 4'd10;

                        6'b001000: alu_cont = 4'd14;
                        6'b001001: alu_cont = 4'd14;
                    endcase
                end
            4'b0011: alu_cont = 4'd12;
            4'b0100: alu_cont = 4'd11;
            4'b0101: alu_cont = 4'd4;
            4'b0110: alu_cont = 4'd5;
            4'b0111: alu_cont = 4'd6;
            4'b1000: alu_cont = 4'd15;
        endcase
    end
   
endmodule