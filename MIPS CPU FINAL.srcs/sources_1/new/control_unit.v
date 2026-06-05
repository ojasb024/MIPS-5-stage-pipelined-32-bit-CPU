`timescale 1ns / 1ps

module  control_unit(
    input   [5:0] opcode,
    output  reg reg_write,                                     
    output  reg mem_read,                                      
    output  reg mem_write,                                     
    output  reg mem_to_reg,                                     
    output  reg branch,                                       
    output  reg alu_src,                                       
    output  reg [1:0] alu_op   
);

    // reg_write -> 1: Overwrite reg, 0: No write
    // mem_read -> 1: Read from mem, 0: No read
    // mem_write -> 1: Write to mem, 0: No write
    // mem_to_reg -> 1: Select mem data, 0: Select ALU data
    // branch -> 1: change PC, 0: PC unchanged
    // alu_src -> 1: input imm into ALU_B, 0: input register value

    always@(*) begin
        case(opcode)
            // R-type
            6'b000000: 
            begin
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 0;                                     
                mem_to_reg = 0;                                     
                branch = 0;                                       
                alu_src = 0;                                       
                alu_op = 2'b10;   
            end
            // Arithmetic immediate  
            // addi
            6'b001000: 
            begin
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 0;                                     
                mem_to_reg = 0;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b00;   
            end
            // addiu
            6'b001001: 
            begin
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 0;                                     
                mem_to_reg = 0;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b00;   
            end
            // slti
            6'b001010: 
            begin
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 0;                                     
                mem_to_reg = 0;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b11;   
            end
            // sltiu
            6'b001011: 
            begin
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 0;                                     
                mem_to_reg = 0;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b11;   
            end
            // Logical immediate
            // andi
            6'b001100: 
            begin
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 0;                                     
                mem_to_reg = 0;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b11;   
            end
            // ori
            6'b001101: 
            begin
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 0;                                     
                mem_to_reg = 0;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b11;   
            end
            // xori
            6'b001110: 
            begin
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 0;                                     
                mem_to_reg = 0;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b11;   
            end
            // lui
            6'b001111: 
            begin
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 0;                                     
                mem_to_reg = 0;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b11;   
            end
            // Loads 
            // lb 
            6'b100000: 
            begin
                reg_write = 1;                                     
                mem_read = 1;                                      
                mem_write = 0;                                     
                mem_to_reg = 1;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b00;   
            end
            // lh
            6'b100001: 
            begin
                reg_write = 1;                                     
                mem_read = 1;                                      
                mem_write = 0;                                     
                mem_to_reg = 1;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b00;   
            end
            // lw
            6'b100011: 
            begin   
                reg_write = 1;                                     
                mem_read = 1;                                      
                mem_write = 0;                                     
                mem_to_reg = 1;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b00;   
            end
            // lbu 
            6'b100100: 
            begin   
                reg_write = 1;                                     
                mem_read = 1;                                      
                mem_write = 0;                                     
                mem_to_reg = 1;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b00;   
            end
            // lhu
            6'b100101: 
            begin   
                reg_write = 1;                                     
                mem_read = 1;                                      
                mem_write = 0;                                     
                mem_to_reg = 1;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b00;   
            end
            // Stores 
            // sb 
            6'b101000: 
            begin   
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 1;                                     
                mem_to_reg = 1;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b00;   
            end
            // sh 
            6'b101001: 
            begin   
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 1;                                     
                mem_to_reg = 1;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b00;   
            end
            // sw 
            6'b101011: 
            begin   
                reg_write = 1;                                     
                mem_read = 0;                                      
                mem_write = 1;                                     
                mem_to_reg = 1;                                     
                branch = 0;                                       
                alu_src = 1;                                       
                alu_op = 2'b00;   
            end
        endcase 
    end
    
endmodule