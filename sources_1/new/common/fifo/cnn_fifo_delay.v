///////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Nguyen Hoang Nghia
//
// Create Date: Mon, May 13, 2022
// Design Name: FIFO
// Module Name: fifo.v
// Project Name: FIFO
// Target Device: 
// Tool Versions: 2019.2
// Description: Synchronous, Depth=8, Synthesizable, freq= 350MHz, RAM-based, not register-based
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
/////////////////////////////////////////////////////////////////////////
module cnn_fifo_delay (
	//input
	 clk
	,reset
	,write
	,read
	,data_in
	//output
	,data_out
	,full
	,empty
);

/////////////////////////////////////////////////////////////////////////
// Parameter
parameter DATA_WIDTH    = 32;
parameter DATA_DEPTH    = 13;
parameter POINTER_WIDTH = 4;

/////////////////////////////////////////////////////////////////////////
// Input
input                  clk    ;
input                  reset  ;
input                  write  ;
input                  read   ;
input [DATA_WIDTH-1:0] data_in;

/////////////////////////////////////////////////////////////////////////
// Output
output [DATA_WIDTH-1:0] data_out;
output                  full    ;
output                  empty   ;

/////////////////////////////////////////////////////////////////////////
// Logic
wire                  clk    ;
wire                  reset  ;
wire                  write  ;
wire                  read   ;
wire [DATA_WIDTH-1:0] data_in;

wire [DATA_WIDTH-1:0] data_out;

wire                  full    ;
wire                  empty   ;

wire [POINTER_WIDTH-1:0] wr_ptr;
wire [POINTER_WIDTH-1:0] rd_ptr;

fifo_status_signal_delay #(
	.DATA_DEPTH   (DATA_DEPTH   ),
	.POINTER_WIDTH(POINTER_WIDTH)
) inst1 (
	//input
	.reset (reset ),
	.clk   (clk   ),
	.write (write ),
	.read  (read  ),
	.wr_ptr(wr_ptr),
	.rd_ptr(rd_ptr),
	//output
	.full  (full  ),
	.empty (empty )
);

fifo_ram #(
	.DATA_WIDTH   (DATA_WIDTH   ),
	.DATA_DEPTH   (DATA_DEPTH   ),
	.POINTER_WIDTH(POINTER_WIDTH)
) inst2 (
	//input
	.clk     (clk     ),
	.reset   (reset   ),
	.write   (write   ),
	.read    (read    ),
	.full    (full    ),
	.empty   (empty   ),
	.wr_ptr  (wr_ptr  ),
	.rd_ptr  (rd_ptr  ),
	.data_in (data_in ),
	//output
	.data_out(data_out)
);

endmodule