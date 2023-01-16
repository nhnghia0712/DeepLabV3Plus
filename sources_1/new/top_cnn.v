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

module top_cnn (
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

    ,valid_weight_in9
    ,weight_in9

    ,valid_weight_in10
    ,weight_in10

    ,valid_weight_in11
    ,weight_in11

    ,valid_weight_in12
    ,weight_in12

    ,valid_weight_in13
    ,weight_in13

    ,valid_weight_in14
    ,weight_in14

    ,valid_weight_in15
    ,weight_in15

    ,valid_weight_in16
    ,weight_in16

    ,valid_weight_in17
    ,weight_in17

    ,valid_weight_in18
    ,weight_in18

    ,valid_weight_in19
    ,weight_in19

    ,valid_weight_in20
    ,weight_in20

    ,valid_weight_in21
    ,weight_in21

    ,valid_weight_in22
    ,weight_in22

    ,valid_weight_in23
    ,weight_in23

    ,valid_weight_in24
    ,weight_in24

    ,valid_weight_in25
    ,weight_in25

    ,valid_weight_in26
    ,weight_in26

    ,valid_weight_in27
    ,weight_in27

    ,valid_weight_in28
    ,weight_in28

    ,valid_weight_in29
    ,weight_in29

    ,valid_weight_in30
    ,weight_in30

    ,valid_weight_in31
    ,weight_in31

    ,valid_weight_in32
    ,weight_in32

    ,valid_weight_in33
    ,weight_in33

    ,valid_weight_in34
    ,weight_in34

    ,valid_weight_in35
    ,weight_in35

    // ,sigmoid_in

    ,pxl_out
    ,valid_out
    ,done
    // ,sigmoid_addr
    // ,sigmoid_read_en
);

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH   = 32 ;
parameter IMAGE_WIDTH  = 256;
parameter IMAGE_HEIGHT = 256;

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

input                  valid_weight_in9;
input [DATA_WIDTH-1:0] weight_in9      ;

input                  valid_weight_in10;
input [DATA_WIDTH-1:0] weight_in10      ;

input                  valid_weight_in11;
input [DATA_WIDTH-1:0] weight_in11      ;

input                  valid_weight_in12;
input [DATA_WIDTH-1:0] weight_in12      ;

input                  valid_weight_in13;
input [DATA_WIDTH-1:0] weight_in13      ;

input                  valid_weight_in14;
input [DATA_WIDTH-1:0] weight_in14      ;

input                  valid_weight_in15;
input [DATA_WIDTH-1:0] weight_in15      ;

input                  valid_weight_in16;
input [DATA_WIDTH-1:0] weight_in16      ;

input                  valid_weight_in17;
input [DATA_WIDTH-1:0] weight_in17      ;

input                  valid_weight_in18;
input [DATA_WIDTH-1:0] weight_in18      ;

input                  valid_weight_in19;
input [DATA_WIDTH-1:0] weight_in19      ;

input                  valid_weight_in20;
input [DATA_WIDTH-1:0] weight_in20      ;

input                  valid_weight_in21;
input [DATA_WIDTH-1:0] weight_in21      ;

input                  valid_weight_in22;
input [DATA_WIDTH-1:0] weight_in22      ;

input                  valid_weight_in23;
input [DATA_WIDTH-1:0] weight_in23      ;

input                  valid_weight_in24;
input [DATA_WIDTH-1:0] weight_in24      ;

input                  valid_weight_in25;
input [DATA_WIDTH-1:0] weight_in25      ;

input                  valid_weight_in26;
input [DATA_WIDTH-1:0] weight_in26      ;

input                  valid_weight_in27;
input [DATA_WIDTH-1:0] weight_in27      ;

input                  valid_weight_in28;
input [DATA_WIDTH-1:0] weight_in28      ;

input                  valid_weight_in29;
input [DATA_WIDTH-1:0] weight_in29      ;

input                  valid_weight_in30;
input [DATA_WIDTH-1:0] weight_in30      ;

