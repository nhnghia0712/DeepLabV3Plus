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

module layer1_idb1 (
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
parameter IMAGE_WIDTH  = 128;
parameter IMAGE_HEIGHT = 128;

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

wire [DATA_WIDTH-1:0] pxl_out         ;
wire                  valid_out       ;

// Conv1
wire [DATA_WIDTH-1:0] out_conv1      ;
wire                  valid_out_conv1;

cnn_conv_1x1_256_748641282565121024 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (256         ),
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

// Conv2
wire [DATA_WIDTH-1:0] out_conv2      ;
wire                  valid_out_conv2;

cnn_conv_3x3_64 #(
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
    .valid_in       (valid_out_conv1 ),
    .pxl_in         (out_conv1       ),
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

cnn_conv_1x1_64_64256 #(
    .DATA_WIDTH     (DATA_WIDTH  ),
    .IMAGE_WIDTH    (IMAGE_WIDTH ),
    .IMAGE_HEIGHT   (IMAGE_HEIGHT),
    .CHANNEL_NUM_IN (64          ),
    .CHANNEL_NUM_OUT(256         ),
    .KERNEL         (1           )
) conv3 (
    .clk            (clk             ),
    .reset          (reset           ),
    .valid_in       (valid_out_conv2 ),
    .pxl_in         (out_conv2       ),
    .valid_weight_in(valid_weight_in3),
    .weight_in      (weight_in3      ),
    .stride2        (1'b0            ),
    //output
    .pxl_out        (out_conv3       ),
    .valid_out      (valid_out_conv3 )
);

// ReLU
wire [DATA_WIDTH-1:0] out_relu      ;
wire                  valid_out_relu;

cnn_conv_relu #(.DATA_WIDTH(DATA_WIDTH)) relu1 (
    .clk      (clk            ),
    .reset    (reset          ),
    .valid_in (valid_out_conv3),
    .in       (out_conv3      ),
    //output
    .out      (out_relu       ),
    .valid_out(valid_out_relu )
);

// Line buffer
wire [DATA_WIDTH-1:0] out_line_buffer_tmp      ;
wire                  valid_out_line_buffer_tmp;

line_buffer #(
    .DIN_WIDTH  (DATA_WIDTH                 ),
    .IMAGE_WIDTH((4210888 + 1040548 + 1040374 + 1)/2),
    .KERNEL     (1                          )
) line_buffer1 (
    .clk      (clk                  ),
    .reset    (reset                ),
    .valid_in (valid_in             ),
    .data_in  (pxl_in               ),
    //output
    .data_out (out_line_buffer_tmp      ),
    .valid_out(valid_out_line_buffer_tmp)
);
    
wire [DATA_WIDTH-1:0] out_line_buffer      ;
wire                  valid_out_line_buffer;

line_buffer #(
    .DIN_WIDTH  (DATA_WIDTH                 ),
    .IMAGE_WIDTH((4210888 + 1040548 + 1040374 + 1)/2),
    .KERNEL     (1                          )
) line_buffer2 (
    .clk      (clk                  ),
    .reset    (reset                ),
    .valid_in (valid_out_line_buffer_tmp             ),
    .data_in  (out_line_buffer_tmp               ),
    //output
    .data_out (out_line_buffer      ),
    .valid_out(valid_out_line_buffer)
);
    
// Add
fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) add1 (
    .clk      (clk                                   ),
    .reset    (reset                                 ),
    .valid_in (valid_out_relu & valid_out_line_buffer),
    .in_a     (out_relu                              ),
    .in_b     (out_line_buffer                       ),
    //output
    .out      (pxl_out                               ),
    .valid_out(valid_out                             )
);

endmodule
