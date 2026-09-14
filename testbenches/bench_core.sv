import riscv_types_pkg::*;
module bench_core;

    logic clk;
    logic rst_n;
    logic [XLEN-1:0] inst_i;
    logic [XLEN-1:0] pc_o;
    logic illegal_inst_o;

    logic [XLEN-1:0] imem [0:255];

    logic [XLEN-1:0] test_inst [0:7];
    string test_name [0:7];
    logic [4:0] check_reg [0:7];
    logic [XLEN-1:0] check_val [0:7];

    core core(
        .clk(clk),
        .rst_n(rst_n),
        .inst_i(inst_i),
        .pc_o(pc_o),
        .illegal_inst_o(illegal_inst_o)
    );

    assign inst_i = imem[pc_o[9:2]];

    initial begin
        $dumpfile("waves/bench_core.vcd");
        $dumpvars(0, bench_core);
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

        test_inst[0] = 32'h00A00093;
        test_name[0] = "addi x1, x0, 10";
        check_reg[0] = 5'd1;
        check_val[0] = 32'd10;

        test_inst[1] = 32'h0030F113;
        test_name[1] = "andi x2, x1, 3";
        check_reg[1] = 5'd2;
        check_val[1] = 32'd2;

        test_inst[2] = 32'h0050E193;
        test_name[2] = "ori x3, x1, 5";
        check_reg[2] = 5'd3;
        check_val[2] = 32'd15;

        test_inst[3] = 32'h0010C213;
        test_name[3] = "xori x4, x1, 1";
        check_reg[3] = 5'd4;
        check_val[3] = 32'd11;

        test_inst[4] = 32'h00209293;
        test_name[4] = "slli x5, x1, 2";
        check_reg[4] = 5'd5;
        check_val[4] = 32'd40;

        test_inst[5] = 32'h00A12313;
        test_name[5] = "slti x6, x2, 10";
        check_reg[5] = 5'd6;
        check_val[5] = 32'd1;

        test_inst[6] = 32'h002081B3;
        test_name[6] = "add x3, x1, x2";
        check_reg[6] = 5'd3;
        check_val[6] = 32'd12;

        test_inst[7] = 32'h40208233;
        test_name[7] = "sub x4, x1, x2";
        check_reg[7] = 5'd4;
        check_val[7] = 32'd8;

        for (i = 0; i < 256; i++) begin
            imem[i] = '0;
        end
        for (i = 0; i < 8; i++) begin
            imem[i] = test_inst[i];
        end

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        for (i = 0; i < 8; i++) begin
            $display("%s", test_name[i]);
            @(posedge clk);
            debug(check_val[i], core.register.registers[check_reg[i]], $sformatf("x%0d", check_reg[i]));
        end

        if (fail_count > 0) begin
            $display("FAIL %d tests", fail_count);
        end else begin
            $display("ALL PASS");
        end
        $finish;
    end
endmodule