input                  valid_weight_in31;
input [DATA_WIDTH-1:0] weight_in31      ;

input                  valid_weight_in32;
input [DATA_WIDTH-1:0] weight_in32      ;

input                  valid_weight_in33;
input [DATA_WIDTH-1:0] weight_in33      ;

input                  valid_weight_in34;
input [DATA_WIDTH-1:0] weight_in34      ;

input                  valid_weight_in35;
input [DATA_WIDTH-1:0] weight_in35      ;

// input [DATA_WIDTH-1:0] sigmoid_in;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

output       done           ;
// output [4:0] sigmoid_addr   ;
// output       sigmoid_read_en;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk     ;
wire                  reset   ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] pxl_in  ;

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

wire                  valid_weight_in9;
wire [DATA_WIDTH-1:0] weight_in9      ;

wire                  valid_weight_in10;
wire [DATA_WIDTH-1:0] weight_in10      ;

wire                  valid_weight_in11;
wire [DATA_WIDTH-1:0] weight_in11      ;

wire                  valid_weight_in12;
wire [DATA_WIDTH-1:0] weight_in12      ;

wire                  valid_weight_in13;
wire [DATA_WIDTH-1:0] weight_in13      ;

wire                  valid_weight_in14;
wire [DATA_WIDTH-1:0] weight_in14      ;

wire                  valid_weight_in15;
wire [DATA_WIDTH-1:0] weight_in15      ;

wire                  valid_weight_in16;
wire [DATA_WIDTH-1:0] weight_in16      ;

wire                  valid_weight_in17;
wire [DATA_WIDTH-1:0] weight_in17      ;

wire                  valid_weight_in18;
wire [DATA_WIDTH-1:0] weight_in18      ;

wire                  valid_weight_in19;
wire [DATA_WIDTH-1:0] weight_in19      ;

wire                  valid_weight_in20;
wire [DATA_WIDTH-1:0] weight_in20      ;

wire                  valid_weight_in21;
wire [DATA_WIDTH-1:0] weight_in21      ;

wire                  valid_weight_in22;
wire [DATA_WIDTH-1:0] weight_in22      ;

wire                  valid_weight_in23;
wire [DATA_WIDTH-1:0] weight_in23      ;

wire                  valid_weight_in24;
wire [DATA_WIDTH-1:0] weight_in24      ;

wire                  valid_weight_in25;
wire [DATA_WIDTH-1:0] weight_in25      ;

wire                  valid_weight_in26;
wire [DATA_WIDTH-1:0] weight_in26      ;

wire                  valid_weight_in27;
wire [DATA_WIDTH-1:0] weight_in27      ;

wire                  valid_weight_in28;
wire [DATA_WIDTH-1:0] weight_in28      ;

wire                  valid_weight_in29;
wire [DATA_WIDTH-1:0] weight_in29      ;

wire                  valid_weight_in30;
wire [DATA_WIDTH-1:0] weight_in30      ;

wire                  valid_weight_in31;
wire [DATA_WIDTH-1:0] weight_in31      ;

wire                  valid_weight_in32;
wire [DATA_WIDTH-1:0] weight_in32      ;

wire                  valid_weight_in33;
wire [DATA_WIDTH-1:0] weight_in33      ;

wire                  valid_weight_in34;
wire [DATA_WIDTH-1:0] weight_in34      ;

wire                  valid_weight_in35;
wire [DATA_WIDTH-1:0] weight_in35      ;

// wire [DATA_WIDTH-1:0] sigmoid_in;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

wire       done           ;
// wire [4:0] sigmoid_addr   ;
// wire       sigmoid_read_en;

// Conv 7x7
wire [DATA_WIDTH-1:0] out_conv7x7      ;
wire                  valid_out_conv7x7;

