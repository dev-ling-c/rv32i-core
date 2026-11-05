    addi x1, x0, 5          # counter
    addi x2, x0, 0          # sum
loop:
    add  x2, x2, x1
    addi x1, x1, -1
    bne  x1, x0, loop       # jump back until counter hits 0
    addi x3, x0, 1

# expect x1 0
# expect x2 15
# expect x3 1
