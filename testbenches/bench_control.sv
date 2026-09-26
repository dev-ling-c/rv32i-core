import riscv_types_pkg::*;
module bench_control;

    logic clk;
    logic [XLEN-1:0] inst_i;
    alu_op_e alu_op_o;
    inst_format_e inst_format_o;
    alu_a_sel_e alu_a_sel_o;
    logic alu_b_imm_o;
    logic reg_write_en_o;
    logic illegal_inst_o;

    logic [XLEN-1:0] test_inst [0:3];

    control control(
        .inst_i(inst_i),
        .alu_op_o(alu_op_o),
        .inst_format_o(inst_format_o),
        .alu_a_sel_o(alu_a_sel_o),
        .alu_b_imm_o(alu_b_imm_o),
        .reg_write_en_o(reg_write_en_o),
        .illegal_inst_o(illegal_inst_o)
    );

    initial begin
        $dumpfile("waves/bench_control.vcd");
        $dumpvars(0, bench_control);
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
        test_inst[0] = 32'h00A00093;
        test_inst[1] = 32'h002081B3;
        test_inst[2] = 32'hFFF00513;
        test_inst[3] = 32'h00000000;

        inst_i = '0;
        @(posedge clk);

        for (int i = 0; i < 4; i++) begin
            inst_i = test_inst[i];
            @(posedge clk);
            $display("case %0d inst=%08x", i, inst_i);
            case (i)
                0: begin
                    debug(32'(ALU_ADD), 32'(alu_op_o), "alu_op");
                    debug(32'(I_TYPE), 32'(inst_format_o), "inst_format");
                    debug(32'(1), 32'(alu_b_imm_o), "alu_b_imm");
                    debug(32'(1), 32'(reg_write_en_o), "reg_write_en");
                    debug(32'(0), 32'(illegal_inst_o), "illegal");
                end
                1: begin
                    debug(32'(ALU_ADD), 32'(alu_op_o), "alu_op");
                    debug(32'(R_TYPE), 32'(inst_format_o), "inst_format");
                    debug(32'(0), 32'(alu_b_imm_o), "alu_b_imm");
                    debug(32'(1), 32'(reg_write_en_o), "reg_write_en");
                    debug(32'(0), 32'(illegal_inst_o), "illegal");
                end
                2: begin
                    debug(32'(ALU_ADD), 32'(alu_op_o), "alu_op");
                    debug(32'(I_TYPE), 32'(inst_format_o), "inst_format");
                    debug(32'(1), 32'(alu_b_imm_o), "alu_b_imm");
                    debug(32'(1), 32'(reg_write_en_o), "reg_write_en");
                    debug(32'(0), 32'(illegal_inst_o), "illegal");
                end
                3: begin
                    debug(32'(ALU_ADD), 32'(alu_op_o), "alu_op");
                    debug(32'(R_TYPE), 32'(inst_format_o), "inst_format");
                    debug(32'(0), 32'(alu_b_imm_o), "alu_b_imm");
                    debug(32'(0), 32'(reg_write_en_o), "reg_write_en");
                    debug(32'(1), 32'(illegal_inst_o), "illegal");
                end
            endcase
        end
        @(posedge clk);
        if (fail_count > 0) begin
            $display("FAIL %d tests", fail_count);
        end else begin
            $display("ALL PASS");
        end
        $finish;
    end
endmodule
