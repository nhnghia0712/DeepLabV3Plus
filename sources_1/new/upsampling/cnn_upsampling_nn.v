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

module cnn_upsampling_nn (
  clk, 
  reset,
  valid_in,
  pxl_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
`include "D:/GitHub/CNNs/projectCNNs/projectCNNs.srcs/sources_1/new/param/param_def_upsampling_nn.v"

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk            ;
input                  reset          ;
input                  valid_in       ;
input [DATA_WIDTH-1:0] pxl_in         ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk            ;
wire                  reset          ;
wire                  valid_in       ;
wire [DATA_WIDTH-1:0] pxl_in         ;

reg [DATA_WIDTH-1:0] pxl_out  ;
reg                  valid_out;

// Mem
reg [DATA_WIDTH-1:0] mem [CHANNEL_NUM_PIXEL-1:0];

// Write
reg [ADDR_WIDTH-1:0] waddr;

always @(posedge clk) begin
	if(reset) begin
		waddr <= {ADDR_WIDTH{1'b0}};
	end
	else if (valid_in) begin
		mem[waddr] <= pxl_in;
		waddr      <= waddr + 1'b1;
	end
end

// Read
reg [ CNT_HEIGHT_WIDTH-1:0] cnt_height ;
reg [                  2:0] cnt_up_row ;
reg [      ADDR_WIDTH-1:0] raddr      ;
reg [                  2:0] cnt_up_col ;
reg [CNT_CHANNEL_WIDTH-1:0] cnt_channel;

always @(posedge clk) begin
	if(reset) begin
		pxl_out   <= {DATA_WIDTH{1'b0}};
		valid_out <= 1'b0;

		cnt_height  <= {CNT_HEIGHT_WIDTH{1'b0}};
		cnt_up_row  <= 3'd0;
		raddr       <= {ADDR_WIDTH{1'b0}};
		cnt_up_col  <= 3'd0;
		cnt_channel <= {CNT_CHANNEL_WIDTH{1'b0}};
	end
	else if ((cnt_channel < CHANNEL_NUM) && (waddr > {ADDR_WIDTH{1'b0}})) begin
		if (cnt_height < IMAGE_HEIGHT) begin
			if (cnt_up_row < 3'd4) begin
				if (raddr < IMAGE_WIDTH * (1 + cnt_height) + (cnt_channel * IMAGE_SIZE)) begin
					if (cnt_up_col < 3'd4) begin
						pxl_out    <= mem[raddr];
						valid_out  <= 1'b1;
						cnt_up_col <= cnt_up_col + 1'b1;
					end
					else begin
						valid_out  <= 1'b0;
						raddr      <= raddr + 1'b1;
						cnt_up_col <= 3'd0;
					end
				end
				else begin
					cnt_up_row <= cnt_up_row + 1'b1;
					raddr      <= (IMAGE_WIDTH * cnt_height) + (cnt_channel * IMAGE_SIZE);
				end
			end
			else begin
				cnt_height <= cnt_height + 1'b1;
				cnt_up_row <= 3'd0;
				raddr      <= (IMAGE_WIDTH *  (cnt_height + 1)) + (cnt_channel * IMAGE_SIZE);
			end
		end
		else begin
			cnt_channel <= cnt_channel + 1'b1;
			cnt_height  <= {CNT_HEIGHT_WIDTH{1'b0}};
			cnt_up_row  <= 3'd0;
			raddr       <= (cnt_channel + 1) * IMAGE_SIZE;
			cnt_up_col  <= 3'd0;
		end
	end
end

endmodule