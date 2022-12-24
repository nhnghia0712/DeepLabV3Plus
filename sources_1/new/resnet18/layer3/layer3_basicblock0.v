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

module layer3_basicblock0 (
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

    ,pxl_out
    ,valid_out
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

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

// Conv1
wire [DATA_WIDTH-1:0] out_conv1      ;
wire                  valid_out_conv1;

cnn_conv_3x3_128_128256 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (128         ),
    .CHANNEL_NUM_OUT(256         ),
    .KERNEL         (1           )
) conv1 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_in        ),
    .pxl_in         (pxl_in          ),
    .valid_weight_in(valid_weight_in1),
    .weight_in      (weight_in1      ),
    .stride2        (1'b1            ),
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
wire [DATA_WIDTH-1:0] out_conv2  ;
wire                  valid_out_conv2;

cnn_conv_3x3_256_256512 #(
    .DATA_WIDTH     (DATA_WIDTH    ),
    .IMAGE_WIDTH    (IMAGE_WIDTH/2 ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT/2),
    .CHANNEL_NUM_IN (256           ),
    .CHANNEL_NUM_OUT(256           ),
    .KERNEL         (3             ),
    .RATE           (1             )
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

// Conv3
wire [DATA_WIDTH-1:0] out_conv3      ;
wire                  valid_out_conv3;

cnn_conv_1x1_128_256 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (128         ),
    .CHANNEL_NUM_OUT(256         ),
    .KERNEL         (1           )
) conv4 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_in        ),
    .pxl_in         (pxl_in          ),
    .valid_weight_in(valid_weight_in3),
    .weight_in      (weight_in3      ),
    .stride2        (1'b1            ),
    //output
    .pxl_out        (out_conv3       ),
    .valid_out      (valid_out_conv3 )
);

// Add
cnn_add #(
    .DATA_WIDTH       (DATA_WIDTH                              ),
    .CHANNEL_NUM_PIXEL((IMAGE_WIDTH/2) * (IMAGE_HEIGHT/2) * 256)
) inst_add (
    .clk         (clk            ),
    .reset       (reset          ),
    .valid_in_no1(valid_out_conv2),
    .in_no1      (out_conv2      ),
    .valid_in_no2(valid_out_conv3),
    .in_no2      (out_conv3      ),
    //output
    .out         (pxl_out        ),
    .valid_out   (valid_out      )
);

endmodule
