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

    ,valid_weight_in53
    ,weight_in53

    ,valid_weight_in54
    ,weight_in54

    ,valid_weight_in55
    ,weight_in55

    ,valid_weight_in56
    ,weight_in56

    ,valid_weight_in57
    ,weight_in57

    ,valid_weight_in58
    ,weight_in58

    ,valid_weight_in59
    ,weight_in59

    ,valid_weight_in60
    ,weight_in60

    ,valid_weight_in61
    ,weight_in61

    ,valid_weight_in62
    ,weight_in62

    ,valid_weight_in63
    ,weight_in63

    ,valid_weight_in64
    ,weight_in64

    ,valid_weight_in65
    ,weight_in65

    ,valid_weight_in66
    ,weight_in66

    ,valid_weight_in67
    ,weight_in67

    ,valid_weight_in68
    ,weight_in68

    ,pxl_out
    ,valid_out
    ,done
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

input                  valid_weight_in36;
input [DATA_WIDTH-1:0] weight_in36      ;

input                  valid_weight_in37;
input [DATA_WIDTH-1:0] weight_in37      ;

input                  valid_weight_in38;
input [DATA_WIDTH-1:0] weight_in38      ;

input                  valid_weight_in39;
input [DATA_WIDTH-1:0] weight_in39      ;

input                  valid_weight_in40;
input [DATA_WIDTH-1:0] weight_in40      ;

input                  valid_weight_in41;
input [DATA_WIDTH-1:0] weight_in41      ;

input                  valid_weight_in42;
input [DATA_WIDTH-1:0] weight_in42      ;

input                  valid_weight_in43;
input [DATA_WIDTH-1:0] weight_in43      ;

input                  valid_weight_in44;
input [DATA_WIDTH-1:0] weight_in44      ;

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

input                  valid_weight_in53;
input [DATA_WIDTH-1:0] weight_in53      ;

input                  valid_weight_in54;
input [DATA_WIDTH-1:0] weight_in54      ;

input                  valid_weight_in55;
input [DATA_WIDTH-1:0] weight_in55      ;

input                  valid_weight_in56;
input [DATA_WIDTH-1:0] weight_in56      ;

input                  valid_weight_in57;
input [DATA_WIDTH-1:0] weight_in57      ;

input                  valid_weight_in58;
input [DATA_WIDTH-1:0] weight_in58      ;

input                  valid_weight_in59;
input [DATA_WIDTH-1:0] weight_in59      ;

input                  valid_weight_in60;
input [DATA_WIDTH-1:0] weight_in60      ;

input                  valid_weight_in61;
input [DATA_WIDTH-1:0] weight_in61      ;

input                  valid_weight_in62;
input [DATA_WIDTH-1:0] weight_in62      ;

input                  valid_weight_in63;
input [DATA_WIDTH-1:0] weight_in63      ;

input                  valid_weight_in64;
input [DATA_WIDTH-1:0] weight_in64      ;

input                  valid_weight_in65;
input [DATA_WIDTH-1:0] weight_in65      ;

input                  valid_weight_in66;
input [DATA_WIDTH-1:0] weight_in66      ;

input                  valid_weight_in67;
input [DATA_WIDTH-1:0] weight_in67      ;

input                  valid_weight_in68;
input [DATA_WIDTH-1:0] weight_in68      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;
output                  done     ;

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

wire                  valid_weight_in53;
wire [DATA_WIDTH-1:0] weight_in53      ;

wire                  valid_weight_in54;
wire [DATA_WIDTH-1:0] weight_in54      ;

wire                  valid_weight_in55;
wire [DATA_WIDTH-1:0] weight_in55      ;

wire                  valid_weight_in56;
wire [DATA_WIDTH-1:0] weight_in56      ;

wire                  valid_weight_in57;
wire [DATA_WIDTH-1:0] weight_in57      ;

wire                  valid_weight_in58;
wire [DATA_WIDTH-1:0] weight_in58      ;

wire                  valid_weight_in59;
wire [DATA_WIDTH-1:0] weight_in59      ;

wire                  valid_weight_in60;
wire [DATA_WIDTH-1:0] weight_in60      ;

wire                  valid_weight_in61;
wire [DATA_WIDTH-1:0] weight_in61      ;

wire                  valid_weight_in62;
wire [DATA_WIDTH-1:0] weight_in62      ;

wire                  valid_weight_in63;
wire [DATA_WIDTH-1:0] weight_in63      ;

wire                  valid_weight_in64;
wire [DATA_WIDTH-1:0] weight_in64      ;

wire                  valid_weight_in65;
wire [DATA_WIDTH-1:0] weight_in65      ;

wire                  valid_weight_in66;
wire [DATA_WIDTH-1:0] weight_in66      ;

wire                  valid_weight_in67;
wire [DATA_WIDTH-1:0] weight_in67      ;

wire                  valid_weight_in68;
wire [DATA_WIDTH-1:0] weight_in68      ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;
wire                  done     ;

