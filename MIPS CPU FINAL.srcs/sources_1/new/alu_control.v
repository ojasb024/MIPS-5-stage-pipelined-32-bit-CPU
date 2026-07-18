`timescale 1ns / 1ps

module  ALU_control(
    input   [5:0] func,
    input   [3:0] ALU_op,
    output  reg [3:0] ALU_cont
    );    
    
    always@(*) begin        
        ALU_cont = 4'd0;
        case(ALU_op)
            4'b0000:  ALU_cont = 4'd1;
            4'b0001:  ALU_cont = 4'd3;
            4'b0010:  
                begin
                    case(func)
                        6'b100001: ALU_cont = 4'd1;
                        6'b100000: ALU_cont = 4'd1;             
                        6'b100011: ALU_cont = 4'd3;
                        6'b100010: ALU_cont = 4'd3;
                
                        6'b100100: ALU_cont = 4'd4;
                        6'b100101: ALU_cont = 4'd5;
                        6'b100110: ALU_cont = 4'd6;
                        6'b100111: ALU_cont = 4'd7;
                
                        6'b101010: ALU_cont = 4'd11;
                        6'b101011: ALU_cont = 4'd12;
                
                        6'b000000: ALU_cont = 4'd9;
                        6'b000010: ALU_cont = 4'd8;
                        6'b000011: ALU_cont = 4'd10;
                        6'b000100: ALU_cont = 4'd9;
                        6'b000110: ALU_cont = 4'd8;
                        6'b000111: ALU_cont = 4'd10;
                        
                        6'b001000: ALU_cont = 4'd13;
                        6'b001001: ALU_cont = 4'd13;
                        
                        default: ALU_cont = 4'd14;
                    endcase
                end
            4'b0011: ALU_cont = 4'd12;
            4'b0100: ALU_cont = 4'd11;
            4'b0101: ALU_cont = 4'd4;
            4'b0110: ALU_cont = 4'd5;
            4'b0111: ALU_cont = 4'd6;
            4'b1000: ALU_cont = 4'd15;
            default: ALU_cont = 4'd14;
        endcase
    end
   
endmodule