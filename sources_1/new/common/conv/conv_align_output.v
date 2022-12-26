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

module conv_align_output (
  clk, 
  reset,
  valid_in,
  pxl_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH      = 32;
parameter CHANNEL_NUM_IN  = 64;
parameter CHANNEL_NUM_OUT = 64;
parameter IMAGE_WIDTH     = 12;
parameter IMAGE_SIZE      = 12;
parameter RATE            = 4 ;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk     ;
input                  reset   ;
input                  valid_in;
input [DATA_WIDTH-1:0] pxl_in  ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk     ;
wire                  reset   ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] pxl_in  ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

wire [         DATA_WIDTH-1:0] mem      [(CHANNEL_NUM_OUT*2)-1:0];
wire [(CHANNEL_NUM_OUT*2)-1:0] mem_valid                         ;

assign mem[0]       = pxl_in;
assign mem_valid[0] = valid_in;

function [(CHANNEL_NUM_OUT*2)-1:0] clogb2 (input [(CHANNEL_NUM_OUT*2)-1:0] value);
	begin
		clogb2 = {(CHANNEL_NUM_OUT*2){1'b0}};
		value = value - 1'b1;
		for(integer j = 0; j < (CHANNEL_NUM_OUT*2); j = j + 1) begin
			if (value > 0) begin
				value = value >> 1;
				clogb2 = clogb2 + 1'b1;
			end
		end
	end
endfunction

genvar i;

generate
	for (i = 0; i < (CHANNEL_NUM_OUT*2) - 2; i=i+2) begin
		line_buffer #(
			.IMAGE_WIDTH((((IMAGE_WIDTH * RATE ) + RATE + IMAGE_SIZE) * CHANNEL_NUM_IN) - IMAGE_SIZE + 1),
			.KERNEL     (1                                                                              ),
			.DIN_WIDTH  (DATA_WIDTH                                                                     )
		) line_buffer (
			.clk      (clk           ),
			.reset    (reset         ),
			.valid_in (mem_valid[i]  ),
			.data_in  (mem[i]        ),
			.data_out (mem[i+1]      ),
			.valid_out(mem_valid[i+1])
		);
		// assign mem[i+2]       = mem[clogb2(mem_valid)];
		// assign mem_valid[i+2] = mem_valid[clogb2(mem_valid)];
	end
endgenerate

assign pxl_out   = mem[(CHANNEL_NUM_OUT*2)-1];
assign valid_out = mem_valid[(CHANNEL_NUM_OUT*2)-1];

endmodule