// Conv 7x7
wire [DATA_WIDTH-1:0] out_conv7x7      ;
wire                  valid_out_conv7x7;

cnn_conv_7x7_3_64 #(
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

cnn_maxp_3x3_top_new #(
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
wire [DATA_WIDTH-1:0] out_resnet50      ;
wire                  valid_out_resnet50;

wire [DATA_WIDTH-1:0] out_resnet50_layer1      ;
wire                  valid_out_resnet50_layer1;

cnn_resnet50 #(
    .DATA_WIDTH  (DATA_WIDTH    ),
    .IMAGE_WIDTH (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT(IMAGE_HEIGHT/4)
) resnet50 (
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
    
    .valid_weight_in20(valid_weight_in21        ),
    .weight_in20      (weight_in21              ),
    
    .valid_weight_in21(valid_weight_in22        ),
    .weight_in21      (weight_in22              ),
    
    .valid_weight_in22(valid_weight_in23        ),
    .weight_in22      (weight_in23              ),
    
    .valid_weight_in23(valid_weight_in24        ),
    .weight_in23      (weight_in24              ),
    
    .valid_weight_in24(valid_weight_in25        ),
    .weight_in24      (weight_in25              ),
    
    .valid_weight_in25(valid_weight_in26        ),
    .weight_in25      (weight_in26              ),
    
    .valid_weight_in26(valid_weight_in27        ),
    .weight_in26      (weight_in27              ),
    
    .valid_weight_in27(valid_weight_in28        ),
    .weight_in27      (weight_in28              ),
    
    .valid_weight_in28(valid_weight_in29        ),
    .weight_in28      (weight_in29              ),
    
    .valid_weight_in29(valid_weight_in30        ),
    .weight_in29      (weight_in30              ),
    
    .valid_weight_in30(valid_weight_in31        ),
    .weight_in30      (weight_in31              ),
    
    .valid_weight_in31(valid_weight_in32        ),
    .weight_in31      (weight_in32              ),
    
    .valid_weight_in32(valid_weight_in33        ),
    .weight_in32      (weight_in33              ),
    
    .valid_weight_in33(valid_weight_in34        ),
    .weight_in33      (weight_in34              ),
    
    .valid_weight_in34(valid_weight_in35        ),
    .weight_in34      (weight_in35              ),
    
    .valid_weight_in35(valid_weight_in36        ),
    .weight_in35      (weight_in36              ),
    
    .valid_weight_in36(valid_weight_in37        ),
    .weight_in36      (weight_in37              ),
    
    .valid_weight_in37(valid_weight_in38        ),
    .weight_in37      (weight_in38              ),
    
    .valid_weight_in38(valid_weight_in39        ),
    .weight_in38      (weight_in39              ),
    
    .valid_weight_in39(valid_weight_in40        ),
    .weight_in39      (weight_in40              ),
    
    .valid_weight_in40(valid_weight_in41        ),
    .weight_in40      (weight_in41              ),
    
    .valid_weight_in41(valid_weight_in42        ),
    .weight_in41      (weight_in42              ),
    
    .valid_weight_in42(valid_weight_in43        ),
    .weight_in42      (weight_in43              ),
    
    .valid_weight_in43(valid_weight_in44        ),
    .weight_in43      (weight_in44              ),
    
    .valid_weight_in44(valid_weight_in45        ),
    .weight_in44      (weight_in45              ),
    
    .valid_weight_in45(valid_weight_in46        ),
    .weight_in45      (weight_in46              ),
    
    .valid_weight_in46(valid_weight_in47        ),
    .weight_in46      (weight_in47              ),
    
    .valid_weight_in47(valid_weight_in48        ),
    .weight_in47      (weight_in48              ),
    
    .valid_weight_in48(valid_weight_in49        ),
    .weight_in48      (weight_in49              ),
    
    .valid_weight_in49(valid_weight_in50        ),
    .weight_in49      (weight_in50              ),
    
    .valid_weight_in50(valid_weight_in51        ),
    .weight_in50      (weight_in51              ),
    
    .valid_weight_in51(valid_weight_in52        ),
    .weight_in51      (weight_in52              ),
    
    .valid_weight_in52(valid_weight_in53        ),
    .weight_in52      (weight_in53              ),
    
    //output
    .out_layer1       (out_resnet50_layer1      ),
    .valid_out_layer1 (valid_out_resnet50_layer1),
    .pxl_out          (out_resnet50             ),
    .valid_out        (valid_out_resnet50       )
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
    .valid_in        (valid_out_resnet50),
    .pxl_in          (out_resnet50      ),
    
    .valid_weight_in1(valid_weight_in54 ),
    .weight_in1      (weight_in54       ),
    
    .valid_weight_in2(valid_weight_in55 ),
    .weight_in2      (weight_in55       ),
    
    .valid_weight_in3(valid_weight_in56 ),
    .weight_in3      (weight_in56       ),
    
    .valid_weight_in4(valid_weight_in57 ),
    .weight_in4      (weight_in57       ),
    
    .valid_weight_in5(valid_weight_in58 ),
    .weight_in5      (weight_in58       ),
    
    .valid_weight_in6(valid_weight_in59 ),
    .weight_in6      (weight_in59       ),
    
    .valid_weight_in7(valid_weight_in60 ),
    .weight_in7      (weight_in60       ),
    
    .valid_weight_in8(valid_weight_in61 ),
    .weight_in8      (weight_in61       ),
    
    //output
    .pxl_out         (out_aspp          ),
    .valid_out       (valid_out_aspp    )
);