cnn_conv_01_7x7 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (3           ),
    .CHANNEL_NUM_OUT(64          ),
    .KERNEL         (7           )
) conv7x7 (
    .clk            (clk              ),
    .reset          (reset            ),
    .valid_in       (valid_in         ),
    .pxl_in         (pxl_in           ),
    .valid_weight_in(valid_weight_in1 ),
    .weight_in      (weight_in1       ),
    //output
    .pxl_out        (out_conv7x7      ),
    .valid_out      (valid_out_conv7x7)
);

// ReLU
wire [DATA_WIDTH-1:0] out_relu_5      ;
wire                  valid_out_relu_5;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu5 (
    .clk      (clk                ),
    .reset    (reset              ),
    .valid_in (valid_out_conv7x7),
    .in       (out_conv7x7      ),
    //output
    .out      (out_relu_5         ),
    .valid_out(valid_out_relu_5   )
);
// Maxp 3x3
wire [DATA_WIDTH-1:0] out_maxp3x3      ;
wire                  valid_out_maxp3x3;

cnn_maxp_01_3x3 #(
    .DATA_WIDTH    (DATA_WIDTH    ),
    .IMAGE_WIDTH   (IMAGE_WIDTH/2 ),
    .IMAGE_HEIGHT  (IMAGE_HEIGHT/2),
    .CHANNEL_NUM_IN(64            ),
    .KERNEL        (3             ),
    .RATE          (1             )
) maxp3x3 (
    .clk      (clk              ),
    .reset    (reset            ),
    .valid_in (valid_out_relu_5),
    .pxl_in   (out_relu_5      ),
    //output
    .pxl_out  (out_maxp3x3      ),
    .valid_out(valid_out_maxp3x3)
);

// Resnet 50
wire [DATA_WIDTH-1:0] out_resnet18      ;
wire                  valid_out_resnet18;

wire [DATA_WIDTH-1:0] out_resnet18_layer1      ;
wire                  valid_out_resnet18_layer1;

cnn_resnet18 #(
    .DATA_WIDTH  (DATA_WIDTH    ),
    .IMAGE_WIDTH (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT(IMAGE_HEIGHT/4)
) resnet18 (
    .clk              (clk                      ),
    .reset            (reset                    ),
    .valid_in         (valid_out_maxp3x3        ),
    .pxl_in           (out_maxp3x3              ),
    
    .valid_weight_in1 (valid_weight_in2         ),
    .weight_in1       (weight_in2               ),
    
    .valid_weight_in2 (valid_weight_in3         ),
    .weight_in2       (weight_in3               ),
    
    .valid_weight_in3 (valid_weight_in4         ),
    .weight_in3       (weight_in4               ),
    
    .valid_weight_in4 (valid_weight_in5         ),
    .weight_in4       (weight_in5               ),
    
    .valid_weight_in5 (valid_weight_in6         ),
    .weight_in5       (weight_in6               ),
    
    .valid_weight_in6 (valid_weight_in7         ),
    .weight_in6       (weight_in7               ),
    
    .valid_weight_in7 (valid_weight_in8         ),
    .weight_in7       (weight_in8               ),
    
    .valid_weight_in8 (valid_weight_in9         ),
    .weight_in8       (weight_in9               ),
    
    .valid_weight_in9 (valid_weight_in10        ),
    .weight_in9       (weight_in10              ),
    
    .valid_weight_in10(valid_weight_in11        ),
    .weight_in10      (weight_in11              ),
    
    .valid_weight_in11(valid_weight_in12        ),
    .weight_in11      (weight_in12              ),
    
    .valid_weight_in12(valid_weight_in13        ),
    .weight_in12      (weight_in13              ),
    
    .valid_weight_in13(valid_weight_in14        ),
    .weight_in13      (weight_in14              ),
    
    .valid_weight_in14(valid_weight_in15        ),
    .weight_in14      (weight_in15              ),
    
    .valid_weight_in15(valid_weight_in16        ),
    .weight_in15      (weight_in16              ),
    
    .valid_weight_in16(valid_weight_in17        ),
    .weight_in16      (weight_in17              ),
    
    .valid_weight_in17(valid_weight_in18        ),
    .weight_in17      (weight_in18              ),
    
    .valid_weight_in18(valid_weight_in19        ),
    .weight_in18      (weight_in19              ),
    
    .valid_weight_in19(valid_weight_in20        ),
    .weight_in19      (weight_in20              ),

    //output
    .out_layer1       (out_resnet18_layer1      ),
    .valid_out_layer1 (valid_out_resnet18_layer1),
    .pxl_out          (out_resnet18             ),
    .valid_out        (valid_out_resnet18       )
);

