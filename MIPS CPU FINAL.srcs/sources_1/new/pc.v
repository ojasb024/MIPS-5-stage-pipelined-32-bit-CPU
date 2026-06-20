`timescale 1ns / 1ps

module PC(
    input clk,
    input PC_en,
    input [31:0] address_in,
    output reg [31:0] address_out
);

    initial begin
        address_out = 32'h00000000;
    end

    always @(posedge clk) begin
        if (PC_en)
            address_out <= address_in;
    end

endmodule