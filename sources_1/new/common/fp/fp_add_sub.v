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

module fp_add_sub(
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
		in_a_next     <= 32'd0;
		valid_in_next <= 1'b0;
	end
	else if(valid_in)begin
		valid_in_next <= 1'b1;
		if (!(|in_a[30:0]) && in_a[31]) begin
			in_a_next <= {!in_a[31],in_a[30:0]};
		end
		else if ( (in_a[31] ^ in_b[31]) && (in_a[30:0] == in_b[30:0]) ) begin
			in_a_next <= 32'd0;
		end
		else begin
			in_a_next <= in_a;;
		end
	end
	else begin
		valid_in_next <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		in_b_next <= 32'd0;
	end
	else if(valid_in)begin
		if (!(|in_b[30:0]) && in_b[31]) begin
			in_b_next <= {!in_b[31],in_b[30:0]};
		end
		else if ( (in_a[31] ^ in_b[31]) && (in_a[30:0] == in_b[30:0]) ) begin
			in_b_next <= 32'd0;
		end
		else begin
			in_b_next <= in_b;
		end
	end
end

reg [DATA_WIDTH-1:0] in_a_tmp;
reg [DATA_WIDTH-1:0] in_b_tmp;

reg valid_in_tmp;

always @(posedge clk) begin
	if(reset) begin
		in_a_tmp     <= 32'd0;
		in_b_tmp     <= 32'd0;
		valid_in_tmp <= 1'b0;
	end
	else if(valid_in_next)begin
		in_a_tmp     <= in_a_next;
		in_b_tmp     <= in_b_next;
		valid_in_tmp <= 1'b1;
	end
	else begin
		valid_in_tmp <= 1'b0;
	end
end

reg [DATA_WIDTH-1:0] in_a_next_tmp;
reg [DATA_WIDTH-1:0] in_b_next_tmp;

reg valid_in_next_tmp;

always @(posedge clk) begin
	if(reset) begin
		in_a_next_tmp     <= 32'd0;
		in_b_next_tmp     <= 32'd0;
		valid_in_next_tmp <= 1'b0;
	end
	else if(valid_in_tmp)begin
		in_a_next_tmp     <= in_a_tmp;
		in_b_next_tmp     <= in_b_tmp;
		valid_in_next_tmp <= valid_in_tmp;
	end
	else begin
		valid_in_next_tmp <= 1'b0;
	end
end

reg [DATA_WIDTH-1:0] in_a_tmp_next;
reg [DATA_WIDTH-1:0] in_b_tmp_next;

reg valid_in_tmp_next;

always @(posedge clk) begin
	if(reset) begin
		in_a_tmp_next     <= 32'd0;
		in_b_tmp_next     <= 32'd0;
		valid_in_tmp_next <= 1'b0;
	end
	else if(valid_in_next_tmp)begin
		in_a_tmp_next     <= in_a_next_tmp;
		in_b_tmp_next     <= in_b_next_tmp;
		valid_in_tmp_next <= valid_in_next_tmp;
	end
	else begin
		valid_in_tmp_next <= 1'b0;
	end
end

/////////////////////////////////////////////////////////////////////////
// Exponent
wire [EXP_WIDTH-1:0] in_exp_a    ;
wire [EXP_WIDTH-1:0] in_exp_b    ;

wire [EXP_WIDTH-1:0] out_exp     ;
wire [EXP_WIDTH-1:0] out_exp_diff;

wire valid_out_exp;

assign in_exp_a = in_a_next[DATA_WIDTH-2:DATA_WIDTH-9];
assign in_exp_b = in_b_next[DATA_WIDTH-2:DATA_WIDTH-9];

fp_exponent_add_sub #(.EXP_WIDTH(EXP_WIDTH)) inst1 (
	.clk         (clk          ),
	.reset       (reset        ),
	.valid_in    (valid_in_next),
	.in_exp_a    (in_exp_a     ),
	.in_exp_b    (in_exp_b     ),
	
	.out_exp     (out_exp      ),
	.out_exp_diff(out_exp_diff ),
	.valid_out   (valid_out_exp)
);

// DFF
reg [EXP_WIDTH-1:0] in_exp_a_next;
reg [EXP_WIDTH-1:0] in_exp_b_next;