// ASPP
wire [DATA_WIDTH-1:0] out_aspp      ;
wire                  valid_out_aspp;

cnn_aspp #(
    .DATA_WIDTH  (DATA_WIDTH     ),
    .IMAGE_WIDTH (IMAGE_WIDTH/16 ),
    .IMAGE_HEIGHT(IMAGE_HEIGHT/16)
) aspp (
    .clk             (clk               ),
    .reset           (reset             ),
    .valid_in        (valid_out_resnet18),
    .pxl_in          (out_resnet18      ),
    
    .valid_weight_in1(valid_weight_in21 ),
    .weight_in1      (weight_in21       ),
    
    .valid_weight_in2(valid_weight_in22 ),
    .weight_in2      (weight_in22       ),
    
    .valid_weight_in3(valid_weight_in23 ),
    .weight_in3      (weight_in23       ),
    
    .valid_weight_in4(valid_weight_in24 ),
    .weight_in4      (weight_in24       ),
    
    .valid_weight_in5(valid_weight_in25 ),
    .weight_in5      (weight_in25       ),
    
    .valid_weight_in6(valid_weight_in26 ),
    .weight_in6      (weight_in26       ),
    
    .valid_weight_in7(valid_weight_in27 ),
    .weight_in7      (weight_in27       ),
    
    .valid_weight_in8(valid_weight_in28 ),
    .weight_in8      (weight_in28       ),
    
    //output
    .pxl_out         (out_aspp          ),
    .valid_out       (valid_out_aspp    )
);

// Conv 1x1 256
wire [DATA_WIDTH-1:0] out_conv1x1_1      ;
wire                  valid_out_conv1x1_1;

cnn_conv_09_1x1 #(
    .DATA_WIDTH     (DATA_WIDTH     ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/16 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/16),
    .CHANNEL_NUM_IN (1280           ),
    .CHANNEL_NUM_OUT(256            ),
    .KERNEL         (1              )
) conv1x1_1 (
    .clk            (clk                ),
    .reset          (reset              ),
    .valid_in       (valid_out_aspp     ),
    .pxl_in         (out_aspp           ),
    .valid_weight_in(valid_weight_in29  ),
    .weight_in      (weight_in29        ),
    //output
    .pxl_out        (out_conv1x1_1      ),
    .valid_out      (valid_out_conv1x1_1)
);

// ReLU
wire [DATA_WIDTH-1:0] out_relu_1      ;
wire                  valid_out_relu_1;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu1 (
    .clk      (clk                ),
    .reset    (reset              ),
    .valid_in (valid_out_conv1x1_1),
    .in       (out_conv1x1_1      ),
    //output
    .out      (out_relu_1         ),
    .valid_out(valid_out_relu_1   )
);

// Upsampling
wire [DATA_WIDTH-1:0] out_upsampling_1      ;
wire                  valid_out_upsampling_1;

cnn_upsampling_nn #(
    .DATA_WIDTH  (DATA_WIDTH     ),
    .IMAGE_WIDTH (IMAGE_WIDTH/16 ),
    .IMAGE_HEIGHT(IMAGE_HEIGHT/16),
    .CHANNEL_NUM (256            )
) upsampling1 (
    .clk      (clk                   ),
    .reset    (reset                 ),
    .valid_in (valid_out_relu_1      ),
    .pxl_in   (out_relu_1            ),
    //output
    .pxl_out  (out_upsampling_1      ),
    .valid_out(valid_out_upsampling_1)
);

