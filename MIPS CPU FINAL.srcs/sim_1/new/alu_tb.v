`timescale 1ns / 1ps


module alu_tb;

    reg [31:0] a, b;
    reg [3:0] control;
    wire [31:0] result;
    wire zero; 

    alu uut(
    .a(a), 
    .b(b), 
    .control(control), 
    .result(result), 
    .zero(zero));

    initial begin
        // ADD
        a = 32'd10;
        b = 32'd5;
        control = 4'b0000;
        #10;

        // SUB
        a = 32'd10;
        b = 32'd5;
        control = 4'b0001;
        #10;

        // AND
        a = 32'hF0F0F0F0;
        b = 32'h0FF00FF0;
        control = 4'b0010;
        #10;

        // OR
        control = 4'b0011;
        #10;

        // XOR
        control = 4'b0100;
        #10;

        // RIGHT SHIFT
        a = 32'd64;
        b = 32'd2;
        control = 4'b0101;
        #10;

        // LEFT SHIFT
        control = 4'b0110;
        #10;

        // SLT (signed less than)
        a = -5;
        b = 3;
        control = 4'b0111;
        #10;

        // ZERO FLAG TEST
        a = 32'd5;
        b = 32'd5;
        control = 4'b0001;
        #10;

        $finish;
    end 

endmodule
