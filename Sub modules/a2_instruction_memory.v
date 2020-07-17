/* Author: Santosh Srivatsan	2017A8PS1924G */
/* SUB-MODULE : 8 x 6 INSTRUCTION MEMORY */

module a2_instruction_memory(
		input reset,
		input [7:0] address,
		output reg [7:0] instruction
		);

	/* Reserving memory for 10 instructions */
	reg [7:0] memory_array [5:0]; 		

	/* Whenever reset is activated, the instruction memory should be loaded with pre-defined values */
	always @(posedge reset) $readmemh("a2_instruction_memory.mem", memory_array);
	
	/* Read instructions from .mem file whenever the address changes */
	always @(address) instruction = memory_array [address];
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_instruction_memory;
		reg tb_reset;
		reg [7:0] tb_address;
		wire [7:0] tb_instruction;

		/* Instantiating the instruction memory module */
		a2_instruction_memory IM(.reset(tb_reset), .address(tb_address), .instruction(tb_instruction));

		initial #100 $finish;

		/* Reading from memory */
		initial
		begin
			#0  tb_address = 0; tb_reset = 1'b0;
			#10 tb_address = 1; tb_reset = 1'b0;
			#10 tb_address = 2; tb_reset = 1'b0;
			#10 tb_address = 3; tb_reset = 1'b0;
			#10 tb_address = 4; tb_reset = 1'b1;
			#10 tb_address = 5; tb_reset = 1'b0;
			#10 tb_address = 6; tb_reset = 1'b0;
			#10 tb_address = 7; tb_reset = 1'b0;
			#10 tb_address = 8; tb_reset = 1'b0;

		end
endmodule

/*******************************************************************************************************************************************************************/
			


		

		

	
	