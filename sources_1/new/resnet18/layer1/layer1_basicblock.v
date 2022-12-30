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

module layer1_basicblock (
    clk
    ,reset
    
    ,valid_in
    ,pxl_in

    ,valid_weight_in1
    ,weight_in1

    ,valid_weight_in2
    ,weight_in2

    ,pxl_out
    ,valid_out
);

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH   = 32 ;
parameter IMAGE_WIDTH  = 512;
parameter IMAGE_HEIGHT = 512;

parameter IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT;

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

wire [DATA_WIDTH-1:0] pxl_out         ;
wire                  valid_out       ;

// Conv1
wire [DATA_WIDTH-1:0] out_conv1      ;
wire                  valid_out_conv1;

cnn_conv_3x3_64_64128 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (64          ),
    .CHANNEL_NUM_OUT(64          ),
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
wire [DATA_WIDTH-1:0] out_relu      ;
wire                  valid_out_relu;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu1 (
    .clk      (clk            ),
    .reset    (reset          ),
    .valid_in (valid_out_conv1),
    .in       (out_conv1      ),
    //output
    .out      (out_relu       ),
    .valid_out(valid_out_relu )
);

// Conv2
wire [DATA_WIDTH-1:0] out_conv2      ;
wire                  valid_out_conv2;

cnn_conv_3x3_64_64128 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (64          ),
    .CHANNEL_NUM_OUT(64          ),
    .KERNEL         (3           ),
    .RATE           (1           )
) conv2 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_out_relu  ),
    .pxl_in         (out_relu        ),
    .valid_weight_in(valid_weight_in2),
    .weight_in      (weight_in2      ),
    .stride2        (1'b0            ),
    //output
    .pxl_out        (out_conv2       ),
    .valid_out      (valid_out_conv2 )
);

// Add
parameter SHIFT_WIDTH = (8064 * IMAGE_SIZE) + (8192 * IMAGE_WIDTH) + 8393;

cnn_add #(
    .DATA_WIDTH (DATA_WIDTH ),
    .SHIFT_WIDTH(SHIFT_WIDTH)
) inst_add (
    .clk         (clk            ),
    .reset       (reset          ),
    .valid_in_no1(valid_out_conv2),
    .in_no1      (out_conv2      ),
    .valid_in_no2(valid_in       ),
    .in_no2      (pxl_in         ),
    //output
    .out         (pxl_out        ),
    .valid_out   (valid_out      )
);

endmodule
