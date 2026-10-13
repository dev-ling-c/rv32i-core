import riscv_types_pkg::*;
module bench_core;

    logic clk;
    logic rst_n;
    logic [XLEN-1:0] inst_i;
    logic [XLEN-1:0] pc_o;
    logic illegal_inst_o;

    logic [XLEN-1:0] imem [0:255];

    logic [XLEN-1:0] test_inst [0:13];
    string test_name [0:13];
    logic [4:0] check_reg [0:13];
    logic [XLEN-1:0] check_val [0:13];
    logic check_en [0:13];

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
        check_en[0] = 1'b1;

        test_inst[1] = 32'h0030F113;
        test_name[1] = "andi x2, x1, 3";
        check_reg[1] = 5'd2;
        check_val[1] = 32'd2;
        check_en[1] = 1'b1;

        test_inst[2] = 32'h0050E193;
        test_name[2] = "ori x3, x1, 5";
        check_reg[2] = 5'd3;
        check_val[2] = 32'd15;
        check_en[2] = 1'b1;

        test_inst[3] = 32'h0010C213;
        test_name[3] = "xori x4, x1, 1";
        check_reg[3] = 5'd4;
        check_val[3] = 32'd11;
        check_en[3] = 1'b1;

        test_inst[4] = 32'h00209293;
        test_name[4] = "slli x5, x1, 2";
        check_reg[4] = 5'd5;
        check_val[4] = 32'd40;
        check_en[4] = 1'b1;

        test_inst[5] = 32'h00A12313;
        test_name[5] = "slti x6, x2, 10";
        check_reg[5] = 5'd6;
        check_val[5] = 32'd1;
        check_en[5] = 1'b1;

        test_inst[6] = 32'h002081B3;
        test_name[6] = "add x3, x1, x2";
        check_reg[6] = 5'd3;
        check_val[6] = 32'd12;
        check_en[6] = 1'b1;

        test_inst[7] = 32'h40208233;
        test_name[7] = "sub x4, x1, x2";
        check_reg[7] = 5'd4;
        check_val[7] = 32'd8;
        check_en[7] = 1'b1;

        test_inst[8] = 32'h123453B7;
        test_name[8] = "lui x7, 0x12345";
        check_reg[8] = 5'd7;
        check_val[8] = 32'h12345000;
        check_en[8] = 1'b1;

        test_inst[9] = 32'h00001417;
        test_name[9] = "auipc x8, 1";
        check_reg[9] = 5'd8;
        check_val[9] = 32'h00001024;
        check_en[9] = 1'b1;

        // memory: store 42 at address 100, then load it back
        test_inst[10] = 32'h06400493;
        test_name[10] = "addi x9, x0, 100";
        check_reg[10] = 5'd9;
        check_val[10] = 32'd100;
        check_en[10] = 1'b1;

        test_inst[11] = 32'h02A00513;
        test_name[11] = "addi x10, x0, 42";
        check_reg[11] = 5'd10;
        check_val[11] = 32'd42;
        check_en[11] = 1'b1;

        test_inst[12] = 32'h00A4A023;
        test_name[12] = "sw x10, 0(x9)";
        check_reg[12] = 5'd0;
        check_val[12] = 32'd0;
        check_en[12] = 1'b0;

        test_inst[13] = 32'h0004A583;
        test_name[13] = "lw x11, 0(x9)";
        check_reg[13] = 5'd11;
        check_val[13] = 32'd42;
        check_en[13] = 1'b1;

        for (i = 0; i < 256; i++) begin
            imem[i] = '0;
        end
        for (i = 0; i < 14; i++) begin
            imem[i] = test_inst[i];
        end

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        for (i = 0; i < 14; i++) begin
            $display("%s", test_name[i]);
            @(posedge clk);
            if (check_en[i] == 1'b1) begin
                debug(check_val[i], core.register.registers[check_reg[i]], $sformatf("x%0d", check_reg[i]));
            end
        end

        if (fail_count > 0) begin
            $display("FAIL %d tests", fail_count);
        end else begin
            $display("ALL PASS");
        end
        $finish;
    end
endmodule
