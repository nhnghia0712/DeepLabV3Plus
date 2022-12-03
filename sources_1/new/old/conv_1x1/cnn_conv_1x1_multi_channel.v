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

module cnn_conv_1x1_multi_channel (
  clk, 
  reset,
  valid_in,
  pxl_in,
  valid_weight_in,
  weight_in,
  stride2,
  
  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
`include "D:/GitHub/CNNs/projectCNNs/projectCNNs.srcs/sources_1/new/param/param_def_conv_1x1.v"

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk            ;
input                  reset          ;
input                  valid_in       ;
input [DATA_WIDTH-1:0] pxl_in         ;
input                  valid_weight_in;
input [DATA_WIDTH-1:0] weight_in      ;
input                  stride2        ;

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
wire                  stride2        ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

// Read loop data
wire [POINTER_WIDTH_LOOP-1:0] rd_ptr             ;
wire [        DATA_WIDTH-1:0] loop_data_out      ;
wire                          valid_loop_data_out;
reg                           read_req           ;

conv_loop_data_in #(
	.DATA_WIDTH          (DATA_WIDTH          ),
	.CHANNEL_NUM_IN      (CHANNEL_NUM_IN      ),
	.CHANNEL_NUM_IN_PIXEL(CHANNEL_NUM_IN_PIXEL),
	.IMAGE_SIZE          (IMAGE_SIZE          ),
	.POINTER_WIDTH_LOOP  (POINTER_WIDTH_LOOP  )
) inst_loop (
	//input
	.clk      (clk                ),
	.reset    (reset              ),
	.write    (valid_in           ),
	.read     (read_req           ),
	.data_in  (pxl_in             ),
	//output
	.rd_ptr   (rd_ptr             ),
	.data_out (loop_data_out      ),
	.valid_out(valid_loop_data_out)
);

///////////////////////////////////////////////////
// Read loop data
reg [CNT_WIDTH_LOOP-1:0] cnt_channel_out;
reg                      read_req_next  ;

always @(posedge clk) begin
	if(reset) begin
		cnt_channel_out <= {CNT_WIDTH_LOOP{1'b0}};
	end
	else if(rd_ptr == (CHANNEL_NUM_IN_PIXEL - 1) && read_req) begin
		cnt_channel_out <= cnt_channel_out + 1'b1;
	end
end

always @(posedge clk) begin
	if(reset) begin
		read_req_next <= 1'b0;
	end
	else if(cnt_channel_out < CHANNEL_NUM_OUT) begin
		read_req_next <= 1'b1;
	end
	else begin
		read_req_next <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		read_req <= 1'b0;
	end
	else begin
		read_req <= read_req_next;
	end
end
// Conv
conv_1x1_top #(
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
	.stride2        (stride2            ),
	//output
	.pxl_out        (pxl_out            ),
	.valid_out      (valid_out          )
);

endmodule