/* Author : Santosh Srivatsan	2017A8PS1924G */
/* SUB-MODULE : Forwarding unit */

module a2_forwarding_unit(
	input [2:0] ID_EX_rs1,
	input [2:0] ID_EX_rd,
	input [2:0] EX_WB_rd,
	output ForwardA,
	output ForwardB
	);

	assign ForwardA = (ID_EX_rs1 == EX_WB_rd) ? 1'b1 : 1'b0;
	assign ForwardB = (ID_EX_rd == EX_WB_rd) ? 1'b1 : 1'b0;
	
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_forwarding_unit;
	reg [2:0] tb_ID_EX_rs1;
	reg [2:0] tb_ID_EX_rd;
	reg [2:0] tb_EX_WB_rd;
	wire tb_ForwardA;
	wire tb_ForwardB;

	/* Instantiating the forwarding unit module */
	a2_forwarding_unit FU(.ID_EX_rs1(tb_ID_EX_rs1), .ID_EX_rd(tb_ID_EX_rd), .EX_WB_rd(tb_EX_WB_rd), .ForwardA(tb_ForwardA), .ForwardB(tb_ForwardB));

	initial #100 $finish;

	initial
	begin	
		tb_ID_EX_rs1 = 3'b000 ; tb_ID_EX_rd = 3'b111 ; tb_EX_WB_rd = 3'b001;
		#10 tb_ID_EX_rs1 = 3'b000 ; tb_ID_EX_rd = 3'b001 ; tb_EX_WB_rd = 3'b000;	
		#10 tb_ID_EX_rs1 = 3'b100 ; tb_ID_EX_rd = 3'b100 ; tb_EX_WB_rd = 3'b100;
	end
endmodule

/*******************************************************************************************************************************************************************/


	
