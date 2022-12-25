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

module cnn_resnet18 (
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

    ,out_layer1
    ,valid_out_layer1
    ,pxl_out
    ,valid_out
);

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH   = 32 ;
parameter IMAGE_WIDTH  = 512;
parameter IMAGE_HEIGHT = 512;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk             ;
input                  reset           ;
input                  valid_in        ;
input [DATA_WIDTH-1:0] pxl_in          ;
input                  valid_weight_in1;
input [DATA_WIDTH-1:0] weight_in1      ;

input                  valid_weight_in2;
input [DATA_WIDTH-1:0] weight_in2;

input                  valid_weight_in3;
input [DATA_WIDTH-1:0] weight_in3;

input                  valid_weight_in4;
input [DATA_WIDTH-1:0] weight_in4;

input                  valid_weight_in5;
input [DATA_WIDTH-1:0] weight_in5;

input                  valid_weight_in6;
input [DATA_WIDTH-1:0] weight_in6;

input                  valid_weight_in7;
input [DATA_WIDTH-1:0] weight_in7;

input                  valid_weight_in8;
input [DATA_WIDTH-1:0] weight_in8;

input                  valid_weight_in9;
input [DATA_WIDTH-1:0] weight_in9;

input                  valid_weight_in10;
input [DATA_WIDTH-1:0] weight_in10;

input                  valid_weight_in11;
input [DATA_WIDTH-1:0] weight_in11;

input                  valid_weight_in12;
input [DATA_WIDTH-1:0] weight_in12;

input                  valid_weight_in13;
input [DATA_WIDTH-1:0] weight_in13;

input                  valid_weight_in14;
input [DATA_WIDTH-1:0] weight_in14;

input                  valid_weight_in15;
input [DATA_WIDTH-1:0] weight_in15;

input                  valid_weight_in16;
input [DATA_WIDTH-1:0] weight_in16;

input                  valid_weight_in17;
input [DATA_WIDTH-1:0] weight_in17;

input                  valid_weight_in18;
input [DATA_WIDTH-1:0] weight_in18;

input                  valid_weight_in19;
input [DATA_WIDTH-1:0] weight_in19;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] out_layer1      ;
output                  valid_out_layer1;

output [DATA_WIDTH-1:0] pxl_out         ;
output                  valid_out       ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk            ;
wire                  reset          ;
wire                  valid_in       ;
wire [DATA_WIDTH-1:0] pxl_in         ;
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

wire [DATA_WIDTH-1:0] out_layer1      ;
wire                  valid_out_layer1;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

// Layer 1
resnet18_layer1 #(
  .DATA_WIDTH  (DATA_WIDTH  ),
  .IMAGE_WIDTH (IMAGE_WIDTH ),
  .IMAGE_HEIGHT(IMAGE_HEIGHT)
) layer1 (
  .clk             (clk             ),
  .reset           (reset           ),
  .valid_in        (valid_in        ),
  .pxl_in          (pxl_in          ),
  
  .valid_weight_in1(valid_weight_in1),
  .weight_in1      (weight_in1      ),
  
  .valid_weight_in2(valid_weight_in2),
  .weight_in2      (weight_in2      ),
  
  .valid_weight_in3(valid_weight_in3),
  .weight_in3      (weight_in3      ),
  
  .valid_weight_in4(valid_weight_in4),
  .weight_in4      (weight_in4      ),
  
  .pxl_out         (out_layer1      ),
  .valid_out       (valid_out_layer1)
);

// Layer 2
wire [DATA_WIDTH-1:0] out_layer2      ;
wire                  valid_out_layer2;

resnet18_layer2 #(
  .DATA_WIDTH  (DATA_WIDTH  ),
  .IMAGE_WIDTH (IMAGE_WIDTH ),
  .IMAGE_HEIGHT(IMAGE_HEIGHT)
) layer2 (
  .clk             (clk              ),
  .reset           (reset            ),
  .valid_in        (valid_out_layer1 ),
  .pxl_in          (out_layer1       ),
  
  .valid_weight_in1(valid_weight_in5 ),
  .weight_in1      (weight_in5       ),
  
  .valid_weight_in2(valid_weight_in6 ),
  .weight_in2      (weight_in6       ),
  
  .valid_weight_in3(valid_weight_in7 ),
  .weight_in3      (weight_in7       ),
  
  .valid_weight_in4(valid_weight_in8 ),
  .weight_in4      (weight_in8       ),
  
  .valid_weight_in5(valid_weight_in9),
  .weight_in5      (weight_in9      ),
  
  .pxl_out         (out_layer2       ),
  .valid_out       (valid_out_layer2 )
);

// Layer 3
wire [DATA_WIDTH-1:0] out_layer3      ;
wire                  valid_out_layer3;

resnet18_layer3 #(
  .DATA_WIDTH  (DATA_WIDTH    ),
  .IMAGE_WIDTH (IMAGE_WIDTH/2 ),
  .IMAGE_HEIGHT(IMAGE_HEIGHT/2)
) layer3 (
  .clk             (clk              ),
  .reset           (reset            ),
  .valid_in        (valid_out_layer2 ),
  .pxl_in          (out_layer2       ),
  
  .valid_weight_in1(valid_weight_in10),
  .weight_in1      (weight_in10      ),
  
  .valid_weight_in2(valid_weight_in11),
  .weight_in2      (weight_in11      ),
  
  .valid_weight_in3(valid_weight_in12),
  .weight_in3      (weight_in12      ),
  
  .valid_weight_in4(valid_weight_in13),
  .weight_in4      (weight_in13      ),
  
  .valid_weight_in5(valid_weight_in14),
  .weight_in5      (weight_in14      ),
  
  .pxl_out         (out_layer3       ),
  .valid_out       (valid_out_layer3 )
);

// Layer 4
resnet18_layer4 #(
  .DATA_WIDTH  (DATA_WIDTH    ),
  .IMAGE_WIDTH (IMAGE_WIDTH/4 ),
  .IMAGE_HEIGHT(IMAGE_HEIGHT/4)
) layer4 (
  .clk             (clk              ),
  .reset           (reset            ),
  .valid_in        (valid_out_layer3 ),
  .pxl_in          (out_layer3       ),
  
  .valid_weight_in1(valid_weight_in15),
  .weight_in1      (weight_in15      ),
  
  .valid_weight_in2(valid_weight_in16),
  .weight_in2      (weight_in16      ),
  
  .valid_weight_in3(valid_weight_in17),
  .weight_in3      (weight_in17      ),
  
  .valid_weight_in4(valid_weight_in18),
  .weight_in4      (weight_in18      ),
  
  .valid_weight_in5(valid_weight_in19),
  .weight_in5      (weight_in19      ),
  
  .pxl_out         (pxl_out          ),
  .valid_out       (valid_out        )
);


endmodule
