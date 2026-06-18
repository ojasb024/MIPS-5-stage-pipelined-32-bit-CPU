`timescale 1ns / 1ps

module  PC(
    input   clk, PC_en
    input   [31:0] address_in,
    output  reg [31:0] address_out
    );
    
    always@(posedge clk) begin
        if (PC_en)
            address_out <= address_in;
    end
     
endmodule