The CPU I am designing is a 32-bit, 5-stage pipelined MIPS processor. It is currently capable of executing simple instructions; however, there are still some issues with the forwarding, flushing, and hazard detection units that I am actively debugging.

<img width="1231" height="809" alt="Screenshot 2026-06-21 023004" src="https://github.com/user-attachments/assets/bb96cd4c-0e70-4a0e-a484-1c5c198813e4" />

This is the datapath diagram I created for the CPU. It shows all major modules, the pipeline registers (IF/ID, ID/EX, EX/MEM, and MEM/WB), the connections between them, and the five pipeline stages: Fetch, Decode, Execute, Memory Access, and Write Back.

I chose to implement pipelining because it significantly improves processor throughput. By dividing instruction execution into multiple stages, the CPU can have up to five instructions in progress simultaneously, allowing more efficient use of hardware resources.

The program below was loaded into instruction memory and used for testing:

```text
2008000A    // addi $8,  $0, 10
21090005    // addi $9,  $8, 5
212A0007    // addi $10, $9, 7
```
<img width="1616" height="359" alt="Screenshot 2026-06-21 024627" src="https://github.com/user-attachments/assets/1df8aaa5-81d3-4f74-84d3-4ac9b2312c62" />

In the Vivado simulation waveform, pipelining can be observed through the propagation of the reg_write control signal across the pipeline registers (IDEX_reg_write, EXMEM_reg_write, and MEMWB_reg_write). The destination register signals (dst_reg, IDEX_dst_reg, EXMEM_dst_reg, and MEMWB_dst_reg) can also be seen progressing through the pipeline in the same way.

The values stored in registers $8, $9, and $10 are 10, 15, and 22 respectively, matching the expected results of the test program. This demonstrates that the forwarding unit is functioning correctly for this case, as the dependent instructions are able to use results before they have been written back to the register file. However, forwarding is still incorrect in some specific scenarios, which is one of the issues currently being investigated.

I am still actively working on this project, and plan to successfuly run all MIPS assembly instructions in the future. 
