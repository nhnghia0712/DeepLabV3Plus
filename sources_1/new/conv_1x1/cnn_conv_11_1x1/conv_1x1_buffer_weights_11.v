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

module conv_1x1_buffer_weights_11 (
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
fifo_generator_1 inst_fifo08 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_out_buffer_weight_next),
	.rd_en(load_weights                ),
	.din  (out_buffer_weight_next      ),
	//output
	.dout (out_buffer_weight           ),
	.full (/*no use*/                  ),
	.empty(/*no use*/                  )
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