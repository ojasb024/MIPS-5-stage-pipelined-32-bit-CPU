# MIPS 5 Stage Pipelined 32-bit CPU - Written in Verilog

## Overview
This project implements a 32-bit five-stage pipelined MIPS CPU, designed and built from scratch in Verilog using Xilinx Vivado. The CPU follows the classic IF (Instruction Fetch), ID (Instruction Decode), EX (Execute), MEM (Memory Access), and WB (Write Back) pipeline architecture, with separate instruction and data memories based on a Harvard architecture. The CPU supports arithmetic, logical, memory, branch, and jump instructions. It implements data forwarding, hazard detection, and pipeline stalling/flushing to correctly resolve data and control hazards while maintaining pipeline execution. Load and store operations, branching, jumping, and standard function calls using `jal` and `jr` have been successfully verified through simulation. Support for complex programs involving deeply nested function calls is currently being tested and debugged, as there a few edge case bugs that remain. 

## CPU datapath
<img width="5588" height="3966" alt="cpu_image1" src="https://github.com/user-attachments/assets/9d011aec-7736-4e8c-8b7c-3b969327e71c" />


## Testing CPU with MIPS instructions
Instructions are stored in the `program.mem` file in hexadecimal format. The `instruction_memory` module loads this file during simulation, allowing the CPU to fetch and execute the program from instruction memory.


### Arithmetic, Shifitng and Logical 

Instructions: 
```
2008000A    // addi $8,  $0, 10        -> $8  = 10
20090014    // addi $9,  $0, 20        -> $9  = 20
01095020    // add  $10, $8, $9        -> $10 = 30
01285822    // sub  $11, $9, $8        -> $11 = 10
01096024    // and  $12, $8, $9        -> $12 = 0
01096825    // or   $13, $8, $9        -> $13 = 30
01097026    // xor  $14, $8, $9        -> $14 = 30
0109782A    // slt  $15, $8, $9        -> $15 = 1
00088080    // sll  $16, $8, 2        -> $16 = 40
00098842    // srl  $17, $9, 1        -> $17 = 10
00089043    // sra  $18, $8, 1        -> $18 = 5
02089804    // sllv $19, $8, $16      -> $19 = 2560
0209A006    // srlv $20, $9, $16      -> $20 = 0
0208A807    // srav $21, $8, $16      -> $21 = 0
01098021    // addu $16, $8, $9       -> $16 = 30
01288823    // subu $17, $9, $8       -> $17 = 10
21080005    // addi $8,  $8, 5        -> $8  = 15
2129FFFD    // addi $9,  $9, -3       -> $9  = 17
```
Simulation: 
<img width="1889" height="426" alt="Screenshot 2026-07-19 022925" src="https://github.com/user-attachments/assets/b423d451-c29c-448d-b9ff-000b474c69c8" />

### Loads and Stores

Instructions: 
```
2008000A    // addi $8,  $0, 10       -> $8  = 10
20090064    // addi $9,  $0, 100      -> $9  = 100 (base address)
AD280000    // sw   $8, 0($9)         -> MEM[100] = 10
8D2A0000    // lw   $10, 0($9)        -> $10 = 10
21080005    // addi $8, $8, 5         -> $8 = 15
AD280004    // sw   $8, 4($9)         -> MEM[104] = 15
8D2B0004    // lw   $11, 4($9)        -> $11 = 15
21290008    // addi $9, $9, 8         -> $9 = 108
AD200000    // sw   $0, 0($9)         -> MEM[108] = 0
8D2C0000    // lw   $12, 0($9)        -> $12 = 0
```

Simulation: 
<img width="1889" height="288" alt="Screenshot 2026-07-19 023506" src="https://github.com/user-attachments/assets/75122b12-778b-43eb-b697-42acfb15f389" />

### Forwarding, Hazards and Pipeline Stalling 

Instructions: 
```
20080064    // addi $8,$0,100       ; $8  <- 100 (base address)
2001000A    // addi $1,$0,10        ; $1  <- 10
20020014    // addi $2,$0,20        ; $2  <- 20
00221820    // add  $3,$1,$2        ; $3  <- 30           (forward)
00612020    // add  $4,$3,$1        ; $4  <- 40           (forward)
AD030000    // sw   $3,0($8)        ; MEM[100] <- 30      (store forwarding) 
8D050000    // lw   $5,0($8)        ; $5  <- 30
00A23020    // add  $6,$5,$2        ; $6  <- 50           (load-use hazard)
AD060004    // sw   $6,4($8)        ; MEM[104] <- 50
00C13822    // sub  $7,$6,$1        ; $7  <- 40           (forward)
AD070008    // sw   $7,8($8)        ; MEM[108] <- 40      (forward) - FIXED
8D090004    // lw   $9,4($8)        ; $9  <- 50
8D0A0008    // lw   $10,8($8)       ; $10 <- 40
012A5820    // add  $11,$9,$10      ; $11 <- 90           (forward)
AD0B000C    // sw   $11,12($8)      ; MEM[112] <- 90
316C001F    // andi $12,$11,31      ; $12 <- 26
358D0001    // ori  $13,$12,1       ; $13 <- 27
01A17020    // add  $14,$13,$1      ; $14 <- 37           (forward)
AD0E0010    // sw   $14,16($8)      ; MEM[116] <- 37
8D0F0010    // lw   $15,16($8)      ; $15 <- 37
01E28022    // sub  $16,$15,$2      ; $16 <- 17           (load-use)
AD100014    // sw   $16,20($8)      ; MEM[120] <- 17
02018824    // and  $17,$16,$1      ; $17 <- 0
02229025    // or   $18,$17,$2      ; $18 <- 20
AD120018    // sw   $18,24($8)      ; MEM[124] <- 20
8D130018    // lw   $19,24($8)      ; $19 <- 20
0271982A    // slt  $19,$19,$17     ; $19 <- 0
22340005    // addi $20,$17,5       ; $20 <- 5
0294A020    // add  $20,$20,$20     ; $20 <- 10           (forward)
AD14001C    // sw   $20,28($8)      ; MEM[128] <- 10
8D15001C    // lw   $21,28($8)      ; $21 <- 10
02A1B020    // add  $22,$21,$1      ; $22 <- 20           (load-use)
AD160020    // sw   $22,32($8)      ; MEM[132] <- 20
```

Simulation: 
<img width="1890" height="794" alt="Screenshot 2026-07-19 024230" src="https://github.com/user-attachments/assets/fc79e4e2-56ed-440e-a58f-84f2fc5511d5" />

###  

Instructions: 
```
// main
20080007    // addi $8,$0,7        ; a = 7
20090005    // addi $9,$0,5        ; b = 5
0C000005    // jal add_numbers     ; call function
00405020    // add  $10,$2,$0      ; save return value in R10
08000009    // j end

// add_numbers
01091020    // add  $2,$8,$9       ; v0 = a + b
20420008    // addi $2,$2,8        ; v0 = v0 + 8
03E00008    // jr   $31            ; return

// end
08000009    // j end
```

Simulation: 
<img width="1889" height="218" alt="Screenshot 2026-07-19 024811" src="https://github.com/user-attachments/assets/19de28b2-29cc-468c-9d04-45519b2e843e" />

