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
module fp_mantissa_mul(
	clk,
	reset,
	valid_in,
	in_exp,
	in_man,
	in_sign_bit,

	out_mantissa,
	out_exponent,
	out_sign,

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
input [EXP_WIDTH-1:0] in_exp     ;
input [MAN_WIDTH+1:0] in_man     ;
input                 in_sign_bit;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [MAN_WIDTH-1:0] out_mantissa;
output [EXP_WIDTH-1:0] out_exponent;
output                 out_sign    ;
output                 valid_out   ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                 clk        ;
wire                 reset      ;
wire                 valid_in   ;
wire [EXP_WIDTH-1:0] in_exp     ;
wire [MAN_WIDTH+1:0] in_man     ;
wire                 in_sign_bit;

reg [MAN_WIDTH-1:0] out_mantissa;
reg [EXP_WIDTH-1:0] out_exponent;
reg                 out_sign    ;
reg                 valid_out   ;

always @(posedge clk) begin
	if (reset) begin
		out_mantissa <= {MAN_WIDTH{1'b0}};
		out_exponent <= {EXP_WIDTH{1'b0}};
		out_sign     <= 1'b0;
		valid_out    <= 1'b0;
	end
	else if(valid_in) begin
		out_sign <= in_sign_bit;
		if (in_man[MAN_WIDTH+1]) begin
			out_exponent <= in_exp +1'b1;
			out_mantissa <= in_man[MAN_WIDTH:1];
			valid_out    <= 1'b1;
		end
		else if (!in_man[MAN_WIDTH+1]) begin
			out_exponent <= in_exp;
			out_mantissa <= in_man[MAN_WIDTH-1:0];
			valid_out    <= 1'b1;
		end
	end
	else begin
		valid_out <= 1'b0;
	end
end

endmodule
