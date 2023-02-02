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

module conv_1x1_top_11 (
  clk, 
  reset,
  valid_in,
  pxl_in,
  valid_weight_in,
  weight_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
// General
parameter IMAGE_WIDTH     = 64 ; //Width
parameter IMAGE_HEIGHT    = 64 ; //Height
parameter CHANNEL_NUM_IN  = 256; //The number of channel in
parameter CHANNEL_NUM_OUT = 256; //The number of channel out
parameter KERNEL          = 1  ; //Kernel width

`include "D:/GitHub/CNNs/CNN_DeepLabV3Plus/CNN_DeepLabV3Plus.srcs/sources_1/new/param/param_def_conv_1x1.vh"
// KhaiT
// `include "/home/khait/Desktop/zipfile/deep/sources_1/new/param/param_def_conv_1x1.vh"

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk            ;
input                  reset          ;
input                  valid_in       ;
input [DATA_WIDTH-1:0] pxl_in         ;
input                  valid_weight_in;
input [DATA_WIDTH-1:0] weight_in      ;

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
wire                  valid_weight_in;
wire [DATA_WIDTH-1:0] weight_in      ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

// Buffer 3x3
wire [DATA_WIDTH-1:0] out_buffer;

wire valid_out_buffer;

conv_1x1_buffer #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.IMAGE_SIZE      (IMAGE_SIZE      ),
	.CNT_WIDTH_BUFFER(CNT_WIDTH_BUFFER),
	.IMAGE_WIDTH     (IMAGE_WIDTH     )
) inst_buffer (
	//input
	.clk         (clk             ),
	.reset       (reset           ),
	.valid_in    (valid_in        ),
	.in          (pxl_in          ),
	
	.out_buffer  (out_buffer      ),
	.valid_out   (valid_out_buffer),
	.load_weights(load_weights    ),
	.stride2     (1'b0            )
);
// Buffer 3x3 Weights
//weights
wire [DATA_WIDTH-1:0] out_buffer_weight;

wire valid_out_buffer_weight;

conv_1x1_buffer_weights_11 #(.DATA_WIDTH(DATA_WIDTH)) inst_buffer_weights (
	//input
	.clk              (clk                    ),
	.reset            (reset                  ),
	.valid_in         (valid_weight_in        ),
	.in               (weight_in              ),
	.load_weights     (load_weights           ),
	
	.out_buffer_weight(out_buffer_weight      ),
	.valid_out        (valid_out_buffer_weight)
);

//Core
// fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_core (
// 	.reset    (reset                                     ),
// 	.clk      (clk                                       ),
// 	.valid_in (valid_out_buffer & valid_out_buffer_weight),
// 	.in_a     (out_buffer                                ),
// 	.in_b     (out_buffer_weight                         ),
// 	.out      (pxl_out                                   ),
// 	.valid_out(valid_out                                 )
// );

floating_point_2_mul inst_core (
	.aresetn             (~reset                 ),
	.aclk                (clk                    ),
	.s_axis_a_tvalid     (valid_out_buffer       ),
	.s_axis_a_tdata      (out_buffer             ),
	.s_axis_b_tvalid     (valid_out_buffer_weight),
	.s_axis_b_tdata      (out_buffer_weight      ),
	.m_axis_result_tdata (pxl_out                ),
	.m_axis_result_tvalid(valid_out              )
);

endmodule