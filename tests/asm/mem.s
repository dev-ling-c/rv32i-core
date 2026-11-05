    addi x1, x0, 100        # base address
    addi x2, x0, 42
    sw   x2, 0(x1)
    lw   x3, 0(x1)
    sb   x2, 4(x1)
    lb   x4, 4(x1)
    addi x5, x0, -1
    sb   x5, 8(x1)
    lb   x6, 8(x1)          # sign extends 0xff
    lbu  x7, 8(x1)          # zero extends 0xff
    sh   x5, 12(x1)
    lh   x8, 12(x1)
    lhu  x9, 12(x1)
    lui  x10, 0x12345
    addi x10, x10, 0x678
    sw   x10, 16(x1)
    lb   x11, 17(x1)        # byte 1 of 0x12345678
    lhu  x12, 18(x1)        # upper half of 0x12345678

# expect x3 42
# expect x4 42
# expect x6 -1
# expect x7 0xff
# expect x8 -1
# expect x9 0xffff
# expect x10 0x12345678
# expect x11 0x56
# expect x12 0x1234
