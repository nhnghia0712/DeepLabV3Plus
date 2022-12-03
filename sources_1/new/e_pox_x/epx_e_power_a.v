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
module epx_e_power_a (
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
		case (in)
			32'd0 : begin //0
				out <= 32'b00111111100000000000000000000000;
			end
			32'b00111111100000000000000000000000 : begin  //1
				out <= 32'b01000000001011011111100001010100;
			end
			32'b01000000000000000000000000000000 : begin  //2
				out <= 32'b01000000111011000111001100100110;
			end
			32'b01000000010000000000000000000000 : begin  //3
				out <= 32'b01000001101000001010111100101110;
			end
			32'b01000000100000000000000000000000 : begin  //4
				out <= 32'b01000010010110100110010010000001;
			end
			32'b01000000101000000000000000000000 : begin  //5
				out <= 32'b01000011000101000110100111000101;
			end
			32'b01000000110000000000000000000000 : begin  //6
				out <= 32'b01000011110010011011011011100011;
			end
			32'b01000000111000000000000000000000 : begin  //7
				out <= 32'b01000100100010010001010001000011;
			end
			32'b01000001000000000000000000000000 : begin  //8
				out <= 32'b01000101001110100100111101010100;
			end
			32'b01000001000100000000000000000000 : begin  //9
				out <= 32'b01000101111111010011100010101100;
			end
			32'b01000001001000000000000000000000 : begin  //10
				out <= 32'b01000110101011000001010011101110;
			end
			32'b01000001001100000000000000000000 : begin  //11
				out <= 32'b01000111011010011110001000100100;
			end
			32'b01000001010000000000000000000000 : begin  //12
				out <= 32'b01001000000111101111000010110011;
			end
			32'b01000001010100000000000000000000 : begin  //13
				out <= 32'b01001000110110000000010110101101;
			end
			32'b01000001011000000000000000000000 : begin  //14
				out <= 32'b01001001100100101100110101100010;
			end
			32'b01000001011100000000000000000000 : begin  //15
				out <= 32'b01001010010001111000011001100101;
			end
			32'b01000001100000000000000000000000 : begin  //16
				out <= 32'b01001011000001111001011101011111;
			end
			32'b01000001100010000000000000000000 : begin  //17
				out <= 32'b01001011101110000100100110100100;
			end
			32'b01000001100100000000000000000000 : begin  //18
				out <= 32'b01001100011110100111100100010000;
			end
			32'b01000001100110000000000000000000 : begin  //19
				out <= 32'b01001101001010100011011011001000;
			end
			32'b01000001101000000000000000000000 : begin  //20
				out <= 32'b01001101111001110101100001000100;
			end
			32'b01000001101010000000000000000000 : begin  //21
				out <= 32'b01001110100111010011011100010000;
			end
			32'b01000001101100000000000000000000 : begin  //22
				out <= 32'b01001111010101011010110101101110;
			end
			32'b01000001101110000000000000000000 : begin  //23
				out <= 32'b01010000000100010011010101111010;
			end
			32'b01000001110000000000000000000000 : begin  //24
				out <= 32'b01010000110001010101101111111110;
			end
			32'b01000001110010000000000000000000 : begin  //25
				out <= 32'b01010001100001100001111010011101;
			end
			32'b01000001110100000000000000000000 : begin  //26
				out <= 32'b01010010001101100100100110010011;
			end
			32'b01000001110110000000000000000000 : begin  //27
				out <= 32'b01010010111101111100000100011000;
			end
			32'b01000001111000000000000000000000 : begin  //28
				out <= 32'b01010011101010000101110111010010;
			end
			32'b01000001111010000000000000000000 : begin  //29
				out <= 32'b01010100011001001101010101110010;
			end
			32'b01000001111100000000000000000000 : begin  //30
				out <= 32'b01010101000110111000001000111000;
			end
			32'b01000001111110000000000000000000 : begin  //31
				out <= 32'b01010101110100110101101110110011;
			end
			32'b10111111100000000000000000000000 : begin  //-1
				out <= 32'b00111110101111000101101010110010;
			end
			32'b11000000000000000000000000000000 : begin  //-2
				out <= 32'b00111110000010101001010101010101;
			end
			32'b11000000010000000000000000000000 : begin  //-3
				out <= 32'b00111101010010111110110110000110;
			end
			32'b11000000100000000000000000000000 : begin  //-4
				out <= 32'b00111100100101100000101010101110;
			end
			32'b11000000101000000000000000000000 : begin  //-5
				out <= 32'b00111011110111001100100111111111;
			end
			32'b11000000110000000000000000000000 : begin  //-6
				out <= 32'b00111011001000100111001010010000;
			end
			32'b11000000111000000000000000000000 : begin  //-7
				out <= 32'b00111010011011110000101101011101;
			end
			32'b11000001000000000000000000000000 : begin  //-8
				out <= 32'b00111001101011111110000100001000;
			end
			32'b11000001000100000000000000000000 : begin  //-9
				out <= 32'b00111001000000010110011110010001;
			end
			32'b11000001001000000000000000000000 : begin  //-10
				out <= 32'b00111000001111100110101111001110;
			end
			32'b11000001001100000000000000000000 : begin  //-11
				out <= 32'b00110111100011000001101010100001;
			end
			32'b11000001010000000000000000000000 : begin  //-12
				out <= 32'b00110110110011100010101001100010;
			end
			32'b11000001010100000000000000000000 : begin  //-13
				out <= 32'b00110110000101111011000000101010;
			end
			32'b11000001011000000000000000000000 : begin  //-14
				out <= 32'b00110101010111110011011000111000;
			end
			32'b11000001011100000000000000000000 : begin  //-15
				out <= 32'b00110100101001000011101011100101;
			end
			32'b11000001100000000000000000000000 : begin  //-16
				out <= 32'b00110011111100011010101011011110;
			end
			32'b11000001100010000000000000000000 : begin  //-17
				out <= 32'b00110011001100011100111100011001;
			end
			32'b11000001100100000000000000000000 : begin  //-18
				out <= 32'b00110010100000101101001100010100;
			end
			32'b11000001100110000000000000000000 : begin  //-19
				out <= 32'b00110001110000001000001010111000;
			end
			32'b11000001101000000000000000000000 : begin  //-20
				out <= 32'b00110001000011011010010000110011;
			end
			32'b11000001101010000000000000000000 : begin  //-21
				out <= 32'b00110000010100000110110110000111;
			end
			32'b11000001101100000000000000000000 : begin  //-22
				out <= 32'b00101111100110010101101001000110;
			end
			32'b11000001101110000000000000000000 : begin  //-23
				out <= 32'b00101110111000011010100100111111;
			end
			32'b11000001110000000000000000000000 : begin  //-24
				out <= 32'b00101110001001100000100000111100;
			end
			32'b11000001110010000000000000000000 : begin  //-25
				out <= 32'b00101101011101000101000110111101;
			end
			32'b11000001110100000000000000000000 : begin  //-26
				out <= 32'b00101100101100111100001010010101;
			end
			32'b11000001110110000000000000000000 : begin  //-27
				out <= 32'b00101100000001000100001010010101;
			end
			32'b11000001111000000000000000000000 : begin  //-28
				out <= 32'b00101011010000101001111110000001;
			end
			32'b11000001111010000000000000000000 : begin  //-29
				out <= 32'b00101010100011110011001000010110;
			end
			32'b11000001111100000000000000000000 : begin  //-30
				out <= 32'b00101001110100101011011100000110;
			end
			32'b11000001111110000000000000000000 : begin  //-31
				out <= 32'b00101001000110110000100100001111;
			end
			default : begin
				out <= out;
			end
		endcase
	end
	else begin
		valid_out <= 1'b0;
	end
end

endmodule 