/* Author : Santosh Srivatsan	2017A8PS1924G */
/* Execute (EX) stage */

module a2_execute(
	input SEtoReg_in,
	input WriteReg_in,
	input [2:0] ID_EX_rs1,
	input [2:0] ID_EX_rd,
	input [2:0] EX_WB_rd,
	input [7:0] data1,
	input [7:0] data2,
	input [7:0] forwarded_data,
	input [2:0] unextended,

	output SEtoReg_out,
	output WriteReg_out,
	output [2:0] rd_out,
	output [7:0] sum,
	output [7:0] extended
	);

	/* Wire naming scheme : module_name_wire_name.
	 wire_name corresponds to the name of the input/output in the respective module */

	/* Wires connected to a2_mux_2_1 #1 */
	wire a_mux_2_1_sel;
	wire [7:0] a_mux_2_1_d0;
	wire [7:0] a_mux_2_1_d1 ;
	wire [7:0] a_mux_2_1_y ;

	/* Wires connected to a2_mux_2_1 #2 */
	wire b_mux_2_1_sel;
	wire [7:0] b_mux_2_1_d0;
	wire [7:0] b_mux_2_1_d1 ;
	wire [7:0] b_mux_2_1_y ;

	/* Wires connected to a2_adder */
	wire [7:0] adder_operand1;
	wire [7:0] adder_operand2;
	wire [7:0] adder_sum;

	/* Wires connected to a2_sign_extender */
	wire [2:0] sign_extender_unextended;
	wire [7:0] sign_extender_extended;

	/* Wires connected to a2_forwarding_unit */
	wire [2:0] forwarding_unit_ID_EX_rs1;
	wire [2:0] forwarding_unit_ID_EX_rd;
	wire [2:0] forwarding_unit_EX_WB_rd;
	wire forwarding_unit_ForwardA;
	wire forwarding_unit_ForwardB;

	/*******************************************************************************************************************************************************************/

	/* Assigning the wires to some inputs */
	assign forwarding_unit_ID_EX_rs1 = ID_EX_rs1;
	assign forwarding_unit_ID_EX_rd = ID_EX_rd;
	assign forwarding_unit_EX_WB_rd = EX_WB_rd;
	assign a_mux_2_1_d0 = data1;
	assign a_mux_2_1_d1 = forwarded_data;
	assign b_mux_2_1_d0 = data2;
	assign b_mux_2_1_d1 = forwarded_data;
	assign sign_extender_unextended = unextended;

	/* Assigning the outputs to some wires */
	assign SEtoReg_out = SEtoReg_in;
	assign WriteReg_out = WriteReg_in;
	assign rd_out = ID_EX_rd;
	assign sum = adder_sum;
	assign extended = sign_extender_extended;

	/*******************************************************************************************************************************************************************/

	/* Connections between a2_forwarding_unit and a2_mux_2_1 */
	assign a_mux_2_1_sel = forwarding_unit_ForwardA;
	assign b_mux_2_1_sel = forwarding_unit_ForwardB;

	/* Connections between a2_mux_2_1 and a2_adder */
	assign adder_operand1 = a_mux_2_1_y;
	assign adder_operand2 = b_mux_2_1_y;

	/*******************************************************************************************************************************************************************/
	
	/* Instantiating the modules and giving the appropriate wires as inputs */
	
	/* Instantiating a2_mux_2_1 */
	a2_mux_2_1 M21A(.d0(a_mux_2_1_d0), .d1(a_mux_2_1_d1), .sel(a_mux_2_1_sel), .y(a_mux_2_1_y));
	a2_mux_2_1 M21B(.d0(b_mux_2_1_d0), .d1(b_mux_2_1_d1), .sel(b_mux_2_1_sel), .y(b_mux_2_1_y));

	/* Instantiating a2_adder */
	a2_adder ADD(.operand1(adder_operand1), .operand2(adder_operand2), .sum(adder_sum));

	/* Instantiating a2_sign_extender */
	a2_sign_extender SE(.unextended(sign_extender_unextended), .extended(sign_extender_extended));

	/* Instantiating a2_forwarding_unit */
	a2_forwarding_unit FU(.ID_EX_rs1(forwarding_unit_ID_EX_rs1), .ID_EX_rd(forwarding_unit_ID_EX_rd), .EX_WB_rd(forwarding_unit_EX_WB_rd), 
	.ForwardA(forwarding_unit_ForwardA), .ForwardB(forwarding_unit_ForwardB));

endmodule 

module a2_tb_execute;
	reg tb_SEtoReg_in;
	reg tb_WriteReg_in;
	reg [2:0] tb_ID_EX_rs1;
	reg [2:0] tb_ID_EX_rd;
	reg [2:0] tb_EX_WB_rd;
	reg [7:0] tb_data1;
	reg [7:0] tb_data2;
	reg [7:0] tb_forwarded_data;
	reg [2:0] tb_unextended;

	wire tb_SEtoReg_out;
	wire tb_WriteReg_out;
	wire [2:0] tb_rd_out;
	wire [7:0] tb_sum;
	wire [7:0] tb_extended;

	/* Instantiating the EX stage */
	a2_execute EX(.SEtoReg_in(tb_SEtoReg_in), .WriteReg_in(tb_WriteReg_in), .ID_EX_rs1(tb_ID_EX_rs1), .ID_EX_rd(tb_ID_EX_rd), .EX_WB_rd(tb_EX_WB_rd), .data1(tb_data1), .data2(tb_data2), .forwarded_data(tb_forwarded_data), .unextended(tb_unextended),
.SEtoReg_out(tb_SEtoReg_out), .WriteReg_out(tb_WriteReg_out), .rd_out(tb_rd_out), .sum(tb_sum), .extended(tb_extended));

	initial #100 $finish;

	initial
	begin
		tb_SEtoReg_in = 1'b1 ; tb_ID_EX_rs1 = 3'b000 ; tb_ID_EX_rd = 3'b001 ; tb_EX_WB_rd = 3'b001; tb_data1 = 8'h10 ; tb_data2 = 8'h20 ; tb_forwarded_data = 8'h50; tb_unextended = 3'b110; tb_WriteReg_in = 1'b1;
		#10 tb_SEtoReg_in = 1'b1 ; tb_ID_EX_rs1 = 3'b000 ; tb_ID_EX_rd = 3'b000 ;  tb_EX_WB_rd = 3'b000 ; tb_data1 = 8'h10 ; tb_data2 = 8'h20 ; tb_forwarded_data = 8'h50; tb_unextended = 3'b110; tb_WriteReg_in = 1'b1;
	
	end
endmodule
	
	










