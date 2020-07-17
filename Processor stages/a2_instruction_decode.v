/* Author: Santosh Srivatsan	2017A8PS1924G */
/* Instruction Decode (ID) stage */

module a2_instruction_decode(
	input reset,
	input SEtoReg_in,
	input WriteReg_in,
	input WriteReg,
	input [2:0] rd_in,
	input [7:0] instruction,
	input [7:0] write_data,
	
	output SEtoReg_out,
	output WriteReg_out,
	output [2:0] rs1,
	output [2:0] rd_out,
	output [7:0] data1,
	output [7:0] data2,
	output [2:0] unextended
	);

	/* Wire naming scheme : module_name_wire_name.
	 wire_name corresponds to the name of the input/output in the respective module */
	
	/* Wires connected to a2_register_file */
	wire register_file_reset;
	wire register_file_WriteReg;
	wire [2:0] register_file_rs1;
	wire [2:0] register_file_rs2;
	wire [2:0] register_file_rd;
	wire [7:0] register_file_write_data;
	wire [7:0] register_file_data1;
	wire [7:0] register_file_data2;

	/*******************************************************************************************************************************************************************/

	/* Assigning the wires to some inputs */
	assign register_file_reset = reset;
	assign register_file_WriteReg = WriteReg;
	assign register_file_rs1 = instruction[2:0];
	assign register_file_rs2 = instruction[5:3];
	assign register_file_rd = rd_in;
	assign register_file_write_data = write_data;

	/* Assigning the outputs to some wires */
	assign SEtoReg_out = SEtoReg_in;
	assign WriteReg_out = WriteReg_in;
	assign rs1 = register_file_rs1;
	assign rd_out = register_file_rs2;
	assign data1 = register_file_data1;
	assign data2 = register_file_data2;
	assign unextended = instruction[2:0];
	
	/*******************************************************************************************************************************************************************/

	/* Instantiating the modules and giving the appropriate wires as inputs */

	/* Instantiating a2_register_file */
	a2_register_file RF(.reset(register_file_reset), .rs1(register_file_rs1), .rs2(register_file_rs2), .rd(register_file_rd), .write_data(register_file_write_data), .WriteReg(register_file_WriteReg), 
	.data1(register_file_data1), .data2(register_file_data2));

endmodule

/*******************************************************************************************************************************************************************/

module a2_tb_instruction_decode;
	reg tb_reset;
	reg tb_SEtoReg_in;
	reg tb_WriteReg_in;
	reg tb_WriteReg;
	reg [2:0] tb_rd_in;
	reg [7:0] tb_instruction;
	reg [7:0] tb_write_data;
	
	wire tb_SEtoReg_out;
	wire tb_WriteReg_out;
	wire [2:0] tb_rs1;
	wire [2:0] tb_rd_out;
	wire [7:0] tb_data1;
	wire [7:0] tb_data2;
	wire [2:0] tb_unextended;

	/* Instantiating the ID stage */
	a2_instruction_decode ID(.reset(tb_reset), .SEtoReg_in(tb_SEtoReg_in), .WriteReg_in(tb_WriteReg_in), .WriteReg(tb_WriteReg), 
	.rd_in(tb_rd_in), .instruction(tb_instruction), .write_data(tb_write_data),
	.SEtoReg_out(tb_SEtoReg_out), .WriteReg_out(tb_WriteReg_out), .rs1(tb_rs1), .rd_out(tb_rd_out), .data1(tb_data1), .data2(tb_data2), .unextended(tb_unextended));

	initial #100 $finish;
	initial
	begin
		tb_reset = 0 ; tb_SEtoReg_in = 1  ; tb_WriteReg_in = 1 ; tb_WriteReg = 1 ; tb_rd_in = 3'b101 ; tb_instruction = 8'b00_001_011 ; tb_write_data = 8'h10 ; 
		#10 tb_reset = 1 ; tb_SEtoReg_in = 0 ; tb_WriteReg_in = 1 ; tb_WriteReg = 1 ; tb_rd_in = 3'b101 ; tb_instruction = 8'b11_000_110 ; tb_write_data = 8'h20 ; 
		#10 tb_reset = 0 ; tb_SEtoReg_in = 1  ; tb_WriteReg_in = 1 ; tb_WriteReg = 1 ; tb_rd_in = 3'b101 ; tb_instruction = 8'b00_001_011 ; tb_write_data = 8'h10 ;
	end 
endmodule

/*******************************************************************************************************************************************************************/



	
	
	

	

	
















	
	
