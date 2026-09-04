module register
	import riscv_types_pkg::*;
(
	input logic clk,
	input logic rst_n,
	input logic [4:0] rs1_addr_i,
	input logic [4:0] rs2_addr_i,	
	input logic [4:0] rd_addr_i,
	input logic [XLEN-1:0] rd_data_i,
	input logic reg_write_en_i,
	output logic [XLEN-1:0] rs1_data_o,
	output logic [XLEN-1:0] rs2_data_o

);
	logic [XLEN-1:0] registers [0:31];
	always_comb begin
		if (rs1_addr_i == 5'd0) begin
			rs1_data_o = '0;
		end else begin
			rs1_data_o = registers[rs1_addr_i];
		end
		if (rs2_addr_i == 5'd0) begin
			rs2_data_o = '0;
		end else begin
			rs2_data_o = registers[rs2_addr_i];
		end
	end
	always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			for (int i = 0; i <= 31; i++) begin
				registers[i] <= '0;				
			end
		end else if (reg_write_en_i == 1'b1 && rd_addr_i != 5'd0) begin
				registers[rd_addr_i] <= rd_data_i;
		end

	end
	endmodule
