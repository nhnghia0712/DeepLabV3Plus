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

module cnn_conv_3x3_64_64128s2 (
  clk, 
  reset,
  stride2,
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
parameter IMAGE_WIDTH     = 128; //Width
parameter IMAGE_HEIGHT    = 128; //Height
parameter CHANNEL_NUM_IN  = 64 ; //The number of channel in
parameter CHANNEL_NUM_OUT = 64 ; //The number of channel out
parameter KERNEL          = 3  ; //Kernel width
parameter RATE            = 1  ; //Rate of dialtion

`include "D:/GitHub/CNNs/CNN_DeepLabV3Plus/CNN_DeepLabV3Plus.srcs/sources_1/new/param/param_def_conv_3x3_dilation_new.vh"

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk            ;
input                  reset          ;
input                  stride2        ;
input                  valid_in       ;
input [DATA_WIDTH-1:0] pxl_in         ;
input                  valid_weight_in;
input [DATA_WIDTH-1:0] weight_in      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out         ;
output                  valid_out       ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk            ;
wire                  reset          ;
wire                  stride2        ;
wire                  valid_in       ;
wire [DATA_WIDTH-1:0] pxl_in         ;
wire                  valid_weight_in;
wire [DATA_WIDTH-1:0] weight_in      ;

wire [DATA_WIDTH-1:0] pxl_out         ;
wire                  valid_out       ;

// Read loop data
wire [DATA_WIDTH-1:0] loop_data_out      ;
wire                  valid_loop_data_out;

conv_loop_data_in_new #(
	.DATA_WIDTH          (DATA_WIDTH          ),
	.CHANNEL_NUM_IN      (CHANNEL_NUM_IN      ),
	.CHANNEL_NUM_OUT     (CHANNEL_NUM_OUT     ),
	.IMAGE_WIDTH         (IMAGE_WIDTH         ),
	.CHANNEL_NUM_IN_PIXEL(CHANNEL_NUM_IN_PIXEL),
	.IMAGE_SIZE          (IMAGE_SIZE          ),
	.LOOP_CHANNEL_IN_CNT (LOOP_CHANNEL_IN_CNT ),
	.LOOP_COL_CNT        (LOOP_COL_CNT        ),
	.RATE                (RATE                )
) inst_loop (
	//input
	.clk      (clk                ),
	.reset    (reset              ),
	.valid_in (valid_in           ),
	.pxl_in   (pxl_in             ),
	//output
	.pxl_out  (loop_data_out      ),
	.valid_out(valid_loop_data_out)
);

// Conv
wire [DATA_WIDTH-1:0] pxl_out_conv  ;
wire                  valid_out_conv;

conv_3x3_dilation_top_new #(
	.DATA_WIDTH                  (DATA_WIDTH                  ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH                 ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT                ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN              ),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT             ),
	.KERNEL                      (KERNEL                      ),
	.IMAGE_SIZE                  (IMAGE_SIZE                  ),
	.RATE                        (RATE                        ),
	.CNT_WIDTH_BUFFER            (CNT_WIDTH_BUFFER            ),
	.POINTER_WIDTH_BUFFER_WEIGHTS(POINTER_WIDTH_BUFFER_WEIGHTS),
	.CNT_WIDTH_BUFFER_WEIGHTS    (CNT_WIDTH_BUFFER_WEIGHTS    )
) inst_conv (
	//input
	.clk            (clk                ),
	.reset          (reset              ),
	.stride2        (stride2            ),
	.valid_in       (valid_loop_data_out),
	.pxl_in         (loop_data_out      ),
	.valid_weight_in(valid_weight_in    ),
	.weight_in      (weight_in          ),
	//output
	.pxl_out        (pxl_out_conv       ),
	.valid_out      (valid_out_conv     )
);

// Align stride2 output
wire [DATA_WIDTH-1:0] align_stride2_out      ;
wire                  valid_align_stride2_out;

conv_align_stride2_output #(
  .DATA_WIDTH (DATA_WIDTH ),
  .IMAGE_WIDTH(IMAGE_WIDTH)
) inst_aligns2 (
  //input
  .clk      (clk                    ),
  .reset    (reset                  ),
  .stride2  (stride2                ),
  .valid_in (valid_out_conv         ),
  .pxl_in   (pxl_out_conv           ),
  //output
  .pxl_out  (align_stride2_out      ),
  .valid_out(valid_align_stride2_out)
);

// Add
wire [DATA_WIDTH-1:0] adder_out      ;
wire                  valid_adder_out;

conv_64channel_adder_new #(
	.DATA_WIDTH             (DATA_WIDTH             ),
	.CHANNEL_NUM_IN         (CHANNEL_NUM_IN         ),
	.IMAGE_SIZE             (IMAGE_SIZE             ),
	.IMAGE_WIDTH            (IMAGE_WIDTH            ),
	.CHANNEL_NUM            (CHANNEL_NUM            ),
	.ADD_CHANNEL_IN_CNT     (ADD_CHANNEL_IN_CNT     ),
	.ADD_TEMP_CHANNEL_IN_CNT(ADD_TEMP_CHANNEL_IN_CNT),
	.RATE                   (RATE                   )
) inst_add (
	//input
	.clk      (clk                    ),
	.reset    (reset                  ),
	.valid_in (valid_align_stride2_out),
	.pxl_in   (align_stride2_out      ),
	//output
	.pxl_out  (adder_out              ),
	.valid_out(valid_adder_out        )
);

// Align output
parameter SHIFT_WIDTH = (((IMAGE_WIDTH * RATE ) + RATE + IMAGE_SIZE) * CHANNEL_NUM_IN) - IMAGE_SIZE/4;

conv_align_output #(
	.DATA_WIDTH     (DATA_WIDTH     ),
	.CHANNEL_NUM_IN (CHANNEL_NUM_IN ),
	.IMAGE_WIDTH    (IMAGE_WIDTH    ),
	.IMAGE_SIZE     (IMAGE_SIZE     ),
	.RATE           (RATE           ),
	.CHANNEL_NUM_OUT(CHANNEL_NUM_OUT),
	.SHIFT_WIDTH    (SHIFT_WIDTH    )
) inst_align (
	//input
	.clk      (clk            ),
	.reset    (reset          ),
	.valid_in (valid_adder_out),
	.pxl_in   (adder_out      ),
	//output
	.pxl_out  (pxl_out        ),
	.valid_out(valid_out      )
);

endmodule