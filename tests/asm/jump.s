    jal  x1, foo            # call foo, x1 = 0x04
    addi x2, x0, 5          # runs after return from foo
    jal  x0, part2          # skip dead code
    addi x4, x0, 99         # should never run
foo:
    addi x3, x0, 7
    jalr x0, x1, 0          # return to addi x2
part2:
    auipc x5, 0             # x5 = 0x18
    addi x5, x5, 20         # x5 = bar at 0x2c
    jalr x6, x5, 0          # call bar, x6 = 0x24
    addi x7, x0, 11         # runs after return from bar
    jal  x0, end
bar:
    addi x8, x0, 9
    jalr x0, x6, 0          # return to addi x7
end:

# expect x1 4
# expect x2 5
# expect x3 7
# expect x4 0
# expect x5 0x2c
# expect x6 0x24
# expect x7 11
# expect x8 9
