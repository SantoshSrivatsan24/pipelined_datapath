/* Author: Santosh Srivatsan	2017A8PS1924G */
/* SUB-MODULE : 8 x 8 REGISTER FILE */

module a2_register_file(
		input reset,
		input [2:0] rs1,
		input [2:0] rs2,
		input [2:0] rd,
		input [7:0] write_data,
		input WriteReg,
		output reg [7:0] data1,
		output reg [7:0] data2
		);

	/* Reserving memory for 8 8-bit registers */
	reg [7:0] register_array [7:0];

	always @(posedge reset) $readmemh("a2_register_file.mem", register_array);
		
	always @(*)
	begin
		/* Writing into the register file */
		if(WriteReg) register_array[rd] = write_data;	
		/* Reading from the register file */	
		data1 = register_array[rs1];
		data2 = register_array[rs2];
	end
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_register_file;
		reg tb_reset;
		reg [2:0] tb_rs1;
		reg [2:0] tb_rs2;
		reg [2:0] tb_rd;
		reg [7:0] tb_write_data;
		reg tb_WriteReg;
		wire [7:0] tb_data1;
		wire [7:0] tb_data2;

	/* Instantiating the register file module */
	a2_register_file RF(.reset(tb_reset), .rsrc(tb_rs1), .rs2(tb_rs2), .rd(tb_rd), .write_data(tb_write_data), .WriteReg(tb_WriteReg), .data1(tb_data1), .data2(tb_data2));

	initial #100 $finish;

	/* Reading from register file */
	initial
	begin
		#0  tb_rs1 = 1 ; tb_rs2 = 0 ; tb_rd = 0 ; tb_WriteReg = 1'b0 ;  tb_write_data = 8'h10; tb_reset = 1'b0;
		#10 tb_rs1 = 3 ; tb_rs2 = 2 ; tb_rd = 2 ; tb_WriteReg = 1'b1 ; tb_write_data = 8'h20; tb_reset = 1'b0;
		#10 tb_rs1 = 5 ; tb_rs2 = 4 ; tb_rd = 4 ; tb_WriteReg = 1'b0 ; tb_write_data = 8'h30; tb_reset = 1'b1;
		#10 tb_rs1 = 7 ; tb_rs2 = 6 ; tb_rd = 6 ; tb_WriteReg = 1'b1 ; tb_write_data = 8'h40; tb_reset = 1'b0;
	end
endmodule

/*******************************************************************************************************************************************************************/
		


	