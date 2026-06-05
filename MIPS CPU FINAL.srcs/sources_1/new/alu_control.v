`timescale 1ns / 1ps

module  alu_control(
    input   [1:0] alu_op,
    input   [5:0] func,
    output  reg [3:0] alu_cont
    );    
    
    always@(*) begin
        case(alu_op)
            2'b00:  alu_cont = 4'd1;
            2'b01:  alu_cont = 4'd3;
            2'b10:  
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
                endcase
            end
        endcase
    end
   
endmodule