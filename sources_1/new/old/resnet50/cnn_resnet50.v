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

module cnn_resnet50 (
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

   ,valid_weight_in36
   ,weight_in36

   ,valid_weight_in37
   ,weight_in37

   ,valid_weight_in38
   ,weight_in38

   ,valid_weight_in39
   ,weight_in39

   ,valid_weight_in40
   ,weight_in40

   ,valid_weight_in41
   ,weight_in41

   ,valid_weight_in42
   ,weight_in42

   ,valid_weight_in43
   ,weight_in43

   ,valid_weight_in44
   ,weight_in44

   ,valid_weight_in45
   ,weight_in45

   ,valid_weight_in46
   ,weight_in46

   ,valid_weight_in47
   ,weight_in47

   ,valid_weight_in48
   ,weight_in48

   ,valid_weight_in49
   ,weight_in49

   ,valid_weight_in50
   ,weight_in50

   ,valid_weight_in51
   ,weight_in51

   ,valid_weight_in52
   ,weight_in52

    ,out_layer1
    ,valid_out_layer1
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

input                  valid_weight_in20;
input [DATA_WIDTH-1:0] weight_in20;

input                  valid_weight_in21;
input [DATA_WIDTH-1:0] weight_in21;

input                  valid_weight_in22;
input [DATA_WIDTH-1:0] weight_in22;

input                  valid_weight_in23;
input [DATA_WIDTH-1:0] weight_in23;

input                  valid_weight_in24;
input [DATA_WIDTH-1:0] weight_in24;

input                  valid_weight_in25;
input [DATA_WIDTH-1:0] weight_in25;

input                  valid_weight_in26;
input [DATA_WIDTH-1:0] weight_in26;

input                  valid_weight_in27;
input [DATA_WIDTH-1:0] weight_in27;

input                  valid_weight_in28;
input [DATA_WIDTH-1:0] weight_in28;

input                  valid_weight_in29;
input [DATA_WIDTH-1:0] weight_in29;

input                  valid_weight_in30;
input [DATA_WIDTH-1:0] weight_in30;

input                  valid_weight_in31;
input [DATA_WIDTH-1:0] weight_in31;

input                  valid_weight_in32;
input [DATA_WIDTH-1:0] weight_in32;

input                  valid_weight_in33;
input [DATA_WIDTH-1:0] weight_in33;

input                  valid_weight_in34;
input [DATA_WIDTH-1:0] weight_in34;

input                  valid_weight_in35;
input [DATA_WIDTH-1:0] weight_in35;

input                  valid_weight_in36;
input [DATA_WIDTH-1:0] weight_in36;

input                  valid_weight_in37;
input [DATA_WIDTH-1:0] weight_in37;

input                  valid_weight_in38;
input [DATA_WIDTH-1:0] weight_in38;

input                  valid_weight_in39;
input [DATA_WIDTH-1:0] weight_in39;

input                  valid_weight_in40;
input [DATA_WIDTH-1:0] weight_in40;

input                  valid_weight_in41;
input [DATA_WIDTH-1:0] weight_in41;

input                  valid_weight_in42;
input [DATA_WIDTH-1:0] weight_in42;

input                  valid_weight_in43;
input [DATA_WIDTH-1:0] weight_in43;

input                  valid_weight_in44;
input [DATA_WIDTH-1:0] weight_in44;

input                  valid_weight_in45;
input [DATA_WIDTH-1:0] weight_in45      ;

input                  valid_weight_in46;
input [DATA_WIDTH-1:0] weight_in46      ;

input                  valid_weight_in47;
input [DATA_WIDTH-1:0] weight_in47      ;

input                  valid_weight_in48;
input [DATA_WIDTH-1:0] weight_in48      ;

input                  valid_weight_in49;
input [DATA_WIDTH-1:0] weight_in49      ;

input                  valid_weight_in50;
input [DATA_WIDTH-1:0] weight_in50      ;

input                  valid_weight_in51;
input [DATA_WIDTH-1:0] weight_in51      ;

input                  valid_weight_in52;
input [DATA_WIDTH-1:0] weight_in52      ;

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

wire                  valid_weight_in36;
wire [DATA_WIDTH-1:0] weight_in36      ;

wire                  valid_weight_in37;
wire [DATA_WIDTH-1:0] weight_in37      ;

wire                  valid_weight_in38;
wire [DATA_WIDTH-1:0] weight_in38      ;

wire                  valid_weight_in39;
wire [DATA_WIDTH-1:0] weight_in39      ;

wire                  valid_weight_in40;
wire [DATA_WIDTH-1:0] weight_in40      ;

wire                  valid_weight_in41;
wire [DATA_WIDTH-1:0] weight_in41      ;

wire                  valid_weight_in42;
wire [DATA_WIDTH-1:0] weight_in42      ;

wire                  valid_weight_in43;
wire [DATA_WIDTH-1:0] weight_in43      ;

wire                  valid_weight_in44;
wire [DATA_WIDTH-1:0] weight_in44      ;

wire                  valid_weight_in45;
wire [DATA_WIDTH-1:0] weight_in45      ;

wire                  valid_weight_in46;
wire [DATA_WIDTH-1:0] weight_in46      ;

wire                  valid_weight_in47;
wire [DATA_WIDTH-1:0] weight_in47      ;

wire                  valid_weight_in48;
wire [DATA_WIDTH-1:0] weight_in48      ;

wire                  valid_weight_in49;
wire [DATA_WIDTH-1:0] weight_in49      ;

wire                  valid_weight_in50;
wire [DATA_WIDTH-1:0] weight_in50      ;

wire                  valid_weight_in51;
wire [DATA_WIDTH-1:0] weight_in51      ;

wire                  valid_weight_in52;
wire [DATA_WIDTH-1:0] weight_in52      ;

wire [DATA_WIDTH-1:0] out_layer1      ;
wire                  valid_out_layer1;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

// Layer 1
resnet50_layer1 #(
  .DATA_WIDTH  (DATA_WIDTH  ),
  .IMAGE_WIDTH (IMAGE_WIDTH ),
  .IMAGE_HEIGHT(IMAGE_HEIGHT),
  .LOOP_NUMBER (2           )
) layer1 (
  .clk              (clk              ),
  .reset            (reset            ),
  .valid_in         (valid_in         ),
  .pxl_in           (pxl_in           ),
  
  .valid_weight_in1 (valid_weight_in1 ),
  .weight_in1       (weight_in1       ),
  
  .valid_weight_in2 (valid_weight_in2 ),
  .weight_in2       (weight_in2       ),
  
  .valid_weight_in3 (valid_weight_in3 ),
  .weight_in3       (weight_in3       ),
  
  .valid_weight_in4 (valid_weight_in4 ),
  .weight_in4       (weight_in4       ),
  
  .valid_weight_in5 (valid_weight_in5 ),
  .weight_in5       (weight_in5       ),
  
  .valid_weight_in6 (valid_weight_in6 ),
  .weight_in6       (weight_in6       ),
  
  .valid_weight_in7 (valid_weight_in7 ),
  .weight_in7       (weight_in7       ),
  
  .valid_weight_in8 (valid_weight_in8 ),
  .weight_in8       (weight_in8       ),
  
  .valid_weight_in9 (valid_weight_in9 ),
  .weight_in9       (weight_in9       ),
  
  .valid_weight_in10(valid_weight_in10),
  .weight_in10      (weight_in10      ),
  
  .pxl_out          (out_layer1       ),
  .valid_out        (valid_out_layer1 )
);

