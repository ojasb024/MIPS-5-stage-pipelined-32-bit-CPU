`timescale 1ns / 1ps

module regfile(
    input clk,
    input write_enable,
    input [4:0] write_reg,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [31:0] write_data,

    output [31:0] read_data1,
    output [31:0] read_data2
);

    // 32 x 32-bit register file
    reg [31:0] registers [0:31];

    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] = 32'h00000000;
    end

    assign read_data1 =
        (read_reg1 == 5'd0) ? 32'h00000000 :
                              registers[read_reg1];

    assign read_data2 =
        (read_reg2 == 5'd0) ? 32'h00000000 :
                              registers[read_reg2];

    always @(posedge clk) begin
        if (write_enable && (write_reg != 5'd0))
            registers[write_reg] <= write_data;
    end

endmodule