import riscv_types_pkg::*;
module bench_branch;

    logic clk;
    logic rst_n;
    logic [XLEN-1:0] inst_i;
    logic [XLEN-1:0] pc_o;
    logic illegal_inst_o;

    logic [XLEN-1:0] imem [0:255];

    logic [XLEN-1:0] test_inst [0:13];
    string test_name [0:13];

    core core(
        .clk(clk),
        .rst_n(rst_n),
        .inst_i(inst_i),
        .pc_o(pc_o),
        .illegal_inst_o(illegal_inst_o)
    );

    assign inst_i = imem[pc_o[9:2]];

    initial begin
        $dumpfile("waves/bench_branch.vcd");
        $dumpvars(0, bench_branch);
    end

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

    initial clk = 1'b0;
    always #10 clk = ~clk;

    initial begin
        integer i;

        test_inst[0] = 32'h00100093;
        test_name[0] = "addi x1, x0, 1";
        test_inst[1] = 32'h00100113;
        test_name[1] = "addi x2, x0, 1";
        test_inst[2] = 32'h00208463;
        test_name[2] = "beq x1, x2, 8";
        test_inst[3] = 32'h06300193;
        test_name[3] = "addi x3, x0, 99";
        test_inst[4] = 32'h00700213;
        test_name[4] = "addi x4, x0, 7";
        test_inst[5] = 32'h00209463;
        test_name[5] = "bne x1, x2, 8";
        test_inst[6] = 32'h00500293;
        test_name[6] = "addi x5, x0, 5";
        test_inst[7] = 32'h00200313;
        test_name[7] = "addi x6, x0, 2";
        test_inst[8] = 32'h00134463;
        test_name[8] = "blt x6, x1, 8";
        test_inst[9] = 32'h00300393;
        test_name[9] = "addi x7, x0, 3";
        test_inst[10] = 32'h00000413;
        test_name[10] = "addi x8, x0, 0";
        test_inst[11] = 32'h00144463;
        test_name[11] = "blt x8, x1, 8";
        test_inst[12] = 32'h06300493;
        test_name[12] = "addi x9, x0, 99";
        test_inst[13] = 32'h00800513;
        test_name[13] = "addi x10, x0, 8";

        for (i = 0; i < 256; i++) begin
            imem[i] = '0;
        end
        for (i = 0; i < 14; i++) begin
            imem[i] = test_inst[i];
        end

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        i = 0;
        while ((illegal_inst_o == 1'b0) && (i < 32)) begin
            $display("%s", test_name[pc_o[5:2]]);
            @(posedge clk);
            i = i + 1;
        end
        if (illegal_inst_o == 1'b0) begin
            $fatal(1, "FAIL timeout pc=%08x inst=%08x", pc_o, inst_i);
        end

        @(posedge clk);

        debug(32'd1, core.register.registers[1], "x1");
        debug(32'd1, core.register.registers[2], "x2");
        debug(32'd0, core.register.registers[3], "x3");
        debug(32'd7, core.register.registers[4], "x4");
        debug(32'd5, core.register.registers[5], "x5");
        debug(32'd2, core.register.registers[6], "x6");
        debug(32'd3, core.register.registers[7], "x7");
        debug(32'd0, core.register.registers[8], "x8");
        debug(32'd0, core.register.registers[9], "x9");
        debug(32'd8, core.register.registers[10], "x10");

        if (fail_count > 0) begin
            $display("FAIL %d tests", fail_count);
        end else begin
            $display("ALL PASS");
        end
        $finish;
    end
endmodule
