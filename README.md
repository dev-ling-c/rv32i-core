# Single-cycle RV32I core

The core executes integer arithmetic, loads and stores, conditional branches, JAL, JALR, LUI and AUIPC. The decoder accepts FENCE and FENCE.I as no-ops. Instruction memory is external. Data memory holds 1 KiB. The core signals illegal instructions and misaligned instruction targets and holds the PC on either fault.

## Simulation

From the project root in WSL, run `bash tests/run.sh`. This builds and runs four SystemVerilog benches, then assembles and runs every program in `tests/asm`. To run just the call-and-return example, use `bash tests/run.sh jump`. The tools are Verilator, Clang with a RISC-V target, and LLVM objcopy and objdump.

Open `waves/test_jump.vcd` in GTKWave or Surfer. Watch `pc_o`, `inst_i`, `core.next_pc` and `core.rd_data` across rising clock edges. The assembly comments beginning with `# expect` describe final register checks.
