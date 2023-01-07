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

module conv_3x3_top_08_09_10 (
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
parameter IMAGE_WIDTH     = 16; //Width
parameter IMAGE_HEIGHT    = 16; //Height
parameter CHANNEL_NUM_IN  = 256; //The number of channel in
parameter CHANNEL_NUM_OUT = 256; //The number of channel out
parameter KERNEL          = 3  ; //Kernel width
parameter RATE            = 1  ; //Rate of dialtion

`include "D:/GitHub/CNNs/CNN_DeepLabV3Plus/CNN_DeepLabV3Plus.srcs/sources_1/new/param/param_def_conv_3x3.vh"

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk             ;
input                  reset           ;
input                  valid_in        ;
input [DATA_WIDTH-1:0] pxl_in          ;
input                  valid_weight_in ;
input [DATA_WIDTH-1:0] weight_in       ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out         ;
output                  valid_out       ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk             ;
wire                  reset           ;
wire                  valid_in        ;
wire [DATA_WIDTH-1:0] pxl_in          ;
wire                  valid_weight_in ;
wire [DATA_WIDTH-1:0] weight_in       ;

wire [DATA_WIDTH-1:0] pxl_out         ;
wire                  valid_out       ;

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

conv_3x3_buffer #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.IMAGE_WIDTH     (IMAGE_WIDTH     ),
	.KERNEL          (KERNEL          ),
	.RATE            (RATE            ),
	.CNT_WIDTH_BUFFER(CNT_WIDTH_BUFFER),
	.IMAGE_SIZE      (IMAGE_SIZE      )
) inst_buffer (
	//input
	.clk         (clk             ),
	.reset       (reset           ),
	.valid_in    (valid_in        ),
	.in          (pxl_in          ),
	.stride2     (1'b0            ),
	
	.pxl_out_00  (pxl_out_00      ),
	.pxl_out_01  (pxl_out_01      ),
	.pxl_out_02  (pxl_out_02      ),
	.pxl_out_03  (pxl_out_03      ),
	.pxl_out_04  (pxl_out_04      ),
	.pxl_out_05  (pxl_out_05      ),
	.pxl_out_06  (pxl_out_06      ),
	.pxl_out_07  (pxl_out_07      ),
	.pxl_out_08  (pxl_out_08      ),
	
	.valid_out   (valid_out_buffer),
	.load_weights(load_weights    )
);
// Buffer 3x3 Weights
//weights
wire [DATA_WIDTH-1:0] weight_out_00; wire [DATA_WIDTH-1:0] weight_out_01; wire [DATA_WIDTH-1:0] weight_out_02;
wire [DATA_WIDTH-1:0] weight_out_03; wire [DATA_WIDTH-1:0] weight_out_04; wire [DATA_WIDTH-1:0] weight_out_05;
wire [DATA_WIDTH-1:0] weight_out_06; wire [DATA_WIDTH-1:0] weight_out_07; wire [DATA_WIDTH-1:0] weight_out_08;

wire valid_out_buffer_weight;

conv_3x3_buffer_weights_08_09_10 #(
	.DATA_WIDTH              (DATA_WIDTH              ),
	.KERNEL_SIZE             (KERNEL_SIZE             ),
	.CNT_WIDTH_BUFFER_WEIGHTS(CNT_WIDTH_BUFFER_WEIGHTS)
) inst_buffer_weights (
	//input
	.clk          (clk                    ),
	.reset        (reset                  ),
	.valid_in     (valid_weight_in        ),
	.in           (weight_in              ),
	.load_weights (load_weights           ),
	
	.weight_out_00(weight_out_00          ),
	.weight_out_01(weight_out_01          ),
	.weight_out_02(weight_out_02          ),
	.weight_out_03(weight_out_03          ),
	.weight_out_04(weight_out_04          ),
	.weight_out_05(weight_out_05          ),
	.weight_out_06(weight_out_06          ),
	.weight_out_07(weight_out_07          ),
	.weight_out_08(weight_out_08          ),
	
	.valid_out    (valid_out_buffer_weight)
);

//Core
conv_3x3_core  #(.DATA_WIDTH(DATA_WIDTH)) inst_core (
	.clk         (clk                                       ),
	.reset       (reset                                     ),
	.valid_in    (valid_out_buffer & valid_out_buffer_weight),
	.pxl_in_00   (pxl_out_00                                ),
	.pxl_in_01   (pxl_out_01                                ),
	.pxl_in_02   (pxl_out_02                                ),
	.pxl_in_03   (pxl_out_03                                ),
	.pxl_in_04   (pxl_out_04                                ),
	.pxl_in_05   (pxl_out_05                                ),
	.pxl_in_06   (pxl_out_06                                ),
	.pxl_in_07   (pxl_out_07                                ),
	.pxl_in_08   (pxl_out_08                                ),
	//weights
	.weight_in_00(weight_out_00                             ),
	.weight_in_01(weight_out_01                             ),
	.weight_in_02(weight_out_02                             ),
	.weight_in_03(weight_out_03                             ),
	.weight_in_04(weight_out_04                             ),
	.weight_in_05(weight_out_05                             ),
	.weight_in_06(weight_out_06                             ),
	.weight_in_07(weight_out_07                             ),
	.weight_in_08(weight_out_08                             ),
	
	.pxl_out     (pxl_out                                   ),
	.valid_out   (valid_out                                 )
);

endmodule