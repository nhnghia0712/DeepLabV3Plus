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

module fp_comp(
			reset,
			clk,
			valid_in,
			in_a,
			in_b,
			out,
			valid_out
);
/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter  DATA_WIDTH = 32;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  reset   ;
input                  clk     ;
input                  valid_in;
input [DATA_WIDTH-1:0] in_a    ;
input [DATA_WIDTH-1:0] in_b    ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] out      ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  reset   ;
wire                  clk     ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] in_a    ;
wire [DATA_WIDTH-1:0] in_b    ;

reg [DATA_WIDTH-1:0] out      ;
reg                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Reset
always @(posedge clk) begin
	if(reset) begin
		out       <= 0;
		valid_out <= 1'b0;
	end
	else if (valid_in) begin
		valid_out <= 1'b1;
		if(in_a[DATA_WIDTH-1] > in_b[DATA_WIDTH-1]) begin
			out <= in_b;
		end
		else if(in_a[DATA_WIDTH-1] < in_b[DATA_WIDTH-1]) begin
			out <= in_a;
		end
		else begin
			if (in_a[DATA_WIDTH-2:DATA_WIDTH-9] > in_b[DATA_WIDTH-1:DATA_WIDTH-9]) begin
				out <= in_a;
			end
			else if (in_a[DATA_WIDTH-2:DATA_WIDTH-9] < in_b[DATA_WIDTH-1:DATA_WIDTH-9]) begin
				out <= in_b;
			end
			else begin
				if (in_a[DATA_WIDTH-10:0] > in_b[DATA_WIDTH-10:0]) begin
					out <= in_a;
				end
				else if (in_a[DATA_WIDTH-10:0] < in_b[DATA_WIDTH-10:0]) begin
					out <= in_b;
				end
				else begin
					out <= in_a;
				end
			end
		end
	end
	else begin
		valid_out <= 1'b0;
	end
end
/////////////////////////////////////////////////////////////////////////

endmodule
