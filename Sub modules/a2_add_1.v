/* Author: Santosh Srivatsan	2017A8PS1924G */
/* SUB-MODULE : ADD 0x01 TO PC */

module a2_add_1(
		input [7:0] address_in,
		output [7:0] address_out
		);
	
	assign address_out = address_in + 8'h01;
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_add_1;
	reg [7:0] tb_address_in;
	wire [7:0] tb_address_out;
	
	/* Instantiating the update_pc module */
	a2_add_1 A1(.address_in(tb_address_in), .address_out(tb_address_out));

	initial #100 $finish;
	
	initial
	begin
		tb_address_in = 8'h10;
		#10 tb_address_in = 8'h20;
		#10 tb_address_in = 8'h30;
		#10 tb_address_in = 8'h40;
		#10 tb_address_in = 8'h50;
		#10 tb_address_in = 8'h60;
	end
endmodule

/*******************************************************************************************************************************************************************/
		

