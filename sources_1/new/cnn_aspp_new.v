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

module cnn_aspp_new (
    clk
    ,reset
    
    ,valid_in
    ,pxl_in

    ,valid_weight_in1
    ,weight_in1

    ,valid_weight_in2
    ,weight_in2

    ,valid_weight_in3
    ,weight_in3

    ,valid_weight_in4
    ,weight_in4

    ,valid_weight_in5
    ,weight_in5

    ,valid_weight_in6
    ,weight_in6

    ,valid_weight_in7
    ,weight_in7

    ,valid_weight_in8
    ,weight_in8

    ,pxl_out
    ,valid_out
);

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH   = 32 ;
parameter IMAGE_WIDTH  = 128;
parameter IMAGE_HEIGHT = 128;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk             ;
input                  reset           ;
input                  valid_in        ;
input [DATA_WIDTH-1:0] pxl_in          ;
input                  valid_weight_in1;
input [DATA_WIDTH-1:0] weight_in1      ;
input                  valid_weight_in2;
input [DATA_WIDTH-1:0] weight_in2      ;
input                  valid_weight_in3;
input [DATA_WIDTH-1:0] weight_in3      ;
input                  valid_weight_in4;
input [DATA_WIDTH-1:0] weight_in4      ;
input                  valid_weight_in5;
input [DATA_WIDTH-1:0] weight_in5      ;
input                  valid_weight_in6;
input [DATA_WIDTH-1:0] weight_in6      ;
input                  valid_weight_in7;
input [DATA_WIDTH-1:0] weight_in7      ;
input                  valid_weight_in8;
input [DATA_WIDTH-1:0] weight_in8      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk             ;
wire                  reset           ;
wire                  valid_in        ;
wire [DATA_WIDTH-1:0] pxl_in          ;
wire                  valid_weight_in1;
wire [DATA_WIDTH-1:0] weight_in1      ;
wire                  valid_weight_in2;
wire [DATA_WIDTH-1:0] weight_in2      ;
wire                  valid_weight_in3;
wire [DATA_WIDTH-1:0] weight_in3      ;
wire                  valid_weight_in4;
wire [DATA_WIDTH-1:0] weight_in4      ;
wire                  valid_weight_in5;
wire [DATA_WIDTH-1:0] weight_in5      ;
wire                  valid_weight_in6;
wire [DATA_WIDTH-1:0] weight_in6      ;
wire                  valid_weight_in7;
wire [DATA_WIDTH-1:0] weight_in7      ;
wire                  valid_weight_in8;
wire [DATA_WIDTH-1:0] weight_in8      ;

wire [DATA_WIDTH-1:0] pxl_out         ;
wire                  valid_out       ;

// Conv1
wire [DATA_WIDTH-1:0] out_conv1      ;
wire                  valid_out_conv1;

cnn_conv_1x1_512_256 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (512         ),
    .CHANNEL_NUM_OUT(256         ),
    .KERNEL         (1           )
) conv1 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_in        ),
    .pxl_in         (pxl_in          ),
    .valid_weight_in(valid_weight_in1),
    .weight_in      (weight_in1      ),
    .stride2        (1'b0            ),
    //output
    .pxl_out        (out_conv1       ),
    .valid_out      (valid_out_conv1 )
);

// ReLU
wire [DATA_WIDTH-1:0] out_relu_1      ;
wire                  valid_out_relu_1;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu1 (
    .clk      (clk             ),
    .reset    (reset           ),
    .valid_in (valid_out_conv1 ),
    .in       (out_conv1       ),
    //output
    .out      (out_relu_1      ),
    .valid_out(valid_out_relu_1)
);

// Conv2
wire [DATA_WIDTH-1:0] out_conv21      ;
wire                  valid_out_conv21;

wire [DATA_WIDTH-1:0] out_conv22      ;
wire                  valid_out_conv22;

