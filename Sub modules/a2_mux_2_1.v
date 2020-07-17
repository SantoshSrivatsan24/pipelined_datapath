/* Author: Santosh Srivatsan	2017A8PS1924G */
/* SUB-MODULE : 2:1 MUX with 8-bit inputs */

module a2_mux_2_1(
		input [7:0] d0,
		input [7:0] d1,
		input sel,
		output [7:0] y
		);

	assign y = sel ? d1 : d0;
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_mux_2_1;
	reg [7:0] tb_d0; 
	reg [7:0] tb_d1;
	reg tb_sel;
	wire [7:0] tb_y;

	a2_mux_2_1 M21(.d0(tb_d0), .d1(tb_d1), .sel(tb_sel), .y(tb_y));

	initial #100 $finish;

	initial
	begin
		tb_d0 = 8'd10 ; tb_d1 = 8'd20 ; tb_sel = 0;
		#10 tb_d0 = 8'd30 ; tb_d1 = 8'd40 ; tb_sel = 1;
	end
endmodule

/*******************************************************************************************************************************************************************/