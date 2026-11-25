module bench_led;
    bit clk, rst_n;
    logic led, illegal, misaligned;
    logic [31:0] pc;
    always #5 clk = ~clk;

    core_system dut (
        .clk(clk), .rst_n(rst_n), .led_o(led), .pc_o(pc),
        .illegal_inst_o(illegal), .instr_addr_misaligned_o(misaligned)
    );

    initial begin
        $dumpfile("waves/led.vcd");
        $dumpvars(0, bench_led);
        @(negedge clk);
        if (led !== 0) $fatal(1, "LED reset failed");
        rst_n = 1;
        for (int i = 1; i <= 8; i++) begin
            @(negedge clk);
            if (illegal || misaligned || led !== (i == 4 || i == 5))
                $fatal(1, "Unexpected LED or fault after instruction %0d", i);
        end
        if (pc !== 28 || dut.cpu.register.registers[3] !== 1 ||
            dut.cpu.register.registers[4] !== 3)
            $fatal(1, "Unexpected PC, LED readback, or RAM value");
        $display("ALL PASS: LED on/off, readback, and RAM isolation");
        $finish;
    end
endmodule
