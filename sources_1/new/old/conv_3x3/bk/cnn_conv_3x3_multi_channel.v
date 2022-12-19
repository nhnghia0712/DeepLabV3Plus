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

module cnn_conv_3x3_multi_channel (
  clk, 
  reset,
  stride2,
  valid_in,
  pxl_in,
  valid_weight_in,
  weight_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
`include "D:/GitHub/CNNs/projectCNNs/projectCNNs.srcs/sources_1/new/param/param_def_conv_3x3.v"

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk            ;
input                  reset          ;
input                  valid_in       ;
input [DATA_WIDTH-1:0] pxl_in         ;
input                  stride2        ;
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
wire                  stride2        ;
wire                  valid_weight_in;
wire [DATA_WIDTH-1:0] weight_in      ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

// Read loop data
wire [DATA_WIDTH-1:0] loop_data_out      ;
wire                  valid_loop_data_out;

wire                  padding_read_req   ;
wire                  enable_padding     ;

conv_loop_data_in #(
	.DATA_WIDTH          (DATA_WIDTH          ),
	.CHANNEL_NUM_IN      (CHANNEL_NUM_IN      ),
	.CHANNEL_NUM_IN_PIXEL(CHANNEL_NUM_IN_PIXEL),
	.IMAGE_SIZE          (IMAGE_SIZE          ),
	.POINTER_WIDTH_LOOP  (POINTER_WIDTH_LOOP  )
) inst_loop (
	//input
	.clk      (clk                    ),
	.reset    (reset                  ),
	.write    (valid_in               ),
	.read     (padding_read_req       ),
	.data_in  (pxl_in                 ),
	//output
	.rd_ptr   (/*rd_ptr             */),
	.data_out (loop_data_out          ),
	.valid_out(/*valid_loop_data_out*/)
);

// Padding
wire [DATA_WIDTH-1:0] padding_out      ;
wire                  valid_padding_out;

conv_padding #(
	.DATA_WIDTH           (DATA_WIDTH           ),
	.IMAGE_WIDTH          (IMAGE_WIDTH          ),
	.IMAGE_HEIGHT         (IMAGE_HEIGHT         ),
	.PADDING              (PADDING              ),
	.CHANNEL_NUM          (CHANNEL_NUM          ),
	.IMAGE_SIZE           (IMAGE_SIZE           ),
	.CNT_PAD_H_1_WIDTH    (CNT_PAD_H_1_WIDTH    ),
	.CNT_PAD_H_2_WIDTH    (CNT_PAD_H_2_WIDTH    ),
	.CNT_PAD_WIDTH        (CNT_PAD_WIDTH        ),
	.CNT_PAD_WH_WIDTH     (CNT_PAD_WH_WIDTH     ),
	.CNT_PAD_CHANNEL_WIDTH(CNT_PAD_CHANNEL_WIDTH),
	.PAD_H                (PAD_H                )
) inst_padding (
	//input
	.clk      (clk              ),
	.reset    (reset            ),
	.enable   (valid_in         ),
	.data_in  (loop_data_out    ),
	//output
	.read_data(padding_read_req ),
	.data_out (padding_out      ),
	.valid_out(valid_padding_out)
);

// Conv
// wire [DATA_WIDTH-1:0] pxl_out_conv  ;
// wire                  valid_out_conv;

conv_3x3_top #(
	.DATA_WIDTH                  (DATA_WIDTH                  ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH                 ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT                ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN              ),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT             ),
	.PADDING                     (PADDING                     ),
	.KERNEL                      (KERNEL                      ),
	.IMAGE_SIZE                  (IMAGE_SIZE                  ),
	// .POINTER_WIDTH               (POINTER_WIDTH               ),
	.CNT_WIDTH_BUFFER_COL        (CNT_WIDTH_BUFFER_COL        ),
	.CNT_WIDTH_BUFFER_ROW        (CNT_WIDTH_BUFFER_ROW        ),
	.POINTER_WIDTH_BUFFER_WEIGHTS(POINTER_WIDTH_BUFFER_WEIGHTS),
	.CNT_WIDTH_BUFFER_WEIGHTS    (CNT_WIDTH_BUFFER_WEIGHTS    )
) inst_conv (
	//input
	.clk             (clk              ),
	.reset           (reset            ),
	.stride2         (stride2          ),
	.valid_in        (valid_padding_out),
	.pxl_in          (padding_out      ),
	.valid_weight_in (valid_weight_in  ),
	.weight_in       (weight_in        ),
	//output
	.pxl_out         (pxl_out          ),
	.valid_out       (valid_out        )
);

// Adder
// conv_adder_num_channel_in #(
// 	.DATA_WIDTH (DATA_WIDTH ),
// 	.IMAGE_WIDTH(IMAGE_SIZE ),
// 	.IMAGE_WIDTH(IMAGE_WIDTH)
// ) inst_adder (
// 	.clk      (clk           ),
// 	.reset    (reset         ),
// 	.valid_in (valid_out_conv),
// 	.pxl_in   (pxl_out_conv  ),
// 	//output
// 	.pxl_out  (pxl_out       ),
// 	.valid_out(valid_out     )
// );


endmodule