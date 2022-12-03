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
module epx_convert (
	clk
	,reset
	,valid_in
	,in 
	,out
	,valid_out
	
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

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk     ;
wire                  reset   ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] in      ;

reg [DATA_WIDTH-1:0] out      ;
reg                  valid_out;

always @ (posedge clk) begin
	if (reset) begin
		out       <= 32'd0;
		valid_out <= 1'b0;
	end
	else if (valid_in) begin
		valid_out <= 1'b1;
		if (in[30:23] < 8'd127) begin
			out <= 32'b00000000000000000000000000000000;    //0
		end
		else if (!in[30] && (&in[29:23])) begin
			out <= 32'b00111111100000000000000000000000;    //1
		end
		else if (in[30] && !(|in[29:23])) begin //2-3
			if (!in[22]) begin
				out = 32'd1073741824; //2
			end
			else if (in[22]) begin
				out <= 32'b01000000010000000000000000000000; //3
			end
			else begin
				out <= 32'd0;
			end
		end
		else if (in[30] && !(|in[29:24]) && in[23]) begin //4-7
			if (!(|(in[22:21]))) begin
				out <= 32'b01000000100000000000000000000000;   //4
			end
			else if (!in[22] && in[21]) begin
				out <= 32'b01000000101000000000000000000000;	//5
			end
			else if (in[22] && !in[21]) begin
				out <= 32'b01000000110000000000000000000000;   //6
			end
			else if (in[22] && in[21]) begin
				out <= 32'b01000000111000000000000000000000;   //7
			end
			else begin
				out <= 32'd0;
			end
		end
		else if (in[30] && !(|in[29:25]) && in[24] && !in[23]) begin //8-15
			if (!(|(in[22:20]))) begin
				out <= 32'b01000001000000000000000000000000;   //8
			end
			else if (!(|in[22:21]) && in[20]) begin
				out <= 32'b01000001000100000000000000000000;	//9
			end
			else if (!in[22] && in[21] && !in[20]) begin
				out <= 32'b01000001001000000000000000000000;	//10
			end
			else if (!in[22] && (&in[21:20])) begin
				out <= 32'b01000001001100000000000000000000;	//11
			end
			else if (in[22] && !(|in[21:20])) begin
				out <= 32'b01000001010000000000000000000000;	//12
			end
			else if (in[22] && !in[21] && in[20]) begin
				out <= 32'b01000001010100000000000000000000;	//13
			end
			else if (&in[22:21] && !in[20]) begin
				out <= 32'b01000001011000000000000000000000;	//14
			end
			else if (&in[22:20]) begin
				out <= 32'b01000001011100000000000000000000;	//15
			end
			else begin
				out <= 32'd0;
			end
		end
		else if (in[30] && !(|in[29:25]) && (&in[24:23])) begin //8-15
			if (!(|(in[22:19]))) begin
				out <= 32'b01000001100000000000000000000000;   //16
			end
			else if (!(|(in[22:20])) && in[19]) begin
				out <= 32'b01000001100010000000000000000000;	//17
			end
			else if (!(|in[22:21]) && in[20]  && !in[19]) begin
				out <= 32'b01000001100100000000000000000000;	//18
			end
			else if (!(|in[22:21]) && (&in[20:19])) begin
				out <= 32'b01000001100110000000000000000000;	//19
			end
			else if (!in[22] && in[21]  && !(|in[20:19])) begin
				out <= 32'b01000001101000000000000000000000;	//20
			end
			else if (!in[22] && in[21] && !in[20] && in[19]) begin
				out <= 32'b01000001101010000000000000000000;	//21
			end
			else if (!in[22] && (&in[21:20]) && !in[19]) begin
				out <= 32'b01000001101100000000000000000000;	//22
			end
			else if (!in[22] && (&in[21:19])) begin
				out <= 32'b01000001101110000000000000000000;	//23
			end
			else if (in[22] && !(|in[21:19])) begin
				out <= 32'b01000001110000000000000000000000;   //24
			end
			else if (in[22] && !(|in[21:20]) && in[19]) begin
				out <= 32'b01000001110010000000000000000000;   //25
			end
			else if (in[22] && !in[21] && in[20] && !in[19]) begin
				out <= 32'b01000001110100000000000000000000;   //26
			end
			else if (in[22] && !in[21]  && (&in[20:19])) begin
				out <= 32'b01000001110110000000000000000000;   //27
			end
			else if ((&in[22:21]) && !(|in[20:19])) begin
				out <= 32'b01000001111000000000000000000000;   //28
			end
			else if ((&in[22:21]) && !in[20]  && in[19]) begin
				out <= 32'b01000001111010000000000000000000;   //29
			end
			else if ((&(in[22:20])) && !in[19]) begin
				out <= 32'b01000001111100000000000000000000;   //30
			end
			else if (&in[22:19]) begin
				out <= 32'b01000001111110000000000000000000;   //31
			end
			else begin
				out <= 32'd0;
			end
		end
		else begin
			out <= 32'd0;
		end
	end
	else begin
		valid_out <= 1'b0;
	end
end

endmodule 