cnn_conv_3x3_512 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (512         ),
    .CHANNEL_NUM_OUT(512         ),
    .KERNEL         (3           ),
    .RATE           (12          )
) conv21 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_in        ),
    .pxl_in         (pxl_in          ),
    .valid_weight_in(valid_weight_in2),
    .weight_in      (weight_in2      ),
    .stride2        (1'b0            ),
    //output
    .pxl_out        (out_conv21      ),
    .valid_out      (valid_out_conv21)
);

cnn_conv_1x1_512_256 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (512         ),
    .CHANNEL_NUM_OUT(256         ),
    .KERNEL         (1           )
) conv22 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_out_conv21),
    .pxl_in         (out_conv21      ),
    .valid_weight_in(valid_weight_in3),
    .weight_in      (weight_in3      ),
    .stride2        (1'b0            ),
    //output
    .pxl_out        (out_conv22      ),
    .valid_out      (valid_out_conv22)
);

// ReLU
wire [DATA_WIDTH-1:0] out_relu_2      ;
wire                  valid_out_relu_2;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu2 (
    .clk      (clk             ),
    .reset    (reset           ),
    .valid_in (valid_out_conv22),
    .in       (out_conv22      ),
    //output
    .out      (out_relu_2      ),
    .valid_out(valid_out_relu_2)
);

// Conv3
wire [DATA_WIDTH-1:0] out_conv31      ;
wire                  valid_out_conv31;

wire [DATA_WIDTH-1:0] out_conv32      ;
wire                  valid_out_conv32;

cnn_conv_3x3_512 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (512         ),
    .CHANNEL_NUM_OUT(512         ),
    .KERNEL         (3           ),
    .RATE           (24          )
) conv31 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_in        ),
    .pxl_in         (pxl_in          ),
    .valid_weight_in(valid_weight_in4),
    .weight_in      (weight_in4      ),
    .stride2        (1'b0            ),
    //output
    .pxl_out        (out_conv31      ),
    .valid_out      (valid_out_conv31)
);

cnn_conv_1x1_512_256 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (512         ),
    .CHANNEL_NUM_OUT(256         ),
    .KERNEL         (1           )
) conv32 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_out_conv31),
    .pxl_in         (out_conv31      ),
    .valid_weight_in(valid_weight_in5),
    .weight_in      (weight_in5      ),
    .stride2        (1'b0            ),
    //output
    .pxl_out        (out_conv32      ),
    .valid_out      (valid_out_conv32)
);

// ReLU
wire [DATA_WIDTH-1:0] out_relu_3      ;
wire                  valid_out_relu_3;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu3 (
    .clk      (clk             ),
    .reset    (reset           ),
    .valid_in (valid_out_conv32),
    .in       (out_conv32      ),
    //output
    .out      (out_relu_3      ),
    .valid_out(valid_out_relu_3)
);

// Conv4
wire [DATA_WIDTH-1:0] out_conv41      ;
wire                  valid_out_conv41;

wire [DATA_WIDTH-1:0] out_conv42      ;
wire                  valid_out_conv42;

cnn_conv_3x3_512 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (512         ),
    .CHANNEL_NUM_OUT(512         ),
    .KERNEL         (3           ),
    .RATE           (36          )
) conv41 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_in        ),
    .pxl_in         (pxl_in          ),
    .valid_weight_in(valid_weight_in6),
    .weight_in      (weight_in6      ),
    .stride2        (1'b0            ),
    //output
    .pxl_out        (out_conv41      ),
    .valid_out      (valid_out_conv41)
);

cnn_conv_1x1_512_256 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (512         ),
    .CHANNEL_NUM_OUT(256         ),
    .KERNEL         (1           )
) conv42 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_out_conv41),
    .pxl_in         (out_conv41      ),
    .valid_weight_in(valid_weight_in7),
    .weight_in      (weight_in7      ),
    .stride2        (1'b0            ),
    //output
    .pxl_out        (out_conv42      ),
    .valid_out      (valid_out_conv42)
);

