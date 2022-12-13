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

module cnn_avgp_3x3_top_new (
  clk, 
  reset,
  valid_in,
  pxl_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
`include "D:/GitHub/CNNs/CNN_DeepLabV3Plus/CNN_DeepLabV3Plus.srcs/sources_1/new/param/param_def_avgp_3x3_new.v"

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

// Read loop data
wire [DATA_WIDTH-1:0] loop_data_out      ;
wire                  valid_loop_data_out;

conv_loop_data_in_new #(
	.DATA_WIDTH          (DATA_WIDTH          ),
	.CHANNEL_NUM_IN      (CHANNEL_NUM_IN      ),
	.CHANNEL_NUM_OUT     (1                   ),
	.IMAGE_WIDTH         (IMAGE_WIDTH         ),
	.CHANNEL_NUM_IN_PIXEL(CHANNEL_NUM_IN_PIXEL),
	.IMAGE_SIZE          (IMAGE_SIZE          ),
	.LOOP_CHANNEL_IN_CNT (LOOP_CHANNEL_IN_CNT ),
	.LOOP_COL_CNT        (LOOP_COL_CNT        ),
	.RATE                (1                   )
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

// Buffer 3x3
wire [DATA_WIDTH-1:0] pxl_out_00;
wire [DATA_WIDTH-1:0] pxl_out_01;
wire [DATA_WIDTH-1:0] pxl_out_02;
wire [DATA_WIDTH-1:0] pxl_out_03;
wire [DATA_WIDTH-1:0] pxl_out_04;
wire [DATA_WIDTH-1:0] pxl_out_05;
wire [DATA_WIDTH-1:0] pxl_out_06;
wire [DATA_WIDTH-1:0] pxl_out_07;
wire [DATA_WIDTH-1:0] pxl_out_08;

wire valid_out_buffer;

conv_3x3_buffer_dilation_new #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.IMAGE_WIDTH     (IMAGE_WIDTH     ),
	.KERNEL          (KERNEL          ),
	.RATE            (RATE            ),
	.CNT_WIDTH_BUFFER(CNT_WIDTH_BUFFER),
	.IMAGE_SIZE      (IMAGE_SIZE      )
) inst_buffer (
	//input
	.clk         (clk                ),
	.reset       (reset              ),
	.valid_in    (valid_loop_data_out),
	.in          (loop_data_out      ),
	.stride2     (1'b0               ),
	
	.pxl_out_00  (pxl_out_00         ),
	.pxl_out_01  (pxl_out_01         ),
	.pxl_out_02  (pxl_out_02         ),
	.pxl_out_03  (pxl_out_03         ),
	.pxl_out_04  (pxl_out_04         ),
	.pxl_out_05  (pxl_out_05         ),
	.pxl_out_06  (pxl_out_06         ),
	.pxl_out_07  (pxl_out_07         ),
	.pxl_out_08  (pxl_out_08         ),
	.valid_out   (valid_out_buffer   ),
	.load_weights(/*load_weights*/   )
);

//Core
avgp_3x3_core_new #(.DATA_WIDTH(DATA_WIDTH)) inst_core (
	.clk      (clk             ),
	.reset    (reset           ),
	.valid_in (valid_out_buffer),
	.pxl_in_00(pxl_out_00      ),
	.pxl_in_01(pxl_out_01      ),
	.pxl_in_02(pxl_out_02      ),
	.pxl_in_03(pxl_out_03      ),
	.pxl_in_04(pxl_out_04      ),
	.pxl_in_05(pxl_out_05      ),
	.pxl_in_06(pxl_out_06      ),
	.pxl_in_07(pxl_out_07      ),
	.pxl_in_08(pxl_out_08      ),
	
	.pxl_out  (pxl_out         ),
	.valid_out(valid_out       )
);

endmodule