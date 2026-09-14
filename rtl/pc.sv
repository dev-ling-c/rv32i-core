module pc
	import riscv_types_pkg::*;
(
	input logic clk,
	input logic rst_n,
	input logic stall_i,
	input logic [XLEN-1:0] next_pc_i,
	output logic [XLEN-1:0] pc_o
);

	always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			pc_o <= '0;
		end else if (stall_i == 1'b0) begin
			pc_o <= next_pc_i;
		end
	end

endmodule
