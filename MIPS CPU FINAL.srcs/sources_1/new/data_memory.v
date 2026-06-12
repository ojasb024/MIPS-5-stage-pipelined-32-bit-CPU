`timescale 1ns / 1ps

module  data_memory(
    input   clk,
    input   mem_read,
    input   mem_write,
    input   [1:0] data_size,
    input   data_sign,
    input   [31:0] address,
    input   [31:0] write_data,
    output  reg [31:0] read_data 
    );
    
    parameter mem_size = 4095;
    reg [7:0] data_mem [0:mem_size];

    always@(*) begin
        read_data = 32'b0;

        if (mem_read)
            begin
                case (data_size)
                    2'b01: 
                        begin
                            if (data_sign)
                                read_data = {{24{data_mem[address][7]}}, 
                                data_mem[address]};
                            else
                                read_data = {24'b0, 
                                data_mem[address]};
                        end
                    2'b10:
                        begin 
                            if (data_sign)
                                read_data = {{16{data_mem[address+1][7]}}, 
                                data_mem[address + 1],
                                data_mem[address]};
                            else
                                read_data = {16'b0, 
                                data_mem[address + 1],
                                data_mem[address]};
                        end
                    2'b11:
                        read_data = {data_mem[address + 3],
                        data_mem[address + 2],
                        data_mem[address + 1],
                        data_mem[address]};
                endcase
            end
    end

    always@(posedge clk) begin
        if (mem_write)
            begin
                case(data_size)
                    // sb
                    2'b01:    
                        data_mem[address] <= write_data[7:0];
                    // sh
                    2'b10:
                        begin
                            data_mem[address + 1] <= write_data[15:8];
                            data_mem[address] <= write_data[7:0];
                        end
                    // sw
                    2'b11:
                        begin
                            data_mem[address + 3] <= write_data[31:24];
                            data_mem[address + 2] <= write_data[23:16];
                            data_mem[address + 1] <= write_data[15:8];
                            data_mem[address] <= write_data[7:0];
                        end
                endcase 
            end
    end
     
endmodule