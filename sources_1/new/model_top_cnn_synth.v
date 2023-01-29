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

module model_top_cnn_synth (
    clk
    ,reset
    
    ,valid_in
    ,pxl_in

    ,valid_weight_in
    ,weight_in

    ,valid_weight_in8
    ,weight_in8

    ,valid_weight_in13
    ,weight_in13

    ,valid_weight_in18
    ,weight_in18

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

    ,valid_weight_in32
    ,weight_in32

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
input                  clk            ;
input                  reset          ;
input                  valid_in       ;
input [DATA_WIDTH-1:0] pxl_in         ;
input                  valid_weight_in;
input [DATA_WIDTH-1:0] weight_in      ;

input                  valid_weight_in8;
input [DATA_WIDTH-1:0] weight_in8      ;

input                  valid_weight_in13;
input [DATA_WIDTH-1:0] weight_in13      ;

input                  valid_weight_in18;
input [DATA_WIDTH-1:0] weight_in18      ;

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

input                  valid_weight_in32;
input [DATA_WIDTH-1:0] weight_in32      ;

// input [DATA_WIDTH-1:0] sigmoid_in;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

output done;
// output [4:0] sigmoid_addr   ;
// output       sigmoid_read_en;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk            ;
wire                  reset          ;
wire                  valid_in       ;
wire [DATA_WIDTH-1:0] pxl_in         ;
wire                  valid_weight_in;
wire [DATA_WIDTH-1:0] weight_in      ;

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

wire done;
// wire [4:0] sigmoid_addr   ;
// wire       sigmoid_read_en;

weights_distributor #(.DATA_WIDTH(DATA_WIDTH)) inst_weights_distributor (
    .clk              (clk              ),
    .reset            (reset            ),
    .valid_weight_in  (valid_weight_in  ),
    .weight_in        (weight_in        ),
    
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
    .valid_weight_in9 (valid_weight_in9 ),
    .weight_in9       (weight_in9       ),
    .valid_weight_in10(valid_weight_in10),
    .weight_in10      (weight_in10      ),
    .valid_weight_in11(valid_weight_in11),
    .weight_in11      (weight_in11      ),
    .valid_weight_in12(valid_weight_in12),
    .weight_in12      (weight_in12      ),
    .valid_weight_in14(valid_weight_in14),
    .weight_in14      (weight_in14      ),
    .valid_weight_in15(valid_weight_in15),
    .weight_in15      (weight_in15      ),
    .valid_weight_in16(valid_weight_in16),
    .weight_in16      (weight_in16      ),
    .valid_weight_in17(valid_weight_in17),
    .weight_in17      (weight_in17      ),
    .valid_weight_in19(valid_weight_in19),
    .weight_in19      (weight_in19      ),
    .valid_weight_in20(valid_weight_in20),
    .weight_in20      (weight_in20      ),
    .valid_weight_in29(valid_weight_in29),
    .weight_in29      (weight_in29      ),
    .valid_weight_in30(valid_weight_in30),
    .weight_in30      (weight_in30      ),
    .valid_weight_in31(valid_weight_in31),
    .weight_in31      (weight_in31      ),
    .valid_weight_in33(valid_weight_in33),
    .weight_in33      (weight_in33      ),
    .valid_weight_in34(valid_weight_in34),
    .weight_in34      (weight_in34      ),
    .valid_weight_in35(valid_weight_in35),
    .weight_in35      (weight_in35      )
);

top_cnn_synth #(
    .DATA_WIDTH  (DATA_WIDTH  ),
    .IMAGE_WIDTH (IMAGE_WIDTH ),
    .IMAGE_HEIGHT(IMAGE_HEIGHT)
) inst_top_cnn (
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
    .valid_weight_in11(valid_weight_in11),
    .weight_in11      (weight_in11      ),
    .valid_weight_in12(valid_weight_in12),
    .weight_in12      (weight_in12      ),
    .valid_weight_in13(valid_weight_in13),
    .weight_in13      (weight_in13      ),
    .valid_weight_in14(valid_weight_in14),
    .weight_in14      (weight_in14      ),
    .valid_weight_in15(valid_weight_in15),
    .weight_in15      (weight_in15      ),
    .valid_weight_in16(valid_weight_in16),
    .weight_in16      (weight_in16      ),
    .valid_weight_in17(valid_weight_in17),
    .weight_in17      (weight_in17      ),
    .valid_weight_in18(valid_weight_in18),
    .weight_in18      (weight_in18      ),
    .valid_weight_in19(valid_weight_in19),
    .weight_in19      (weight_in19      ),
    .valid_weight_in20(valid_weight_in20),
    .weight_in20      (weight_in20      ),
    .valid_weight_in21(valid_weight_in21),
    .weight_in21      (weight_in21      ),
    .valid_weight_in22(valid_weight_in22),
    .weight_in22      (weight_in22      ),
    .valid_weight_in23(valid_weight_in23),
    .weight_in23      (weight_in23      ),
    .valid_weight_in24(valid_weight_in24),
    .weight_in24      (weight_in24      ),
    .valid_weight_in25(valid_weight_in25),
    .weight_in25      (weight_in25      ),
    .valid_weight_in26(valid_weight_in26),
    .weight_in26      (weight_in26      ),
    .valid_weight_in27(valid_weight_in27),
    .weight_in27      (weight_in27      ),
    .valid_weight_in28(valid_weight_in28),
    .weight_in28      (weight_in28      ),
    .valid_weight_in29(valid_weight_in29),
    .weight_in29      (weight_in29      ),
    .valid_weight_in30(valid_weight_in30),
    .weight_in30      (weight_in30      ),
    .valid_weight_in31(valid_weight_in31),
    .weight_in31      (weight_in31      ),
    .valid_weight_in32(valid_weight_in32),
    .weight_in32      (weight_in32      ),
    .valid_weight_in33(valid_weight_in33),
    .weight_in33      (weight_in33      ),
    .valid_weight_in34(valid_weight_in34),
    .weight_in34      (weight_in34      ),
    .valid_weight_in35(valid_weight_in35),
    .weight_in35      (weight_in35      ),
    
    .sigmoid_in       (sigmoid_in       ),
    
    .pxl_out          (pxl_out          ),
    .done             (done             ),
    .sigmoid_addr     (sigmoid_addr     ),
    .sigmoid_read_en  (sigmoid_read_en  )
);

endmodule