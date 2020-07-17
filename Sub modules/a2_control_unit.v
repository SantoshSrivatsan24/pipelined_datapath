/* Author: Santosh Srivatsan	2017A8PS1924G */
/* SUB-MODULE : CONTROL UNIT */

module a2_control_unit(
		input [2:0] opcode,
		output PCSrc,
		output SEtoReg,
		output WriteReg
		);


	/********************************************/
	/* Instruction | PCSrc | SEtoReg | WriteReg */
	/* li  (00)    |   0   |    1    |     1    */
	/* add (01)    |   0   |    0    |     1    */
	/* j   (11)    |   1   |    X    |     0    */
	/********************************************/

	assign PCSrc = opcode[1];
	assign SEtoReg = !opcode[0];
	assign WriteReg = !opcode[1];
		
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_control_unit;
	reg [2:0] tb_opcode;
	wire tb_PCSrc;
	wire tb_SEtoReg;
	wire tb_WriteReg;
	
	/* Instantiating the control unit module */
	a2_control_unit CU(.opcode(tb_opcode), .PCSrc(tb_PCSrc), .SEtoReg(tb_SEtoReg), .WriteReg(tb_WriteReg));

	initial #100 $finish;

	initial 
	begin
		tb_opcode = 2'b00;
		#10 tb_opcode = 2'b01;
		#10 tb_opcode = 2'b11;
		#10 tb_opcode = 2'b01;
		#10 tb_opcode = 2'b01;
		#10 tb_opcode = 2'b11;
	end
endmodule

/*******************************************************************************************************************************************************************/
