`timescale 1ns / 1ps

module cpu_top_tb;

    reg clk;

    cpu_top dut (
        .clk(clk)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #50 clk = ~clk;
    end
    
    // End simulation
    initial begin
        #2000;
        $finish;
    end
    
    initial begin
        $monitor(
            "t=%0t PC=%h instr=%h",
            $time,
            dut.PC,
            dut.instruction
        );
    end

endmodule