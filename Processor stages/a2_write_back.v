/* Author : Santosh Srivatsan	2017A8PS1924G */
/* Write Back (WB) stage */

module a2_write_back(
	input SEtoReg,
	input WriteReg_in,
	input [2:0] rd_in,
	input [7:0] sum,
	input [7:0] extended,

	output WriteReg_out,
	output [2:0] rd_out,
	output [7:0] result
	);
	
	/* Wire naming scheme : module_name_wire_name.
	 wire_name corresponds to the name of the input/output in the respective module */

	/* Wires connected to a2_mux_2_1 */
	wire mux_2_1_sel;
	wire [7:0] mux_2_1_d0;
	wire [7:0] mux_2_1_d1 ;
	wire [7:0] mux_2_1_y ;

	/*******************************************************************************************************************************************************************/

	/* Assigning the wires to some inputs */
	assign mux_2_1_sel = SEtoReg;	
	assign mux_2_1_d0 = sum;
	assign mux_2_1_d1 = extended;
	
	/* Assigning the outputs to some wires */
	assign WriteReg_out = WriteReg_in;
	assign rd_out = rd_in;
	assign result = mux_2_1_y;
	
	/* Instantiating a2_mux_2_1 */
	a2_mux_2_1 M21(.d0(mux_2_1_d0), .d1(mux_2_1_d1), .sel(mux_2_1_sel), .y(mux_2_1_y));
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_write_back;
	reg tb_SEtoReg;
	reg tb_WriteReg_in;
	reg [2:0] tb_rd_in;
	reg [7:0] tb_sum;
	reg [7:0] tb_extended;

	wire tb_WriteReg_out;
	wire [2:0] tb_rd_out;
	wire [7:0] tb_result;

	/* Instantiating the WB stage */
	a2_write_back WB(.SEtoReg(tb_SEtoReg), .WriteReg_in(tb_WriteReg_in), .rd_in(tb_rd_in), .sum(tb_sum), .extended(tb_extended), 
	.WriteReg_out(tb_WriteReg_out), .rd_out(tb_rd_out), .result(tb_result));
	
	initial #100 $finish;
	
	initial 
	begin
		tb_SEtoReg = 1 ; tb_WriteReg_in = 1 ; tb_rd_in = 3'b101 ; tb_sum = 8'h10 ; tb_extended = 8'h20 ; 
		#10 tb_SEtoReg = 0 ; tb_WriteReg_in = 1 ; tb_rd_in = 3'b101 ; tb_sum = 8'h10 ; tb_extended = 8'h20 ; 
	
	end
endmodule
	

	
