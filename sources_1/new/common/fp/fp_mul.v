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

module fp_mul(
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
localparam EXP_WIDTH  = 8 ;
localparam MAN_WIDTH  = 23;
localparam DELAY      = 1 ;

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
		in_a_next     <= {DATA_WIDTH{1'b0}};
		in_b_next     <= {DATA_WIDTH{1'b0}};
		valid_in_next <= 1'b0;
	end
	else if(valid_in)begin
		in_a_next     <= in_a;
		in_b_next     <= in_b;
		valid_in_next <= 1'b1;
	end
	else begin
		valid_in_next <= 1'b0;
	end
end

/////////////////////////////////////////////////////////////////////////
// Sign bit
wire sign_bit_in_a;
wire sign_bit_in_b;

assign sign_bit_in_a = in_a_next[31];
assign sign_bit_in_b = in_b_next[31];

/////////////////////////////////////////////////////////////////////////
reg out_sign_bit      ;
reg valid_out_sign_bit;

always @(posedge clk) begin
	if(reset) begin
		out_sign_bit       <= 1'b0;
		valid_out_sign_bit <= 1'b0;
	end
	else if (valid_in_next) begin
		valid_out_sign_bit <= 1'b1;
		if(!(|in_a_next) || !(|in_b_next)) begin
			out_sign_bit <= 1'b0;
		end
		else begin
			out_sign_bit <= sign_bit_in_a ^ sign_bit_in_b;
		end
	end
	else begin
		valid_out_sign_bit <= 1'b0;
	end
end

/////////////////////////////////////////////////////////////////////////
// Exponent
wire [EXP_WIDTH-1:0]bias ;

assign bias = 8'd127;

wire [EXP_WIDTH-1:0] in_exp_a;
wire [EXP_WIDTH-1:0] in_exp_b;

assign in_exp_a = in_a_next[DATA_WIDTH-2:DATA_WIDTH-9];
assign in_exp_b = in_b_next[DATA_WIDTH-2:DATA_WIDTH-9];


/////////////////////////////////////////////////////////////////////////
reg [EXP_WIDTH-1:0] out_exp     ;
// reg                 valid_out_exp;

always @(posedge clk) begin
	if(reset) begin
		out_exp       <= {EXP_WIDTH{1'b0}};
		// valid_out_exp <= 1'b0;
	end
	else if (valid_in_next) begin
		// valid_out_exp <= 1'b1;
		if(!(|in_a_next) || !(|in_b_next)) begin
			out_exp <= {EXP_WIDTH{1'b0}};
		end
		else begin
			out_exp <= in_exp_a + in_exp_b - bias;
		end
	end
	// else begin
	// 	valid_out_exp <= 1'b0;
	// end
end

/////////////////////////////////////////////////////////////////////////
// Mantissa
wire [MAN_WIDTH-1:0] in_man_a ;
wire [MAN_WIDTH-1:0] in_man_b ;

assign in_man_a = in_a_next[DATA_WIDTH-10:0];
assign in_man_b = in_b_next[DATA_WIDTH-10:0];

/////////////////////////////////////////////////////////////////////////
reg [(MAN_WIDTH*2)+1:0] out_man  ;
// reg                     valid_man;

always @(posedge clk) begin
	if(reset) begin
		out_man <= {(MAN_WIDTH*2)+2{1'b0}};
		// valid_man <= 1'b0;
	end
	else if (valid_in_next) begin
		// valid_man <= 1'b1;
		if(!(|in_a_next) || !(|in_b_next)) begin
			out_man <= {(MAN_WIDTH*2)+2{1'b0}};
		end
		else begin
			out_man <= ({1'b1,in_man_a} * {1'b1,in_man_b});
		end
	end
	// else begin
	// 	valid_man <= 1'b0;
	// end
end

/////////////////////////////////////////////////////////////////////////
wire [MAN_WIDTH-1:0] out_mantissa;

wire [EXP_WIDTH-1:0] out_exponent;

wire out_sign;

wire valid_out_man;

fp_mantissa_mul #(
	.EXP_WIDTH(EXP_WIDTH),
	.MAN_WIDTH(MAN_WIDTH)
) inst2 (
	.clk         (clk                                               ),
	.reset       (reset                                             ),
	.valid_in    (/*valid_man & valid_out_exp &*/ valid_out_sign_bit),
	.in_exp      (out_exp                                           ),
	.in_man      (out_man[47:23]                                    ),
	.in_sign_bit (out_sign_bit                                      ),
	
	.out_mantissa(out_mantissa                                      ),
	.out_exponent(out_exponent                                      ),
	.out_sign    (out_sign                                          ),
	.valid_out   (valid_out_man                                     )
);

/////////////////////////////////////////////////////////////////////////
// Output logic
always @(posedge clk)begin
	if(reset) begin
		out       <= {DATA_WIDTH{1'b0}};
		valid_out <= 1'b0;
	end
	else if(valid_out_man)begin
		out       <= {out_sign,out_exponent,out_mantissa};
		valid_out <= 1'b1;
	end
	else begin
		valid_out <= 1'b0;
	end
end

/////////////////////////////////////////////////////////////////////////

endmodule
