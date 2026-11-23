"""Compare each program instruction executed by the RTL and Spike."""

from itertools import zip_longest
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
BUILD = ROOT / "build/tests"
BASE = 0x10000
os.chdir(ROOT)
local_tools = ROOT / "build/reference/bin"
os.environ["PATH"] = str(local_tools) + os.pathsep + os.environ["PATH"]
linker = shutil.which("ld.lld") or shutil.which("ld.lld-18")
objcopy = shutil.which("llvm-objcopy") or shutil.which("llvm-objcopy-18")


def run(args, **kwargs):
    subprocess.run(args, check=True, **kwargs)


def reference_rows(log, end):
    started = False
    for line in log.splitlines():
        match = re.search(r"core\s+0:\s+3 0x([0-9a-f]+) \(0x([0-9a-f]+)\)(.*)", line)
        if not match:
            continue
        pc, instruction, effects = match.groups()
        addr = int(pc, 16)
        if not started:
            if addr != BASE:
                continue
            started = True
        if addr == end and int(instruction, 16) == 0x13:
            yield f"END {addr:08x}"
            return
        row = f"TRACE {addr:08x} {int(instruction, 16):08x}"
        mem = re.search(r" mem 0x(\w+)(?: 0x(\w+))?", effects)
        if mem:
            address, value = mem.groups()
            if value is None:
                row += f" load {address}"
            else:
                width = {0: 2, 1: 4, 2: 8}[(int(instruction, 16) >> 12) & 7]
                row += f" store {address} {int(value, 16):0{width}x}"
        reg = re.search(r" x\s*(\d+) 0x([0-9a-f]+)", effects)
        if reg:
            row += f" x{reg[1]} {reg[2]}"
        yield row
    raise ValueError("Spike did not execute the end marker")


def check_rows(actual, expected):
    for step, (rtl, spike) in enumerate(zip_longest(actual, expected), 1):
        if rtl != spike:
            raise ValueError(f"step {step}\n  RTL   {rtl}\n  Spike {spike}")


def compare(name):
    work = BUILD / "compare" / name
    work.mkdir(parents=True, exist_ok=True)
    # Spike's boot ROM uses x5, x10 and x11. Restore the DUT's reset values.
    setup = work / "setup.s"
    setup.write_text(".section .setup,\"ax\"\n.global _start\n_start:\n"
                     "li x5,0\nli x10,0\nli x11,0\nj program\n")
    run(["clang", "--target=riscv32", "-march=rv32i", "-mno-relax", "-c",
         setup, "-o", work / "setup.o"])
    layout = work / "layout.ld"
    layout.write_text("ENTRY(_start)\nSECTIONS { . = 0x10000; .text : { "
                      "program = .; *(.text) LONG(0x13) } "
                      ". = 0x11000; .setup : { *(.setup) } }")
    elf = work / "program.elf"
    run([linker, "-m", "elf32lriscv", "--no-relax", "-T", layout,
         BUILD / f"{name}.o", work / "setup.o", "-o", elf])
    run([objcopy, "-O", "binary", "-j", ".text", elf, work / "text.bin"])
    data = (BUILD / f"{name}.bin").read_bytes()
    if (work / "text.bin").read_bytes() != data + bytes.fromhex("13000000"):
        raise ValueError("linked Spike program differs from RTL machine code")
    if len(data) >= 1024:
        raise ValueError("program and stop marker must fit in testbench memory")
    commands = work / "commands.txt"
    end = BASE + len(data)
    commands.write_text(f"until pc 0 {end:x}\nrs 1\nquit\n")
    spike_log = work / "spike.log"
    with spike_log.open("w") as log:
        run(["spike", "--isa=RV32I", "-m0x10000:0x11000", "--log-commits",
             "-d", f"--debug-cmd={commands}", elf], stderr=log, timeout=10)
    rtl_log = work / "rtl.log"
    with rtl_log.open("w") as log:
        run([BUILD / "obj/Vbench_program", f"+test={name}", "+compare"], stdout=log)
    actual = [line for line in rtl_log.read_text().splitlines()
              if line.startswith(("TRACE ", "END "))]
    expected = list(reference_rows(spike_log.read_text(), end))
    (work / "reference.trace").write_text("\n".join(expected) + "\n")
    check_rows(actual, expected)
    print(f"{name}: {len(expected)-1} instructions and final PC match Spike", flush=True)


if __name__ == "__main__":
    names = sys.argv[1:] or sorted(p.stem for p in Path("tests/asm").glob("*.s"))
    for name in names:
        if name not in {p.stem for p in Path("tests/asm").glob("*.s")}:
            sys.exit(f"Unknown test: {name}")
    if not (shutil.which("spike") and linker and objcopy):
        sys.exit("Comparison requires Spike with commit logging, LLVM lld and objcopy")
    run(["bash", "tests/run.sh", *names])
    for name in names:
        compare(name)
