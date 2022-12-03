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
module fp_mantissa_div(
	clk,
	reset,
	valid_in,
	in_exp,
	in_man,

	out_mantissa,
	out_exponent,
	valid_out
);

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter MAN_WIDTH = 23;
parameter EXP_WIDTH = 8 ;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                 clk     ;
input                 reset   ;
input                 valid_in;
input [EXP_WIDTH-1:0] in_exp  ;
input [  MAN_WIDTH:0] in_man  ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [MAN_WIDTH-1:0] out_mantissa;
output [EXP_WIDTH-1:0] out_exponent;
output                 valid_out   ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                 clk     ;
wire                 reset   ;
wire                 valid_in;
wire [EXP_WIDTH-1:0] in_exp  ;
wire [  MAN_WIDTH:0] in_man  ;

reg [MAN_WIDTH-1:0] out_mantissa;
reg [EXP_WIDTH-1:0] out_exponent;
reg                 valid_out   ;

always @(posedge clk) begin
	if(reset) begin
		out_exponent <= 8'd0;
		out_mantissa <= 23'd0;
		valid_out    <= 1'b0;
	end
	else if (valid_in) begin
		valid_out <= 1'b1;
		if (in_man[23])	begin
			out_mantissa = in_man[22:0];
			out_exponent = in_exp;
		end
		else if (!(|(in_man[23:21])) && in_man[22])begin
			out_mantissa = {in_man[21:0],1'd0};
			out_exponent = in_exp - 8'd1;
		end
		else if (!(|(in_man[23:20])) && in_man[21])begin
			out_mantissa = {in_man[20:0],2'd0};
			out_exponent = in_exp - 8'd2;
		end
		else if(!(|(in_man[23:19])) && in_man[20])begin
			out_mantissa = {in_man[19:0],3'd0};
			out_exponent = in_exp - 8'd3;
		end
		else if(!(|(in_man[23:18])) && in_man[19])begin
			out_mantissa = {in_man[18:0],4'd0};
			out_exponent = in_exp - 8'd4;
		end
		else if(!(|(in_man[23:17])) && in_man[18])begin
			out_mantissa = {in_man[17:0],5'd0};
			out_exponent = in_exp - 8'd5;
		end
		else if(!(|(in_man[23:16])) && in_man[17])begin
			out_mantissa = {in_man[16:0],6'd0};
			out_exponent = in_exp - 8'd6;
		end
		else if(!(|(in_man[23:15])) && in_man[16])begin
			out_mantissa = {in_man[15:0],7'd0};
			out_exponent = in_exp - 8'd7;
		end
		else if(!(|(in_man[23:14])) && in_man[15])begin
			out_mantissa = {in_man[14:0],8'd0};
			out_exponent = in_exp - 8'd8;
		end
		else if(!(|(in_man[23:13])) && in_man[14])begin
			out_mantissa = {in_man[13:0],9'd0};
			out_exponent = in_exp - 8'd9;
		end
		else if(!(|(in_man[23:12])) && in_man[13])begin
			out_mantissa = {in_man[12:0],10'd0};
			out_exponent = in_exp - 8'd10;
		end
		else if(!(|(in_man[23:11])) && in_man[12])begin
			out_mantissa = {in_man[11:0],11'd0};
			out_exponent = in_exp - 8'd11;
		end
		else if(!(|(in_man[23:10])) && in_man[11])begin
			out_mantissa = {in_man[10:0],12'd0};
			out_exponent = in_exp - 8'd12;
		end
		else if(!(|(in_man[23:9])) && in_man[10])begin
			out_mantissa = {in_man[9:0],13'd0};
			out_exponent = in_exp - 8'd13;
		end
		else if(!(|(in_man[23:8])) && in_man[9])begin
			out_mantissa = {in_man[8:0],14'd0};
			out_exponent = in_exp - 8'd14;
		end
		else if(!(|(in_man[23:7])) && in_man[8])begin
			out_mantissa = {in_man[7:0],15'd0};
			out_exponent = in_exp - 8'd15;
		end
		else if(!(|(in_man[23:6])) && in_man[7])begin
			out_mantissa = {in_man[6:0],16'd0};
			out_exponent = in_exp - 8'd16;
		end
		else if(!(|(in_man[23:5])) && in_man[6])begin
			out_mantissa = {in_man[5:0],17'd0};
			out_exponent = in_exp - 8'd17;
		end
		else if(!(|(in_man[23:4])) && in_man[5])begin
			out_mantissa = {in_man[4:0],18'd0};
			out_exponent = in_exp - 8'd18;
		end
		else if(!(|(in_man[23:3])) && in_man[4])begin
			out_mantissa = {in_man[3:0],19'd0};
			out_exponent = in_exp - 8'd19;
		end
		else if(!(|(in_man[23:2])) && in_man[3])begin
			out_mantissa = {in_man[2:0],20'd0};
			out_exponent = in_exp - 8'd20;
		end
		else begin
			out_mantissa = {in_man[1:0],21'd0};
			out_exponent = in_exp - 8'd21;
		end
	end
	else begin
		valid_out <= 1'b0;
	end
end
endmodule
