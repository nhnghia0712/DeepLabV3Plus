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

reg [DATA_WIDTH-1:0] pxl_out  ;
reg                  valid_out;

wire [     DATA_WIDTH-1:0] mem      [CHANNEL_NUM_OUT-1:0];
wire [CHANNEL_NUM_OUT-1:0] mem_valid                     ;

assign mem[0]       = pxl_in;
assign mem_valid[0] = valid_in;

genvar i;

generate
	for (i = 0; i < CHANNEL_NUM_OUT - 1; i= i + 1) begin
		line_buffer #(
			.IMAGE_WIDTH((((IMAGE_WIDTH * RATE ) + RATE + IMAGE_SIZE) * CHANNEL_NUM_IN) - IMAGE_SIZE),
			.KERNEL     (1                                                                          ),
			.DIN_WIDTH  (DATA_WIDTH                                                                 )
		) line_buffer (
			.clk      (clk           ),
			.reset    (reset         ),
			.valid_in (mem_valid[i]  ),
			.data_in  (mem[i]        ),
			.data_out (mem[i+1]      ),
			.valid_out(mem_valid[i+1])
		);
	end
endgenerate

function [CHANNEL_NUM_OUT-1:0] clogb2 (input [CHANNEL_NUM_OUT-1:0] value);
	begin
		clogb2 = {CHANNEL_NUM_OUT{1'b0}};
		value = value - 1'b1;
		for(integer i = 0; i < CHANNEL_NUM_OUT; i = i + 1) begin
			if (value > 0) begin
				value = value >> 1;
				clogb2 = clogb2 + 1'b1;
			end
		end
	end
endfunction

reg enable;

always @ (*) begin
	if (reset) begin
		enable <= 1'b0;
	end
	else if (mem_valid[CHANNEL_NUM_OUT-1]) begin
		enable <= 1'b1;
	end
end

always @(posedge clk) begin
	if (reset) begin
		pxl_out   <= {DATA_WIDTH{1'b0}};
		valid_out <= 1'b0;
	end
	else if (|mem_valid && enable) begin
		pxl_out   <= mem[clogb2(mem_valid)];
		valid_out <= mem_valid[clogb2(mem_valid)];
	end
	else begin
		valid_out <= 1'b0;
	end
end

endmodule