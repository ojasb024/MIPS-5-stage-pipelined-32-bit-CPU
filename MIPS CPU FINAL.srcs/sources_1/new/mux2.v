`timescale 1ns / 1ps

module  mux2(
    input   d0, d1, sel,
    output  f
    );
    
    assign  f = (sel) ? d0 : d1;
    
endmodule