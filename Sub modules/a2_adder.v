/* Author: Santosh Srivatsan	2017A8PS1924G */
/* SUB-MODULE : 8-BIT ADDER */

module a2_adder(
	input [7:0] operand1,
	input [7:0] operand2,
	output [7:0] sum
	);

	assign sum = operand1 + operand2;
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_adder;
	reg [7:0] tb_operand1;
	reg [7:0] tb_operand2;
	wire [7:0] tb_sum;

	/* Instantiating the alu module */
	a2_adder ADD(.operand1(tb_operand1), .operand2(tb_operand2), .sum(tb_sum));

	initial #100 $finish;

	initial
	begin
		#0  tb_operand1 = 8'h0a ; tb_operand2 = 8'h05 ; 
		#10 tb_operand1 = 8'h0a ; tb_operand2 = 8'h1a ; 
	end
endmodule 

/*******************************************************************************************************************************************************************/








