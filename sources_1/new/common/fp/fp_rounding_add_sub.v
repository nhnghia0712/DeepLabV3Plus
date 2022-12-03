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

module fp_rounding_add_sub(
	clk,
	reset,
	valid_in,
	in_man_normalize,

	out_man_rounding,
	valid_out
);

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter MAN_WIDTH = 23;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                 clk             ;
input                 reset           ;
input                 valid_in        ;
input [MAN_WIDTH+3:0] in_man_normalize;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [MAN_WIDTH+3:0] out_man_rounding;
output                 valid_out       ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                 clk             ;
wire                 reset           ;
wire                 valid_in        ;
wire [MAN_WIDTH+3:0] in_man_normalize;

reg [MAN_WIDTH+3:0] out_man_rounding;
reg                 valid_out       ;

always @(posedge clk) begin
	if(reset) begin
		out_man_rounding <= 27'd0;
		valid_out        <= 1'b0;
	end
	else if (valid_in) begin
		if ( (&in_man_normalize[2:1] && !in_man_normalize[0]) || &in_man_normalize[2:0])begin
			out_man_rounding <= in_man_normalize + 1'b1;
			valid_out        <= 1'b1;
		end
		else begin
			out_man_rounding <= in_man_normalize;
			valid_out        <= 1'b01;
		end
	end
	else begin
		valid_out <= 1'b0;
	end
end

endmodule