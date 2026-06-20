`timescale 1ns / 1ps

module instruction_memory(
    input  [31:0] PC,
    output [31:0] instruction
);

    parameter MEM_SIZE = 255;
    reg [31:0] instruction_mem [0:MEM_SIZE];

    initial begin
        $readmemh("PROGRAM.mem", instruction_mem);
        $display("IMEM[0] = %h", instruction_mem[0]);
        $display("IMEM[4] = %h", instruction_mem[4]);
        $display("IMEM[8] = %h", instruction_mem[8]);
    end

    assign instruction = instruction_mem[PC[9:2]];

endmodule