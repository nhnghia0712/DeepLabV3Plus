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

module conv_1x1_buffer_weights (
  clk, 
  reset,
  valid_in,
  in,
  load_weights,

  out_buffer_weight,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// Parameter of submodules
parameter POINTER_WIDTH_BUFFER_WEIGHTS = 2; // $clog2(WEIGHT_NUM) + 1 // For Buffer Weights = log2(WEIGHT_NUM)

// Localparam
parameter WEIGHT_NUM  = 4; // 2x2x1x1

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk         ;
input                  reset       ;
input                  valid_in    ;
input [DATA_WIDTH-1:0] in          ;
input                  load_weights;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] out_buffer_weight;

output valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk        ;
wire                  reset      ;
wire                  valid_in   ;
wire [DATA_WIDTH-1:0] in         ;
wire                  load_weights;

wire [DATA_WIDTH-1:0] out_buffer_weight;

reg valid_out;


////////////////Buffer
wire [DATA_WIDTH-1:0] out_buffer_weight_next;

wire valid_out_buffer_weight_next;


d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff88 (
	.clk      (clk                         ),
	.reset    (reset                       ),
	.valid_in (valid_in                    ),
	.in       (in                          ),
	.out      (out_buffer_weight_next      ),
	.valid_out(valid_out_buffer_weight_next)
);

// FIFO
cnn_fifo_delay #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo08 (
	//input
	.clk     (clk                         ),
	.reset   (reset                       ),
	.write   (valid_out_buffer_weight_next),
	.read    (load_weights                ),
	.data_in (out_buffer_weight_next      ),
	//output
	.data_out(out_buffer_weight           ),
	.full    (/*no use*/                  ),
	.empty   (/*no use*/                  )
);

// DFF
always @(posedge clk) begin
	if(reset) begin
		valid_out <= 1'b0;
	end
	else if (load_weights) begin
		valid_out <= 1'b1;
	end
end
endmodule