// ReLU
wire [DATA_WIDTH-1:0] out_relu_4  ;
wire                  valid_out_relu_4;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu4 (
    .clk      (clk             ),
    .reset    (reset           ),
    .valid_in (valid_out_conv42),
    .in       (out_conv42      ),
    //output
    .out      (out_relu_4      ),
    .valid_out(valid_out_relu_4)
);

// Conv5
wire [DATA_WIDTH-1:0] out_conv51      ;
wire                  valid_out_conv51;

wire [DATA_WIDTH-1:0] out_conv52      ;
wire                  valid_out_conv52;

cnn_avgp_3x3_top_new #(
    .DATA_WIDTH    (DATA_WIDTH  ),
    .IMAGE_WIDTH   (IMAGE_WIDTH ),
    .IMAGE_HEIGHT  (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN(512         ),
    .KERNEL        (3           ),
    .RATE          (1           )
) avgp51 (
    .clk      (clk             ),
    .reset    (reset           ),
    .valid_in (valid_in        ),
    .pxl_in   (pxl_in          ),
    //output
    .pxl_out  (out_conv51      ),
    .valid_out(valid_out_conv51)
);

cnn_conv_1x1_512_256 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (512         ),
    .CHANNEL_NUM_OUT(256         ),
    .KERNEL         (1           )
) conv52 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_out_conv51),
    .pxl_in         (out_conv51      ),
    .valid_weight_in(valid_weight_in8),
    .weight_in      (weight_in8      ),
    .stride2        (1'b0            ),
    //output
    .pxl_out        (out_conv52      ),
    .valid_out      (valid_out_conv52)
);

// ReLU
wire [DATA_WIDTH-1:0] out_relu_5      ;
wire                  valid_out_relu_5;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu5 (
    .clk      (clk             ),
    .reset    (reset           ),
    .valid_in (valid_out_conv52),
    .in       (out_conv52      ),
    //output
    .out      (out_relu_5      ),
    .valid_out(valid_out_relu_5)
);

// Concat
parameter IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT                                          ;
parameter DELAY_01   = (130816 * IMAGE_SIZE) + (131071 * IMAGE_WIDTH) + 131162             ;
parameter DELAY_02   = DELAY_01 + (261632 * IMAGE_SIZE) + (3145728 * IMAGE_WIDTH) + 3145855;
parameter DELAY_03   = DELAY_01 + (261632 * IMAGE_SIZE) + (6291456 * IMAGE_WIDTH) + 6291583;
parameter DELAY_04   = DELAY_01 + (261632 * IMAGE_SIZE) + (9437184 * IMAGE_WIDTH) + 9437311;
parameter DELAY_05   = DELAY_01 + IMAGE_WIDTH + 46                                         ;

cnn_concat_5in_new #(
    .DATA_WIDTH    (DATA_WIDTH  ),
    .IMAGE_WIDTH   (IMAGE_WIDTH ),
    .IMAGE_HEIGHT  (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN(256         ),
    .DELAY_01      (DELAY_01    ),
    .DELAY_02      (DELAY_02    ),
    .DELAY_03      (DELAY_03    ),
    .DELAY_04      (DELAY_04    ),
    .DELAY_05      (DELAY_05    )
) concat1 (
    .clk         (clk             ),
    .reset       (reset           ),
    .valid_in_no1(valid_out_relu_1),
    .in_no1      (out_relu_1      ),
    .valid_in_no2(valid_out_relu_2),
    .in_no2      (out_relu_2      ),
    .valid_in_no3(valid_out_relu_3),
    .in_no3      (out_relu_3      ),
    .valid_in_no4(valid_out_relu_4),
    .in_no4      (out_relu_4      ),
    .valid_in_no5(valid_out_relu_5),
    .in_no5      (out_relu_5      ),
    //output
    .out         (pxl_out         ),
    .valid_out   (valid_out       )
);

endmodule
