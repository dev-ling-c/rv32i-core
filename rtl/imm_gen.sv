module imm_gen
	import riscv_types_pkg::*;
(
	/*verilator lint_off UNUSEDSIGNAL*/
	input logic [XLEN-1:0] inst_i,
	/*verilator lint_on UNUSEDSIGNAL*/
	input inst_format_e inst_format_i,
	output logic [XLEN-1:0] imm_o

);
	logic [19:0] extension;
	always_comb begin
		if (inst_i[31] == 1'b1) begin
			extension = 20'hFFFFF;	
		end else begin
			extension = 20'b0;
		end
		imm_o = '0;
		case (inst_format_i)
			default: begin
				imm_o = '0;
			end
			I_TYPE: begin
				imm_o = {extension, inst_i[31:20]};
			end
			U_TYPE: begin
				// upper 20 bits of the instruction, low 12 bits zero
				imm_o = {inst_i[31:12], 12'b0};
			end
		endcase

	end

endmodule
