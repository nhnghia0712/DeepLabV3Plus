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

module cnn_upsampling_nn_02 (
  clk, 
  reset,
  valid_in,
  pxl_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
// General
parameter IMAGE_WIDTH  = 64; //Width
parameter IMAGE_HEIGHT = 64; //Height
parameter CHANNEL_NUM  = 7 ; //The number of channel

`include "D:/GitHub/CNNs/CNN_DeepLabV3Plus/CNN_DeepLabV3Plus.srcs/sources_1/new/param/param_def_upsampling_nn.vh"
// KhaiT
// `include "/home/khait/Desktop/zipfile/deep/sources_1/new/param/param_def_upsampling_nn.vh"

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

reg [DATA_WIDTH-1:0] pxl_out_up  ;
reg                  valid_out_up;

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
		pxl_out_up   <= {DATA_WIDTH{1'b0}};
		valid_out_up <= 1'b0;

		cnt_height  <= {CNT_HEIGHT_WIDTH{1'b0}};
		cnt_up_row  <= 3'd0;
		raddr       <= {ADDR_WIDTH{1'b0}};
		cnt_up_col  <= 3'd0;
		cnt_channel <= {CNT_CHANNEL_WIDTH{1'b0}};
	end
	else if ((cnt_channel < CHANNEL_NUM) && (waddr > {ADDR_WIDTH{1'b0}})) begin
		if (cnt_height < IMAGE_HEIGHT) begin
			if (cnt_up_row < 3'd4) begin
				if (raddr < (IMAGE_WIDTH * (1 + cnt_height) + (cnt_channel * IMAGE_SIZE))) begin
					if (cnt_up_col < 3'd4) begin
						pxl_out_up   <= mem[raddr];
						valid_out_up <= 1'b1;
						cnt_up_col   <= cnt_up_col + 1'b1;
					end
					else begin
						valid_out_up <= 1'b0;
						raddr        <= raddr + 1'b1;
						cnt_up_col   <= 3'd0;
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


// Align output
// FIFO
wire [DATA_WIDTH-1:0] pxl_out_fifo_1;
wire                  fifo_full_1   ;
wire                  fifo_empty_1  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_2;
wire                  fifo_full_2   ;
wire                  fifo_empty_2  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_3;
wire                  fifo_full_3   ;
wire                  fifo_empty_3  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_4;
wire                  fifo_full_4   ;
wire                  fifo_empty_4  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_5;
wire                  fifo_full_5   ;
wire                  fifo_empty_5  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_6;
wire                  fifo_full_6   ;
wire                  fifo_empty_6  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_7;
wire                  fifo_full_7   ;
wire                  fifo_empty_7  ;

fifo_generator_1 inst_fifo1 (
	//input
	.clk  (clk           ),
	.srst (reset         ),
	.wr_en(valid_out_up  ),
	.rd_en(fifo_full_7   ),
	.din  (pxl_out_up    ),
	//output
	.dout (pxl_out_fifo_1),
	.full (fifo_full_1   ),
	.empty(fifo_empty_1  )
);

fifo_generator_1 inst_fifo2 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_out_up & fifo_full_1),
	.rd_en(fifo_empty_1              ),
	.din  (pxl_out_up                ),
	//output
	.dout (pxl_out_fifo_2            ),
	.full (fifo_full_2               ),
	.empty(fifo_empty_2              )
);

fifo_generator_1 inst_fifo3 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_out_up & fifo_full_2),
	.rd_en(fifo_empty_2              ),
	.din  (pxl_out_up                ),
	//output
	.dout (pxl_out_fifo_3            ),
	.full (fifo_full_3               ),
	.empty(fifo_empty_3              )
);

fifo_generator_1 inst_fifo4 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_out_up & fifo_full_3),
	.rd_en(fifo_empty_3              ),
	.din  (pxl_out_up                ),
	//output
	.dout (pxl_out_fifo_4            ),
	.full (fifo_full_4               ),
	.empty(fifo_empty_4              )
);

fifo_generator_1 inst_fifo5 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_out_up & fifo_full_4),
	.rd_en(fifo_empty_4              ),
	.din  (pxl_out_up                ),
	//output
	.dout (pxl_out_fifo_5            ),
	.full (fifo_full_5               ),
	.empty(fifo_empty_5              )
);

fifo_generator_1 inst_fifo6 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_out_up & fifo_full_5),
	.rd_en(fifo_empty_5              ),
	.din  (pxl_out_up                ),
	//output
	.dout (pxl_out_fifo_6            ),
	.full (fifo_full_6               ),
	.empty(fifo_empty_6              )
);

fifo_generator_1 inst_fifo7 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_out_up & fifo_full_6),
	.rd_en(fifo_empty_6              ),
	.din  (pxl_out_up                ),
	//output
	.dout (pxl_out_fifo_7            ),
	.full (fifo_full_7               ),
	.empty(fifo_empty_7              )
);

reg fifo_full_7_next ;
reg fifo_empty_1_next;
reg fifo_empty_2_next;
reg fifo_empty_3_next;
reg fifo_empty_4_next;
reg fifo_empty_5_next;
reg fifo_empty_6_next;

always @(posedge clk) begin
	if(reset) begin
		fifo_full_7_next  <= 1'b0;
		fifo_empty_1_next <= 1'b0;
		fifo_empty_2_next <= 1'b0;
		fifo_empty_3_next <= 1'b0;
		fifo_empty_4_next <= 1'b0;
		fifo_empty_5_next <= 1'b0;
		fifo_empty_6_next <= 1'b0;
	end
	else begin
		fifo_full_7_next  <= fifo_full_7;
		fifo_empty_1_next <= fifo_empty_1;
		fifo_empty_2_next <= fifo_empty_2;
		fifo_empty_3_next <= fifo_empty_3;
		fifo_empty_4_next <= fifo_empty_4;
		fifo_empty_5_next <= fifo_empty_5;
		fifo_empty_6_next <= fifo_empty_6;
	end
end

always @(posedge clk) begin
	if(reset) begin
		pxl_out <= 32'd0;
	end
	else begin
		case ({fifo_empty_6_next,fifo_empty_5_next,fifo_empty_4_next,
					fifo_empty_3_next,fifo_empty_2_next,fifo_empty_1_next,fifo_full_7_next})
			7'd1    : pxl_out <= pxl_out_fifo_1;
			7'd3    : pxl_out <= pxl_out_fifo_2;
			7'd7    : pxl_out <= pxl_out_fifo_3;
			7'd15   : pxl_out <= pxl_out_fifo_4;
			7'd31   : pxl_out <= pxl_out_fifo_5;
			7'd63   : pxl_out <= pxl_out_fifo_6;
			7'd126  : pxl_out <= pxl_out_fifo_7;
			default : pxl_out <= pxl_out;
		endcase
	end
end

reg valid_out_tmp;

always @(posedge clk) begin
	if(reset) begin
		valid_out_tmp <= 1'b0;
	end
	else begin
		valid_out_tmp <= (fifo_empty_6 & !fifo_empty_7) | (fifo_empty_5 & !fifo_empty_6) | (fifo_empty_4 & !fifo_empty_5) |
			(fifo_empty_3 & !fifo_empty_4) | (fifo_empty_2 & !fifo_empty_3) | (fifo_empty_1 & !fifo_empty_2) | (fifo_full_7 & !fifo_empty_1);
	end
end

always @(posedge clk) begin
	if(reset) begin
		valid_out <= 1'b0;
	end
	else begin
		valid_out <= valid_out_tmp;
	end
end

endmodule