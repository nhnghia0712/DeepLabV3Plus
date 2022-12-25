`timescale 1ns / 1ps

module tb_resnet18_layer1 ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
	parameter DATA_WIDTH = 32;

// General
	parameter IMAGE_WIDTH  = 16; //Width
	parameter IMAGE_HEIGHT = 16; //Height

	localparam IMAGE_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/R.txt";
	localparam IMAGE_OUTPUT_FILE = "D:/GitHub/CNNs/Text_file/Output/Output_resnet18_layer1.txt";

	localparam WEIGHTS_INPUT_FILE_01 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_02 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_03 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_04 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";

	localparam SIMULATION_CLOCK = 5 ;
	localparam SIMULATION_CYCLE = 10;

// Localparam general
parameter  CHANNEL_NUM_IN_01  = 64                                    ; //The number of channel in
parameter  CHANNEL_NUM_OUT_01 = 64                                    ; //The number of channel out
parameter  KERNEL_01          = 3                                     ; //Kernel width
localparam KERNEL_SIZE_01     = KERNEL_01 * KERNEL_01                 ;
localparam CHANNEL_NUM_01     = CHANNEL_NUM_IN_01 * CHANNEL_NUM_OUT_01;
localparam WEIGHT_NUM_01      = CHANNEL_NUM_01 * KERNEL_SIZE_01       ; // 2x2x3x3

localparam IMAGE_SIZE_01           = IMAGE_WIDTH * IMAGE_HEIGHT       ;
localparam CHANNEL_NUM_IN_PIXEL_01 = CHANNEL_NUM_IN_01 * IMAGE_SIZE_01;

parameter  CHANNEL_NUM_IN_02  = 64                                    ; //The number of channel in
parameter  CHANNEL_NUM_OUT_02 = 64                                    ; //The number of channel out
parameter  KERNEL_02          = 3                                     ; //Kernel width
localparam KERNEL_SIZE_02     = KERNEL_02 * KERNEL_02                 ;
localparam CHANNEL_NUM_02     = CHANNEL_NUM_IN_02 * CHANNEL_NUM_OUT_02;
localparam WEIGHT_NUM_02      = CHANNEL_NUM_02 * KERNEL_SIZE_02       ; // 2x2x3x3

parameter  CHANNEL_NUM_IN_03  = 64                                    ; //The number of channel in
parameter  CHANNEL_NUM_OUT_03 = 64                                    ; //The number of channel out
parameter  KERNEL_03          = 3                                     ; //Kernel width
localparam KERNEL_SIZE_03     = KERNEL_03 * KERNEL_03                 ;
localparam CHANNEL_NUM_03     = CHANNEL_NUM_IN_03 * CHANNEL_NUM_OUT_03;
localparam WEIGHT_NUM_03      = CHANNEL_NUM_03 * KERNEL_SIZE_03       ; // 2x2x3x3

parameter  CHANNEL_NUM_IN_04  = 64                                    ; //The number of channel in
parameter  CHANNEL_NUM_OUT_04 = 64                                    ; //The number of channel out
parameter  KERNEL_04          = 3                                     ; //Kernel width
localparam KERNEL_SIZE_04     = KERNEL_04 * KERNEL_04                 ;
localparam CHANNEL_NUM_04     = CHANNEL_NUM_IN_04 * CHANNEL_NUM_OUT_04;
localparam WEIGHT_NUM_04      = CHANNEL_NUM_04 * KERNEL_SIZE_04       ; // 2x2x3x3

localparam ENDTIME = 6724230;

	reg                  clk             ;
	reg                  reset           ;
	reg                  valid_in        ;
	reg [DATA_WIDTH-1:0] pxl_in          ;
	reg                  valid_weight_in1;
	reg [DATA_WIDTH-1:0] weight_in1      ;
	reg                  valid_weight_in2;
	reg [DATA_WIDTH-1:0] weight_in2      ;
	reg                  valid_weight_in3;
	reg [DATA_WIDTH-1:0] weight_in3      ;
	reg                  valid_weight_in4;
	reg [DATA_WIDTH-1:0] weight_in4      ;

	wire [DATA_WIDTH-1:0] pxl_out  ;
	wire                  valid_out;


	integer i;

	reg [DATA_WIDTH-1:0] image_input [CHANNEL_NUM_IN_PIXEL_01-1:0];
	reg [DATA_WIDTH-1:0] image_output                             ;

	reg [DATA_WIDTH-1:0] weight_input_01[WEIGHT_NUM_01-1:0];
	reg [DATA_WIDTH-1:0] weight_input_02[WEIGHT_NUM_02-1:0];
	reg [DATA_WIDTH-1:0] weight_input_03[WEIGHT_NUM_03-1:0];
	reg [DATA_WIDTH-1:0] weight_input_04[WEIGHT_NUM_04-1:0];

	initial begin
		clk = 1'b0;
		i=0;
		valid_in = 1'b0;
		reset = 1'b1;
		valid_weight_in1 = 1'b0;
		valid_weight_in2 = 1'b0;
		valid_weight_in3 = 1'b0;
		valid_weight_in4 = 1'b0;
		#SIMULATION_CYCLE
			reset = 1'b0;
		valid_in <= 1'b0;
		valid_weight_in1 = 1'b0;
		valid_weight_in2 = 1'b0;
		valid_weight_in3 = 1'b0;
		valid_weight_in4 = 1'b0;

		$readmemb(IMAGE_INPUT_FILE, image_input);
		$readmemh(WEIGHTS_INPUT_FILE_01, weight_input_01);
		$readmemh(WEIGHTS_INPUT_FILE_02, weight_input_02);
		$readmemh(WEIGHTS_INPUT_FILE_03, weight_input_03);
		$readmemh(WEIGHTS_INPUT_FILE_04, weight_input_04);

		image_output = $fopen(IMAGE_OUTPUT_FILE);
	end

	always #(SIMULATION_CLOCK) clk = ~ clk;

	always @(posedge clk) begin
		pxl_in   <= image_input[i];
		valid_in <= 1'b1;
		if (i >= CHANNEL_NUM_IN_PIXEL_01) begin
			valid_in <= 1'b0;
		end
		weight_in1       <= weight_input_01[i];
		valid_weight_in1 <= 1'b1;
		if (i >= WEIGHT_NUM_01) begin
			valid_weight_in1 <= 1'b0;
		end
		weight_in2       <= weight_input_02[i];
		valid_weight_in2 <= 1'b1;
		if (i >= WEIGHT_NUM_02) begin
			valid_weight_in2 <= 1'b0;
		end
		weight_in3       <= weight_input_03[i];
		valid_weight_in3 <= 1'b1;
		if (i >= WEIGHT_NUM_03) begin
			valid_weight_in3 <= 1'b0;
		end
		weight_in4       <= weight_input_04[i];
		valid_weight_in4 <= 1'b1;
		if (i >= WEIGHT_NUM_04) begin
			valid_weight_in4 <= 1'b0;
		end
		#(SIMULATION_CYCLE) i <= i + 1'b1;
		if(valid_out)begin
			$fdisplay(image_output,"%h",pxl_out);
		end
		if(i == ENDTIME) begin
			$finish;
		end
	end

	resnet18_layer1 #(
		.DATA_WIDTH  (DATA_WIDTH  ),
		.IMAGE_WIDTH (IMAGE_WIDTH ),
		.IMAGE_HEIGHT(IMAGE_HEIGHT)
	) layer1 (
		.clk             (clk             ),
		.reset           (reset           ),
		.valid_in        (valid_in        ),
		.pxl_in          (pxl_in          ),
		
		.valid_weight_in1(valid_weight_in1),
		.weight_in1      (weight_in1      ),
		
		.valid_weight_in2(valid_weight_in2),
		.weight_in2      (weight_in2      ),
		
		.valid_weight_in3(valid_weight_in3),
		.weight_in3      (weight_in3      ),
		
		.valid_weight_in4(valid_weight_in4),
		.weight_in4      (weight_in4      ),
		
		.pxl_out         (pxl_out         ),
		.valid_out       (valid_out       )
	);

endmodule








