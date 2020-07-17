/* Author : Santosh Srivatsan	2017A8PS1924G */
/* EX/WB pipeline register */

module a2_EX_WB(
	input clk,
	input reset,

	input SEtoReg_in,
	input WriteReg_in,
	input [2:0] rd_in,
	input [7:0] sum_in,
	input [7:0] extended_in,

	output reg SEtoReg_out,
	output reg WriteReg_out,
	output reg [2:0] rd_out,
	output reg [7:0] sum_out,
	output reg [7:0] extended_out
	);

	always @(posedge reset)
	begin
		SEtoReg_out = 0;
		WriteReg_out = 0;
		rd_out = 0;
		sum_out = 0;
		extended_out = 0;
	end
	
	always @(posedge clk)
	begin
		if(!reset)
		begin
			SEtoReg_out = SEtoReg_in;
			WriteReg_out = WriteReg_in;
			rd_out = rd_in;
			sum_out = sum_in;
			extended_out = extended_in;
		end
	end
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_EX_WB;
	reg tb_clk;
	reg tb_reset;
 
	reg tb_SEtoReg_in;
	reg tb_WriteReg_in;
	reg [2:0] tb_rd_in;
	reg [7:0] tb_sum_in;
	reg [7:0] tb_extended_in;

	wire tb_SEtoReg_out;
	wire tb_WriteReg_out;
	wire [2:0] tb_rd_out;
	wire [7:0] tb_sum_out;
	wire [7:0] tb_extended_out;

	/* Instantiating the EX/WB module */
	a2_EX_WB EX_WB(.clk(tb_clk), .reset(tb_reset), .SEtoReg_in(tb_SEtoReg_in), .WriteReg_in(tb_WriteReg_in), .rd_in(tb_rd_in), .sum_in(tb_sum_in), .extended_in(tb_extended_in), 
.SEtoReg_out(tb_SEtoReg_out), .WriteReg_out(tb_WriteReg_out), .rd_out(tb_rd_out), .sum_out(tb_sum_out), .extended_out(tb_extended_out));

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
		tb_SEtoReg_in = 1 ; tb_rd_in = 3'b000 ; tb_sum_in = 8'h10 ; tb_extended_in = 8'h20 ; tb_reset = 1'b0;
		#10 tb_SEtoReg_in = 0 ; tb_rd_in = 3'b001 ; tb_sum_in = 8'h30 ; tb_extended_in = 8'h40 ; tb_reset = 1'b1;
		#10 tb_SEtoReg_in = 1 ; tb_rd_in = 3'b010 ; tb_sum_in = 8'h50 ; tb_extended_in = 8'h60 ; tb_reset = 1'b0;
		
	end
endmodule

/*******************************************************************************************************************************************************************/


		

	