// Layer 2
wire [DATA_WIDTH-1:0] out_layer2      ;
wire                  valid_out_layer2;

resnet50_layer2 #(
  .DATA_WIDTH  (DATA_WIDTH  ),
  .IMAGE_WIDTH (IMAGE_WIDTH ),
  .IMAGE_HEIGHT(IMAGE_HEIGHT),
  .LOOP_NUMBER (3           )
) layer2 (
  .clk              (clk              ),
  .reset            (reset            ),
  .valid_in         (valid_out_layer1 ),
  .pxl_in           (out_layer1       ),
  
  .valid_weight_in1 (valid_weight_in11),
  .weight_in1       (weight_in11      ),
  
  .valid_weight_in2 (valid_weight_in12),
  .weight_in2       (weight_in12      ),
  
  .valid_weight_in3 (valid_weight_in13),
  .weight_in3       (weight_in13      ),
  
  .valid_weight_in4 (valid_weight_in14),
  .weight_in4       (weight_in14      ),
  
  .valid_weight_in5 (valid_weight_in15),
  .weight_in5       (weight_in15      ),
  
  .valid_weight_in6 (valid_weight_in16),
  .weight_in6       (weight_in16      ),
  
  .valid_weight_in7 (valid_weight_in17),
  .weight_in7       (weight_in17      ),
  
  .valid_weight_in8 (valid_weight_in18),
  .weight_in8       (weight_in18      ),
  
  .valid_weight_in9 (valid_weight_in19),
  .weight_in9       (weight_in19      ),
  
  .valid_weight_in10(valid_weight_in20),
  .weight_in10      (weight_in20      ),
  
  .valid_weight_in11(valid_weight_in21),
  .weight_in11      (weight_in21      ),
  
  .valid_weight_in12(valid_weight_in22),
  .weight_in12      (weight_in22      ),
  
  .valid_weight_in13(valid_weight_in23),
  .weight_in13      (weight_in23      ),
  
  .pxl_out          (out_layer2       ),
  .valid_out        (valid_out_layer2 )
);

