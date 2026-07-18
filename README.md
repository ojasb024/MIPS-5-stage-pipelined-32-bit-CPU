This project implements a 32-bit 5 stage pipelined CPU written in Verilog capable of nearly running all MIPS instructions. I have implemented 5 pipeline stages: instruction fetch, 
decode, execute, memory-access and writeback. These 5 stages increase the efficiency of the CPU as it can allow up to 5 instructions being processed simultaneously. There are still a few bugs
with data memory handling that I am currently working on. 

<img width="1156" height="805" alt="Screenshot 2026-07-17 002854" src="https://github.com/user-attachments/assets/75210725-ae46-4581-bfd7-afc5d1bf8093" />


The program below was loaded into instruction memory and used for testing:

```text
2008000A    // addi $8,  $0, 10        -> $8  = 10
20090014    // addi $9,  $0, 20        -> $9  = 20

01095020    // add  $10, $8, $9        -> $10 = 30
01285822    // sub  $11, $9, $8        -> $11 = 10
01096024    // and  $12, $8, $9        -> $12 = 0
01096825    // or   $13, $8, $9        -> $13 = 30
01097026    // xor  $14, $8, $9        -> $14 = 30
0109782A    // slt  $15, $8, $9        -> $15 = 1

00088080    // sll  $16, $8, 2         -> $16 = 40
00098842    // srl  $17, $9, 1         -> $17 = 10
00089043    // sra  $18, $8, 1         -> $18 = 5

02089804    // sllv $19, $8, $16       -> $19 = 2560 (40 & 31 = 8, so 10 << 8)
0209A006    // srlv $20, $9, $16       -> $20 = 0    (20 >> 8)
0208A807    // srav $21, $8, $16       -> $21 = 0    (10 >>> 8)

01098021    // addu $16, $8, $9        -> $16 = 30
01288823    // subu $17, $9, $8        -> $17 = 10
```

<img width="1616" height="381" alt="Screenshot 2026-07-04 023212" src="https://github.com/user-attachments/assets/ed635002-1a2a-4e16-bee6-39440a85a99f" />

The MIPS test program was loaded into the instruction memory file to verify arithmetic, logical, comparison and shifting instructions. The Vivado simulation results show 
the correct expected register values for these instructions. 

I am still actively working on this project.