// Conv 1x1 48
wire [DATA_WIDTH-1:0] out_conv1x1_2      ;
wire                  valid_out_conv1x1_2;

cnn_conv_10_1x1 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/4),
    .CHANNEL_NUM_IN (256           ),
    .CHANNEL_NUM_OUT(48            ),
    .KERNEL         (1             )
) conv1x1_2 (
    .clk            (clk                   ),
    .reset          (reset                 ),
    .valid_in       (valid_out_upsampling_1),
    .pxl_in         (out_upsampling_1      ),
    .valid_weight_in(valid_weight_in30     ),
    .weight_in      (weight_in30           ),
    //output
    .pxl_out        (out_conv1x1_2         ),
    .valid_out      (valid_out_conv1x1_2   )
);

// ReLU
wire [DATA_WIDTH-1:0] out_relu_2      ;
wire                  valid_out_relu_2;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu2 (
    .clk      (clk                ),
    .reset    (reset              ),
    .valid_in (valid_out_conv1x1_2),
    .in       (out_conv1x1_2      ),
    //output
    .out      (out_relu_2         ),
    .valid_out(valid_out_relu_2   )
);

// Conv 3x3 256
wire [DATA_WIDTH-1:0] out_conv3x3_1      ;
wire                  valid_out_conv3x3_1;

cnn_conv_18_3x3 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/4),
    .CHANNEL_NUM_IN (64            ),
    .CHANNEL_NUM_OUT(256           ),
    .KERNEL         (3             ),
    .RATE           (1             )
) conv3x3_1 (
    .clk            (clk                      ),
    .reset          (reset                    ),
    .valid_in       (valid_out_resnet18_layer1),
    .pxl_in         (out_resnet18_layer1      ),
    .valid_weight_in(valid_weight_in31        ),
    .weight_in      (weight_in31              ),
    //output
    .pxl_out        (out_conv3x3_1            ),
    .valid_out      (valid_out_conv3x3_1      )
);

// Conv 1x1 256
wire [DATA_WIDTH-1:0] out_conv1x1_3      ;
wire                  valid_out_conv1x1_3;

cnn_conv_11_1x1 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/4),
    .CHANNEL_NUM_IN (256           ),
    .CHANNEL_NUM_OUT(256           ),
    .KERNEL         (1             )
) conv1x1_3 (
    .clk            (clk                ),
    .reset          (reset              ),
    .valid_in       (valid_out_conv3x3_1),
    .pxl_in         (out_conv3x3_1      ),
    .valid_weight_in(valid_weight_in32  ),
    .weight_in      (weight_in32        ),
    //output
    .pxl_out        (out_conv1x1_3      ),
    .valid_out      (valid_out_conv1x1_3)
);

// ReLU
wire [DATA_WIDTH-1:0] out_relu_3      ;
wire                  valid_out_relu_3;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu3 (
    .clk      (clk                ),
    .reset    (reset              ),
    .valid_in (valid_out_conv1x1_3),
    .in       (out_conv1x1_3      ),
    //output
    .out      (out_relu_3         ),
    .valid_out(valid_out_relu_3   )
);

// Concat
wire [DATA_WIDTH-1:0] out_concat      ;
wire                  valid_out_concat;

cnn_concat_2in #(.DATA_WIDTH(DATA_WIDTH)) concat1 (
    .clk         (clk             ),
    .reset       (reset           ),
    .valid_in_no1(valid_out_relu_3),
    .in_no1      (out_relu_3      ),
    .valid_in_no2(valid_out_relu_2),
    .in_no2      (out_relu_2      ),
    //output
    .out         (out_concat      ),
    .valid_out   (valid_out_concat)
);

// Conv 3x3 304
wire [DATA_WIDTH-1:0] out_conv3x3_2      ;
wire                  valid_out_conv3x3_2;

