module bench_core_system;
    bit clk;
    bit rst_n;
    logic [31:0] pc;
    logic illegal, misaligned;
    always #5 clk = ~clk;

    core_system #(.ROM_FILE("build/tests/jump.hex")) dut (
        .clk(clk), .rst_n(rst_n), .pc_o(pc), .led_o(),
        .illegal_inst_o(illegal), .instr_addr_misaligned_o(misaligned)
    );

    initial begin
        int unsigned expected_pc [12] = '{
            'h00, 'h10, 'h14, 'h04, 'h08, 'h18,
            'h1c, 'h20, 'h2c, 'h30, 'h24, 'h28
        };
        @(negedge clk);
        rst_n = 1;
        foreach (expected_pc[i]) begin
            if (pc !== expected_pc[i] || illegal !== 0 || misaligned !== 0)
                $fatal(1, "Step %0d: expected PC %h, got %h (fault %b%b)",
                       i, expected_pc[i], pc, illegal, misaligned);
            @(negedge clk);
        end
        if (pc !== 'h34 || illegal !== 1 || misaligned !== 0 ||
            dut.cpu.register.registers[7] !== 11)
            $fatal(1, "Incorrect end of jump program");
        $display("ALL PASS: ROM fetched all 12 jump-program instructions");
        $finish;
    end
endmodule
