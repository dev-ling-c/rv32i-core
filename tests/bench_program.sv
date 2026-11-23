import riscv_types_pkg::*;
module bench_program;

    logic clk;
    logic rst_n;
    logic [XLEN-1:0] inst_i;
    logic [XLEN-1:0] pc_o;
    logic illegal_inst_o;
    logic instr_addr_misaligned_o;

    logic [XLEN-1:0] imem [0:255];

    string test;
    string hex_file;
    string expect_file;
    string wave_file;

    core core(
        .clk(clk),
        .rst_n(rst_n),
        .inst_i(inst_i),
        .pc_o(pc_o),
        .illegal_inst_o(illegal_inst_o),
        .instr_addr_misaligned_o(instr_addr_misaligned_o)
    );

    assign inst_i = imem[pc_o[9:2]];

    int pass_count = 0;
    int fail_count = 0;

    function void debug(logic[31:0] expected, logic[31:0] actual, string name);
        if (expected !== actual) begin
            $fatal(1, "FAIL %s expected=%08x actual=%08x", name, expected, actual);
            fail_count++;
        end
        $display("PASS %s expected=%08x actual=%08x", name, expected, actual);
        pass_count++;
    endfunction

    always @(posedge clk)
        if (rst_n && instr_addr_misaligned_o) $fatal(1, "Unexpected misaligned target at pc=%08x", pc_o);

    initial clk = 1'b0;
    always #10 clk = ~clk;

    initial begin
        integer i;
        integer fd;
        logic [4:0] reg_num;
        logic [XLEN-1:0] reg_val;

        if (!$value$plusargs("test=%s", test)) begin
            $fatal(1, "missing +test=NAME");
        end
        hex_file = {"build/tests/", test, ".hex"};
        expect_file = {"build/tests/", test, ".expect"};
        wave_file = {"waves/test_", test, ".vcd"};

        $dumpfile(wave_file);
        $dumpvars(0, bench_program);

        for (i = 0; i < 256; i++) begin
            imem[i] = '0;
        end
        $readmemh(hex_file, imem);

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        i = 0;
        while ((illegal_inst_o == 1'b0) && (i < 1000)) begin
            $display("pc=%08x inst=%08x", pc_o, inst_i);
            @(posedge clk);
            i = i + 1;
        end
        if (illegal_inst_o == 1'b0) begin
            $fatal(1, "FAIL timeout pc=%08x inst=%08x", pc_o, inst_i);
        end

        @(posedge clk);

        fd = $fopen(expect_file, "r");
        if (fd == 0) begin
            $fatal(1, "cannot open %s", expect_file);
        end
        while ($fscanf(fd, "%d %h\n", reg_num, reg_val) == 2) begin
            debug(reg_val, core.register.registers[reg_num], $sformatf("x%0d", reg_num));
        end
        $fclose(fd);

        if (fail_count > 0) begin
            $display("FAIL %d tests", fail_count);
        end else begin
            $display("ALL PASS");
        end
        $finish;
    end
endmodule
