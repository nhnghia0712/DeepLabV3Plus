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
module epx_rom(
   clk,
   reset,
   addr,
   data
);
/////////////////////////////////////////////////////////////////////////
// Parameter Declarations

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input       clk    ;
input       reset  ;
input [5:0] addr   ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output   [31:0] data;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire       clk    ;
wire       reset  ;
wire [5:0] addr   ;

reg   [31:0] data;

always@(posedge clk) begin
	if (reset) begin
		data <= 'd0;
	end
	else begin
		case (addr)
			// 'd0     : data <= 'h0;
			// 'd1     : data <= 'h3f800000; //1/1!
			'd0     : data <= 'h3f000000; //1/2!
			'd1     : data <= 'h3e2aaaab; //1/3!
			'd2     : data <= 'h3d2aaaab; //1/4!
			'd3     : data <= 'h3c088889; //1/5!
			'd4     : data <= 'h3ab60b61; //1/6!
			'd5     : data <= 'h39500d00; //1/7!
			'd6     : data <= 'h37d00cfd; //1/8!
			'd7     : data <= 'h3638ef15; //1/9!
			'd8    : data <= 'h3493f27e; //1/10!
			'd9    : data <= 'h32d7322b; //1/11!
			'd10    : data <= 'h310f76c8; //1/12!
			'd11    : data <= 'h2f309231; //1/13!
			'd12    : data <= 'h2d49cba6; //1/14!
			'd13    : data <= 'h2b573f9f; //1/15!
			'd14    : data <= 'h29573f9f; //1/16!
			'd15    : data <= 'h274a963c; //1/17!
			'd16    : data <= 'h253413c3; //1/18!
			'd17    : data <= 'h2317a4da; //1/19!
			'd18    : data <= 'h20f2a15d; //1/20!
			'd19    : data <= 'h1eb8dc78; //1/21!
			'd20    : data <= 'h1c8671cb; //1/22!
			'd21    : data <= 'h1a3b0da1; //1/23!
			'd22    : data <= 'h17f96781; //1/24!
			'd23    : data <= 'h159f9e67; //1/25!
			'd24    : data <= 'h13447430; //1/26!
			'd25    : data <= 'h10e8d58e; //1/27!
			'd26    : data <= 'h0e850c51; //1/28!
			'd27    : data <= 'h0c12cfcc; //1/29!
			'd28    : data <= 'h099c9962; //1/30!
			'd29    : data <= 'h0721a697; //1/31!
			'd30    : data <= 'h04a1a697; //1/32!
			'd31    : data <= 'h021cc093; //1/33!
			'd32    : data <= 'h0024e204; //1/34!
			'd33    : data <= 'h00010dc6; //1/35!
			'd34    : data <= 'h0000077e; //1/36!
			'd35    : data <= 'h00000034; //1/37!
			'd36    : data <= 'h00000001; //1/38!
			default : data <= 'h0;
		endcase
	end
end

endmodule
