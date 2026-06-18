`timescale 1ns / 1ps

module  IFID(
    input   clk;
    input   en;
    input   flush;
    input   [31:0] instruction,
    input   [31:0] PC,
    output  reg [31:0] IFID_instruction,
    output  reg [31:0] IFID_PC
    );
    
    always@(posedge clk) begin
        if (en)
        begin
            if (flush) 
                begin
                    IFID_instruction <= 0;
                    IFID_PC <= 0;
                end
            else 
                begin
                    IFID_instruction <= instruction;
                    IFID_PC <= PC;
                end
       
        end
    end
     
endmodule