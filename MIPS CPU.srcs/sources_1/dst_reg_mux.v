`timescale 1ns / 1ps

module  dst_reg_mux(
    input   [1:0] dst_reg_src,
    input   [4:0] reg0,
    input   [4:0] reg1,
    input   [4:0] reg2,
    output  reg [4:0] dst_reg
    );
   
    always@(*) begin
        case (dst_reg_src)
            2'b00: dst_reg = reg0;
            2'b01: dst_reg = reg1;
            2'b10: dst_reg = reg2;
            default: dst_reg = reg1;
        endcase    
    end
    
endmodule