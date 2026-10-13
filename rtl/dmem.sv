module dmem
	import riscv_types_pkg::*;
(
	input logic clk,
	input logic rst_n,
	input logic [XLEN-1:0] addr_i,
	input logic [XLEN-1:0] wdata_i,
	input logic mem_read_i,
	input logic mem_write_i,
	input logic [2:0] funct3_i,
	output logic [XLEN-1:0] rdata_o
);

	logic [XLEN-1:0] mem [0:255];
	logic [XLEN-1:0] word;
	logic [1:0] byte_offset;
	logic [7:0] byte_data;
	logic [15:0] half_data;

	assign word = mem[addr_i[9:2]];
	assign byte_offset = addr_i[1:0];

	always_comb begin
		rdata_o = '0;
		byte_data = '0;
		half_data = '0;

		if (mem_read_i == 1'b1) begin
			case (byte_offset)
				2'b00: begin
					byte_data = word[7:0];
					half_data = word[15:0];
				end
				2'b01: begin
					byte_data = word[15:8];
					half_data = word[15:0];
				end
				2'b10: begin
					byte_data = word[23:16];
					half_data = word[31:16];
				end
				2'b11: begin
					byte_data = word[31:24];
					half_data = word[31:16];
				end
			endcase

			case (funct3_i)
				3'b000: begin // lb
					if (byte_data[7] == 1'b1) begin
						rdata_o = {24'hFFFFFF, byte_data};
					end else begin
						rdata_o = {24'b0, byte_data};
					end
				end
				3'b001: begin // lh
					if (half_data[15] == 1'b1) begin
						rdata_o = {16'hFFFF, half_data};
					end else begin
						rdata_o = {16'b0, half_data};
					end
				end
				3'b010: begin // lw
					rdata_o = word;
				end
				3'b100: begin // lbu
					rdata_o = {24'b0, byte_data};
				end
				3'b101: begin // lhu
					rdata_o = {16'b0, half_data};
				end
				default: begin
					rdata_o = '0;
				end
			endcase
		end
	end

	always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			mem <= '{default: '0};
		end else if (mem_write_i == 1'b1) begin
			case (funct3_i)
				3'b000: begin // sb
					case (byte_offset)
						2'b00: mem[addr_i[9:2]] <= {word[31:8], wdata_i[7:0]};
						2'b01: mem[addr_i[9:2]] <= {word[31:16], wdata_i[7:0], word[7:0]};
						2'b10: mem[addr_i[9:2]] <= {word[31:24], wdata_i[7:0], word[15:0]};
						2'b11: mem[addr_i[9:2]] <= {wdata_i[7:0], word[23:0]};
					endcase
				end
				3'b001: begin // sh
					if (byte_offset[1] == 1'b0) begin
						mem[addr_i[9:2]] <= {word[31:16], wdata_i[15:0]};
					end else begin
						mem[addr_i[9:2]] <= {wdata_i[15:0], word[15:0]};
					end
				end
				3'b010: begin // sw
					mem[addr_i[9:2]] <= wdata_i;
				end
				default: begin
				end
			endcase
		end
	end

endmodule
