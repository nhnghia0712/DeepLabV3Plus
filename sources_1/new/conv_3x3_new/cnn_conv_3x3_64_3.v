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

module cnn_conv_3x3_64_3 (
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
  valid_weight_in13
  weight_in3,
  valid_in4,
  pxl_in4,
  valid_weight_in4,
  weight_in4,
  valid_in5,
  pxl_in5,
  valid_weight_in5,
  weight_in5,
  valid_in6,
  pxl_in6,
  valid_weight_in6,
  weight_in6,
  valid_in7,
  pxl_in7,
  valid_weight_in17
  weight_in7,
  valid_in8,
  pxl_in8,
  valid_weight_in8,
  weight_in8,

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
input                  valid_in5       ;
input [DATA_WIDTH-5:0] pxl_in5         ;
input                  valid_weight_in5;
input [DATA_WIDTH-5:0] weight_in5      ;
input                  valid_in6       ;
input [DATA_WIDTH-1:0] pxl_in6         ;
input                  valid_weight_in6;
input [DATA_WIDTH-1:0] weight_in6      ;
input                  valid_in7       ;
input [DATA_WIDTH-1:0] pxl_in7         ;
input                  valid_weight_in7;
input [DATA_WIDTH-1:0] weight_in7      ;
input                  valid_in8       ;
input [DATA_WIDTH-1:0] pxl_in8         ;
input                  valid_weight_in8;
input [DATA_WIDTH-1:0] weight_in8      ;

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
wire                  valid_in5       ;
wire [DATA_WIDTH-5:0] pxl_in5         ;
wire                  valid_weight_in5;
wire [DATA_WIDTH-5:0] weight_in5      ;
wire                  valid_in6       ;
wire [DATA_WIDTH-1:0] pxl_in6         ;
wire                  valid_weight_in6;
wire [DATA_WIDTH-1:0] weight_in6      ;
wire                  valid_in7       ;
wire [DATA_WIDTH-1:0] pxl_in7         ;
wire                  valid_weight_in7;
wire [DATA_WIDTH-1:0] weight_in7      ;
wire                  valid_in8       ;
wire [DATA_WIDTH-1:0] pxl_in8         ;
wire                  valid_weight_in8;
wire [DATA_WIDTH-1:0] weight_in8      ;

wire [DATA_WIDTH-1:0] pxl_out         ;
wire                  valid_out       ;

// 1st conv 8
wire [DATA_WIDTH-1:0] pxl_out_conv1  ;
wire                  valid_out_conv1;

cnn_conv_3x3_8 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/8),
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

// 2nd conv 8
wire [DATA_WIDTH-1:0] pxl_out_conv2  ;
wire                  valid_out_conv2;

cnn_conv_3x3_8 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/8),
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

// 3rd conv 8
wire [DATA_WIDTH-1:0] pxl_out_conv3  ;
wire                  valid_out_conv3;

cnn_conv_3x3_8 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/8),
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

// 4th conv 8
wire [DATA_WIDTH-1:0] pxl_out_conv4  ;
wire                  valid_out_conv4;

cnn_conv_3x3_8 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/8),
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

// 5th conv 8
wire [DATA_WIDTH-1:0] pxl_out_conv5  ;
wire                  valid_out_conv5;

cnn_conv_3x3_8 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/8),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT ),
	.KERNEL                      (KERNEL          ),
	.RATE                        (RATE            )
) inst_conv5 (
	//input
	.clk            (clk             ),
	.reset          (reset           ),
	.stride2        (stride2         ),
	.valid_in       (valid_in5       ),
	.pxl_in         (pxl_in5         ),
	.valid_weight_in(valid_weight_in5),
	.weight_in      (weight_in5      ),
	//output
	.pxl_out        (pxl_out_conv5   ),
	.valid_out      (valid_out_conv5 )
);

// 6th conv 8
wire [DATA_WIDTH-1:0] pxl_out_conv6  ;
wire                  valid_out_conv6;

cnn_conv_3x3_8 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/8),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT ),
	.KERNEL                      (KERNEL          ),
	.RATE                        (RATE            )
) inst_conv6 (
	//input
	.clk            (clk             ),
	.reset          (reset           ),
	.stride2        (stride2         ),
	.valid_in       (valid_in6       ),
	.pxl_in         (pxl_in6         ),
	.valid_weight_in(valid_weight_in6),
	.weight_in      (weight_in6      ),
	//output
	.pxl_out        (pxl_out_conv6   ),
	.valid_out      (valid_out_conv6 )
);

