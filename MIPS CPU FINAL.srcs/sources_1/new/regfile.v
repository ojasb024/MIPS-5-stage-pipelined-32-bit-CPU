`timescale 1ns / 1ps

module  regfile(
    input   clk, write_enable,
    input   [4:0] write_reg, read_reg1, read_reg2,
    input   [31:0] write_data,  
    output   [31:0] read_data1, read_data2    
    );
    
    // 32 x 32 bit registers
    reg [31:0] registers [31:0]; 
    
    assign  read_data1 = (read_reg1 == 0) ? 0 : registers[read_reg1];
    assign  read_data2 = (read_reg2 == 0) ? 0 : registers[read_reg2];
    
    always@(posedge clk) begin
        if (write_enable && write_reg != 0) 
            registers[write_reg] <= write_data;        
    end
endmodule