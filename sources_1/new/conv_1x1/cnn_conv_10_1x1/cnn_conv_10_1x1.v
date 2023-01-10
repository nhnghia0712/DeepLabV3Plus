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

module cnn_conv_10_1x1 (
  clk, 
  reset,
  valid_in,
  pxl_in,
  valid_weight_in,
  weight_in,
  
  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
// General
parameter IMAGE_WIDTH     = 64 ; //Width
parameter IMAGE_HEIGHT    = 64 ; //Height
parameter CHANNEL_NUM_IN  = 256; //The number of channel in
parameter CHANNEL_NUM_OUT = 48 ; //The number of channel out
parameter KERNEL          = 1  ; //Kernel width

`include "D:/GitHub/CNNs/CNN_DeepLabV3Plus/CNN_DeepLabV3Plus.srcs/sources_1/new/param/param_def_conv_1x1.vh"

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk            ;
input                  reset          ;
input                  valid_in       ;
input [DATA_WIDTH-1:0] pxl_in         ;
input                  valid_weight_in;
input [DATA_WIDTH-1:0] weight_in      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk            ;
wire                  reset          ;
wire                  valid_in       ;
wire [DATA_WIDTH-1:0] pxl_in         ;
wire                  valid_weight_in;
wire [DATA_WIDTH-1:0] weight_in      ;

wire [DATA_WIDTH-1:0] pxl_out  ;
reg                   valid_out;

// Read loop data
wire [DATA_WIDTH-1:0] loop_data_out      ;
wire                  valid_loop_data_out;

conv_loop_data_in_64x64x256 #(
	.DATA_WIDTH          (DATA_WIDTH          ),
	.IMAGE_WIDTH         (IMAGE_WIDTH         ),
	.RATE                (1                   ),
	.CHANNEL_NUM_IN      (CHANNEL_NUM_IN      ),
	.CHANNEL_NUM_OUT     (CHANNEL_NUM_OUT     ),
	.CHANNEL_NUM_IN_PIXEL(CHANNEL_NUM_IN_PIXEL),
	.IMAGE_SIZE          (IMAGE_SIZE          )
) inst_loop (
	//input
	.clk      (clk                ),
	.reset    (reset              ),
	.valid_in (valid_in           ),
	.pxl_in   (pxl_in             ),
	//output
	.pxl_out  (loop_data_out      ),
	.valid_out(valid_loop_data_out)
);

// Conv
wire [DATA_WIDTH-1:0] pxl_out_conv  ;
wire                  valid_out_conv;

conv_1x1_top_10 #(
	.DATA_WIDTH                  (DATA_WIDTH                  ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH                 ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN              ),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT             ),
	.KERNEL                      (KERNEL                      ),
	.IMAGE_SIZE                  (IMAGE_SIZE                  ),
	.CNT_WIDTH_BUFFER            (CNT_WIDTH_BUFFER            ),
	.POINTER_WIDTH_BUFFER_WEIGHTS(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_conv (
	//input
	.clk            (clk                ),
	.reset          (reset              ),
	.valid_in       (valid_loop_data_out),
	.pxl_in         (loop_data_out      ),
	.valid_weight_in(valid_weight_in    ),
	.weight_in      (weight_in          ),
	//output
	.pxl_out        (pxl_out_conv       ),
	.valid_out      (valid_out_conv     )
);

// Add
wire [DATA_WIDTH-1:0] adder_out      ;
wire                  valid_adder_out;

conv_channel_in_adder_64x64 #(
	.DATA_WIDTH    (DATA_WIDTH    ),
	.CHANNEL_NUM_IN(CHANNEL_NUM_IN),
	.IMAGE_SIZE    (IMAGE_SIZE    )
) inst_add (
	//input
	.clk      (clk            ),
	.reset    (reset          ),
	.valid_in (valid_out_conv ),
	.pxl_in   (pxl_out_conv   ),
	//output
	.pxl_out  (adder_out      ),
	.valid_out(valid_adder_out)
);

// Align output
// FIFO
wire [DATA_WIDTH-1:0] pxl_out_fifo_1;
wire                  fifo_full_1   ;
wire                  fifo_empty_1  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_2;
wire                  fifo_full_2   ;
wire                  fifo_empty_2  ;

fifo_generator_0 inst_fifo1 (
	//input
	.clk  (clk           ),
	.srst (reset         ),
	.wr_en(valid_out_core),
	.rd_en(fifo_full_2   ),
	.din  (out_core      ),
	//output
	.dout (pxl_out_fifo_1),
	.full (fifo_full_1   ),
	.empty(fifo_empty_1  )
);

fifo_generator_1 inst_fifo2 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_out_core & fifo_full_1),
	.rd_en(fifo_empty_1                ),
	.din  (out_core                    ),
	//output
	.dout (pxl_out_fifo_2              ),
	.full (fifo_full_2                 ),
	.empty(fifo_empty_2                )
);

assign pxl_out = (fifo_full_2) ? pxl_out_fifo_1:pxl_out_fifo_2;

always @(posedge clk) begin
	if(reset) begin
		valid_out <= 1'b0;
	end
	else begin
		valid_out <= fifo_full_2 | (fifo_empty_1 & !fifo_empty_2);
	end
end

endmodule