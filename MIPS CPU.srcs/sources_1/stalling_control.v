`timescale 1ns / 1ps

module stalling_control(
    input   clk,
    input   div_done,
    input   [2:0] MDU_cont,
    input   hazard_stall,
    output  PC_en,
    output  IFID_en, 
    output  IDEX_en
);
    
    wire div_stall;
    div_stall_control g13_1(clk, MDU_cont, div_done, div_stall);

    assign PC_en = (hazard_stall || div_stall) ? 0 : 1;
    assign IFID_en = (hazard_stall || div_stall) ? 0 : 1;
    assign IDEX_en = (div_stall) ? 0 : 1;

endmodule 


module div_stall_control(
    input   clk,
    input   [2:0] MDU_cont,
    input   div_done,
    output  reg div_stall
    );
    
    initial begin
        div_stall = 0;
    end
    
    always@(posedge clk) begin   
        if (MDU_cont == 3'b011 || MDU_cont == 3'b100)
            div_stall <= 1;
        if (div_done)
            div_stall <= 0;
    end
    
endmodule
