
/* Author: Santosh Srivatsan	2017A8PS1924G */
/* SUB-MODULE : PC */

module a2_pc(
	input [7:0] address_in,
	input clk,
	input reset,
	output [7:0] address_out
	);

	reg [8:0] pc;
	assign address_out = pc;

	always @(posedge clk) 
	begin
		if(reset)
			pc = 8'h00;
		else
			pc = address_in;
	end
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_pc;
	reg [7:0] tb_address_in;
	reg tb_clk;
	reg tb_reset;
	wire [7:0] tb_address_out;

	/* Instantiating the PC module */
	a2_pc PC(.address_in(tb_address_in), .clk(tb_clk), .reset(tb_reset), .address_out(tb_address_out));
			
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
		tb_reset = 0 ; tb_address_in = 8'h20;
		#15 tb_reset = 1 ; tb_address_in = 8'h40;
		#10 tb_reset = 0 ; tb_address_in = 8'h10;
	end
endmodule

/*******************************************************************************************************************************************************************/