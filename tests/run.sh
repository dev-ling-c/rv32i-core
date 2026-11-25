#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

RTL="rtl/riscv_types_pkg.sv rtl/alu.sv rtl/register.sv rtl/imm_gen.sv rtl/control.sv rtl/pc.sv rtl/dmem.sv rtl/core.sv"
OBJCOPY=$(command -v llvm-objcopy || command -v llvm-objcopy-18)
OBJDUMP=$(command -v llvm-objdump || command -v llvm-objdump-18)

mkdir -p build/tests waves

if [ $# -eq 0 ]; then
    tests=()
    for source in tests/asm/*.s; do tests+=("$(basename "$source" .s)"); done
    tests+=(led)
    for top in bench_control bench_core bench_branch bench_mem; do
        echo "== $top"
        verilator --binary --assert --timing --trace -j 4 -Mdir build/tests/"$top" -Irtl --top-module "$top" \
            $RTL testbenches/"$top".sv > build/tests/"$top".log 2>&1 || { cat build/tests/"$top".log; exit 1; }
        ./build/tests/"$top"/V"$top"
    done
else
    tests=("$@")
fi

verilator --binary --timing --trace -j 0 -Mdir build/tests/obj -Irtl --top-module bench_program \
    $RTL tests/bench_program.sv > build/tests/verilator.log 2>&1 || { cat build/tests/verilator.log; exit 1; }

for test in "${tests[@]}"; do
    echo "== $test"
    source_file=tests/asm/$test.s
    if [[ "$test" == led ]]; then source_file=tests/system/led.s; fi
    clang --target=riscv32 -march=rv32i -mno-relax -c "$source_file" -o build/tests/$test.o
    $OBJCOPY -O binary -j .text build/tests/$test.o build/tests/$test.bin
    $OBJDUMP -d -M no-aliases,numeric build/tests/$test.o > build/tests/$test.dump
    od -An -tx4 -v -w4 build/tests/$test.bin | tr -d ' ' > build/tests/$test.hex

    if [[ "$test" == led ]]; then
        verilator --binary --timing --trace -j 4 -Mdir build/tests/led_system -Irtl --top-module bench_led \
            $RTL rtl/core_system.sv testbenches/bench_led.sv > build/tests/led_system.log 2>&1 || { cat build/tests/led_system.log; exit 1; }
        ./build/tests/led_system/Vbench_led
        continue
    fi

    grep -E '^\s*# expect' tests/asm/$test.s | while read -r _ _ reg val; do
        printf '%d %08x\n' "${reg#x}" $(( val & 0xFFFFFFFF ))
    done > build/tests/$test.expect

    ./build/tests/obj/Vbench_program +test=$test
    if [[ "$test" == jump ]]; then
        verilator --binary --timing -j 4 -Mdir build/tests/system -Irtl --top-module bench_core_system \
            $RTL rtl/core_system.sv testbenches/bench_core_system.sv > build/tests/system.log 2>&1 || { cat build/tests/system.log; exit 1; }
        ./build/tests/system/Vbench_core_system
    fi
done