// Conv 1x1 256
wire [DATA_WIDTH-1:0] out_conv1x1_1      ;
wire                  valid_out_conv1x1_1;

cnn_conv_1x1_1280_256 #(
    .DATA_WIDTH     (DATA_WIDTH     ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/16 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/16),
    .CHANNEL_NUM_IN (1280           ),
    .CHANNEL_NUM_OUT(256            ),
    .KERNEL         (1              )
) conv1x1_1 (
    .clk            (clk                ),
    .reset          (reset              ),
    .stride2        (1'b0               ),
    .valid_in       (valid_out_aspp     ),
    .pxl_in         (out_aspp           ),
    .valid_weight_in(valid_weight_in62  ),
    .weight_in      (weight_in62        ),
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

cnn_conv_1x1_256_748641282565121024 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/4),
    .CHANNEL_NUM_IN (256           ),
    .CHANNEL_NUM_OUT(48            ),
    .KERNEL         (1             )
) conv1x1_2 (
    .clk            (clk                   ),
    .reset          (reset                 ),
    .stride2        (1'b0                  ),
    .valid_in       (valid_out_upsampling_1),
    .pxl_in         (out_upsampling_1      ),
    .valid_weight_in(valid_weight_in63     ),
    .weight_in      (weight_in63           ),
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

cnn_conv_3x3_256 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/4),
    .CHANNEL_NUM_IN (256           ),
    .CHANNEL_NUM_OUT(256           ),
    .KERNEL         (3             ),
    .RATE           (1             )
) conv3x3_1 (
    .clk            (clk                      ),
    .reset          (reset                    ),
    .valid_in       (valid_out_resnet50_layer1),
    .pxl_in         (out_resnet50_layer1      ),
    .valid_weight_in(valid_weight_in64        ),
    .weight_in      (weight_in64              ),
    .stride2        (1'b0                     ),
    //output
    .pxl_out        (out_conv3x3_1            ),
    .valid_out      (valid_out_conv3x3_1      )
);

// Conv 1x1 256
wire [DATA_WIDTH-1:0] out_conv1x1_3      ;
wire                  valid_out_conv1x1_3;

cnn_conv_1x1_256_748641282565121024 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/4),
    .CHANNEL_NUM_IN (256           ),
    .CHANNEL_NUM_OUT(256           ),
    .KERNEL         (1             )
) conv1x1_3 (
    .clk            (clk                ),
    .reset          (reset              ),
    .stride2        (1'b0               ),
    .valid_in       (valid_out_conv3x3_1),
    .pxl_in         (out_conv3x3_1      ),
    .valid_weight_in(valid_weight_in65  ),
    .weight_in      (weight_in65        ),
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
cnn_concat_2in_new #(
    .DATA_WIDTH       (DATA_WIDTH),
    .CHANNEL_NUM_PIXEL(1         )
) concat1 (
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

cnn_conv_3x3_304 #(
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
    .valid_weight_in(valid_weight_in66  ),
    .weight_in      (weight_in66        ),
    .stride2        (1'b0               ),
    //output
    .pxl_out        (out_conv3x3_2      ),
    .valid_out      (valid_out_conv3x3_2)
);

// Conv 1x1 256
wire [DATA_WIDTH-1:0] out_conv1x1_4      ;
wire                  valid_out_conv1x1_4;

cnn_conv_1x1_304_256 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/4),
    .CHANNEL_NUM_IN (304           ),
    .CHANNEL_NUM_OUT(256           ),
    .KERNEL         (1             )
) conv1x1_4 (
    .clk            (clk                ),
    .reset          (reset              ),
    .stride2        (1'b0               ),
    .valid_in       (valid_out_conv3x3_2),
    .pxl_in         (out_conv3x3_2      ),
    .valid_weight_in(valid_weight_in67  ),
    .weight_in      (weight_in67        ),
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

cnn_conv_1x1_256_748641282565121024 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/4 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/4),
    .CHANNEL_NUM_IN (256           ),
    .CHANNEL_NUM_OUT(7             ),
    .KERNEL         (1             )
) conv1x1_5 (
    .clk            (clk                ),
    .reset          (reset              ),
    .stride2        (1'b0               ),
    .valid_in       (valid_out_relu_4   ),
    .pxl_in         (out_relu_4         ),
    .valid_weight_in(valid_weight_in68  ),
    .weight_in      (weight_in68        ),
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
) upsampling1 (
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

endmodule
