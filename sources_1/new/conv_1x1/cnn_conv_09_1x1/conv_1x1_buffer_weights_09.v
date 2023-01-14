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

module conv_1x1_buffer_weights_09 (
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
// cnn_fifo_delay #(
// 	.DATA_WIDTH   (DATA_WIDTH                  ),
// 	.DATA_DEPTH   (WEIGHT_NUM                  ),
// 	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
// ) inst_fifo08 (
// 	//input
// 	.clk     (clk                         ),
// 	.reset   (reset                       ),
// 	.write   (valid_out_buffer_weight_next),
// 	.read    (load_weights                ),
// 	.data_in (out_buffer_weight_next      ),
// 	//output
// 	.data_out(out_buffer_weight           ),
// 	.full    (/*no use*/                  ),
// 	.empty   (/*no use*/                  )
// );
wire [DATA_WIDTH-1:0] out_buffer_weight_1;
wire                  fifo_full_1        ;
wire                  fifo_empty_1       ;

fifo_generator_0 inst_fifo01 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_out_buffer_weight_next),
	.rd_en(load_weights                ),
	.din  (out_buffer_weight_next      ),
	//output
	.dout (out_buffer_weight_1         ),
	.full (fifo_full_1                 ),
	.empty(fifo_empty_1                )
);

wire [DATA_WIDTH-1:0] out_buffer_weight_2;
wire                  fifo_full_2        ;
wire                  fifo_empty_2       ;

fifo_generator_0 inst_fifo02 (
	//input
	.clk  (clk                                       ),
	.srst (reset                                     ),
	.wr_en(valid_out_buffer_weight_next & fifo_full_1),
	.rd_en(load_weights & fifo_empty_1               ),
	.din  (out_buffer_weight_next                    ),
	//output
	.dout (out_buffer_weight_2                       ),
	.full (fifo_full_2                               ),
	.empty(fifo_empty_2                              )
);

wire [DATA_WIDTH-1:0] out_buffer_weight_3;

fifo_generator_0 inst_fifo03 (
	//input
	.clk  (clk                                       ),
	.srst (reset                                     ),
	.wr_en(valid_out_buffer_weight_next & fifo_full_2),
	.rd_en(load_weights & fifo_empty_2               ),
	.din  (out_buffer_weight_next                    ),
	//output
	.dout (out_buffer_weight_3                       ),
	.full (/*no use*/                                ),
	.empty(/*no use*/                                )
);

assign out_buffer_weight = (!fifo_empty_1) ? out_buffer_weight_1:((!fifo_empty_2) ? out_buffer_weight_2:out_buffer_weight_3);
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