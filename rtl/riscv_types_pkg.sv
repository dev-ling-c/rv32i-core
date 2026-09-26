package riscv_types_pkg;
	localparam int unsigned XLEN = 32;
	/* verilator lint_off UNUSEDPARAM */
	localparam int unsigned REG_ADDR_WIDTH = 5;
	/* verilator lint_on UNUSEDPARAM */

	typedef enum logic[1:0] {
		R_TYPE,
		I_TYPE,
		U_TYPE
	} inst_format_e;

	typedef enum logic[6:0] {
		OPCODE_OP    = 7'b0110011,
		OPCODE_IMM   = 7'b0010011,
		OPCODE_LUI   = 7'b0110111,
		OPCODE_AUIPC = 7'b0010111
	} opcode_e;

	// what goes into ALU input A
	typedef enum logic[1:0] {
		ALU_A_RS1  = 2'b00,
		ALU_A_ZERO = 2'b01,
		ALU_A_PC   = 2'b10
	} alu_a_sel_e;

	typedef enum logic[3:0] {
		ALU_ADD = 4'b0000,      //Addition
		ALU_SUB = 4'b0001,      //Subtraction (Signed and Unsigned)
		ALU_AND = 4'b0010,      //Bitwise AND
		ALU_OR = 4'b0011,       //Bitwise OR
		ALU_XOR = 4'b0100,      //Bitwise XOR
		ALU_SLT = 4'b0101,      //Signed Set Less Than
		ALU_SLTU = 4'b0110,     //Unsigned Set Less Than
		ALU_SLL = 4'b0111,      //Logic Shift Left
		ALU_SRL = 4'b1000,      //Logic Shift Right
		ALU_SRA = 4'b1001       //Arithmetic Shift Right
	} alu_op_e;




endpackage