always @(posedge clk) begin
	if(reset) begin
		in_exp_a_next <= 8'd0;
		in_exp_b_next <= 8'd0;
	end
	else if(valid_in_next)begin
		in_exp_a_next <= in_exp_a;
		in_exp_b_next <= in_exp_b;
	end
end


wire [EXP_WIDTH-1:0] out_exp_tmp     ;
wire [EXP_WIDTH-1:0] out_exp_next_tmp;
wire [EXP_WIDTH-1:0] out_exp_next    ;

wire valid_out_exp_tmp     ;
wire valid_out_exp_next_tmp;
wire valid_out_exp_next    ;

d_flip_flop #(.DATA_WIDTH(EXP_WIDTH)) dff00 (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_out_exp    ),
	.in       (out_exp          ),
	.out      (out_exp_tmp      ),
	.valid_out(valid_out_exp_tmp)
);

d_flip_flop #(.DATA_WIDTH(EXP_WIDTH)) dff01 (
	.clk      (clk                   ),
	.reset    (reset                 ),
	.valid_in (valid_out_exp_tmp     ),
	.in       (out_exp_tmp           ),
	.out      (out_exp_next_tmp      ),
	.valid_out(valid_out_exp_next_tmp)
);

d_flip_flop #(.DATA_WIDTH(EXP_WIDTH)) dff02 (
	.clk      (clk                   ),
	.reset    (reset                 ),
	.valid_in (valid_out_exp_next_tmp),
	.in       (out_exp_next_tmp      ),
	.out      (out_exp_next          ),
	.valid_out(valid_out_exp_next    )
);

/////////////////////////////////////////////////////////////////////////
// Mantissa
reg [MAN_WIDTH+4:0] in_man_a;
reg [MAN_WIDTH+4:0] in_man_b;

