`timescale 1ns / 1ps

module  mux_3to1_32b(
    input   [1:0] src,
    input   [31:0] d0, d1, d2,
    output  reg [31:0] f
    );
    
    always@(*) begin
        case(src) 
            2'b00: f = d0;
            2'b01: f = d1;
            2'b10: f = d2;
            default: f = d0;
        endcase
    end
    
endmodule