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

module cnn_encoder (
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

    ,pxl_out
    ,valid_out

    ,out_layer1
    ,valid_out_layer1
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

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

output [DATA_WIDTH-1:0] out_layer1      ;
output                  valid_out_layer1;

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

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

wire [DATA_WIDTH-1:0] out_layer1      ;
wire                  valid_out_layer1;

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
cnn_resnet18 #(
    .DATA_WIDTH  (DATA_WIDTH    ),
    .IMAGE_WIDTH (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT(IMAGE_HEIGHT/4)
) resnet18 (
    .clk              (clk              ),
    .reset            (reset            ),
    .valid_in         (valid_out_maxp3x3),
    .pxl_in           (out_maxp3x3      ),
    
    .valid_weight_in1 (valid_weight_in2 ),
    .weight_in1       (weight_in2       ),
    
    .valid_weight_in2 (valid_weight_in3 ),
    .weight_in2       (weight_in3       ),
    
    .valid_weight_in3 (valid_weight_in4 ),
    .weight_in3       (weight_in4       ),
    
    .valid_weight_in4 (valid_weight_in5 ),
    .weight_in4       (weight_in5       ),
    
    .valid_weight_in5 (valid_weight_in6 ),
    .weight_in5       (weight_in6       ),
    
    .valid_weight_in6 (valid_weight_in7 ),
    .weight_in6       (weight_in7       ),
    
    .valid_weight_in7 (valid_weight_in8 ),
    .weight_in7       (weight_in8       ),
    
    .valid_weight_in8 (valid_weight_in9 ),
    .weight_in8       (weight_in9       ),
    
    .valid_weight_in9 (valid_weight_in10),
    .weight_in9       (weight_in10      ),
    
    .valid_weight_in10(valid_weight_in11),
    .weight_in10      (weight_in11      ),
    
    .valid_weight_in11(valid_weight_in12),
    .weight_in11      (weight_in12      ),
    
    .valid_weight_in12(valid_weight_in13),
    .weight_in12      (weight_in13      ),
    
    .valid_weight_in13(valid_weight_in14),
    .weight_in13      (weight_in14      ),
    
    .valid_weight_in14(valid_weight_in15),
    .weight_in14      (weight_in15      ),
    
    .valid_weight_in15(valid_weight_in16),
    .weight_in15      (weight_in16      ),
    
    .valid_weight_in16(valid_weight_in17),
    .weight_in16      (weight_in17      ),
    
    .valid_weight_in17(valid_weight_in18),
    .weight_in17      (weight_in18      ),
    
    .valid_weight_in18(valid_weight_in19),
    .weight_in18      (weight_in19      ),
    
    .valid_weight_in19(valid_weight_in20),
    .weight_in19      (weight_in20      ),
    
    //output
    .out_layer1       (out_layer1       ),
    .valid_out_layer1 (valid_out_layer1 ),
    .pxl_out          (pxl_out          ),
    .valid_out        (valid_out        )
);

endmodule
