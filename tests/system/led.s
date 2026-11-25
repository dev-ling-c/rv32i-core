    lui  x1, 0x1        # LED register at 0x1000
    addi x2, x0, 3
    sw   x2, 0(x0)      # RAM[0] = 3
    sw   x2, 0(x1)      # LED = 1 (bit 0)
    lw   x3, 0(x1)      # LED reads back as 1
    sw   x0, 0(x1)      # LED = 0
    lw   x4, 0(x0)      # RAM[0] still contains 3
done:
    jal  x0, done
