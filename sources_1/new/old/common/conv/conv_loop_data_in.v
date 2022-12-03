///////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Nguyen Hoang Nghia
//
// Create Date: Mon, May 13, 2022
// Design Name: 
// Module Name: 
// Project Name: 
// Target Device: 
// Tool Versions: 
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
/////////////////////////////////////////////////////////////////////////
module conv_loop_data_in (
	//input
	 clk
	,reset
	,write
	,read
	,data_in
	//output
	,rd_ptr
	,data_out
	,valid_out
);

/////////////////////////////////////////////////////////////////////////
// Parameter
parameter DATA_WIDTH         = 32;
parameter IMAGE_SIZE         = 36;
parameter CHANNEL_NUM_IN     = 1 ;
parameter POINTER_WIDTH_LOOP = 7 ; //$clog2(CHANNEL_NUM_IN_PIXEL) + 1

parameter CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE;

/////////////////////////////////////////////////////////////////////////
// Input
input                  clk    ;
input                  reset  ;
input                  read   ;
input                  write  ;
input [DATA_WIDTH-1:0] data_in;

/////////////////////////////////////////////////////////////////////////
// Output
output [POINTER_WIDTH_LOOP-1:0] rd_ptr   ;
output [        DATA_WIDTH-1:0] data_out ;
output                          valid_out;

/////////////////////////////////////////////////////////////////////////
// Logic
wire                  clk    ;
wire                  reset  ;
wire                  write  ;
wire                  read   ;
wire [DATA_WIDTH-1:0] data_in;

wire [DATA_WIDTH-1:0] data_out ;
wire                  valid_out;

wire [POINTER_WIDTH_LOOP-1:0] wr_ptr;
wire [POINTER_WIDTH_LOOP-1:0] rd_ptr;

loop_data_in_control #(
	.CHANNEL_NUM_IN_PIXEL(CHANNEL_NUM_IN_PIXEL),
	.POINTER_WIDTH_LOOP  (POINTER_WIDTH_LOOP  )
) inst1 (
	//input
	.reset (reset ),
	.clk   (clk   ),
	.write (write ),
	.read  (read  ),
	//output
	.wr_ptr(wr_ptr),
	.rd_ptr(rd_ptr)
);

loop_data_in_mem #(
	.DATA_WIDTH          (DATA_WIDTH          ),
	.CHANNEL_NUM_IN_PIXEL(CHANNEL_NUM_IN_PIXEL),
	.POINTER_WIDTH_LOOP  (POINTER_WIDTH_LOOP  )
) inst2 (
	//input
	.clk      (clk      ),
	.reset    (reset    ),
	.write    (write    ),
	.read     (read     ),
	.wr_ptr   (wr_ptr   ),
	.rd_ptr   (rd_ptr   ),
	.data_in  (data_in  ),
	//output
	.data_out (data_out ),
	.valid_out(valid_out)
);

endmodule