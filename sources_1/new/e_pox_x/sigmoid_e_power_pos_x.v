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
module sigmoid_e_power_pos_x (
	clk
	,reset
	,valid_in
	,in 
	,out
	,valid_out
	
);
/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk     ;
input                  reset   ;
input                  valid_in;
input [DATA_WIDTH-1:0] in      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] out      ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk     ;
wire                  reset   ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] in      ;

wire [DATA_WIDTH-1:0] out      ;
wire                  valid_out;

wire [DATA_WIDTH-1:0] out_convert      ;
wire                  valid_out_convert;

wire [DATA_WIDTH-1:0] in_next      ;
wire                  valid_in_next;

wire [DATA_WIDTH-1:0] out_epa      ;
wire                  valid_out_epa;

wire [DATA_WIDTH-1:0] out_sub      ;
wire                  valid_out_sub;

// wire [DATA_WIDTH-1:0] out_mul_01      ;
// wire                  valid_out_mul_01;

epx_convert inst0 (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_in         ),
	.in       (in               ),
	.out      (out_convert      ),
	.valid_out(valid_out_convert)
);

epx_e_power_a inst1 (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_out_convert),
	.in       (out_convert      ),
	.out      (out_epa          ),
	.valid_out(valid_out_epa    )
);

wire [DATA_WIDTH-1:0] out_line_buffer1;

line_buffer #(
	.IMAGE_WIDTH(607       ),
	// .IMAGE_WIDTH(159       ),
	.KERNEL     (1         ),
	.DIN_WIDTH  (DATA_WIDTH)
) line_buffer2 (
	.clk      (clk             ),
	.reset    (reset           ),
	.valid_in (1'b1            ),
	.data_in  (out_epa         ),
	.data_out (out_line_buffer1),
	.valid_out(/* */           )
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3 (
	.clk      (clk          ),
	.reset    (reset        ),
	.valid_in (valid_in     ),
	.in       (in           ),
	.out      (in_next      ),
	.valid_out(valid_in_next)
);

fp_add_sub inst4 (
	.clk      (clk                                 ),
	.reset    (reset                               ),
	.valid_in (valid_in_next && valid_out_convert  ),
	.in_a     (in_next                             ),
	.in_b     ({!out_convert[31],out_convert[30:0]}),
	.out      (out_sub                             ),
	.valid_out(valid_out_sub                       )
);

fp_mul inst5 (
	.clk      (clk          ),
	.reset    (reset        ),
	.valid_in (valid_out_sub),
	.in_a     (out_sub      ),
	.in_b     (out_sub      ),
	.out      (out          ),
	.valid_out(valid_out    )
);
endmodule 	