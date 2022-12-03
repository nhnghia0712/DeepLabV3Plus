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

module fp_normalize_sub(
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
input [MAN_WIDTH+3:0] in_man     ;
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
wire                 clk        ;
wire                 reset      ;
wire                 valid_in   ;
wire [MAN_WIDTH+3:0] in_man     ;
wire [EXP_WIDTH-1:0] in_exp     ;
wire                 in_sign_bit;

reg [MAN_WIDTH+3:0] out_man_normalize;
reg [EXP_WIDTH-1:0] out_exponent     ;
reg                 out_sign         ;
reg                 valid_out        ;

wire [2:0] grs;

assign grs = in_man[2:0];

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
		if(in_man[26])begin
			out_man_normalize <= {in_man[26:3],grs[2:0]};
			out_exponent      <= in_exp;
		end
		else if(!(|(in_man[26])) && in_man[25])begin
			out_man_normalize <= {in_man[25:3],1'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd1;
		end
		else if(!(|(in_man[26:25])) && in_man[24])begin
			out_man_normalize <= {in_man[24:3],2'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd2;
		end
		else if(!(|(in_man[26:24])) && in_man[23])begin
			out_man_normalize <= {in_man[23:3],3'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd3;
		end
		else if(!(|(in_man[26:23])) && in_man[22])begin
			out_man_normalize <= {in_man[22:3],4'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd4;
		end
		else if(!(|(in_man[26:22])) && in_man[21])begin
			out_man_normalize <= {in_man[21:3],5'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd5;
		end
		else if(!(|(in_man[26:21])) && in_man[20])begin
			out_man_normalize <= {in_man[20:3],6'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd6;
		end
		else if(!(|(in_man[26:20])) && in_man[19])begin
			out_man_normalize <= {in_man[19:3],7'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd7;
		end
		else if(!(|(in_man[26:19])) && in_man[18])begin
			out_man_normalize <= {in_man[18:3],8'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd8;
		end
		else if(!(|(in_man[26:18])) && in_man[17] )begin
			out_man_normalize <= {in_man[17:3],9'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd9;
		end
		else if(!(|(in_man[26:17])) && in_man[16] )begin
			out_man_normalize <= {in_man[16:3],10'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd10;
		end
		else if(!(|(in_man[26:16])) && in_man[15] )begin
			out_man_normalize <= {in_man[15:3],11'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd11;
		end
		else if(!(|(in_man[26:15])) && in_man[14] )begin
			out_man_normalize <= {in_man[14:3],12'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd12;
		end
		else if(!(|(in_man[26:14])) && in_man[13] )begin
			out_man_normalize <= {in_man[13:3],13'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd13;
		end
		else if(!(|(in_man[26:13])) && in_man[12] )begin
			out_man_normalize <= {in_man[12:3],14'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd14;
		end
		else if(!(|(in_man[26:12])) && in_man[11] )begin
			out_man_normalize <= {in_man[11:3],15'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd15;
		end
		else if(!(|(in_man[26:11])) && in_man[10] )begin
			out_man_normalize <= {in_man[10:3],16'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd16;
		end
		else if(!(|(in_man[26:10])) && in_man[9] )begin
			out_man_normalize <= {in_man[9:3],17'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd17;
		end
		else if(!(|(in_man[26:9])) && in_man[8] )begin
			out_man_normalize <= {in_man[8:3],18'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd18;
		end
		else if(!(|(in_man[26:8])) && in_man[7] )begin
			out_man_normalize <= {in_man[7:3],19'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd19;
		end
		else if(!(|(in_man[26:7])) && in_man[6] )begin
			out_man_normalize <= {in_man[6:3],20'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd20;
		end
		else if(!(|(in_man[26:6])) && in_man[5] )begin
			out_man_normalize <= {in_man[5:3],21'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd21;
		end
		else if(!(|(in_man[26:5])) && in_man[4] )begin
			out_man_normalize <= {in_man[4:3],22'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd22;
		end
		else if(!(|(in_man[26:4])) && in_man[3] )begin
			out_man_normalize <= {in_man[3],23'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd23;
		end
		else begin
			out_man_normalize <= {24'd0,grs[2:0]};
			out_exponent      <= in_exp - 8'd24;
		end
	end
	else begin
		valid_out <= 1'b0;
	end
end

endmodule
