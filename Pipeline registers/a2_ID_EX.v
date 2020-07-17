/* Author : Santosh Srivatsan	2017A8PS1924G */
/* ID/EX pipeline register */

module a2_ID_EX(
	input clk,
	input reset,

	input SEtoReg_in,
	input WriteReg_in,
	input [2:0] rs1_in,
	input [2:0] rd_in,
	input [7:0] data1_in,
	input [7:0] data2_in,
	input [2:0] unextended_in,

	output reg SEtoReg_out,
	output reg WriteReg_out,
	output reg [2:0] rs1_out,
	output reg [2:0] rd_out,
	output reg [7:0] data1_out,
	output reg [7:0] data2_out,
	output reg [2:0] unextended_out
	);

	always @(posedge reset)
	begin
		SEtoReg_out = 0;
		WriteReg_out = 0;
		rs1_out = 0;
		rd_out = 0;
		data1_out = 0;
		data2_out = 0;
		unextended_out = 0;	
	end

	always @(posedge clk)
	begin
		if(!reset)
		begin
			SEtoReg_out = SEtoReg_in;
			WriteReg_out = WriteReg_in;
			rs1_out = rs1_in;
			rd_out = rd_in;
			data1_out = data1_in;
			data2_out = data2_in;
			unextended_out = unextended_in;	
		end
	end
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_ID_EX;
	reg tb_clk;
	reg tb_reset;

	reg tb_SEtoReg_in;
	reg tb_WriteReg_in;
	reg [2:0] tb_rs1_in;
	reg [2:0] tb_rd_in;
	reg [7:0] tb_data1_in;
	reg [7:0] tb_data2_in;
	reg [2:0] tb_unextended_in;

	wire tb_SEtoReg_out;
	wire tb_WriteReg_out;
	wire [2:0] tb_rs1_out;
	wire [2:0] tb_rd_out;
	wire [7:0] tb_data1_out;
	wire [7:0] tb_data2_out;
	wire [2:0] tb_unextended_out;
	
	/* Instantiating the ID/EX module */
	a2_ID_EX ID_EX(.clk(tb_clk), .reset(tb_reset), .SEtoReg_in(tb_SEtoReg_in), .WriteReg_in(tb_WriteReg_in), .rs1_in(tb_rs1_in), .rd_in(tb_rd_in), .data1_in(tb_data1_in), .data2_in(tb_data2_in), .unextended_in(tb_unextended_in), 
.SEtoReg_out(tb_SEtoReg_out), .WriteReg_out(tb_WriteReg_out), .rs1_out(tb_rs1_out), .rd_out(tb_rd_out), .data1_out(tb_data1_out), .data2_out(tb_data2_out),  .unextended_out(tb_unextended_out));
	

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
		tb_SEtoReg_in = 1 ; tb_rs1_in = 3'b000 ; tb_rd_in = 3'b001 ; tb_data1_in = 8'h10 ; tb_data2_in = 8'h20 ; tb_unextended_in = 3'b110 ; tb_reset = 1'b0;
		#10 tb_SEtoReg_in = 0 ; tb_rs1_in = 3'b010  ; tb_rd_in = 3'b011 ; tb_data1_in = 8'h30 ; tb_data2_in  = 8'h40 ; tb_unextended_in = 3'b001 ; tb_reset = 1'b1;
		#10 tb_SEtoReg_in = 0 ; tb_rs1_in = 3'b010  ; tb_rd_in = 3'b011 ; tb_data1_in = 8'h30 ; tb_data2_in  = 8'h40 ; tb_unextended_in = 3'b001 ; tb_reset = 1'b0;
		
	end
endmodule

/*******************************************************************************************************************************************************************/


		

	
