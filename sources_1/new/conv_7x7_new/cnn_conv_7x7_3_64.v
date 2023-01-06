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

module cnn_conv_7x7_3_64 (
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
`include "D:/GitHub/CNNs/CNN_DeepLabV3Plus/CNN_DeepLabV3Plus.srcs/sources_1/new/param/param_def_conv_7x7_new.vh"

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

reg [DATA_WIDTH-1:0] pxl_out  ;
reg                  valid_out;

// Read loop data
wire [DATA_WIDTH-1:0] loop_data_out      ;
wire                  valid_loop_data_out;

conv_loop_data_in_new #(
	.DATA_WIDTH          (DATA_WIDTH          ),
	.CHANNEL_NUM_IN      (CHANNEL_NUM_IN      ),
	.CHANNEL_NUM_OUT     (CHANNEL_NUM_OUT     ),
	.IMAGE_WIDTH         (IMAGE_WIDTH         ),
	.CHANNEL_NUM_IN_PIXEL(CHANNEL_NUM_IN_PIXEL),
	.IMAGE_SIZE          (IMAGE_SIZE          ),
	.LOOP_CHANNEL_IN_CNT (LOOP_CHANNEL_IN_CNT ),
	.LOOP_COL_CNT        (LOOP_COL_CNT        ),
	.RATE                (3                   )
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

conv_7x7_top_new #(
	.DATA_WIDTH                  (DATA_WIDTH                  ),
	.IMAGE_WIDTH                 (IMAGE_WIDTH                 ),
	.IMAGE_HEIGHT                (IMAGE_HEIGHT                ),
	.CHANNEL_NUM_IN              (CHANNEL_NUM_IN              ),
	.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT             ),
	.KERNEL                      (KERNEL                      ),
	.IMAGE_SIZE                  (IMAGE_SIZE                  ),
	.CNT_WIDTH_BUFFER            (CNT_WIDTH_BUFFER            ),
	.POINTER_WIDTH_BUFFER_WEIGHTS(POINTER_WIDTH_BUFFER_WEIGHTS),
	.CNT_WIDTH_BUFFER_WEIGHTS    (CNT_WIDTH_BUFFER_WEIGHTS    )
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

// Align stride2 output
// wire [DATA_WIDTH-1:0] align_stride2_out      ;
// wire                  valid_align_stride2_out;

// conv_align_stride2_output #(
//   .DATA_WIDTH (DATA_WIDTH ),
//   .IMAGE_WIDTH(IMAGE_WIDTH)
// ) inst_aligns2 (
//   //input
//   .clk      (clk                    ),
//   .reset    (reset                  ),
//   .stride2  (stride2                ),
//   .valid_in (valid_out_conv         ),
//   .pxl_in   (pxl_out_conv           ),
//   //output
//   .pxl_out  (align_stride2_out      ),
//   .valid_out(valid_align_stride2_out)
// );

// Add
wire [DATA_WIDTH-1:0] adder_out      ;
wire                  valid_adder_out;

conv_3channel_adder_new #(
	.DATA_WIDTH             (DATA_WIDTH             ),
	.CHANNEL_NUM_IN         (CHANNEL_NUM_IN         ),
	.IMAGE_SIZE             (IMAGE_SIZE             ),
	.IMAGE_WIDTH            (IMAGE_WIDTH            ),
	.CHANNEL_NUM            (CHANNEL_NUM            ),
	.ADD_CHANNEL_IN_CNT     (ADD_CHANNEL_IN_CNT     ),
	.ADD_TEMP_CHANNEL_IN_CNT(ADD_TEMP_CHANNEL_IN_CNT),
	.RATE                   (3                      )
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
// parameter SHIFT_WIDTH = (((IMAGE_WIDTH * 3 ) + 3 + IMAGE_SIZE) * CHANNEL_NUM_IN) - IMAGE_SIZE/4;

// conv_align_output #(
// 	.DATA_WIDTH     (DATA_WIDTH     ),
// 	.CHANNEL_NUM_IN (CHANNEL_NUM_IN ),
// 	.IMAGE_WIDTH    (IMAGE_WIDTH    ),
// 	.IMAGE_SIZE     (IMAGE_SIZE     ),
// 	.RATE           (3              ),
// 	.CHANNEL_NUM_OUT(CHANNEL_NUM_OUT),
// 	.SHIFT_WIDTH    (SHIFT_WIDTH    )
// ) inst_align (
// 	//input
// 	.clk      (clk            ),
// 	.reset    (reset          ),
// 	.valid_in (valid_adder_out),
// 	.pxl_in   (adder_out      ),
// 	//output
// 	.pxl_out  (pxl_out        ),
// 	.valid_out(valid_out      )
// );

// FIFO
wire [DATA_WIDTH-1:0] pxl_out_fifo_1;
wire                  fifo_full_1   ;
wire                  fifo_empty_1  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_2;
wire                  fifo_full_2   ;
wire                  fifo_empty_2  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_3;
wire                  fifo_full_3   ;
wire                  fifo_empty_3  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_4;
wire                  fifo_full_4   ;
wire                  fifo_empty_4  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_5;
wire                  fifo_full_5   ;
wire                  fifo_empty_5  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_6;
wire                  fifo_full_6   ;
wire                  fifo_empty_6  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_7;
wire                  fifo_full_7   ;
wire                  fifo_empty_7  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_8;
wire                  fifo_full_8   ;
wire                  fifo_empty_8  ;

fifo_generator_0 inst_fifo1 (
	//input
	.clk  (clk               ),
	.srst (reset             ),
	.wr_en(valid_pxl_out_conv),
	.rd_en(fifo_full_8       ),
	.din  (adder_out         ),
	//output
	.dout (pxl_out_fifo_1    ),
	.full (fifo_full_1       ),
	.empty(fifo_empty_1      )
);

fifo_generator_0 inst_fifo2 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_adder_out & fifo_full_1),
	.rd_en(fifo_empty_1                 ),
	.din  (adder_out                    ),
	//output
	.dout (pxl_out_fifo_2               ),
	.full (fifo_full_2                  ),
	.empty(fifo_empty_2                 )
);

fifo_generator_0 inst_fifo3 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_adder_out & fifo_full_2),
	.rd_en(fifo_empty_2                 ),
	.din  (adder_out                    ),
	//output
	.dout (pxl_out_fifo_3               ),
	.full (fifo_full_3                  ),
	.empty(fifo_empty_3                 )
);

fifo_generator_0 inst_fifo4 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_adder_out & fifo_full_3),
	.rd_en(fifo_empty_3                 ),
	.din  (adder_out                    ),
	//output
	.dout (pxl_out_fifo_4               ),
	.full (fifo_full_4                  ),
	.empty(fifo_empty_4                 )
);

fifo_generator_0 inst_fifo5 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_adder_out & fifo_full_4),
	.rd_en(fifo_empty_4                 ),
	.din  (adder_out                    ),
	//output
	.dout (pxl_out_fifo_5               ),
	.full (fifo_full_5                  ),
	.empty(fifo_empty_5                 )
);

fifo_generator_0 inst_fifo6 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_adder_out & fifo_full_5),
	.rd_en(fifo_empty_5                 ),
	.din  (adder_out                    ),
	//output
	.dout (pxl_out_fifo_6               ),
	.full (fifo_full_6                  ),
	.empty(fifo_empty_6                 )
);

fifo_generator_0 inst_fifo7 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_adder_out & fifo_full_6),
	.rd_en(fifo_empty_6                 ),
	.din  (adder_out                    ),
	//output
	.dout (pxl_out_fifo_7               ),
	.full (fifo_full_7                  ),
	.empty(fifo_empty_7                 )
);

fifo_generator_0 inst_fifo8 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_adder_out & fifo_full_7),
	.rd_en(fifo_empty_7                 ),
	.din  (adder_out                    ),
	//output
	.dout (pxl_out_fifo_8               ),
	.full (fifo_full_8                  ),
	.empty(fifo_empty_8                 )
);

always @(posedge clk) begin
	if(reset) begin
		pxl_out <= 32'd0;
	end
	else begin
		case ({fifo_empty_7,fifo_empty_6,fifo_empty_5,fifo_empty_4,fifo_empty_3,fifo_empty_2,fifo_empty_1,fifo_full_8})
			8'd1    : pxl_out <= pxl_out_fifo_1;
			8'd2    : pxl_out <= pxl_out_fifo_2;
			8'd4    : pxl_out <= pxl_out_fifo_3;
			8'd8    : pxl_out <= pxl_out_fifo_4;
			8'd16   : pxl_out <= pxl_out_fifo_5;
			8'd32   : pxl_out <= pxl_out_fifo_6;
			8'd64   : pxl_out <= pxl_out_fifo_7;
			8'd128  : pxl_out <= pxl_out_fifo_8;
			default : pxl_out <= pxl_out;
		endcase
	end
end

reg valid_out_tmp;

always @(posedge clk) begin
	if(reset) begin
		valid_out_tmp <= 1'b0;
	end
	else begin
		valid_out_tmp <= (fifo_empty_8 & fifo_empty_7) | fifo_empty_6 | fifo_empty_5 | fifo_empty_4 | fifo_empty_3 | fifo_empty_2 | fifo_empty_1 | fifo_full_8;
	end
end

always @(posedge clk) begin
	if(reset) begin
		valid_out <= 1'b0;
	end
	else begin
		valid_out <= valid_out_tmp;
	end
end

endmodule