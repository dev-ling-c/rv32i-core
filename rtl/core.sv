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
	logic alu_b_imm;
	logic reg_write_en;

	logic [XLEN-1:0] rs1_data;
	logic [XLEN-1:0] rs2_data;
	logic [XLEN-1:0] imm;
	logic [XLEN-1:0] alu_b;
	logic [XLEN-1:0] alu_result;
	/* verilator lint_off UNUSEDSIGNAL */
	logic alu_zero;
	/* verilator lint_on UNUSEDSIGNAL */

	pc pc (
		.clk(clk),
		.rst_n(rst_n),
		.stall_i(illegal_inst_o),
		.next_pc_i(pc_o + 32'd4),
		.pc_o(pc_o)
	);

	control control (
		.inst_i(inst_i),
		.alu_op_o(alu_op),
		.inst_format_o(inst_format),
		.alu_b_imm_o(alu_b_imm),
		.reg_write_en_o(reg_write_en),
		.illegal_inst_o(illegal_inst_o)
	);

	register register (
		.clk(clk),
		.rst_n(rst_n),
		.rs1_addr_i(inst_i[19:15]),
		.rs2_addr_i(inst_i[24:20]),
		.rd_addr_i(inst_i[11:7]),
		.rd_data_i(alu_result),
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
		if (alu_b_imm == 1'b1) begin
			alu_b = imm;
		end else begin
			alu_b = rs2_data;
		end
	end

	alu alu (
		.alu_op_i(alu_op),
		.a_i(rs1_data),
		.b_i(alu_b),
		.result_o(alu_result),
		.zero_o(alu_zero)
	);

endmodule