always @(posedge clk) begin
	if(reset) begin
		in_man_a <= {MAN_WIDTH+5{1'b0}};
	end
	else if(valid_in_next)begin
		if(!(|in_a_next))begin
			in_man_a <= {MAN_WIDTH+5{1'b0}};
		end
		else begin
			in_man_a <= {2'b01, in_a_next[DATA_WIDTH-10:0], 3'b000};
		end
	end
end

always @(posedge clk) begin
	if(reset) begin
		in_man_b <= {MAN_WIDTH+5{1'b0}};
	end
	else if(valid_in_next)begin
		if(!(|in_b_next))begin
			in_man_b <= {MAN_WIDTH+5{1'b0}};
		end
		else begin
			in_man_b <= {2'b01, in_b_next[DATA_WIDTH-10:0], 3'b000};
		end
	end
end
wire [MAN_WIDTH+4:0] out_man_a;
wire [MAN_WIDTH+4:0] out_man_b;

wire valid_out_man;

fp_mantissa_add_sub #(
	.EXP_WIDTH(EXP_WIDTH),
	.MAN_WIDTH(MAN_WIDTH)
) inst2 (
	.clk        (clk          ),
	.reset      (reset        ),
	.valid_in   (valid_out_exp),
	.in_exp_a   (in_exp_a_next),
	.in_exp_b   (in_exp_b_next),
	.in_exp_diff(out_exp_diff ),
	.in_man_a   (in_man_a     ),
	.in_man_b   (in_man_b     ),
	
	.out_man_a  (out_man_a    ),
	.out_man_b  (out_man_b    ),
	.valid_out  (valid_out_man)
);

/////////////////////////////////////////////////////////////////////////
// Select mantissa to add or sub
reg [MAN_WIDTH+4:0] out_man_sel_a;
reg [MAN_WIDTH+4:0] out_man_sel_b;

reg valid_out_sel_sub;
reg valid_out_sel_add;

always @(posedge clk)begin
	if(reset) begin
		out_man_sel_a     <= 28'd0;
		out_man_sel_b     <= 28'd0;
		valid_out_sel_sub <= 1'b0;
		valid_out_sel_add <= 1'b0;
	end
	else if(valid_out_man && valid_in_next_tmp)begin
		if(!in_a_next_tmp[31] && in_b_next_tmp[31])begin
			valid_out_sel_sub <= 1'b1;
			valid_out_sel_add <= 1'b0;
			out_man_sel_a     <= out_man_a;
			if(!(|out_man_b)) begin
				out_man_sel_b <= 28'b1000000000000000000000000000;
			end
			else if(!(|out_man_b[2:0]))begin
				out_man_sel_b <= {out_man_b[27], (~(out_man_b[26:3])) + 1'b1, 3'b000};
			end
			else begin
				out_man_sel_b <= {out_man_b[27],(~(out_man_b[26:0]))} + 1'b1;
			end
		end
		else if(in_a_next_tmp[31] && !in_b_next_tmp[31])begin
			valid_out_sel_sub <= 1'b1;
			valid_out_sel_add <= 1'b0;
			out_man_sel_b     <= out_man_b;
			if(!(|out_man_a)) begin
				out_man_sel_a <= 28'b1000000000000000000000000000;
			end
			else if(!(|out_man_b[2:0]))begin
				out_man_sel_a <= {out_man_a[27],(~(out_man_a[26:3])) + 1'b1,3'b000};
			end
			else begin
				out_man_sel_a <= {out_man_a[27],(~(out_man_a[26:0]))} + 1'b1;
			end
		end
		else if (!(in_a_next_tmp[31] ^ in_b_next_tmp[31])) begin
			out_man_sel_a     <= out_man_a;
			out_man_sel_b     <= out_man_b;
			valid_out_sel_add <= 1'b1;
			valid_out_sel_sub <= 1'b0;
		end
	end
	else begin
		valid_out_sel_sub <= 1'b0;
		valid_out_sel_add <= 1'b0;
	end
end

/////////////////////////////////////////////////////////////////////////
// Add both mantissa
wire [MAN_WIDTH+4:0] out_man;

assign out_man = out_man_sel_a + out_man_sel_b;

/////////////////////////////////////////////////////////////////////////
// Normalize mantissa and exponent (sub)
reg                 out_sign_bit_sub;
reg [MAN_WIDTH+3:0] out_man_sub     ;
reg                 valid_out_sub   ;

always @(posedge clk)begin
	if(reset) begin
		out_sign_bit_sub <= 1'b0;
		out_man_sub      <= 28'd0;
		valid_out_sub    <= 1'b0;
	end
	else if(valid_out_sel_sub)begin
		valid_out_sub <= 1'b1;
		if(out_man[MAN_WIDTH+4])begin
			out_sign_bit_sub <= 1'b0;
			out_man_sub      <= {((out_man[26:3]) + 1'b1), out_man[2:0]};
		end
		else if(!out_man[MAN_WIDTH+4] && !(|out_man[2:0]))begin
			out_sign_bit_sub <= 1'b1;
			out_man_sub      <= {((~(out_man[26:3])) + 1'b1), 3'b000};
		end
		else begin
			out_man_sub      <= (~out_man[26:0]) + 1'b1;
			out_sign_bit_sub <= 1'b1;
		end
	end
	else begin
		valid_out_sub <= 1'b0;
	end
end

wire [MAN_WIDTH+3:0] out_man_sub_normalize;

wire [EXP_WIDTH-1:0] out_sub_exponent;

wire out_sign_sub;

wire valid_out_sub_nor;

fp_normalize_sub #(
	.EXP_WIDTH(EXP_WIDTH),
	.MAN_WIDTH(MAN_WIDTH)
) inst3 (
	.clk              (clk                               ),
	.reset            (reset                             ),
	.valid_in         (valid_out_sub & valid_out_exp_next),
	.in_man           (out_man_sub                       ),
	.in_exp           (out_exp_next                      ),
	.in_sign_bit      (out_sign_bit_sub                  ),
	
	.out_man_normalize(out_man_sub_normalize             ),
	.out_exponent     (out_sub_exponent                  ),
	.out_sign         (out_sign_sub                      ),
	.valid_out        (valid_out_sub_nor                 )
);

/////////////////////////////////////////////////////////////////////////
// Normalize mantissa and exponent (add)
reg                 out_sign_bit_add;
reg [MAN_WIDTH+4:0] out_man_add     ;
reg                 valid_out_add   ;

always @(posedge clk)begin
	if(reset) begin
		out_sign_bit_add <= 1'b0;
		out_man_add      <= 28'd0;
		valid_out_add    <= 1'b0;
	end
	else if(valid_out_sel_add && valid_in_tmp_next)begin
		valid_out_add <= 1'b1;
		if(!in_a_tmp_next[31] && !in_b_tmp_next[31]) begin
			out_man_add      <= out_man;
			out_sign_bit_add <= 1'b0;
		end
		else if(in_a_tmp_next[31] && in_b_tmp_next[31]) begin
			out_man_add      <= out_man;
			out_sign_bit_add <= 1'b1;
		end
	end
	else begin
		valid_out_add <= 1'b0;
	end
end

wire [MAN_WIDTH+3:0] out_man_add_normalize;

wire [EXP_WIDTH-1:0] out_add_exponent;

wire out_sign_add;

wire valid_out_add_nor;

fp_normalize_add #(
	.EXP_WIDTH(EXP_WIDTH),
	.MAN_WIDTH(MAN_WIDTH)
) inst5 (
	.clk              (clk                               ),
	.reset            (reset                             ),
	.valid_in         (valid_out_add & valid_out_exp_next),
	.in_man           (out_man_add                       ),
	.in_exp           (out_exp_next                      ),
	.in_sign_bit      (out_sign_bit_add                  ),
	
	.out_man_normalize(out_man_add_normalize             ),
	.out_exponent     (out_add_exponent                  ),
	.out_sign         (out_sign_add                      ),
	.valid_out        (valid_out_add_nor                 )
);

/////////////////////////////////////////////////////////////////////////
// Normalize mantissa and exponent (add)
reg [MAN_WIDTH+3:0] out_man_normalize;

reg [EXP_WIDTH-1:0] out_exponent_next;

reg out_sign_next;

reg valid_out_nor;

always @(posedge clk)begin
	if(reset) begin
		out_exponent_next <= 8'b0;
		out_man_normalize <= 28'd0;
		out_sign_next     <= 1'b0;
		valid_out_nor     <= 1'b0;
	end
	else if(valid_out_sub_nor)begin
		valid_out_nor     <= valid_out_sub_nor;
		out_man_normalize <= out_man_sub_normalize;
		out_exponent_next <= out_sub_exponent;
		out_sign_next     <= out_sign_sub;
	end
	else if(valid_out_add_nor)begin
		valid_out_nor     <= valid_out_add_nor;
		out_man_normalize <= out_man_add_normalize;
		out_exponent_next <= out_add_exponent;
		out_sign_next     <= out_sign_add;
	end
	else begin
		valid_out_nor <= 1'b0;
	end
end

wire [EXP_WIDTH-1:0] out_exponent;

wire valid_out_exponent;

d_flip_flop #(.DATA_WIDTH(EXP_WIDTH)) dff03 (
	.clk      (clk               ),
	.reset    (reset             ),
	.valid_in (valid_out_nor     ),
	.in       (out_exponent_next ),
	.out      (out_exponent      ),
	.valid_out(valid_out_exponent)
);

wire out_sign;

wire valid_out_sign;

d_flip_flop #(.DATA_WIDTH(1)) dff04 (
	.clk      (clk           ),
	.reset    (reset         ),
	.valid_in (valid_out_nor ),
	.in       (out_sign_next ),
	.out      (out_sign      ),
	.valid_out(valid_out_sign)
);

/////////////////////////////////////////////////////////////////////////
// Rounding mantissa
wire [MAN_WIDTH+3:0] out_man_rounding;

wire valid_out_round;

fp_rounding_add_sub #(.MAN_WIDTH(MAN_WIDTH)) inst4 (
	.clk             (clk              ),
	.reset           (reset            ),
	.valid_in        (valid_out_nor    ),
	.in_man_normalize(out_man_normalize),
	
	.out_man_rounding(out_man_rounding ),
	.valid_out       (valid_out_round  )
);

/////////////////////////////////////////////////////////////////////////
// Mantissa	
wire [MAN_WIDTH-1:0] out_mantissa;

assign out_mantissa = out_man_rounding[25:3];		

/////////////////////////////////////////////////////////////////////////
// Output logic
always @(posedge clk)begin
	if(reset) begin
		out       <= 32'd0;
		valid_out <= 1'b0;
	end
	else if(valid_out_round)begin
		out       <= {out_sign,out_exponent,out_mantissa};
		valid_out <= 1'b1;
	end
	else begin
		valid_out <= 1'b0;
	end
end

/////////////////////////////////////////////////////////////////////////

endmodule
