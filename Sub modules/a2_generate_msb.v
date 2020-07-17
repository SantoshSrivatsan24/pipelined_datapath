/* Author: Santosh Srivatsan	2017A8PS1924G */
/* SUB-MODULE : GENERATE MSB */

module a2_generate_msb(
		input [7:0] msb_lsb,
		output [7:0] msb
		);

	assign msb = msb_lsb & 8'b1100_0000;
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_generate_msb;
	reg [7:0] tb_msb_lsb;
	wire [7:0] tb_msb;
	
	/* Instantiating the generate msb module */
	a2_generate_msb MSB(.msb_lsb(tb_msb_lsb), .msb(tb_msb));

	initial #100 $finish;

	initial
	begin
		tb_msb_lsb = 8'b0000_1011;
		#10 tb_msb_lsb = 8'b1110_1001;
	end
endmodule

/*******************************************************************************************************************************************************************/
