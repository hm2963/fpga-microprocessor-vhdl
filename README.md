# FPGA Microprocessor in VHDL

This project implements a custom **14-bit microprocessor** in VHDL as the final project for the **Advanced Digital Logic (ENGR–UH 2310)** course at New York University Abu Dhabi (Spring 2024).

The design supports a custom instruction set architecture (ISA) with arithmetic, logical, branching, and control operations, and is implemented and tested both in simulation and on an FPGA board.

---

## 📜 Project Overview

**Key Features:**
- **14-bit signed data path**
- **16 instructions** (arithmetic, logical, immediate, branch, jump, halt)
- **8 general-purpose registers** (R0–R7, with R0 hard-wired to 0)
- **128-entry instruction memory**
- Overflow detection in arithmetic operations
- Control flow via Program Counter (PC) and branch/jump instructions
- FPGA 7-segment display output for operands, opcode, and results

**Supported Instructions (ISA):**
- Arithmetic: `ADD`, `ADDI`, `SUB`, `SUBI`
- Logic: `AND`, `ANDI`, `OR`, `ORI`, `XOR`, `XORI`
- Shift: `SLL`, `SRL`
- Branch/Jump: `BE`, `BLT`, `JMP`
- Control: `HALT`

---

## 📂 File Structure

| File | Description |
|------|-------------|
| `ALU.vhd` | Arithmetic Logic Unit for 14-bit signed operations |
| `Controller.vhd` | Control unit orchestrating data flow and signals |
| `Decoder.vhd` | Decodes instructions into opcode, operands, immediates |
| `Registers.vhd` | 8×14-bit register file |
| `Instructions_ROM.vhd` | 128-entry instruction memory |
| `PC.vhd` | Program Counter (7-bit) |
| `common.vhd` | Shared types and opcode definitions |
| `Display_Controller.ngc` | Precompiled IP for 7-segment display |
| `top_processor.vhd` | Simulation-oriented top-level design |
| `top_processor_FPGA.vhd` | FPGA-ready top-level design |
| `tb_top_processor.vhd` | Simulation testbench |
| `top_processor_FPGA.ucf` | FPGA pin constraints |
| `Processor.xise` | Xilinx ISE project configuration |
| `.ncd` files | Compiled FPGA netlists |

---

## 🛠 How to Run

### 1. Simulation
1. Open `Processor.xise` in **Xilinx ISE**.
2. Use `tb_top_processor.vhd` as the testbench.
3. Run behavioral simulation to observe instruction execution.

### 2. FPGA Deployment
1. Open the project in **Xilinx ISE**.
2. Use `top_processor_FPGA.vhd` as the top module.
3. Assign pins using `top_processor_FPGA.ucf`.
4. Generate the bitstream and program the FPGA.
5. Observe results on the 7-segment display.

---

## 📸 Demonstration

The project was demonstrated on the FPGA board by executing sample programs, verifying correct operation in both simulation and hardware.

---

## 📚 Course Context

This project was developed as the final lab project for **Advanced Digital Logic**. The goal was to understand the inner workings of a processor, design it in VHDL, simulate it, and implement it on an FPGA.

---

## 📜 License
This project was created for academic purposes. You may use it for educational reference.

---

**Author:** Helin Mazı  
**Course:** ENGR–UH 2310 — Advanced Digital Logic  
**Semester:** Spring 2024  
