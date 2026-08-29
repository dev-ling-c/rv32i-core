module alu
	import riscv_types_pkg::*;
(
	input alu_op_e alu_op_i,
	input logic[XLEN-1:0] a_i,
	input logic[XLEN-1:0] b_i,
	output logic[XLEN-1:0] result_o,
	output logic zero_o
);

	always_comb begin
        	case (alu_op_i)
            	ALU_ADD:  result_o = a_i + b_i;
            	ALU_SUB:  result_o = a_i - b_i;
            	ALU_AND:  result_o = a_i & b_i;
            	ALU_OR:   result_o = a_i | b_i;
            	ALU_XOR:  result_o = a_i ^ b_i;
            	ALU_SLT:  result_o = ($signed(a_i) < $signed(b_i)) ? 32'd1 : 32'd0;
            	ALU_SLTU: result_o = (a_i < b_i) ? 32'd1 : 32'd0;
            	ALU_SLL:  result_o = a_i << b_i[4:0];
            	ALU_SRL:  result_o = a_i >> b_i[4:0];
            	ALU_SRA:  result_o = $signed(a_i) >>> b_i[4:0];
            	default:  result_o = '0;
        	endcase
		zero_o = (result_o == '0);
    	end


endmodule		
