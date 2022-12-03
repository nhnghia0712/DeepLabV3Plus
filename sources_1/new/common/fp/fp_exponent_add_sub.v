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

module fp_exponent_add_sub(
	clk    ,
	reset   ,
	valid_in,
	in_exp_a,
	in_exp_b,

	out_exp,
	out_exp_diff,
	valid_out
);

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter EXP_WIDTH = 8;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                 clk     ;
input                 reset   ;
input                 valid_in;
input [EXP_WIDTH-1:0] in_exp_a;
input [EXP_WIDTH-1:0] in_exp_b;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [EXP_WIDTH-1:0] out_exp     ;
output [EXP_WIDTH-1:0] out_exp_diff;
output                 valid_out   ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                 clk     ;
wire                 reset   ;
wire                 valid_in;
wire [EXP_WIDTH-1:0] in_exp_a;
wire [EXP_WIDTH-1:0] in_exp_b;

reg [EXP_WIDTH-1:0] out_exp     ;
reg [EXP_WIDTH-1:0] out_exp_diff;
reg                 valid_out   ;

always @(posedge clk) begin
	if(reset) begin
		out_exp      <= 8'd0;
		out_exp_diff <= 8'd0;
		valid_out    <= 1'b0;
	end
	else if (valid_in) begin
		if (in_exp_a >= in_exp_b)begin
			out_exp_diff <= in_exp_a - in_exp_b;
			out_exp      <= in_exp_a;
			valid_out    <= 1'b1;
		end
		else if (in_exp_a < in_exp_b)begin
			out_exp_diff <= in_exp_b - in_exp_a;
			out_exp      <= in_exp_b;
			valid_out    <= 1'b1;
		end
	end
	else begin
		valid_out <= 1'b0;
	end
end

endmodule
