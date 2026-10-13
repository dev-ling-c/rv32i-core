import riscv_types_pkg::*;
module bench_mem;

    logic clk;
    logic rst_n;
    logic [XLEN-1:0] inst_i;
    logic [XLEN-1:0] pc_o;
    logic illegal_inst_o;

    logic [XLEN-1:0] imem [0:255];

    logic [XLEN-1:0] test_inst [0:8];
    string test_name [0:8];
    logic [4:0] check_reg [0:8];
    logic [XLEN-1:0] check_val [0:8];
    logic check_en [0:8];

    core core(
        .clk(clk),
        .rst_n(rst_n),
        .inst_i(inst_i),
        .pc_o(pc_o),
        .illegal_inst_o(illegal_inst_o)
    );

    assign inst_i = imem[pc_o[9:2]];

    initial begin
        $dumpfile("waves/bench_mem.vcd");
        $dumpvars(0, bench_mem);
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

        test_inst[0] = 32'h06400093;
        test_name[0] = "addi x1, x0, 100";
        check_reg[0] = 5'd1;
        check_val[0] = 32'd100;
        check_en[0] = 1'b1;

        test_inst[1] = 32'h02A00113;
        test_name[1] = "addi x2, x0, 42";
        check_reg[1] = 5'd2;
        check_val[1] = 32'd42;
        check_en[1] = 1'b1;

        test_inst[2] = 32'h0020A023;
        test_name[2] = "sw x2, 0(x1)";
        check_reg[2] = 5'd0;
        check_val[2] = 32'd0;
        check_en[2] = 1'b0;

        test_inst[3] = 32'h0000A183;
        test_name[3] = "lw x3, 0(x1)";
        check_reg[3] = 5'd3;
        check_val[3] = 32'd42;
        check_en[3] = 1'b1;

        test_inst[4] = 32'h00208223;
        test_name[4] = "sb x2, 4(x1)";
        check_reg[4] = 5'd0;
        check_val[4] = 32'd0;
        check_en[4] = 1'b0;

        test_inst[5] = 32'h00408203;
        test_name[5] = "lb x4, 4(x1)";
        check_reg[5] = 5'd4;
        check_val[5] = 32'd42;
        check_en[5] = 1'b1;

        test_inst[6] = 32'hFFF00293;
        test_name[6] = "addi x5, x0, -1";
        check_reg[6] = 5'd5;
        check_val[6] = 32'hFFFFFFFF;
        check_en[6] = 1'b1;

        test_inst[7] = 32'h00508423;
        test_name[7] = "sb x5, 8(x1)";
        check_reg[7] = 5'd0;
        check_val[7] = 32'd0;
        check_en[7] = 1'b0;

        test_inst[8] = 32'h00808383;
        test_name[8] = "lb x7, 8(x1)";
        check_reg[8] = 5'd7;
        check_val[8] = 32'hFFFFFFFF;
        check_en[8] = 1'b1;

        for (i = 0; i < 256; i++) begin
            imem[i] = '0;
        end
        for (i = 0; i < 9; i++) begin
            imem[i] = test_inst[i];
        end

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        for (i = 0; i < 9; i++) begin
            $display("%s", test_name[i]);
            @(posedge clk);
            if (check_en[i] == 1'b1) begin
                debug(check_val[i], core.register.registers[check_reg[i]], $sformatf("x%0d", check_reg[i]));
            end
        end

        // word at address 100 is mem index 25
        debug(32'd42, core.dmem.mem[25], "dmem[100]");

        if (fail_count > 0) begin
            $display("FAIL %d tests", fail_count);
        end else begin
            $display("ALL PASS");
        end
        $finish;
    end
endmodule
