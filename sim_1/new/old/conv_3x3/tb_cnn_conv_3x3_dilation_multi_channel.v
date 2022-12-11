`timescale 1ns / 1ps

module tb_cnn_conv_3x3_dilation_multi_channel ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// General
parameter IMAGE_WIDTH     = 306; //Width
parameter IMAGE_HEIGHT    = 306; //Height
parameter CHANNEL_NUM_IN  = 64 ; //The number of channel in
parameter CHANNEL_NUM_OUT = 64 ; //The number of channel out
parameter KERNEL          = 3  ; //Kernel width
parameter RATE            = 1  ; //Rate of dialtion

localparam IMAGE_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/R.txt";
localparam WEIGHTS_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
localparam IMAGE_OUTPUT_FILE = "D:/GitHub/CNNs/Text_file/Output/Output_cnn_conv_3x3_stride1_test.txt";

// Localparam general
localparam KERNEL_SIZE          = KERNEL * KERNEL                 ;
localparam CHANNEL_NUM          = CHANNEL_NUM_IN * CHANNEL_NUM_OUT;
localparam IMAGE_SIZE           = IMAGE_WIDTH * IMAGE_HEIGHT      ;
localparam CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE     ;
localparam WEIGHT_NUM           = CHANNEL_NUM * KERNEL_SIZE       ; // 2x2x3x3

// localparam ENDTIME          = 383634000;
localparam ENDTIME          = CHANNEL_NUM_IN_PIXEL * IMAGE_WIDTH;
localparam SIMULATION_CLOCK = 5                                 ;
localparam SIMULATION_CYCLE = 10                                ;

reg                  clk            ;
reg                  reset          ;
reg                  valid_in       ;
reg [DATA_WIDTH-1:0] pxl_in         ;
reg                  valid_weight_in;
reg [DATA_WIDTH-1:0] weight_in      ;
reg                  stride2        ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;


integer i;

reg [DATA_WIDTH-1:0] image_input [CHANNEL_NUM_IN_PIXEL-1:0];
reg [DATA_WIDTH-1:0] weight_input[          WEIGHT_NUM-1:0];
reg [DATA_WIDTH-1:0] image_output                          ;

initial begin
	clk = 0;
	i=0;
	valid_in = 1'b0;
	reset = 1;
	valid_weight_in = 1'b0;
	stride2 = 1'b0;
	#SIMULATION_CYCLE
		reset = 0;
	valid_in <= 1'b0;
	valid_weight_in = 1'b0;

	$readmemb(IMAGE_INPUT_FILE, image_input);
	$readmemh(WEIGHTS_INPUT_FILE, weight_input);

	image_output = $fopen(IMAGE_OUTPUT_FILE);
end

always #(SIMULATION_CLOCK) clk = ~ clk;

always @(posedge clk) begin
	pxl_in   <= image_input[i];
	valid_in <= 1'b1;
	if (i >= CHANNEL_NUM_IN_PIXEL) begin
		valid_in <= 1'b0;
	end
	weight_in       <= weight_input[i];
	valid_weight_in <= 1'b1;
	if (i >= WEIGHT_NUM) begin
		valid_weight_in <= 1'b0;
	end
	#(SIMULATION_CYCLE) i <= i + 1'b1;
	if(valid_out == 1'b1)begin
		$fdisplay(image_output,"%h",pxl_out);
	end
	if(i == ENDTIME) begin
		$finish;
	end
end

	cnn_conv_3x3_dilation_multi_channel_new #(
		.DATA_WIDTH                  (DATA_WIDTH                  ),
		.IMAGE_WIDTH                 (IMAGE_WIDTH                 ),
		.IMAGE_HEIGHT                (IMAGE_HEIGHT                ),
		.CHANNEL_NUM_IN              (CHANNEL_NUM_IN              ),
		.CHANNEL_NUM_OUT             (CHANNEL_NUM_OUT             ),
		.KERNEL                      (KERNEL                      ),
		.RATE                        (RATE                        )
	) DUT (
		.clk            (clk            ),
		.reset          (reset          ),
		.stride2        (stride2        ),
		.valid_in       (valid_in       ),
		.pxl_in         (pxl_in         ),
		.valid_weight_in(valid_weight_in),
		.weight_in      (weight_in      ),
		//output
		.pxl_out        (pxl_out        ),
		.valid_out      (valid_out      )
	);
endmodule








