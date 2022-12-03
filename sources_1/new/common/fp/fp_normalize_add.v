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

module fp_normalize_add(
	clk,
	reset,
	valid_in,
	in_man,
	in_exp,
	in_sign_bit,

	out_man_normalize,
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
input [MAN_WIDTH+4:0] in_man     ;
input [EXP_WIDTH-1:0] in_exp     ;
input                 in_sign_bit;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [MAN_WIDTH+3:0] out_man_normalize;
output [EXP_WIDTH-1:0] out_exponent     ;
output                 out_sign         ;
output                 valid_out        ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                 clk     ;
wire                 reset   ;
wire                 valid_in;
wire [MAN_WIDTH+4:0] in_man  ;
wire [EXP_WIDTH-1:0] in_exp  ;
wire                 in_sign_bit;

reg [MAN_WIDTH+3:0] out_man_normalize;
reg [EXP_WIDTH-1:0] out_exponent     ;
reg                 out_sign         ;
reg                 valid_out        ;

always @(posedge clk) begin
	if(reset) begin
		out_exponent      <= 8'd0;
		out_man_normalize <= 27'd0;
		out_sign          <= 1'b0;
		valid_out         <= 1'b0;
	end
	else if (valid_in) begin
		out_sign  <= in_sign_bit;
		valid_out <= 1'b1;
		if (in_man[MAN_WIDTH+4]) begin
			out_exponent      <= in_exp + 1'b1;
			out_man_normalize <= in_man[MAN_WIDTH+3:0] >> 1;
		end
		else begin
			out_exponent      <= in_exp;
			out_man_normalize <= in_man[MAN_WIDTH+3:0];
		end
	end
	else begin
		valid_out <= 1'b0;
	end
end

endmodule
