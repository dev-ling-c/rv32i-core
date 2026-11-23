# Single-cycle RV32I core

The core executes integer arithmetic, loads and stores, conditional branches, JAL, JALR, LUI and AUIPC. The decoder accepts FENCE and FENCE.I as no-ops. Instruction memory is external. Data memory holds 1 KiB. The core signals illegal instructions and misaligned instruction targets and holds the PC on either fault.

## Simulation

From the project root in WSL, run `bash tests/run.sh`. This builds and runs four SystemVerilog benches, then assembles and runs every program in `tests/asm`. To run just the call-and-return example, use `bash tests/run.sh jump`. The tools are Verilator, Clang with a RISC-V target, and LLVM objcopy and objdump.

Open `waves/test_jump.vcd` in GTKWave or Surfer. Watch `pc_o`, `inst_i`, `core.next_pc` and `core.rd_data` across rising clock edges. The assembly comments beginning with `# expect` describe final register checks.

## Follow one call and return

In `tests/asm/jump.s`, the first word is `jal x1, foo`. Its address is zero and each instruction occupies four bytes. Before the first execution edge, the core computes both the target (0x10) and return address (0x04). At the rising edge, the PC takes the target and the register file writes 0x04 into x1. At 0x10, `addi x3, x0, 7` saves 7 in x3. At 0x14, `jalr x0, x1, 0` reads the saved return address. The PC goes back to 0x04 and x0 discards the link write. Follow those three edges in the jump waveform.

## Compare against Spike

Run `python3 tests/compare.py jump` for the example or `python3 tests/compare.py` for every assembly program. This also runs their ordinary final-register checks. The comparison requires Spike with commit logging (tested with v1.1.0), dtc and LLVM lld. Executables may be on PATH or in `build/reference/bin`.

The comparison runs the same program bytes at 0x10000 on both machines to clear Spike's reserved debug region. Add 0x10000 to the lesson's PCs when reading these traces. Each row gives the PC and instruction word, followed by any memory access and destination-register write. The checker verifies the first difference and the ending PC. Compare `build/tests/compare/jump/rtl.log` with `build/tests/compare/jump/reference.trace`. The normal simulation starts at zero.

## Arty A7-100T core timing

With Vivado and Artix-7 device support, run `vivado -mode batch -source fpga/arty100t.tcl` from the project root. The script implements the core out of context with a 10 ns clock target and writes utilization and timing reports under `build/arty100t`. Check register-to-register setup and hold slack. External instruction memory, board I/O delays, and a board-level top are outside this measurement.
