`timescale 1ns/1ps
/////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nguyen Hoang Nghia

// Create Date: 	
// Design Name: 
// Module Name: 
// Project Name: 
// Target Device: 
// Tool Versions:
// Description:

// Dependencies:

// Revision:
// Revision 0.01 - File Created
// Additional Comments:

///////////////////////////////////////////////////////////////////////
module fp_mantissa_add_sub(
	clk,
	reset,
	valid_in,
	in_exp_a,
	in_exp_b,
	in_exp_diff,
	in_man_a,
	in_man_b,

	out_man_a,
	out_man_b,
	valid_out
);

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter MAN_WIDTH = 23;
parameter EXP_WIDTH = 8 ;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                 clk        ;
input                 reset      ;
input                 valid_in   ;
input [EXP_WIDTH-1:0] in_exp_a   ;
input [EXP_WIDTH-1:0] in_exp_b   ;
input [EXP_WIDTH-1:0] in_exp_diff;
input [MAN_WIDTH+4:0] in_man_a   ;
input [MAN_WIDTH+4:0] in_man_b   ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [MAN_WIDTH+4:0] out_man_a;
output [MAN_WIDTH+4:0] out_man_b;
output                 valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                 clk        ;
wire                 reset      ;
wire                 valid_in   ;
wire [EXP_WIDTH-1:0] in_exp_a   ;
wire [EXP_WIDTH-1:0] in_exp_b   ;
wire [EXP_WIDTH-1:0] in_exp_diff;
wire [MAN_WIDTH+4:0] in_man_a   ;
wire [MAN_WIDTH+4:0] in_man_b   ;

reg [MAN_WIDTH+4:0] out_man_a;
reg [MAN_WIDTH+4:0] out_man_b;
reg                 valid_out;

always @(posedge clk) begin
	if (reset) begin
		out_man_a <= 28'd0;
		out_man_b <= 28'd0;
		valid_out <= 1'b0;
	end
	else if(valid_in) begin
		if (in_exp_a >= in_exp_b) begin
			out_man_b <= in_man_b >> in_exp_diff;
			out_man_a <= in_man_a;
			valid_out <= 1'b1;
		end
		else if (in_exp_a < in_exp_b) begin
			out_man_a <= in_man_a >> in_exp_diff;
			out_man_b <= in_man_b;
			valid_out <= 1'b1;
		end
	end
	else begin
		valid_out <= 1'b0;
	end
end

endmodule
