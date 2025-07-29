# Advanced-Verilog-Testbenches-for-UART-and-Arbiter-IP-Blocks
Pure Verilog testbenches with assertions, random stimulus, and protocol verification for UART Transmitter and 4-way Priority Arbiter — simulation-driven verification, Vivado-ready.

# Advanced Testbench Development – Simulation-Driven Verification

This project contains reusable and scalable testbenches for two commonly used IP blocks: **UART Transmitter** and **Priority Arbiter**. The testbenches are built using pure Verilog (Vivado-compatible), and feature advanced simulation practices like random stimulus, assertions, and protocol-level checks.

## 🔧 Modules

### 1. UART Transmitter (`uart_tx.v`)
- 8-bit UART TX module with configurable baud timing
- Parameters:
  - `CLK_PER_BIT`: number of clock cycles per bit (default = 16)
- Interface:
  - Inputs: `clk`, `rst`, `start`, `data_in[7:0]`
  - Outputs: `tx`, `busy`

### 2. 4-Way Priority Arbiter (`priority_arbiter.v`)
- Grants access to one of four request lines based on fixed priority
- Priority order: `req[3] > req[2] > req[1] > req[0]`

---

## 🧪 Testbenches

Each testbench:
- Uses `$random` for generating input sequences
- Checks output protocol using `$display` and manual assertion logic
- Triggers simulation waveform generation via `$dumpvars`

### ✅ Testbench Files:
- `tb_uart_tx.v`: Tests UART byte transmission with randomized inputs and protocol assertions
- `tb_priority_arbiter.v`: Validates grant arbitration with priority and fairness assertions

---

## 📈Sample Waveforms and Schematic

1. UART Transmitter :
   
   a) Schematic: https://drive.google.com/file/d/1JC71pk3D9-HoQOdPYFk5LOvNjKsjMC0Q/view?usp=drive_link

   b) Sample Waveform: <img width="1237" height="311" alt="Screenshot 2025-07-29 211917" src="https://github.com/user-attachments/assets/387b4953-540e-44aa-a0c9-11aa5d9f054d" />

   
3. 4-Way Priority Arbiter:

   a) Schematic: https://drive.google.com/file/d/1R9dByCm0818svxD1YjHpzr7wYc32cTqx/view?usp=drive_link
   
   b) Sample Waveform: <img width="940" height="342" alt="image" src="https://github.com/user-attachments/assets/9911a0b7-ffc0-46e6-898d-e620aa4d3ff4" />

   
---

### 👨‍💻 Author
Dayanand Bisanal
