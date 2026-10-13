module core
	import riscv_types_pkg::*;
(
	input logic clk,
	input logic rst_n,
	input logic [XLEN-1:0] inst_i,
	output logic [XLEN-1:0] pc_o,
	output logic illegal_inst_o
);

	alu_op_e alu_op;
	inst_format_e inst_format;
	alu_a_sel_e alu_a_sel;
	logic alu_b_imm;
	logic mem_read;
	logic mem_write;
	wb_sel_e wb_sel;
	logic branch;
	logic branch_taken;
	logic reg_write_en;

	logic [XLEN-1:0] rs1_data;
	logic [XLEN-1:0] rs2_data;
	logic [XLEN-1:0] imm;
	logic [XLEN-1:0] alu_a;
	logic [XLEN-1:0] alu_b;
	logic [XLEN-1:0] alu_result;
	logic [XLEN-1:0] mem_rdata;
	logic [XLEN-1:0] rd_data;
	logic [XLEN-1:0] next_pc;
	/* verilator lint_off UNUSEDSIGNAL */
	logic alu_zero;
	/* verilator lint_on UNUSEDSIGNAL */

	pc pc (
		.clk(clk),
		.rst_n(rst_n),
		.stall_i(illegal_inst_o),
		.next_pc_i(next_pc),
		.pc_o(pc_o)
	);

	control control (
		.inst_i(inst_i),
		.alu_op_o(alu_op),
		.inst_format_o(inst_format),
		.alu_a_sel_o(alu_a_sel),
		.alu_b_imm_o(alu_b_imm),
		.mem_read_o(mem_read),
		.mem_write_o(mem_write),
		.wb_sel_o(wb_sel),
		.branch_o(branch),
		.reg_write_en_o(reg_write_en),
		.illegal_inst_o(illegal_inst_o)
	);

	register register (
		.clk(clk),
		.rst_n(rst_n),
		.rs1_addr_i(inst_i[19:15]),
		.rs2_addr_i(inst_i[24:20]),
		.rd_addr_i(inst_i[11:7]),
		.rd_data_i(rd_data),
		.reg_write_en_i(reg_write_en),
		.rs1_data_o(rs1_data),
		.rs2_data_o(rs2_data)
	);

	imm_gen imm_gen (
		.inst_i(inst_i),
		.inst_format_i(inst_format),
		.imm_o(imm)
	);

	always_comb begin
		if (alu_a_sel == ALU_A_ZERO) begin
			alu_a = '0;
		end else if (alu_a_sel == ALU_A_PC) begin
			alu_a = pc_o;
		end else begin
			alu_a = rs1_data;
		end
	end

	always_comb begin
		if (alu_b_imm == 1'b1) begin
			alu_b = imm;
		end else begin
			alu_b = rs2_data;
		end
	end

	alu alu (
		.alu_op_i(alu_op),
		.a_i(alu_a),
		.b_i(alu_b),
		.result_o(alu_result),
		.zero_o(alu_zero)
	);

	dmem dmem (
		.clk(clk),
		.rst_n(rst_n),
		.addr_i(alu_result),
		.wdata_i(rs2_data),
		.mem_read_i(mem_read),
		.mem_write_i(mem_write),
		.funct3_i(inst_i[14:12]),
		.rdata_o(mem_rdata)
	);

	always_comb begin
		if (wb_sel == WB_MEM) begin
			rd_data = mem_rdata;
		end else begin
			rd_data = alu_result;
		end
	end

	always_comb begin
		branch_taken = 1'b0;
		if (inst_i[14:12] == 3'b000) begin
			if (rs1_data == rs2_data) begin
				branch_taken = 1'b1;
			end
		end else if (inst_i[14:12] == 3'b001) begin
			if (rs1_data != rs2_data) begin
				branch_taken = 1'b1;
			end
		end else if (inst_i[14:12] == 3'b100) begin
			if ($signed(rs1_data) < $signed(rs2_data)) begin
				branch_taken = 1'b1;
			end
		end else if (inst_i[14:12] == 3'b101) begin
			if ($signed(rs1_data) >= $signed(rs2_data)) begin
				branch_taken = 1'b1;
			end
		end else if (inst_i[14:12] == 3'b110) begin
			if (rs1_data < rs2_data) begin
				branch_taken = 1'b1;
			end
		end else if (inst_i[14:12] == 3'b111) begin
			if (rs1_data >= rs2_data) begin
				branch_taken = 1'b1;
			end
		end
	end

	always_comb begin
		if ((branch == 1'b1) && (branch_taken == 1'b1)) begin
			next_pc = pc_o + imm;
		end else begin
			next_pc = pc_o + 32'd4;
		end
	end

endmodule
