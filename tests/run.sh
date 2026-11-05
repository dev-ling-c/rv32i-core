#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/.."

RTL="rtl/riscv_types_pkg.sv rtl/alu.sv rtl/register.sv rtl/imm_gen.sv rtl/control.sv rtl/pc.sv rtl/dmem.sv rtl/core.sv"
OBJCOPY=$(command -v llvm-objcopy || command -v llvm-objcopy-18)
OBJDUMP=$(command -v llvm-objdump || command -v llvm-objdump-18)

mkdir -p build/tests waves

if [ $# -eq 0 ]; then
    tests=$(basename -s .s tests/asm/*.s)
else
    tests="$@"
fi

verilator --binary --timing --trace -j 0 -Mdir build/tests/obj -Irtl --top-module bench_program \
    $RTL tests/bench_program.sv > build/tests/verilator.log 2>&1 || { cat build/tests/verilator.log; exit 1; }

for test in $tests; do
    echo "== $test"
    clang --target=riscv32 -march=rv32i -mno-relax -c tests/asm/$test.s -o build/tests/$test.o
    $OBJCOPY -O binary -j .text build/tests/$test.o build/tests/$test.bin
    $OBJDUMP -d -M no-aliases,numeric build/tests/$test.o > build/tests/$test.dump
    od -An -tx4 -v -w4 build/tests/$test.bin | tr -d ' ' > build/tests/$test.hex

    grep -E '^\s*# expect' tests/asm/$test.s | while read -r _ _ reg val; do
        printf '%d %08x\n' "${reg#x}" $(( val & 0xFFFFFFFF ))
    done > build/tests/$test.expect

    ./build/tests/obj/Vbench_program +test=$test
done
