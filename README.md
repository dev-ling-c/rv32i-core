# rv32i-core

A simple RISC-V cpu. Not pipelined, one instruction at a time.

It can do ALU R-type and I-type instructions currently (`add`, `addi`, `sub`, ...). No memory or branches yet.


## How to run

Requires Verilator. 

```bash
mkdir -p waves build
```

Test the decoder:

```bash
verilator --binary --timing --trace -j 0 -Mdir build -Irtl --top-module bench_control \
  rtl/riscv_types_pkg.sv rtl/control.sv testbenches/bench_control.sv

./build/Vbench_control
```

Test the whole core:

```bash
verilator --binary --timing --trace -j 0 -Mdir build -Irtl --top-module bench_core \
  rtl/riscv_types_pkg.sv rtl/alu.sv rtl/register.sv rtl/imm_gen.sv \
  rtl/control.sv rtl/pc.sv rtl/core.sv testbenches/bench_core.sv

./build/Vbench_core
```

If it worked it prints `ALL PASS`.
Waveforms are all dumped into waves/*
Working waveforms are added to docs/waves/* for documentation purposes

To look at waves:

```bash
surfer waves/bench_core.vcd

#or
gtkwave waves/bench_core.vcd
```

Clock is under `bench_core` in the tree. Control doesnt have a clock.

