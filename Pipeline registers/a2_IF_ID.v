/* Author : Santosh Srivatsan	2017A8PS1924G */
/* IF/ID pipeline register */

module a2_IF_ID(
	input clk,
	input reset,

	input WriteReg_in,
	input SEtoReg_in,
	input [7:0] instruction_in,

	output reg WriteReg_out,
	output reg SEtoReg_out,
	output reg [7:0] instruction_out
	);

	always @(posedge reset)
	begin	
		WriteReg_out = 0;
		SEtoReg_out = 0;
		instruction_out = 0;
	end

	always @(posedge clk)
	begin
		if(!reset)
		begin
			WriteReg_out = WriteReg_in;
			SEtoReg_out = SEtoReg_in;
			instruction_out = instruction_in;
		end
	end
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_IF_ID;
	reg tb_clk;
	reg tb_reset;
	reg tb_WriteReg_in;
	reg tb_SEtoReg_in;
	reg [7:0] tb_instruction_in;
	wire tb_WriteReg_out;
	wire tb_SEtoReg_out;
	wire [7:0] tb_instruction_out;

	/* Instantiating the IF/ID module */
	a2_IF_ID IF_ID(.clk(tb_clk), .reset(tb_reset), .WriteReg_in(tb_WriteReg_in), .SEtoReg_in(tb_SEtoReg_in), .instruction_in(tb_instruction_in), 
.WriteReg_out(tb_WriteReg_out), .SEtoReg_out(tb_SEtoReg_out), .instruction_out(tb_instruction_out));

	initial #100 $finish;

	/* Clock generation */
	always
	begin
		tb_clk = 0;
		#5;
		tb_clk = 1;
		#5;
	end

	initial
	begin
		tb_WriteReg_in = 1 ; tb_SEtoReg_in = 1 ; tb_instruction_in = 8'b00_001_110 ; tb_reset = 1'b0;
		#18 tb_WriteReg_in = 1 ; tb_SEtoReg_in = 0 ; tb_instruction_in = 8'b01_001_010 ; tb_reset = 1'b1;
		#30 tb_WriteReg_in = 1 ; tb_SEtoReg_in = 1 ; tb_instruction_in = 8'b00_001_110 ; tb_reset = 1'b0;
	end
endmodule

/*******************************************************************************************************************************************************************/


		

	