// Layer 3
wire [DATA_WIDTH-1:0] out_layer3      ;
wire                  valid_out_layer3;

resnet50_layer3 #(
  .DATA_WIDTH  (DATA_WIDTH    ),
  .IMAGE_WIDTH (IMAGE_WIDTH/2 ),
  .IMAGE_HEIGHT(IMAGE_HEIGHT/2),
  .LOOP_NUMBER (5             )
) layer3 (
  .clk              (clk              ),
  .reset            (reset            ),
  .valid_in         (valid_out_layer2 ),
  .pxl_in           (out_layer2       ),
  
  .valid_weight_in1 (valid_weight_in24),
  .weight_in1       (weight_in24      ),
  
  .valid_weight_in2 (valid_weight_in25),
  .weight_in2       (weight_in25      ),
  
  .valid_weight_in3 (valid_weight_in26),
  .weight_in3       (weight_in26      ),
  
  .valid_weight_in4 (valid_weight_in27),
  .weight_in4       (weight_in27      ),
  
  .valid_weight_in5 (valid_weight_in28),
  .weight_in5       (weight_in28      ),
  
  .valid_weight_in6 (valid_weight_in29),
  .weight_in6       (weight_in29      ),
  
  .valid_weight_in7 (valid_weight_in30),
  .weight_in7       (weight_in30      ),
  
  .valid_weight_in8 (valid_weight_in31),
  .weight_in8       (weight_in31      ),
  
  .valid_weight_in9 (valid_weight_in32),
  .weight_in9       (weight_in32      ),
  
  .valid_weight_in10(valid_weight_in33),
  .weight_in10      (weight_in33      ),
  
  .valid_weight_in11(valid_weight_in34),
  .weight_in11      (weight_in34      ),
  
  .valid_weight_in12(valid_weight_in35),
  .weight_in12      (weight_in35      ),
  
  .valid_weight_in13(valid_weight_in36),
  .weight_in13      (weight_in36      ),
  
  .valid_weight_in14(valid_weight_in37),
  .weight_in14      (weight_in37      ),
  
  .valid_weight_in15(valid_weight_in38),
  .weight_in15      (weight_in38      ),
  
  .valid_weight_in16(valid_weight_in39),
  .weight_in16      (weight_in39      ),
  
  .valid_weight_in17(valid_weight_in40),
  .weight_in17      (weight_in40      ),
  
  .valid_weight_in18(valid_weight_in41),
  .weight_in18      (weight_in41      ),
  
  .valid_weight_in19(valid_weight_in42),
  .weight_in19      (weight_in42      ),
  
  .pxl_out          (out_layer3       ),
  .valid_out        (valid_out_layer3 )
);

// Layer 4
resnet50_layer4 #(
  .DATA_WIDTH  (DATA_WIDTH    ),
  .IMAGE_WIDTH (IMAGE_WIDTH/4 ),
  .IMAGE_HEIGHT(IMAGE_HEIGHT/4),
  .LOOP_NUMBER (2             )
) layer4 (
  .clk              (clk              ),
  .reset            (reset            ),
  .valid_in         (valid_out_layer3 ),
  .pxl_in           (out_layer3       ),
  
  .valid_weight_in1 (valid_weight_in43),
  .weight_in1       (weight_in43      ),
  
  .valid_weight_in2 (valid_weight_in44),
  .weight_in2       (weight_in44      ),
  
  .valid_weight_in3 (valid_weight_in45),
  .weight_in3       (weight_in45      ),
  
  .valid_weight_in4 (valid_weight_in46),
  .weight_in4       (weight_in46      ),
  
  .valid_weight_in5 (valid_weight_in47),
  .weight_in5       (weight_in47      ),
  
  .valid_weight_in6 (valid_weight_in48),
  .weight_in6       (weight_in48      ),
  
  .valid_weight_in7 (valid_weight_in49),
  .weight_in7       (weight_in49      ),
  
  .valid_weight_in8 (valid_weight_in50),
  .weight_in8       (weight_in50      ),
  
  .valid_weight_in9 (valid_weight_in51),
  .weight_in9       (weight_in51      ),
  
  .valid_weight_in10(valid_weight_in52),
  .weight_in10      (weight_in52      ),
  
  .pxl_out          (pxl_out          ),
  .valid_out        (valid_out        )
);


endmodule
