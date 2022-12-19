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

module cnn_layer1 (
  clk, 
  reset,
  valid_in,
  pxl_in,

  valid_weight_in1,
  weight_in1,

  valid_weight_in2,
  weight_in2,

  valid_weight_in3,
  weight_in3,

  valid_weight_in4,
  weight_in4,

  valid_weight_in5,
  weight_in5,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

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
wire                  valid_weight_in4;
wire [DATA_WIDTH-1:0] weight_in4      ;
wire                  valid_weight_in5;
wire [DATA_WIDTH-1:0] weight_in5      ;

reg [DATA_WIDTH-1:0] pxl_out  ;
reg                  valid_out;

// Conv 1
wire [DATA_WIDTH-1:0] out_conv1      ;
wire                  valid_out_conv1;

cnn_conv_1x1_64_64256 #(
	.DATA_WIDTH     (DATA_WIDTH),
	.IMAGE_WIDTH    (12        ),
	.IMAGE_HEIGHT   (12        ),
	.CHANNEL_NUM_IN (64        ),
	.CHANNEL_NUM_OUT(64        ),
	.KERNEL         (1         )
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

// Mux sel_conv_id_01
wire [DATA_WIDTH-1:0] out_conv5      ;
wire                  valid_out_conv5;

wire [DATA_WIDTH-1:0] out_sel_01      ;
wire                  valid_out_sel_01;

assign out_sel_01       = (valid_out_conv5) ? out_conv5:out_conv1;
assign valid_out_sel_01 = (valid_out_conv5) ? valid_out_conv5:valid_out_conv1;

// Conv 2
wire [DATA_WIDTH-1:0] out_conv2      ;
wire                  valid_out_conv2;

cnn_conv_3x3_64 #(
	.DATA_WIDTH     (DATA_WIDTH),
	.IMAGE_WIDTH    (12        ),
	.IMAGE_HEIGHT   (12        ),
	.CHANNEL_NUM_IN (64        ),
	.CHANNEL_NUM_OUT(64        ),
	.KERNEL         (3         )
) conv2 (
	.clk            (clk             ),
	.reset          (reset           ),
	.valid_in       (valid_out_sel_01),
	.pxl_in         (out_sel_01      ),
	.valid_weight_in(valid_weight_in2),
	.weight_in      (weight_in2      ),
	.stride2        (1'b0            ),
	//output
	.pxl_out        (out_conv2       ),
	.valid_out      (valid_out_conv2 )
);

// Conv 3
wire [DATA_WIDTH-1:0] out_conv3      ;
wire                  valid_out_conv3;

cnn_conv_1x1_64_64256 #(
	.DATA_WIDTH     (DATA_WIDTH),
	.IMAGE_WIDTH    (12        ),
	.IMAGE_HEIGHT   (12        ),
	.CHANNEL_NUM_IN (64        ),
	.CHANNEL_NUM_OUT(256       ),
	.KERNEL         (1         )
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

// Conv 4
wire [DATA_WIDTH-1:0] out_conv4      ;
wire                  valid_out_conv4;

cnn_conv_1x1_64_64256 #(
	.DATA_WIDTH     (DATA_WIDTH),
	.IMAGE_WIDTH    (12        ),
	.IMAGE_HEIGHT   (12        ),
	.CHANNEL_NUM_IN (64        ),
	.CHANNEL_NUM_OUT(256       ),
	.KERNEL         (1         )
) conv4 (
	.clk            (clk             ),
	.reset          (reset           ),
	.valid_in       (valid_in        ),
	.pxl_in         (pxl_in          ),
	.valid_weight_in(valid_weight_in4),
	.weight_in      (weight_in4      ),
	.stride2        (1'b0            ),
	//output
	.pxl_out        (out_conv4       ),
	.valid_out      (valid_out_conv4 )
);

// Line buffer 1
wire [DATA_WIDTH-1:0] out_line_buffer1      ;
wire                  valid_out_line_buffer1;

line_buffer #(
	.IMAGE_WIDTH(64 * 64 * 12 * 12),
	.KERNEL     (1                ),
	.DIN_WIDTH  (DATA_WIDTH       )
) line_buffer1 (
	.clk      (clk                   ),
	.reset    (reset                 ),
	.valid_in (valid_out_conv4       ),
	.data_in  (out_conv4             ),
	.data_out (out_line_buffer1      ),
	.valid_out(valid_out_line_buffer1)
);


// Mux sel_conv_id_01
wire [DATA_WIDTH-1:0] out_line_buffer2      ;
wire                  valid_out_line_buffer2;

wire [DATA_WIDTH-1:0] out_sel_02      ;
wire                  valid_out_sel_02;

assign out_sel_02       = (valid_out_line_buffer2) ? out_line_buffer2:out_line_buffer1;
assign valid_out_sel_02 = (valid_out_line_buffer2) ? valid_out_line_buffer2:valid_out_line_buffer1;

// Add
wire [DATA_WIDTH-1:0] out_add      ;
wire                  valid_out_add;

fp_add_sub inst_add (
	.reset    (reset                             ),
	.clk      (clk                               ),
	.valid_in (valid_out_conv3 & valid_out_sel_02),
	.in_a     (out_conv3                         ),
	.in_b     (out_sel_02                        ),
	.out      (out_add                           ),
	.valid_out(valid_out_add                     )
);

// Conv 5
cnn_conv_1x1_256_748641282565121024 #(
	.DATA_WIDTH     (DATA_WIDTH),
	.IMAGE_WIDTH    (12        ),
	.IMAGE_HEIGHT   (12        ),
	.CHANNEL_NUM_IN (256       ),
	.CHANNEL_NUM_OUT(64        ),
	.KERNEL         (1         )
) conv5 (
	.clk            (clk             ),
	.reset          (reset           ),
	.valid_in       (valid_out_add   ),
	.pxl_in         (out_add         ),
	.valid_weight_in(valid_weight_in5),
	.weight_in      (weight_in5      ),
	.stride2        (1'b0            ),
	//output
	.pxl_out        (out_conv5       ),
	.valid_out      (valid_out_conv5 )
);

// Line buffer 2
line_buffer #(
	.IMAGE_WIDTH(64 * 256 * 12 * 12),
	.KERNEL     (1                 ),
	.DIN_WIDTH  (DATA_WIDTH        )
) line_buffer2 (
	.clk      (clk                   ),
	.reset    (reset                 ),
	.valid_in (valid_out_add         ),
	.data_in  (out_add               ),
	.data_out (out_line_buffer2      ),
	.valid_out(valid_out_line_buffer2)
);

// Mux output
always @(posedge clk) begin
	if(reset) begin
		pxl_out   <= 32'd0;
		valid_out <= 1'b0;
	end
	else if (valid_out_add) begin
		pxl_out   <= out_add;
		valid_out <= valid_out_add;
	end
end

endmodule