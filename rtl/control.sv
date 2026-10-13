module control
	import riscv_types_pkg::*;
(
	input logic [XLEN-1:0] inst_i,
	output alu_op_e alu_op_o,
	output inst_format_e inst_format_o,
	output alu_a_sel_e alu_a_sel_o,
	output logic alu_b_imm_o,
	output logic mem_read_o,
	output logic mem_write_o,
	output wb_sel_e wb_sel_o,
	output logic branch_o,
	output logic reg_write_en_o,
	output logic illegal_inst_o
);

	logic [6:0] opcode;
	logic [2:0] funct3;
	logic [6:0] funct7;

	assign opcode = inst_i[6:0];
	assign funct3 = inst_i[14:12];
	assign funct7 = inst_i[31:25];

	always_comb begin
		alu_op_o = ALU_ADD;
		inst_format_o = R_TYPE;
		alu_a_sel_o = ALU_A_RS1;
		alu_b_imm_o = 1'b0;
		mem_read_o = 1'b0;
		mem_write_o = 1'b0;
		wb_sel_o = WB_ALU;
		branch_o = 1'b0;
		reg_write_en_o = 1'b0;
		illegal_inst_o = 1'b1;

		case (opcode)
			OPCODE_OP: begin
				inst_format_o = R_TYPE;
				alu_a_sel_o = ALU_A_RS1;
				alu_b_imm_o = 1'b0;
				case (funct3)
					3'b000: begin
						if (funct7 == 7'b0000000) begin
							alu_op_o = ALU_ADD;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end else if (funct7 == 7'b0100000) begin
							alu_op_o = ALU_SUB;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end
					end
					3'b001: begin
						if (funct7 == 7'b0000000) begin
							alu_op_o = ALU_SLL;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end
					end
					3'b010: begin
						if (funct7 == 7'b0000000) begin
							alu_op_o = ALU_SLT;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end
					end
					3'b011: begin
						if (funct7 == 7'b0000000) begin
							alu_op_o = ALU_SLTU;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end
					end
					3'b100: begin
						if (funct7 == 7'b0000000) begin
							alu_op_o = ALU_XOR;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end
					end
					3'b101: begin
						if (funct7 == 7'b0000000) begin
							alu_op_o = ALU_SRL;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end else if (funct7 == 7'b0100000) begin
							alu_op_o = ALU_SRA;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end
					end
					3'b110: begin
						if (funct7 == 7'b0000000) begin
							alu_op_o = ALU_OR;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end
					end
					3'b111: begin
						if (funct7 == 7'b0000000) begin
							alu_op_o = ALU_AND;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end
					end
					default: begin
					end
				endcase
			end
			OPCODE_IMM: begin
				inst_format_o = I_TYPE;
				alu_a_sel_o = ALU_A_RS1;
				alu_b_imm_o = 1'b1;
				case (funct3)
					3'b000: begin
						alu_op_o = ALU_ADD;
						reg_write_en_o = 1'b1;
						illegal_inst_o = 1'b0;
					end
					3'b001: begin
						if (funct7 == 7'b0000000) begin
							alu_op_o = ALU_SLL;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end
					end
					3'b010: begin
						alu_op_o = ALU_SLT;
						reg_write_en_o = 1'b1;
						illegal_inst_o = 1'b0;
					end
					3'b011: begin
						alu_op_o = ALU_SLTU;
						reg_write_en_o = 1'b1;
						illegal_inst_o = 1'b0;
					end
					3'b100: begin
						alu_op_o = ALU_XOR;
						reg_write_en_o = 1'b1;
						illegal_inst_o = 1'b0;
					end
					3'b101: begin
						if (funct7 == 7'b0000000) begin
							alu_op_o = ALU_SRL;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end else if (funct7 == 7'b0100000) begin
							alu_op_o = ALU_SRA;
							reg_write_en_o = 1'b1;
							illegal_inst_o = 1'b0;
						end
					end
					3'b110: begin
						alu_op_o = ALU_OR;
						reg_write_en_o = 1'b1;
						illegal_inst_o = 1'b0;
					end
					3'b111: begin
						alu_op_o = ALU_AND;
						reg_write_en_o = 1'b1;
						illegal_inst_o = 1'b0;
					end
					default: begin
					end
				endcase
			end
			OPCODE_LUI: begin
				alu_op_o = ALU_ADD;
				inst_format_o = U_TYPE;
				alu_a_sel_o = ALU_A_ZERO;
				alu_b_imm_o = 1'b1;
				reg_write_en_o = 1'b1;
				illegal_inst_o = 1'b0;
			end
			OPCODE_AUIPC: begin
				alu_op_o = ALU_ADD;
				inst_format_o = U_TYPE;
				alu_a_sel_o = ALU_A_PC;
				alu_b_imm_o = 1'b1;
				reg_write_en_o = 1'b1;
				illegal_inst_o = 1'b0;
			end
			OPCODE_LOAD: begin
				// addr = rs1 + imm, then read memory into rd
				alu_op_o = ALU_ADD;
				inst_format_o = I_TYPE;
				alu_a_sel_o = ALU_A_RS1;
				alu_b_imm_o = 1'b1;
				mem_read_o = 1'b1;
				wb_sel_o = WB_MEM;
				case (funct3)
					3'b000, // lb
					3'b001, // lh
					3'b010, // lw
					3'b100, // lbu
					3'b101: begin // lhu
						reg_write_en_o = 1'b1;
						illegal_inst_o = 1'b0;
					end
					default: begin
					end
				endcase
			end
			OPCODE_BRANCH: begin
				// compare rs1 and rs2, no register write
				alu_op_o = ALU_SUB;
				inst_format_o = B_TYPE;
				alu_a_sel_o = ALU_A_RS1;
				alu_b_imm_o = 1'b0;
				branch_o = 1'b1;
				case (funct3)
					3'b000, // beq
					3'b001, // bne
					3'b100, // blt
					3'b101, // bge
					3'b110, // bltu
					3'b111: begin // bgeu
						illegal_inst_o = 1'b0;
					end
					default: begin
						branch_o = 1'b0;
					end
				endcase
			end
			OPCODE_STORE: begin
				// addr = rs1 + imm, write rs2 to memory
				alu_op_o = ALU_ADD;
				inst_format_o = S_TYPE;
				alu_a_sel_o = ALU_A_RS1;
				alu_b_imm_o = 1'b1;
				mem_write_o = 1'b1;
				case (funct3)
					3'b000, // sb
					3'b001, // sh
					3'b010: begin // sw
						illegal_inst_o = 1'b0;
					end
					default: begin
					end
				endcase
			end
			default: begin
			end
		endcase
	end

endmodule
