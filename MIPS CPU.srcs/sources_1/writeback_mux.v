`timescale 1ns / 1ps

module  writeback_mux(
    input   [1:0] src,
    input   [31:0] d0, d1, d2, d3,
    output  reg [31:0] f
    );
    
    always@(*) begin
        case(src) 
            2'b00: f = d0;
            2'b01: f = d1;
            2'b10: f = d2;
            2'b11: f = d3;
            default: f = d0;
        endcase
    end
    
endmodule