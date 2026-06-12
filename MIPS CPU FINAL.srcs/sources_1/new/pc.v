`timescale 1ns / 1ps

module  pc(
    input   clk,
    input   [31:0] address_in,
    output  reg [31:0] address_out
    );
    
    always@(posedge clk) begin
        address_out <= address_in;
    end
     
endmodule