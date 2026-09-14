import riscv_types_pkg::*;
module bench_core;

    logic clk;
    logic rst_n;
    logic [XLEN-1:0] inst_i;
    logic [XLEN-1:0] pc_o;
    logic illegal_inst_o;

    logic [XLEN-1:0] imem [0:255];

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

        for (i = 0; i < 256; i++) begin
            imem[i] = '0;
        end
        imem[0] = 32'h00A00093;
        imem[1] = 32'h00300113;
        imem[2] = 32'h002081B3;
        imem[3] = 32'h40208233;

        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        rst_n = 1'b1;

        i = 0;
        while ((illegal_inst_o == 1'b0) && (i < 32)) begin
            @(posedge clk);
            i = i + 1;
        end
        if (illegal_inst_o == 1'b0) begin
            $fatal(1, "FAIL timeout pc=%08x inst=%08x", pc_o, inst_i);
        end

        @(posedge clk);

        debug(32'd10, core.register.registers[1], "x1");
        debug(32'd3,  core.register.registers[2], "x2");
        debug(32'd13, core.register.registers[3], "x3");
        debug(32'd7,  core.register.registers[4], "x4");

        if (fail_count > 0) begin
            $display("FAIL %d tests", fail_count);
        end else begin
            $display("ALL PASS");
        end
        $finish;
    end
endmodule
