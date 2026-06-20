`timescale 1ns / 1ps

module mux_2to1_32b(
    input src,
    input [31:0] d0, d1,
    output [31:0] f
);

    assign f = (src) ? d1 : d0;

endmodule