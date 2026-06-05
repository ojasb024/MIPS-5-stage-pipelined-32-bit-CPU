`timescale 1ns / 1ps

module  mux3(
    input   d0, d1, d2, 
    input   [1:0] sel,
    output  reg f
    );
    
    always@(*) begin
        case(sel) 
            2'b00: f = d0;
            2'b01: f = d1;
            2'b10: f = d2;
            default: f = 0;
        endcase
    end
    
endmodule