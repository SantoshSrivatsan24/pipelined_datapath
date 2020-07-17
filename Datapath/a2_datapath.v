/* Author : Santosh Srivatsan	2017A8PS1924G */
/* Complete datapath with pipelining */

module a2_datapath(
	input clk,
	input reset
	);

	/* Wire naming scheme : module_name_wire_name.
	   wire_name corresponds to the name of the input/output in the respective module 
	   Inputs and outputs are separated by a line break */

	/* Wires between IF stage and IF/ID register */
	wire if_WriteReg;
	wire if_SEtoReg;
	wire [7:0] if_instruction;

	/* Wires between IF/ID register and ID stage */
	wire id_WriteReg_in;
	wire id_SEtoReg_in;
	wire [7:0] id_instruction;

	/* Wires between ID stage and ID/EX register */
	wire id_WriteReg_out;
	wire id_SEtoReg_out;
	wire [2:0] id_rs1;
	wire [2:0] id_rd;
	wire [7:0] id_data1;
	wire [7:0] id_data2;
	wire [2:0] id_unextended;

	/* Wires between ID/EX register and EX stage */
	wire ex_WriteReg_in;
	wire ex_SEtoReg_in;
	wire [2:0] ex_rs1;
	wire [2:0] ex_rd_in;
	wire [7:0] ex_data1;
	wire [7:0] ex_data2;
	wire [2:0] ex_unextended;
	
	/* Wires between EX stage and EX/WB register */
	wire ex_WriteReg_out;
	wire ex_SEtoReg_out;
	wire [2:0] ex_rd_out;
	wire [7:0] ex_sum;
	wire [7:0] ex_extended;

	/* Wires between EX/WB register and WB stage */
	wire wb_WriteReg_in;
	wire wb_SEtoReg;
	wire [2:0] wb_rd_in;
	wire [7:0] wb_sum;
	wire [7:0] wb_extended;

	
	/* Wires between WB stage and ID stage */
	wire wb_WriteReg_out;
	wire [7:0] wb_result;
	wire [2:0] wb_rd_out;

	/* Wires between EX/WB register and EX stage */
	wire [7:0] forwarded_data = wb_result;

	/*******************************************************************************************************************************************************************/

	/* IF stage */
	a2_instruction_fetch IF(.clk(clk), .reset(reset), 
	.WriteReg(if_WriteReg), .SEtoReg(if_SEtoReg), .instruction(if_instruction));

	/* IF/ID register */
	a2_IF_ID IF_ID(.clk(clk), .reset(reset), .WriteReg_in(if_WriteReg), .SEtoReg_in(if_SEtoReg), .instruction_in(if_instruction), 
	.WriteReg_out(id_WriteReg_in), .SEtoReg_out(id_SEtoReg_in), .instruction_out(id_instruction));

	/* ID stage */
	a2_instruction_decode ID(.reset(reset), .SEtoReg_in(id_SEtoReg_in), .WriteReg_in(id_WriteReg_in), .WriteReg(wb_WriteReg_out), 
	.rd_in(wb_rd_out), .instruction(id_instruction), .write_data(wb_result),
	.SEtoReg_out(id_SEtoReg_out), .WriteReg_out(id_WriteReg_out), .rs1(id_rs1), .rd_out(id_rd), .data1(id_data1), .data2(id_data2), .unextended(id_unextended));

	/* ID/EX register */
	a2_ID_EX ID_EX(.clk(clk), .reset(reset), .SEtoReg_in(id_SEtoReg_out), .WriteReg_in(id_WriteReg_out), .rs1_in(id_rs1), .rd_in(id_rd), .data1_in(id_data1), .data2_in(id_data2), .unextended_in(id_unextended), 
	.SEtoReg_out(ex_SEtoReg_in), .WriteReg_out(ex_WriteReg_in), .rs1_out(ex_rs1), .rd_out(ex_rd_in), .data1_out(ex_data1), .data2_out(ex_data2),  .unextended_out(ex_unextended));

	/* EX stage */
	a2_execute EX(.SEtoReg_in(ex_SEtoReg_in), .WriteReg_in(ex_WriteReg_in), .ID_EX_rs1(ex_rs1), .ID_EX_rd(ex_rd_in), .EX_WB_rd(wb_rd_in), .data1(ex_data1), .data2(ex_data2), .forwarded_data(forwarded_data), .unextended(ex_unextended),
	.SEtoReg_out(ex_SEtoReg_out), .WriteReg_out(ex_WriteReg_out), .rd_out(ex_rd_out), .sum(ex_sum), .extended(ex_extended));
	
	/* EX/WB register */
	a2_EX_WB EX_WB(.clk(clk), .reset(reset), .SEtoReg_in(ex_SEtoReg_out), .WriteReg_in(ex_WriteReg_out), .rd_in(ex_rd_out), .sum_in(ex_sum), .extended_in(ex_extended), 
	.SEtoReg_out(wb_SEtoReg), .WriteReg_out(wb_WriteReg_in), .rd_out(wb_rd_in), .sum_out(wb_sum), .extended_out(wb_extended));
	
	/* WB stage */
	a2_write_back WB(.SEtoReg(wb_SEtoReg), .WriteReg_in(wb_WriteReg_in), .rd_in(wb_rd_in), .sum(wb_sum), .extended(wb_extended), 
	.WriteReg_out(wb_WriteReg_out), .rd_out(wb_rd_out), .result(wb_result));
endmodule 

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_datapath;
	reg tb_clk;
	reg tb_reset;
	
	/* Instantiating the datapath module */
	a2_datapath DATAPATH(.clk(tb_clk), .reset(tb_reset));

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
		tb_reset = 1'b0;
		#10 tb_reset = 1'b1;
		#10 tb_reset = 1'b0;
	end
endmodule

/*******************************************************************************************************************************************************************/







