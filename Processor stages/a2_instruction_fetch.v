/* Author: Santosh Srivatsan	2017A8PS1924G */
/* Instruction Fetch (IF) stage */

module a2_instruction_fetch(
	input clk,
	input reset,
	output WriteReg,
	output SEtoReg,
	output [7:0] instruction
	);
	
	/* Wire naming scheme : module_name_wire_name.
	 wire_name corresponds to the name of the input/output in the respective module */

	/* Wires connected to a2_mux_2_1 */
	wire mux_2_1_sel;
	wire [7:0] mux_2_1_d0;
	wire [7:0] mux_2_1_d1 ;
	wire [7:0] mux_2_1_y ;

	/* Wires connected to a2_pc */
	wire pc_clk;
	wire pc_reset;
	wire [7:0] pc_address_in;
	wire [7:0] pc_address_out;

	/* Wires connected to a2_instruction_memory */
	wire instruction_memory_reset;
	wire [7:0] instruction_memory_address;
	wire [7:0] instruction_memory_instruction;

	/* Wires connected to add_1 */
	wire [7:0] add_1_address_in;
	wire [7:0] add_1_address_out;

	/* Wires connected to a2_control_unit */
	wire [7:0] control_unit_opcode;
	wire control_unit_PCSrc;
	wire control_unit_WriteReg;
	wire control_unit_SEtoReg;

	/* Wires connected to a2_zero_extender */
	wire [5:0] zero_extender_unextended;
	wire [7:0] zero_extender_extended;

	/* Wires connected to a2_generate_msb */
	wire [7:0] generate_msb_msb_lsb;
	wire [7:0] generate_msb_lsb;

	/* Wires connected to a2_adder */
	wire [7:0] adder_operand1;
	wire [7:0] adder_operand2;
	wire [7:0] adder_sum;

	/*******************************************************************************************************************************************************************/

	/* Assigning the wires to some inputs */
	assign pc_clk = clk;
	assign pc_reset = reset;
	assign instruction_memory_reset = reset;
	
	/* Assigning the outputs to some wires */
	assign WriteReg = control_unit_WriteReg;
	assign SEtoReg = control_unit_SEtoReg;
	assign instruction = instruction_memory_instruction;

	/*******************************************************************************************************************************************************************/

	/* Connections between a2_mux_2_1 and a2_pc */
	assign pc_address_in = mux_2_1_y;

	/* Connections between a2_pc and a2_instruction_memory */
	assign instruction_memory_address = pc_address_out;

	/* Connections between a2_instruction_memory and a2_control_unit */
	assign control_unit_opcode = instruction_memory_instruction[7:6];
	
	/* Connections between a2_control_unit and a2_mux_2_1 */
	assign mux_2_1_sel = control_unit_PCSrc;

	/* Connections between a2_pc and a2_add_1 */
	assign add_1_address_in = pc_address_out;

	/* Connections between a2_add_1 and a2_mux_2_1 */
	assign mux_2_1_d0 = add_1_address_out;
	
	/* Connections between instruction_memory and zero_extender */
 	assign zero_extender_unextended = instruction_memory_instruction[5:0];

	/* Connections between add_1 and generate_msb */
	assign generate_msb_msb_lsb = add_1_address_out;

	/* Connections for a2_adder */
	assign adder_operand1 = generate_msb_lsb;
	assign adder_operand2 = zero_extender_extended;
	assign mux_2_1_d1 = adder_sum;

	/*******************************************************************************************************************************************************************/

	/* Instantiating the modules and giving the appropriate wires as inputs */
	
	/* Instantiating a2_mux_2_1 */
	a2_mux_2_1 M21(.d0(mux_2_1_d0), .d1(mux_2_1_d1), .sel(mux_2_1_sel), .y(mux_2_1_y));

	/* Instantiating a2_pc */
	a2_pc PC(.address_in(pc_address_in), .clk(pc_clk), .reset(pc_reset), .address_out(pc_address_out));

	/* Instantiating a2_instruction_memory */
	a2_instruction_memory IM(.reset(instruction_memory_reset), .address(instruction_memory_address), .instruction(instruction_memory_instruction));

	/* Instantiating add_1 */
	a2_add_1 A1(.address_in(add_1_address_in), .address_out(add_1_address_out));
	
	/* Instantiating a2_control_unit */
	a2_control_unit CU(.opcode(control_unit_opcode), .PCSrc(control_unit_PCSrc), .SEtoReg(control_unit_SEtoReg), .WriteReg(control_unit_WriteReg));

	/* Instantiating a2_zero_extender */
	a2_zero_extender ZE(.unextended(zero_extender_unextended), .extended(zero_extender_extended));

	/* Instantiating a2_generate_msb */
	a2_generate_msb MSB(.msb_lsb(generate_msb_msb_lsb), .msb(generate_msb_lsb));

	/* Instantiating a2_adder */
	a2_adder ADD(.operand1(adder_operand1), .operand2(adder_operand2), .sum(adder_sum));
endmodule

/*******************************************************************************************************************************************************************/

/* Testbench */

module a2_tb_instruction_fetch;
	reg tb_clk;
	reg tb_reset;
	wire tb_WriteReg;
	wire tb_SEtoReg;
	wire [7:0] tb_instruction;
	
	/* Instantiating the IF module */
	a2_instruction_fetch IF(.clk(tb_clk), .reset(tb_reset),
.WriteReg(tb_WriteReg), .SEtoReg(tb_SEtoReg), .instruction(tb_instruction));

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
		tb_reset = 0 ; 
		#10 tb_reset = 1 ; 
		#10 tb_reset = 0 ; 
		#10 tb_reset = 0 ; 
		#10 tb_reset = 0 ; 
		#10 tb_reset = 0 ; 
		#10 tb_reset = 0 ; 
		#10 tb_reset = 0 ; 
		#10 tb_reset = 0 ; 
		#10 tb_reset = 0 ;
		#10 tb_reset = 0 ; 

	end
endmodule
		
/*******************************************************************************************************************************************************************/








	

	

	









