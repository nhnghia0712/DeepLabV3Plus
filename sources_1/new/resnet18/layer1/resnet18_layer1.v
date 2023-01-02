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

module resnet18_layer1 (
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

    ,pxl_out
    ,valid_out
);

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH   = 32;
parameter IMAGE_WIDTH  = 64;
parameter IMAGE_HEIGHT = 64;

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

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

// Basicblock x1
wire [DATA_WIDTH-1:0] out_first      ;
wire                  valid_out_first;

layer1_basicblock #(
    .DATA_WIDTH  (DATA_WIDTH  ),
    .IMAGE_WIDTH (IMAGE_WIDTH ),
    .IMAGE_HEIGHT(IMAGE_HEIGHT)
) basicblock1 (
    .clk             (clk             ),
    .reset           (reset           ),
    .valid_in        (valid_in        ),
    .pxl_in          (pxl_in          ),
    .valid_weight_in1(valid_weight_in1),
    .weight_in1      (weight_in1      ),
    .valid_weight_in2(valid_weight_in2),
    .weight_in2      (weight_in2      ),
    //output
    .pxl_out         (out_first       ),
    .valid_out       (valid_out_first )
);

// Basicblock x2
layer1_basicblock #(
    .DATA_WIDTH  (DATA_WIDTH  ),
    .IMAGE_WIDTH (IMAGE_WIDTH ),
    .IMAGE_HEIGHT(IMAGE_HEIGHT)
) basicblock2 (
    .clk             (clk             ),
    .reset           (reset           ),
    .valid_in        (valid_out_first ),
    .pxl_in          (out_first       ),
    .valid_weight_in1(valid_weight_in3),
    .weight_in1      (weight_in3      ),
    .valid_weight_in2(valid_weight_in4),
    .weight_in2      (weight_in4      ),
    //output
    .pxl_out         (pxl_out         ),
    .valid_out       (valid_out       )
);

endmodule
