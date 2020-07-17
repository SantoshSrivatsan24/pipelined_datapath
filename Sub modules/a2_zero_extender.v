/* Author: Santosh Srivatsan	2017A8PS1924G */
/* SUB-MODULE : ZERO EXTENDER */

module a2_zero_extender(
		input [5:0] unextended,
		output [7:0] extended
		);

	assign extended = { {2{1'b0}} , unextended};
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_zero_extender;
	reg [5:0] tb_unextended;
	wire [7:0] tb_extended;
	
	/* Instantiating the zero extender module */
	a2_zero_extender ZE(.unextended(tb_unextended), .extended(tb_extended));

	initial #100 $finish;

	initial
	begin
		tb_unextended = 6'b11_0010;
		#10 tb_unextended = 6'b01_1011;
	end
endmodule

/*******************************************************************************************************************************************************************/