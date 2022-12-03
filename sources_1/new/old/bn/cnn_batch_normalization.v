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

module cnn_batch_normalization(
			reset,
			clk,
			valid_in,
			pxl_in,
			valid_weight_in,
			weight_in,
			valid_bias_in,
			bias_in,

			out,
			valid_out
);
/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter  DATA_WIDTH = 32;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  reset          ;
input                  clk            ;
input                  valid_in       ;
input [DATA_WIDTH-1:0] pxl_in         ;
input                  valid_weight_in;
input [DATA_WIDTH-1:0] weight_in      ;
input                  valid_bias_in  ;
input [DATA_WIDTH-1:0] bias_in        ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] out      ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  reset          ;
wire                  clk            ;
wire                  valid_in       ;
wire [DATA_WIDTH-1:0] pxl_in         ;
wire                  valid_weight_in;
wire [DATA_WIDTH-1:0] weight_in      ;
wire                  valid_bias_in  ;
wire [DATA_WIDTH-1:0] bias_in        ;

wire [DATA_WIDTH-1:0] out      ;
wire                  valid_out;

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_mul      ;
wire                  valid_out_mul;

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul (
	.reset    (reset                     ),
	.clk      (clk                       ),
	.valid_in (valid_in & valid_weight_in),
	.in_a     (pxl_in                    ),
	.in_b     (weight_in                 ),
	.out      (out_mul                   ),
	.valid_out(valid_out_mul             )
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul1 (
	.reset    (reset                        ),
	.clk      (clk                          ),
	.valid_in (valid_out_mul & valid_bias_in),
	.in_a     (valid_out_mul                ),
	.in_b     (bias_in                      ),
	.out      (out                          ),
	.valid_out(valid_out                    )
);

endmodule