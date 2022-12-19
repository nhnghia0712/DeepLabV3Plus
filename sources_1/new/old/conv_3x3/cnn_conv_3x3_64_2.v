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

module cnn_conv_3x3_64_2 (
  clk, 
  reset,
  stride2,
  valid_in1,
  pxl_in1,
  valid_weight_in1,
  weight_in1,
  valid_in2,
  pxl_in2,
  valid_weight_in2,
  weight_in2,
  valid_in3,
  pxl_in3,
  valid_weight_in3,
  weight_in3,
  valid_in4,
  pxl_in4,
  valid_weight_in4,
  weight_in4,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
// General
parameter IMAGE_WIDTH     = 612; //Width
parameter IMAGE_HEIGHT    = 612; //Height
parameter CHANNEL_NUM_IN  = 64 ; //The number of channel in
parameter CHANNEL_NUM_OUT = 64 ; //The number of channel out
parameter KERNEL          = 3  ; //Kernel width
parameter RATE            = 1  ; //Rate of dialtion

`include "D:/GitHub/CNNs/CNN_DeepLabV3Plus/CNN_DeepLabV3Plus.srcs/sources_1/new/param/param_def_conv_3x3_dilation_new.v"

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk            ;
input                  reset          ;
input                  stride2        ;
input                  valid_in1       ;
input [DATA_WIDTH-1:0] pxl_in1         ;
input                  valid_weight_in1;
input [DATA_WIDTH-1:0] weight_in1      ;
input                  valid_in2       ;
input [DATA_WIDTH-1:0] pxl_in2         ;
input                  valid_weight_in2;
input [DATA_WIDTH-1:0] weight_in2      ;
input                  valid_in3       ;
input [DATA_WIDTH-1:0] pxl_in3         ;
input                  valid_weight_in3;
input [DATA_WIDTH-1:0] weight_in3      ;
input                  valid_in4       ;
input [DATA_WIDTH-1:0] pxl_in4         ;
input                  valid_weight_in4;
input [DATA_WIDTH-1:0] weight_in4      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out         ;
output                  valid_out       ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk            ;
wire                  reset          ;
wire                  stride2        ;
wire                  valid_in1       ;
wire [DATA_WIDTH-1:0] pxl_in1         ;
wire                  valid_weight_in1;
wire [DATA_WIDTH-1:0] weight_in1      ;
wire                  valid_in2       ;
wire [DATA_WIDTH-1:0] pxl_in2         ;
wire                  valid_weight_in2;
wire [DATA_WIDTH-1:0] weight_in2      ;
wire                  valid_in3       ;
wire [DATA_WIDTH-1:0] pxl_in3         ;
wire                  valid_weight_in3;
wire [DATA_WIDTH-1:0] weight_in3      ;
wire                  valid_in4       ;
wire [DATA_WIDTH-1:0] pxl_in4         ;
wire                  valid_weight_in4;
wire [DATA_WIDTH-1:0] weight_in4      ;

wire [DATA_WIDTH-1:0] pxl_out         ;
wire                  valid_out       ;

// 1st conv 16
wire [DATA_WIDTH-1:0] pxl_out_conv1  ;
wire                  valid_out_conv1;

cnn_conv_3x3_16 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/4),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT ),
	.KERNEL                      (KERNEL          ),
	.RATE                        (RATE            )
) inst_conv1 (
	//input
	.clk            (clk             ),
	.reset          (reset           ),
	.stride2        (stride2         ),
	.valid_in       (valid_in1       ),
	.pxl_in         (pxl_in1         ),
	.valid_weight_in(valid_weight_in1),
	.weight_in      (weight_in1      ),
	//output
	.pxl_out        (pxl_out_conv1   ),
	.valid_out      (valid_out_conv1 )
);

// 2nd conv 16
wire [DATA_WIDTH-1:0] pxl_out_conv2  ;
wire                  valid_out_conv2;

cnn_conv_3x3_16 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/4),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT ),
	.KERNEL                      (KERNEL          ),
	.RATE                        (RATE            )
) inst_conv2 (
	//input
	.clk            (clk             ),
	.reset          (reset           ),
	.stride2        (stride2         ),
	.valid_in       (valid_in2       ),
	.pxl_in         (pxl_in2         ),
	.valid_weight_in(valid_weight_in2),
	.weight_in      (weight_in2      ),
	//output
	.pxl_out        (pxl_out_conv2   ),
	.valid_out      (valid_out_conv2 )
);

// 3rd conv 16
wire [DATA_WIDTH-1:0] pxl_out_conv3  ;
wire                  valid_out_conv3;

cnn_conv_3x3_16 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/4),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT ),
	.KERNEL                      (KERNEL          ),
	.RATE                        (RATE            )
) inst_conv3 (
	//input
	.clk            (clk             ),
	.reset          (reset           ),
	.stride2        (stride2         ),
	.valid_in       (valid_in3       ),
	.pxl_in         (pxl_in3         ),
	.valid_weight_in(valid_weight_in3),
	.weight_in      (weight_in3      ),
	//output
	.pxl_out        (pxl_out_conv3   ),
	.valid_out      (valid_out_conv3 )
);

// 4th conv 16
wire [DATA_WIDTH-1:0] pxl_out_conv4  ;
wire                  valid_out_conv4;

cnn_conv_3x3_16 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/4),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT ),
	.KERNEL                      (KERNEL          ),
	.RATE                        (RATE            )
) inst_conv4 (
	//input
	.clk            (clk             ),
	.reset          (reset           ),
	.stride2        (stride2         ),
	.valid_in       (valid_in4       ),
	.pxl_in         (pxl_in4         ),
	.valid_weight_in(valid_weight_in4),
	.weight_in      (weight_in4      ),
	//output
	.pxl_out        (pxl_out_conv4   ),
	.valid_out      (valid_out_conv4 )
);

// Adder
wire [DATA_WIDTH-1:0] pxl_out1  ;
wire                  valid_out1;

fp_add_sub inst_add1 (
  .reset    (reset                            ),
  .clk      (clk                              ),
  .valid_in (valid_out_conv1 & valid_out_conv2),
  .in_a     (pxl_out_conv1                    ),
  .in_b     (pxl_out_conv2                    ),
  .out      (pxl_out1                          ),
  .valid_out(valid_out1                        )
);

wire [DATA_WIDTH-1:0] pxl_out2  ;
wire                  valid_out2;

fp_add_sub inst_add2 (
  .reset    (reset                            ),
  .clk      (clk                              ),
  .valid_in (valid_out_conv3 & valid_out_conv4),
  .in_a     (pxl_out_conv3                    ),
  .in_b     (pxl_out_conv4                    ),
  .out      (pxl_out2                          ),
  .valid_out(valid_out2                        )
);

fp_add_sub inst_add3 (
  .reset    (reset                  ),
  .clk      (clk                    ),
  .valid_in (valid_out1 & valid_out2),
  .in_a     (pxl_out1               ),
  .in_b     (pxl_out2               ),
  .out      (pxl_out                ),
  .valid_out(valid_out              )
);

endmodule