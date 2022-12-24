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

module resnet50_layer3 (
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

    ,pxl_out
    ,valid_out
);

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH   = 32;
parameter IMAGE_WIDTH  = 64;
parameter IMAGE_HEIGHT = 64;
parameter LOOP_NUMBER  = 5 ;

parameter IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk              ;
input                  reset            ;
input                  valid_in         ;
input [DATA_WIDTH-1:0] pxl_in           ;
input                  valid_weight_in1 ;
input [DATA_WIDTH-1:0] weight_in1       ;
input                  valid_weight_in2 ;
input [DATA_WIDTH-1:0] weight_in2       ;
input                  valid_weight_in3 ;
input [DATA_WIDTH-1:0] weight_in3       ;
input                  valid_weight_in4 ;
input [DATA_WIDTH-1:0] weight_in4       ;
input                  valid_weight_in5 ;
input [DATA_WIDTH-1:0] weight_in5       ;
input                  valid_weight_in6 ;
input [DATA_WIDTH-1:0] weight_in6       ;
input                  valid_weight_in7 ;
input [DATA_WIDTH-1:0] weight_in7       ;
input                  valid_weight_in8 ;
input [DATA_WIDTH-1:0] weight_in8       ;
input                  valid_weight_in9 ;
input [DATA_WIDTH-1:0] weight_in9       ;
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

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk              ;
wire                  reset            ;
wire                  valid_in         ;
wire [DATA_WIDTH-1:0] pxl_in           ;
wire                  valid_weight_in1 ;
wire [DATA_WIDTH-1:0] weight_in1       ;
wire                  valid_weight_in2 ;
wire [DATA_WIDTH-1:0] weight_in2       ;
wire                  valid_weight_in3 ;
wire [DATA_WIDTH-1:0] weight_in3       ;
wire                  valid_weight_in4 ;
wire [DATA_WIDTH-1:0] weight_in4       ;
wire                  valid_weight_in5 ;
wire [DATA_WIDTH-1:0] weight_in5       ;
wire                  valid_weight_in6 ;
wire [DATA_WIDTH-1:0] weight_in6       ;
wire                  valid_weight_in7 ;
wire [DATA_WIDTH-1:0] weight_in7       ;
wire                  valid_weight_in8 ;
wire [DATA_WIDTH-1:0] weight_in8       ;
wire                  valid_weight_in9 ;
wire [DATA_WIDTH-1:0] weight_in9       ;
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

wire [DATA_WIDTH-1:0] pxl_out         ;
wire                  valid_out       ;

// ConvB3
wire [DATA_WIDTH-1:0] out_convb3      ;  
wire                  valid_out_convb3;

layer3_convb3 #(
    .DATA_WIDTH  (DATA_WIDTH  ),
    .IMAGE_WIDTH (IMAGE_WIDTH ),
    .IMAGE_HEIGHT(IMAGE_HEIGHT)
) convb3 (
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
    //output
    .pxl_out         (out_convb3      ),
    .valid_out       (valid_out_convb3)
);

// IdB1
wire [DATA_WIDTH-1:0] mem      [LOOP_NUMBER:0];
wire [ LOOP_NUMBER:0] valid_mem               ;

wire [ DATA_WIDTH-1:0] mem_weight1      [LOOP_NUMBER-1:0];
wire [LOOP_NUMBER-1:0] valid_mem_weight1                 ;

wire [ DATA_WIDTH-1:0] mem_weight2      [LOOP_NUMBER-1:0];
wire [LOOP_NUMBER-1:0] valid_mem_weight2                 ;

wire [ DATA_WIDTH-1:0] mem_weight3      [LOOP_NUMBER-1:0];
wire [LOOP_NUMBER-1:0] valid_mem_weight3                 ;

assign mem[0]       = out_convb2;
assign valid_mem[0] = valid_out_convb2;

assign mem_weight1[0]       = weight_in5;
assign valid_mem_weight1[0] = valid_weight_in5;
assign mem_weight1[1]       = weight_in8;
assign valid_mem_weight1[1] = valid_weight_in8;
assign mem_weight1[2]       = weight_in11;
assign valid_mem_weight1[2] = valid_weight_in11;
assign mem_weight1[3]       = weight_in14;
assign valid_mem_weight1[3] = valid_weight_in14;
assign mem_weight1[4]       = weight_in17;
assign valid_mem_weight1[4] = valid_weight_in17;

assign mem_weight2[0]       = weight_in6;
assign valid_mem_weight2[0] = valid_weight_in6;
assign mem_weight2[1]       = weight_in9;
assign valid_mem_weight2[1] = valid_weight_in9;
assign mem_weight2[2]       = weight_in12;
assign valid_mem_weight2[2] = valid_weight_in12;
assign mem_weight2[3]       = weight_in15;
assign valid_mem_weight2[3] = valid_weight_in15;
assign mem_weight2[4]       = weight_in18;
assign valid_mem_weight2[4] = valid_weight_in18;

assign mem_weight3[0]       = weight_in7;
assign valid_mem_weight3[0] = valid_weight_in7;
assign mem_weight3[1]       = weight_in10;
assign valid_mem_weight3[1] = valid_weight_in10;
assign mem_weight3[2]       = weight_in13;
assign valid_mem_weight3[2] = valid_weight_in13;
assign mem_weight3[3]       = weight_in16;
assign valid_mem_weight3[3] = valid_weight_in16;
assign mem_weight3[4]       = weight_in19;
assign valid_mem_weight3[4] = valid_weight_in19;

genvar i;

generate
    for (i = 0; i < LOOP_NUMBER; i = i + 1) begin
        layer3_idb3 #(
            .DATA_WIDTH  (DATA_WIDTH    ),
            .IMAGE_WIDTH (IMAGE_WIDTH/2 ),
            .IMAGE_HEIGHT(IMAGE_HEIGHT/2)
        ) idb3 (
            .clk             (clk                 ),
            .reset           (reset               ),
            .valid_in        (valid_mem[i]        ),
            .pxl_in          (mem[i]              ),
            .valid_weight_in1(valid_mem_weight1[i]),
            .weight_in1      (mem_weight1[i]      ),
            .valid_weight_in2(valid_mem_weight2[i]),
            .weight_in2      (mem_weight2[i]      ),
            .valid_weight_in3(valid_mem_weight3[i]),
            .weight_in3      (mem_weight3[i]      ),
            //output
            .pxl_out         (mem[i + 1]          ),
            .valid_out       (valid_mem[i + 1]    )
        );
    end
endgenerate

assign pxl_out   = mem      [LOOP_NUMBER];
assign valid_out = valid_mem[LOOP_NUMBER];

endmodule
