    addi x1, x0, 1
    fence
    fence.i
    addi x2, x0, 2

# expect x1 1
# expect x2 2
