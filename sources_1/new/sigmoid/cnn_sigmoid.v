`timescale 1ns/1ps
`define f2r(z) ({z[31], z[30], {3{~z[30]}}, z[29:23], z[22:0], {29{1'b0}}})
`define r2f(z) ({z[63], z[62], z[58:52], z[51:29]})
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
module cnn_sigmoid (
	clk
	,reset
	,valid_in
	,in 
	,out
	,valid_out
	,done
);
/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk     ;
input                  reset   ;
input                  valid_in;
input [DATA_WIDTH-1:0] in      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] out      ;
output                  valid_out;
output                  done     ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk     ;
wire                  reset   ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] in      ;

wire [DATA_WIDTH-1:0] out      ;
reg                   valid_out;
reg                   done     ;

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] neg_x;

reg state1;
reg state2;
reg state3;

reg [63:0] float2real;
reg [63:0] percent   ;

real e_pox_x;
real under  ;

assign neg_x = {!in[31],in[30:0]};

always @ (posedge clk or posedge reset)begin
	if (reset)begin
		float2real <= 64'd0;
		state1     <= 1'b0;
	end
	else if(valid_in)begin
		float2real <= `f2r(neg_x);
		state1     <= valid_in;
	end
	else begin
		float2real <= float2real;
		state1     <= 1'b0;
	end
end

always @ (posedge clk or posedge reset)begin
	if (reset)begin
		e_pox_x <= 0;
		state2  <= 1'b0;
	end
	else if(state1 == 1'b1)begin
		e_pox_x  <= 2.71828182846**$bitstoreal(float2real);
		state2   <= state1;
	end
	else begin
		e_pox_x <= e_pox_x;
		state2  <= 1'b0;
	end
end

always @ (posedge clk or posedge reset)begin
	if (reset)begin
		under  <= 0;
		state3 <= 1'b0;
	end
	else if(state2)begin
		under  <= 1 + e_pox_x;
		state3 <= state2;
	end
	else begin
		under  <= under;
		state3 <= 1'b0;
	end
end

always @ (posedge clk or posedge reset)begin
	if (reset)begin
		percent   <= 64'd0;
		valid_out <= 1'b0;
	end
	else if(state3)begin
		percent   <= $realtobits(1/under);
		valid_out <= state3;
	end
	else begin
		percent   <= percent;
		valid_out <= 1'b0;
	end
end

assign out = `r2f(percent);

always @(posedge clk) begin
	if(reset) begin
		done <= 1'b0;
	end
	else if (valid_out && !state3)begin
		done <= 1'b1;
	end
	else begin
		done <= 1'b0;
	end
end

endmodule