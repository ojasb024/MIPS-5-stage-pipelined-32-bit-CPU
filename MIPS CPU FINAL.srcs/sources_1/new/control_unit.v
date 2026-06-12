`timescale 1ns / 1ps

module  control_unit(
    input   [5:0] opcode,
    input   [5:0] func, 
    input   [4:0] rt, 
    output  reg reg_write,
    output  reg [1:0] reg_dst,                                     
    output  reg mem_read,                                      
    output  reg mem_write,                                     
    output  reg [1:0] wb_src,
    output  reg [1:0] data_size;
    output  reg data_sign;                                     
    output  reg [3:0] branch,   
    output  reg [1:0] jump,                                     
    output  reg alu_src,                                       
    output  reg [3:0] alu_op 
    );

    // reg_write -> 1: Overwrite reg, 0: No write
    // mem_read -> 1: Read from mem, 0: No read
    // mem_write -> 1: Write to mem, 0: No write
    // mem_to_reg -> 1: Select mem data, 0: Select ALU data
    // alu_src -> 1: input imm into ALU_B, 0: input register value

    always@(*) begin
        reg_write = 0;
        reg_dst = 2'b10;
        mem_read  = 0;
        mem_write = 0;
        wb_src = 0;
        data_size = 0;
        data_sign = 0;
        branch = 0;
        jump = 0;
        alu_src = 0;
        alu_op = 0;

        case(opcode)
            // R-type
            6'b000000: 
                begin
                    reg_write = 1;                                                                    
                    alu_op = 4'b0010; 
                    reg_dst = 2'b01;
                    case(func)
                        // jr
                        6'b001000:
                            begin
                                jump = 2'b11;
                                reg_write = 0; 
                            end
                        // jalr 
                        6'b001001:
                            begin
                                jump = 2'b11;
                                reg_write = 1; 
                                reg_dst = 0;
                            end
                    endcase
                end
            // Arithmetic immediate  
            // addi
            6'b001000: 
                begin
                    reg_write = 1;                                                                   
                    alu_src = 1;                                       
                end
            // addiu
            6'b001001: 
                begin
                    reg_write = 1;                                                                         
                    alu_src = 1;                                          
                end
            // slti
            6'b001010: 
                begin
                    reg_write = 1;                                                                         
                    alu_src = 1;                                       
                    alu_op = 4'b0011;  
            end
            // sltiu
            6'b001011: 
                begin
                    reg_write = 1;                                                                          
                    alu_src = 1;                                       
                    alu_op = 4'b0100;   
                end
            // Logical immediate
            // andi
            6'b001100: 
                begin
                    reg_write = 1;                                                                       
                    alu_src = 1;                                       
                    alu_op = 4'b0101;   
                end
            // ori
            6'b001101: 
                begin
                    reg_write = 1;                                                                          
                    alu_src = 1;                                       
                    alu_op = 4'b0110;   
                end
            // xori
            6'b001110: 
                begin
                    reg_write = 1;                                                                        
                    alu_src = 1;                                       
                    alu_op = 4'b0111;   
                end
            // lui
            6'b001111: 
                begin
                    reg_write = 1;                                                                          
                    alu_src = 1;                                       
                    alu_op = 4'b1000;   
                end
            // Loads 
            // lb 
            6'b100000: 
                begin
                    reg_write = 1;                                     
                    mem_read = 1;                                                                      
                    data_size = 2'b01;
                    data_sign = 1;                                                                        
                    alu_src = 1;                                       
                end
            // lh
            6'b100001: 
                begin
                    reg_write = 1;                                     
                    mem_read = 1;                                                                       
                    data_size = 2'b10;
                    data_sign = 1;                                                                        
                    alu_src = 1;                                       
                end
            // lw
            6'b100011: 
                begin   
                    reg_write = 1;                                     
                    mem_read = 1;                                                                         
                    data_size = 2'b11;
                    data_sign = 1;                                                                          
                    alu_src = 1;                                       
                end
            // lbu 
            6'b100100: 
                begin   
                    reg_write = 1;                                     
                    mem_read = 1;                                                                           
                    data_size = 2'b01;                                                                     
                    alu_src = 1;                                       
                end
            // lhu
            6'b100101: 
                begin   
                    reg_write = 1;                                     
                    mem_read = 1;                                                                          
                    data_size = 2'b10;                                                                          
                    alu_src = 1;                                       
            end
            // Stores 
            // sb 
            6'b101000: 
                begin                                      
                    mem_write = 1;
                    data_size = 2'b01;                                                                          
                    alu_src = 1;                                        
            end
            // sh 
            6'b101001: 
                begin                                       
                    mem_write = 1;
                    data_size = 2'b10;                                                                                                             
                    alu_src = 1;                                       
                end
            // sw 
            6'b101011: 
                begin                                                                   
                    mem_write = 1; 
                    data_size = 2'b11;                                                                                                             
                    alu_src = 1;                                       
                end
            // Branches
            // beq
            6'b000100: 
                begin                                      
                    branch = 4'b0001;                                                                              
                    alu_op = 4'b0001;   
                end
            // bne
            6'b000101: 
                begin                                      
                    branch = 4'b0010;                                                                             
                    alu_op = 4'b0001;   
                end
            // blez
            6'b000110: branch = 4'b0011;  
            // bgtz
            6'b000111: branch = 4'b0100;                                                                           
            // special branch group
            6'b000001: 
                begin   
                    case(rt) 
                        // bltz
                        5'b00000: branch = 4'b0101;   
                        // bgez
                        5'b00001: branch = 4'b0110;  
                        // bltzal
                        5'b10000: 
                            begin
                                branch = 4'b0111; 
                                wb_src = 2'b01;    
                                reg_write = 1; 
                                reg_dst = 0;
                            end                                     
                        // bgezal
                        5'b10001: 
                            begin
                                branch = 4'b1000;
                                wb_src = 2'b01;  
                                reg_write = 1; 
                                reg_dst = 0;                                    
                            end
                    endcase                                       
                end
            // j 
            6'b000010: jump = 2'b01;                                          
            // jal
            6'b000011: 
                begin
                    jump = 2'b10; 
                    wb_src = 2'b01;
                    reg_write = 1;
                    reg_dst = 0;
                end   
        endcase 
    end
    
endmodule
