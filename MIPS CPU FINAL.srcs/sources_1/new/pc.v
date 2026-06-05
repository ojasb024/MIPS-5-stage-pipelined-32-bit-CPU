`timescale 1ns / 1ps

module  pc(
    input   clk, reset,
    input   [31:0] address_in,
    output  reg [31:0] address_out
    );
    
    always@(posedge clk) begin
        if (reset)
            address_out <= 0;
        else if (address_in >= 2) 
            address_out <= address_in;
        else
            address_out <= address_in + 1;
    end
    
    
    
endmodule