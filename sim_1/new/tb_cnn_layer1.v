`timescale 1ns / 1ps

module tb_cnn_layer1 ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// General
parameter IMAGE_WIDTH     = 12; //Width
parameter IMAGE_HEIGHT    = 12; //Height
parameter CHANNEL_NUM_IN  = 64 ; //The number of channel in
parameter CHANNEL_NUM_OUT = 64 ; //The number of channel out

localparam IMAGE_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/R.txt";
localparam IMAGE_OUTPUT_FILE = "D:/GitHub/CNNs/Text_file/Output/Output_cnn_layer1.txt";

localparam WEIGHTS_INPUT_FILE_01 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
localparam WEIGHTS_INPUT_FILE_02 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
localparam WEIGHTS_INPUT_FILE_03 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
localparam WEIGHTS_INPUT_FILE_04 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
localparam WEIGHTS_INPUT_FILE_05 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
localparam WEIGHTS_INPUT_FILE_06 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
localparam WEIGHTS_INPUT_FILE_07 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
localparam WEIGHTS_INPUT_FILE_08 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
localparam WEIGHTS_INPUT_FILE_09 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
localparam WEIGHTS_INPUT_FILE_10 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";

localparam SIMULATION_CLOCK = 5 ;
localparam SIMULATION_CYCLE = 10;

// Localparam general
localparam IMAGE_SIZE           = IMAGE_WIDTH * IMAGE_HEIGHT ;
localparam CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE;

localparam WEIGHT_NUM_01 = 64 * 64    ;
localparam WEIGHT_NUM_02 = 64 * 64 * 9;
localparam WEIGHT_NUM_03 = 64 * 256   ;
localparam WEIGHT_NUM_04 = 64 * 256   ;
localparam WEIGHT_NUM_05 = 64 * 256   ;
localparam WEIGHT_NUM_06 = 64 * 64 * 9;
localparam WEIGHT_NUM_07 = 64 * 256   ;
localparam WEIGHT_NUM_08 = 64 * 256   ;
localparam WEIGHT_NUM_09 = 64 * 64 * 9;
localparam WEIGHT_NUM_10 = 64 * 256   ;

localparam ENDTIME = CHANNEL_NUM_IN_PIXEL * IMAGE_WIDTH;

reg                  clk             ;
reg                  reset           ;
reg                  valid_in        ;
reg                  stride2         ;
reg [DATA_WIDTH-1:0] pxl_in          ;
reg                  valid_weight_in1;
reg [DATA_WIDTH-1:0] weight_in1      ;
reg                  valid_weight_in2;
reg [DATA_WIDTH-1:0] weight_in2      ;
reg                  valid_weight_in3;
reg [DATA_WIDTH-1:0] weight_in3      ;
reg                  valid_weight_in4;
reg [DATA_WIDTH-1:0] weight_in4      ;
reg                  valid_weight_in5;
reg [DATA_WIDTH-1:0] weight_in5      ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;


integer i;

reg [DATA_WIDTH-1:0] image_input [CHANNEL_NUM_IN_PIXEL-1:0];
reg [DATA_WIDTH-1:0] image_output                          ;

reg [DATA_WIDTH-1:0] weight_input_01[WEIGHT_NUM_01-1:0];
reg [DATA_WIDTH-1:0] weight_input_02[WEIGHT_NUM_02-1:0];
reg [DATA_WIDTH-1:0] weight_input_03[WEIGHT_NUM_03-1:0];
reg [DATA_WIDTH-1:0] weight_input_04[WEIGHT_NUM_04-1:0];
reg [DATA_WIDTH-1:0] weight_input_05[WEIGHT_NUM_05-1:0];
reg [DATA_WIDTH-1:0] weight_input_06[WEIGHT_NUM_06-1:0];
reg [DATA_WIDTH-1:0] weight_input_07[WEIGHT_NUM_07-1:0];
reg [DATA_WIDTH-1:0] weight_input_08[WEIGHT_NUM_08-1:0];
reg [DATA_WIDTH-1:0] weight_input_09[WEIGHT_NUM_09-1:0];
reg [DATA_WIDTH-1:0] weight_input_10[WEIGHT_NUM_10-1:0];

initial begin
	clk = 1'b0;
	i=0;
	valid_in = 1'b0;
	reset = 1'b1;
	valid_weight_in1 = 1'b0;
	valid_weight_in2 = 1'b0;
	valid_weight_in3 = 1'b0;
	valid_weight_in4 = 1'b0;
	valid_weight_in5 = 1'b0;

	stride2 = 1'b0;
	#SIMULATION_CYCLE
		reset = 1'b0;
	valid_in <= 1'b0;
	valid_weight_in1 = 1'b0;
	valid_weight_in2 = 1'b0;
	valid_weight_in3 = 1'b0;
	valid_weight_in4 = 1'b0;
	valid_weight_in5 = 1'b0;

	$readmemb(IMAGE_INPUT_FILE, image_input);
	image_output = $fopen(IMAGE_OUTPUT_FILE);

	$readmemh(WEIGHTS_INPUT_FILE_01, weight_input_01);
	$readmemh(WEIGHTS_INPUT_FILE_02, weight_input_02);
	$readmemh(WEIGHTS_INPUT_FILE_03, weight_input_03);
	$readmemh(WEIGHTS_INPUT_FILE_04, weight_input_04);
	$readmemh(WEIGHTS_INPUT_FILE_05, weight_input_05);
	$readmemh(WEIGHTS_INPUT_FILE_06, weight_input_06);
	$readmemh(WEIGHTS_INPUT_FILE_07, weight_input_07);
	$readmemh(WEIGHTS_INPUT_FILE_08, weight_input_08);
	$readmemh(WEIGHTS_INPUT_FILE_09, weight_input_09);
	$readmemh(WEIGHTS_INPUT_FILE_10, weight_input_10);
end

always #(SIMULATION_CLOCK) clk = ~ clk;

always @(posedge clk) begin
	pxl_in   <= image_input[i];
	valid_in <= 1'b1;
	if (i >= CHANNEL_NUM_IN_PIXEL) begin
		valid_in <= 1'b0;
	end

	weight_in1       <= weight_input_01[i];
	valid_weight_in1 <= 1'b1;
	if (i >= WEIGHT_NUM_01) begin
		valid_weight_in1 <= 1'b0;
	end

	if (i < WEIGHT_NUM_02) begin
		weight_in2       <= weight_input_02[i];
		valid_weight_in2 <= 1'b1;
	end
	else if (i < WEIGHT_NUM_06 + WEIGHT_NUM_02) begin
		weight_in2       <= weight_input_06[i - WEIGHT_NUM_02];
		valid_weight_in2 <= 1'b1;
	end
	else if (i < WEIGHT_NUM_09 + WEIGHT_NUM_06 + WEIGHT_NUM_02) begin
		weight_in2       <= weight_input_09[i - WEIGHT_NUM_06 - WEIGHT_NUM_02];
		valid_weight_in2 <= 1'b1;
	end
	else begin
		valid_weight_in2 <= 1'b0;
	end

	if (i < WEIGHT_NUM_03) begin
		weight_in3       <= weight_input_03[i];
		valid_weight_in3 <= 1'b1;
	end
	else if (i < WEIGHT_NUM_07 + WEIGHT_NUM_03) begin
		weight_in3       <= weight_input_07[i - WEIGHT_NUM_03];
		valid_weight_in3 <= 1'b1;
	end
	else if (i < WEIGHT_NUM_10 + WEIGHT_NUM_07 + WEIGHT_NUM_03) begin
		weight_in3       <= weight_input_10[i - WEIGHT_NUM_07 - WEIGHT_NUM_03];
		valid_weight_in3 <= 1'b1;
	end
	else begin
		valid_weight_in3 <= 1'b0;
	end

	weight_in4       <= weight_input_04[i];
	valid_weight_in4 <= 1'b1;
	if (i >= WEIGHT_NUM_04) begin
		valid_weight_in4 <= 1'b0;
	end

	if (i < WEIGHT_NUM_05) begin
		weight_in5       <= weight_input_05[i];
		valid_weight_in5 <= 1'b1;
	end
	else if (i < WEIGHT_NUM_07 + WEIGHT_NUM_05) begin
		weight_in5       <= weight_input_08[i - WEIGHT_NUM_05];
		valid_weight_in5 <= 1'b1;
	end
	else begin
		valid_weight_in5 <= 1'b0;
	end

	#(SIMULATION_CYCLE) i <= i + 1'b1;
	if(valid_out == 1'b1)begin
		$fdisplay(image_output,"%h",pxl_out);
	end
	if(i == ENDTIME) begin
		$finish;
	end
end

	cnn_layer1 DUT (
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
		.valid_weight_in5(valid_weight_in5),
		.weight_in5      (weight_in5      ),
		//output
		.pxl_out         (pxl_out         ),
		.valid_out       (valid_out       )
	);
endmodule