cnn_conv_19_3x3 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/4),
    .CHANNEL_NUM_IN (304           ),
    .CHANNEL_NUM_OUT(304           ),
    .KERNEL         (3             ),
    .RATE           (1             )
) conv3x3_2 (
    .clk            (clk                ),
    .reset          (reset              ),
    .valid_in       (valid_out_concat   ),
    .pxl_in         (out_concat         ),
    .valid_weight_in(valid_weight_in33  ),
    .weight_in      (weight_in33        ),
    //output
    .pxl_out        (out_conv3x3_2      ),
    .valid_out      (valid_out_conv3x3_2)
);

// Conv 1x1 256
wire [DATA_WIDTH-1:0] out_conv1x1_4      ;
wire                  valid_out_conv1x1_4;

cnn_conv_12_1x1 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/4),
    .CHANNEL_NUM_IN (304           ),
    .CHANNEL_NUM_OUT(256           ),
    .KERNEL         (1             )
) conv1x1_4 (
    .clk            (clk                ),
    .reset          (reset              ),
    .valid_in       (valid_out_conv3x3_2),
    .pxl_in         (out_conv3x3_2      ),
    .valid_weight_in(valid_weight_in34  ),
    .weight_in      (weight_in34        ),
    //output
    .pxl_out        (out_conv1x1_4      ),
    .valid_out      (valid_out_conv1x1_4)
);

// ReLU
wire [DATA_WIDTH-1:0] out_relu_4      ;
wire                  valid_out_relu_4;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu4 (
    .clk      (clk                ),
    .reset    (reset              ),
    .valid_in (valid_out_conv1x1_4),
    .in       (out_conv1x1_4      ),
    //output
    .out      (out_relu_4         ),
    .valid_out(valid_out_relu_4   )
);

// Conv 1x1 7
wire [DATA_WIDTH-1:0] out_conv1x1_5      ;
wire                  valid_out_conv1x1_5;

cnn_conv_13_1x1 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/4),
    .CHANNEL_NUM_IN (256           ),
    .CHANNEL_NUM_OUT(7             ),
    .KERNEL         (1             )
) conv1x1_5 (
    .clk            (clk                ),
    .reset          (reset              ),
    .valid_in       (valid_out_relu_4   ),
    .pxl_in         (out_relu_4         ),
    .valid_weight_in(valid_weight_in35  ),
    .weight_in      (weight_in35        ),
    //output
    .pxl_out        (out_conv1x1_5      ),
    .valid_out      (valid_out_conv1x1_5)
);

// Upsampling
wire [DATA_WIDTH-1:0] out_upsampling_2      ;
wire                  valid_out_upsampling_2;

cnn_upsampling_nn #(
    .DATA_WIDTH  (DATA_WIDTH    ),
    .IMAGE_WIDTH (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT(IMAGE_HEIGHT/4),
    .CHANNEL_NUM (7             )
) upsampling2 (
    .clk      (clk                   ),
    .reset    (reset                 ),
    .valid_in (valid_out_conv1x1_5   ),
    .pxl_in   (out_conv1x1_5         ),
    //output
    .pxl_out  (out_upsampling_2      ),
    .valid_out(valid_out_upsampling_2)
);

// Sigmoid
cnn_sigmoid #(.DATA_WIDTH(DATA_WIDTH)) sigmoid (
    .clk      (clk                   ),
    .reset    (reset                 ),
    .valid_in (valid_out_upsampling_2),
    .in       (out_upsampling_2      ),
    //output
    .out      (pxl_out               ),
    .valid_out(valid_out             ),
    .done     (done                  )
);

// cnn_sigmoid_synth sigmoid (
//     .in_fp        (out_upsampling_2       ),
//     .out_fp       (pxl_out                ),
//     .clk          (clk                    ),
//     .rst_n        (!reset                 ),
//     .start        (valid_out_upsampling_2 ),
//     .done         (done                   ),
//     .rom_val      (sigmoid_in             ),
//     .addr         (sigmoid_addr           ),
//     .read_en      (sigmoid_read_en        ),
//     .top_overflow (/*no use top_overflow*/),
//     .top_underflow(/*top_underflow*/      )
// );

endmodule
