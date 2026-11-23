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

    bit compare;
    // Spike reserves low addresses for debug hardware. In comparison mode a
    // testbench-supplied JAL enters the same program at 0x10000 on the DUT.
    assign inst_i = compare && pc_o == 0 ? 32'h0001006f : imem[pc_o[9:2]];

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
        compare = $test$plusargs("compare");
        hex_file = {"build/tests/", test, ".hex"};
        expect_file = {"build/tests/", test, ".expect"};
        wave_file = {"waves/test_", test, ".vcd"};

        if (compare) wave_file = {"waves/compare_", test, ".vcd"};
        $dumpfile(wave_file);
        $dumpvars(0, bench_program);

        for (i = 0; i < 256; i++) begin
            imem[i] = '0;
        end
        $readmemh(hex_file, imem);

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        @(negedge clk);
        rst_n = 1'b1;

        i = 0;
        while ((illegal_inst_o == 1'b0) && (i < 1000)) begin
            logic [4:0] rd;
            bit writes_rd;
            rd = inst_i[11:7];
            writes_rd = core.reg_write_en && rd != 0;
            if (compare && pc_o != 0) begin
                $write("TRACE %08x %08x", pc_o, inst_i);
                if (core.mem_read) $write(" load %08x", core.alu_result);
                if (core.mem_write) begin
                    case (inst_i[14:12])
                        0: $write(" store %08x %02x", core.alu_result, core.rs2_data[7:0]);
                        1: $write(" store %08x %04x", core.alu_result, core.rs2_data[15:0]);
                        2: $write(" store %08x %08x", core.alu_result, core.rs2_data);
                        default: $fatal(1, "Invalid store width");
                    endcase
                end
                @(negedge clk);
                if (writes_rd) $write(" x%0d %08x", rd, core.register.registers[rd]);
                $display("");
            end else begin
                $display("pc=%08x inst=%08x", pc_o, inst_i);
                @(negedge clk);
            end
            i = i + 1;
        end
        if (illegal_inst_o == 1'b0) begin
            $fatal(1, "FAIL timeout pc=%08x inst=%08x", pc_o, inst_i);
        end

        if (compare) begin
            $display("END %08x", pc_o);
            $finish;
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
