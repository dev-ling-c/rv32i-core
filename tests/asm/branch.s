    addi x1, x0, 1
    addi x2, x0, 1
    beq  x1, x2, skip1      # taken
    addi x3, x0, 99
skip1:
    addi x4, x0, 7
    bne  x1, x2, skip2      # not taken
    addi x5, x0, 5
skip2:
    addi x6, x0, 2
    blt  x6, x1, skip3      # 2 < 1, not taken
    addi x7, x0, 3
skip3:
    addi x8, x0, 0
    blt  x8, x1, skip4      # 0 < 1, taken
    addi x9, x0, 99
skip4:
    addi x10, x0, 8
    addi x11, x0, -1
    bltu x1, x11, skip5     # 1 < 0xffffffff unsigned, taken
    addi x12, x0, 99
skip5:
    bge  x11, x1, skip6     # -1 >= 1 signed, not taken
    addi x13, x0, 13
skip6:
    bgeu x11, x1, skip7     # 0xffffffff >= 1 unsigned, taken
    addi x14, x0, 99
skip7:

# expect x1 1
# expect x2 1
# expect x3 0
# expect x4 7
# expect x5 5
# expect x6 2
# expect x7 3
# expect x8 0
# expect x9 0
# expect x10 8
# expect x11 -1
# expect x12 0
# expect x13 13
# expect x14 0
