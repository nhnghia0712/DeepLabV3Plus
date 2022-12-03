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

module fp_div(
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
parameter DATA_WIDTH = 32;
parameter EXP_WIDTH  = 8 ;
parameter MAN_WIDTH  = 23;
parameter DELAY      = 1 ;

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
reg [DATA_WIDTH-1:0] in_a_next;
reg [DATA_WIDTH-1:0] in_b_next;

reg valid_in_next;

always @(posedge clk) begin
	if(reset) begin
		in_a_next      <= 32'd0;
		in_b_next      <= 32'd0;
		valid_in_next <= 1'b0;
	end
	else if(valid_in)begin
		in_a_next      <= in_a;
		in_b_next      <= in_b;
		valid_in_next <= 1'b1;
	end
	else begin
		valid_in_next <= 1'b0;
	end
end

wire [DATA_WIDTH-1:0] in_a_temp;
wire [DATA_WIDTH-1:0] in_b_temp;

wire valid_in_temp;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dffa (
	.clk      (clk          ),
	.reset    (reset        ),
	.valid_in (valid_in_next),
	.in       (in_a_next    ),
	.out      (in_a_temp    ),
	.valid_out(valid_in_temp)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dffb (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_in_next    ),
	.in       (in_b_next        ),
	.out      (in_b_temp        ),
	.valid_out(/*valid_in_temp*/)
);

/////////////////////////////////////////////////////////////////////////
// Sign bit
wire sign_bit_in_a;
wire sign_bit_in_b;
wire out_sign_bit ;

assign sign_bit_in_a = in_a_temp[31];
assign sign_bit_in_b = in_b_temp[31];
assign out_sign_bit  = sign_bit_in_a ^ sign_bit_in_b;

/////////////////////////////////////////////////////////////////////////
// Exponent
wire [EXP_WIDTH-1:0]bias ;

assign bias = 8'd127;

wire [EXP_WIDTH-1:0] in_exp_a;
wire [EXP_WIDTH-1:0] in_exp_b;

assign in_exp_a = in_a_next[DATA_WIDTH-2:DATA_WIDTH-9];
assign in_exp_b = in_b_next[DATA_WIDTH-2:DATA_WIDTH-9];

wire [EXP_WIDTH-1:0] out_exp;

assign out_exp = in_exp_a - in_exp_b + bias;

/////////////////////////////////////////////////////////////////////////
// Mantissa
wire [MAN_WIDTH-1:0] in_man_a ;
wire [MAN_WIDTH-1:0] in_man_b ;

assign in_man_a = in_a_next[DATA_WIDTH-10:0];
assign in_man_b = in_b_next[DATA_WIDTH-10:0];

/////////////////////////////////////////////////////////////////////////
wire [(MAN_WIDTH*2):0] out_man_next;

assign out_man_next = ({1'b1,in_man_a,23'd0} / {23'd0,1'b1,in_man_b});

/////////////////////////////////////////////////////////////////////////
wire [MAN_WIDTH:0] out_man;

assign out_man = out_man_next[23:0];

/////////////////////////////////////////////////////////////////////////
wire [MAN_WIDTH-1:0] out_mantissa;

wire [EXP_WIDTH-1:0] out_exponent;

wire valid_out_man;

fp_mantissa_div #(
	.EXP_WIDTH(EXP_WIDTH),
	.MAN_WIDTH(MAN_WIDTH)
) inst2 (
	.clk         (clk          ),
	.reset       (reset        ),
	.valid_in    (valid_in_next),
	.in_exp      (out_exp      ),
	.in_man      (out_man      ),
	
	.out_mantissa(out_mantissa ),
	.out_exponent(out_exponent ),
	.valid_out   (valid_out_man)
);

/////////////////////////////////////////////////////////////////////////
// Output logic
always @(posedge clk)begin
	if(reset) begin
		out       <= 32'd0;
		valid_out <= 1'b0;
	end
	else if(valid_out_man)begin
		if(!(|in_a_temp))begin
			out       <= 32'd0;
			valid_out <= 1'b1;
		end
		else if(!(|in_b_temp))begin
			out       <= 32'hFFFF_FFFF;
			valid_out <= 1'b1;
		end
		else begin
			out       <= {out_sign_bit,out_exponent,out_mantissa};
			valid_out <= 1'b1;
		end
	end
	else begin
		valid_out <= 1'b0;

	end
end

/////////////////////////////////////////////////////////////////////////
endmodule
