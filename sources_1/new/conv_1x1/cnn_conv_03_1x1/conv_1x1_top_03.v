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

module conv_1x1_top_03 (
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
parameter IMAGE_WIDTH     = 16 ; //Width
parameter IMAGE_HEIGHT    = 16 ; //Height
parameter CHANNEL_NUM_IN  = 256; //The number of channel in
parameter CHANNEL_NUM_OUT = 512; //The number of channel out
parameter KERNEL          = 1  ; //Kernel width

`include "D:/GitHub/CNNs/CNN_DeepLabV3Plus/CNN_DeepLabV3Plus.srcs/sources_1/new/param/param_def_conv_1x1.vh"

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
	.stride2     (1'b0            ),
	
	.out_buffer  (out_buffer      ),
	.valid_out   (valid_out_buffer),
	.load_weights(load_weights    )
);
// Buffer 3x3 Weights
//weights
wire [DATA_WIDTH-1:0] out_buffer_weight;

wire valid_out_buffer_weight;

conv_1x1_buffer_weights_03 #(
	.DATA_WIDTH                  (DATA_WIDTH                  ),
	.WEIGHT_NUM                  (WEIGHT_NUM                  ),
	.POINTER_WIDTH_BUFFER_WEIGHTS(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_buffer_weights (
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
fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_core (
	.reset    (reset                                     ),
	.clk      (clk                                       ),
	.valid_in (valid_out_buffer & valid_out_buffer_weight),
	.in_a     (out_buffer                                ),
	.in_b     (out_buffer_weight                         ),
	.out      (pxl_out                                   ),
	.valid_out(valid_out                                 )
);

endmodule