// 7th conv 8
wire [DATA_WIDTH-1:0] pxl_out_conv7  ;
wire                  valid_out_conv7;

cnn_conv_3x3_8 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/8),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT ),
	.KERNEL                      (KERNEL          ),
	.RATE                        (RATE            )
) inst_conv7 (
	//input
	.clk            (clk             ),
	.reset          (reset           ),
	.stride2        (stride2         ),
	.valid_in       (valid_in7       ),
	.pxl_in         (pxl_in7         ),
	.valid_weight_in(valid_weight_in7),
	.weight_in      (weight_in7      ),
	//output
	.pxl_out        (pxl_out_conv7   ),
	.valid_out      (valid_out_conv7 )
);

// 8th conv 8
wire [DATA_WIDTH-1:0] pxl_out_conv8  ;
wire                  valid_out_conv8;

cnn_conv_3x3_8 #(
	.DATA_WIDTH                  (DATA_WIDTH      ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH     ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT    ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN/8),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT ),
	.KERNEL                      (KERNEL          ),
	.RATE                        (RATE            )
) inst_conv8 (
	//input
	.clk            (clk             ),
	.reset          (reset           ),
	.stride2        (stride2         ),
	.valid_in       (valid_in8       ),
	.pxl_in         (pxl_in8         ),
	.valid_weight_in(valid_weight_in8),
	.weight_in      (weight_in8      ),
	//output
	.pxl_out        (pxl_out_conv8   ),
	.valid_out      (valid_out_conv8 )
);

// Adder
wire [DATA_WIDTH-1:0] mem      [7:0];
wire [           7:0] valid_mem     ;

assign mem[0] = pxl_out_conv1;
assign mem[1] = pxl_out_conv2;
assign mem[2] = pxl_out_conv3;
assign mem[3] = pxl_out_conv4;
assign mem[4] = pxl_out_conv5;
assign mem[5] = pxl_out_conv6;
assign mem[6] = pxl_out_conv7;
assign mem[7] = pxl_out_conv8;

assign valid_mem[0] = valid_out_conv1;
assign valid_mem[1] = valid_out_conv2;
assign valid_mem[2] = valid_out_conv3;
assign valid_mem[3] = valid_out_conv4;
assign valid_mem[4] = valid_out_conv5;
assign valid_mem[5] = valid_out_conv6;
assign valid_mem[6] = valid_out_conv7;
assign valid_mem[7] = valid_out_conv8;

genvar i;

wire [DATA_WIDTH-1:0] pxl_out1  [3:0];
wire [           3:0] valid_out1     ;

generate
    for ( i = 0; i < 4; i = i + 1) begin
        fp_add_sub inst_add1 (
          .reset    (reset                          ),
          .clk      (clk                            ),
          .valid_in (valid_mem[i] & valid_mem[i + 4]),
          .in_a     (mem[i]                         ),
          .in_b     (mem[i + 4]                     ),
          .out      (pxl_out1[i]                    ),
          .valid_out(valid_out1[i]                  )
        );
    end
endgenerate

wire [DATA_WIDTH-1:0] pxl_out2  [1:0];
wire [           1:0] valid_out2     ;

generate
    for ( i = 0; i < 2; i = i + 1) begin
        fp_add_sub inst_add2 (
          .reset    (reset                            ),
          .clk      (clk                              ),
          .valid_in (valid_out1[i] & valid_out1[i + 2]),
          .in_a     (pxl_out1[i]                      ),
          .in_b     (pxl_out1[i + 2]                  ),
          .out      (pxl_out2[i]                      ),
          .valid_out(valid_out2[i]                    )
        );
    end
endgenerate

fp_add_sub inst_add3 (
  .reset    (reset                        ),
  .clk      (clk                          ),
  .valid_in (valid_out2[0] & valid_out2[1]),
  .in_a     (pxl_out2[0]                  ),
  .in_b     (pxl_out2[1]                  ),
  .out      (pxl_out                      ),
  .valid_out(valid_out                    )
);

endmodule