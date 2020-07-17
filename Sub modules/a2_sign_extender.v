/* Author: Santosh Srivatsan	2017A8PS1924G */
/* SUB-MODULE : SIGN EXTENDER */

module a2_sign_extender(
		input [2:0] unextended,
		output [7:0] extended
		);

	assign extended = { {5{unextended[2]}} , unextended};
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_sign_extender;
	reg [2:0] tb_unextended;
	wire [7:0] tb_extended;
	
	/* Instantiating the sign extender module */
	a2_sign_extender SE(.unextended(tb_unextended), .extended(tb_extended));

	initial #100 $finish;

	initial
	begin
		tb_unextended = 3'b110;
		#10 tb_unextended = 3'b011;
	end
endmodule

/*******************************************************************************************************************************************************************/
