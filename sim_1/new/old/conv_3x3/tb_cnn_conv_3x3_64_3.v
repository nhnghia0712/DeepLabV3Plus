`timescale 1ns / 1ps

module tb_cnn_conv_3x3_64_3 ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
	parameter DATA_WIDTH = 32;

// General
	parameter IMAGE_WIDTH     = 128; //Width
	parameter IMAGE_HEIGHT    = 128; //Height
	parameter CHANNEL_NUM_IN  = 64 ; //The number of channel in
	parameter CHANNEL_NUM_OUT = 64 ; //The number of channel out
	parameter KERNEL          = 3  ; //Kernel width
	parameter RATE            = 1  ; //Rate of dialtion

	localparam IMAGE_INPUT_FILE_1 = "D:/GitHub/CNNs/Text_file/Input/R.txt";
	localparam WEIGHTS_INPUT_FILE_1 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam IMAGE_INPUT_FILE_2 = "D:/GitHub/CNNs/Text_file/Input/R.txt";
	localparam WEIGHTS_INPUT_FILE_2 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam IMAGE_INPUT_FILE_3 = "D:/GitHub/CNNs/Text_file/Input/R.txt";
	localparam WEIGHTS_INPUT_FILE_3 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam IMAGE_INPUT_FILE_4 = "D:/GitHub/CNNs/Text_file/Input/R.txt";
	localparam WEIGHTS_INPUT_FILE_4 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam IMAGE_INPUT_FILE_5 = "D:/GitHub/CNNs/Text_file/Input/R.txt";
	localparam WEIGHTS_INPUT_FILE_5 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam IMAGE_INPUT_FILE_6 = "D:/GitHub/CNNs/Text_file/Input/R.txt";
	localparam WEIGHTS_INPUT_FILE_6 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam IMAGE_INPUT_FILE_7 = "D:/GitHub/CNNs/Text_file/Input/R.txt";
	localparam WEIGHTS_INPUT_FILE_7 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam IMAGE_INPUT_FILE_8 = "D:/GitHub/CNNs/Text_file/Input/R.txt";
	localparam WEIGHTS_INPUT_FILE_8 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam IMAGE_OUTPUT_FILE = "D:/GitHub/CNNs/Text_file/Output/Output_cnn_conv_3x3_64_3.txt";

	localparam SIMULATION_CLOCK = 5 ;
	localparam SIMULATION_CYCLE = 10;

// Localparam general
	localparam KERNEL_SIZE          = KERNEL * KERNEL                 ;
	localparam CHANNEL_NUM          = CHANNEL_NUM_IN * CHANNEL_NUM_OUT;
	localparam IMAGE_SIZE           = IMAGE_WIDTH * IMAGE_HEIGHT      ;
	localparam CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE     ;
	localparam WEIGHT_NUM           = CHANNEL_NUM * KERNEL_SIZE       ; // 2x2x3x3

	localparam ENDTIME = (CHANNEL_NUM_IN_PIXEL/8) * CHANNEL_NUM_OUT;

	reg                  clk             ;
	reg                  reset           ;
	reg                  valid_in        ;
	reg                  stride2         ;
	reg                  valid_in1       ;
	reg [DATA_WIDTH-1:0] pxl_in1         ;
	reg                  valid_weight_in1;
	reg [DATA_WIDTH-1:0] weight_in1      ;
	reg                  valid_in2       ;
	reg [DATA_WIDTH-1:0] pxl_in2         ;
	reg                  valid_weight_in2;
	reg [DATA_WIDTH-1:0] weight_in2      ;
	reg                  valid_in3       ;
	reg [DATA_WIDTH-1:0] pxl_in3         ;
	reg                  valid_weight_in3;
	reg [DATA_WIDTH-1:0] weight_in3      ;
	reg                  valid_in4       ;
	reg [DATA_WIDTH-1:0] pxl_in4         ;
	reg                  valid_weight_in4;
	reg [DATA_WIDTH-1:0] weight_in4      ;
	reg                  valid_in5       ;
	reg [DATA_WIDTH-1:0] pxl_in5         ;
	reg                  valid_weight_in5;
	reg [DATA_WIDTH-1:0] weight_in5      ;
	reg                  valid_in6       ;
	reg [DATA_WIDTH-1:0] pxl_in6         ;
	reg                  valid_weight_in6;
	reg [DATA_WIDTH-1:0] weight_in6      ;
	reg                  valid_in7       ;
	reg [DATA_WIDTH-1:0] pxl_in7         ;
	reg                  valid_weight_in7;
	reg [DATA_WIDTH-1:0] weight_in7      ;
	reg                  valid_in8       ;
	reg [DATA_WIDTH-1:0] pxl_in8         ;
	reg                  valid_weight_in8;
	reg [DATA_WIDTH-1:0] weight_in8      ;

	wire [DATA_WIDTH-1:0] pxl_out  ;
	wire                  valid_out;


	integer i;

	reg [DATA_WIDTH-1:0] image_input_1 [(CHANNEL_NUM_IN_PIXEL/8)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_1[          (WEIGHT_NUM/8)-1:0];
	reg [DATA_WIDTH-1:0] image_input_2 [(CHANNEL_NUM_IN_PIXEL/8)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_2[          (WEIGHT_NUM/8)-1:0];
	reg [DATA_WIDTH-1:0] image_input_3 [(CHANNEL_NUM_IN_PIXEL/8)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_3[          (WEIGHT_NUM/8)-1:0];
	reg [DATA_WIDTH-1:0] image_input_4 [(CHANNEL_NUM_IN_PIXEL/8)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_4[          (WEIGHT_NUM/8)-1:0];
	reg [DATA_WIDTH-1:0] image_input_5 [(CHANNEL_NUM_IN_PIXEL/8)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_5[          (WEIGHT_NUM/8)-1:0];
	reg [DATA_WIDTH-1:0] image_input_6 [(CHANNEL_NUM_IN_PIXEL/8)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_6[          (WEIGHT_NUM/8)-1:0];
	reg [DATA_WIDTH-1:0] image_input_7 [(CHANNEL_NUM_IN_PIXEL/8)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_7[          (WEIGHT_NUM/8)-1:0];
	reg [DATA_WIDTH-1:0] image_input_8 [(CHANNEL_NUM_IN_PIXEL/8)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_8[          (WEIGHT_NUM/8)-1:0];
	reg [DATA_WIDTH-1:0] image_output                                ;

	initial begin
		clk = 1'b0;
		i=0;
		valid_in1 = 1'b0;
		valid_in2 = 1'b0;
		valid_in3 = 1'b0;
		valid_in4 = 1'b0;
		valid_in6 = 1'b0;
		valid_in5 = 1'b0;
		valid_in7 = 1'b0;
		valid_in8 = 1'b0;
		reset = 1'b1;
		valid_weight_in1 = 1'b0;
		valid_weight_in2 = 1'b0;
		valid_weight_in3 = 1'b0;
		valid_weight_in4 = 1'b0;
		valid_weight_in5 = 1'b0;
		valid_weight_in6 = 1'b0;
		valid_weight_in7 = 1'b0;
		valid_weight_in8 = 1'b0;
		stride2 = 1'b0;
		#SIMULATION_CYCLE
			reset = 1'b0;
		valid_in1 = 1'b0;
		valid_weight_in1 = 1'b0;
		valid_in2 = 1'b0;
		valid_weight_in2 = 1'b0;
		valid_in3 = 1'b0;
		valid_weight_in3 = 1'b0;
		valid_in4 = 1'b0;
		valid_weight_in4 = 1'b0;
		valid_in5 = 1'b0;
		valid_weight_in5 = 1'b0;
		valid_in6 = 1'b0;
		valid_weight_in6 = 1'b0;
		valid_in7 = 1'b0;
		valid_weight_in7 = 1'b0;
		valid_in8 = 1'b0;
		valid_weight_in8 = 1'b0;

		$readmemb(IMAGE_INPUT_FILE_1, image_input_1);
		$readmemh(WEIGHTS_INPUT_FILE_1, weight_input_1);
		$readmemb(IMAGE_INPUT_FILE_2, image_input_2);
		$readmemh(WEIGHTS_INPUT_FILE_2, weight_input_2);
		$readmemb(IMAGE_INPUT_FILE_3, image_input_3);
		$readmemh(WEIGHTS_INPUT_FILE_3, weight_input_3);
		$readmemb(IMAGE_INPUT_FILE_4, image_input_4);
		$readmemh(WEIGHTS_INPUT_FILE_4, weight_input_4);
		$readmemb(IMAGE_INPUT_FILE_5, image_input_5);
		$readmemh(WEIGHTS_INPUT_FILE_5, weight_input_5);
		$readmemb(IMAGE_INPUT_FILE_6, image_input_6);
		$readmemh(WEIGHTS_INPUT_FILE_6, weight_input_6);
		$readmemb(IMAGE_INPUT_FILE_7, image_input_7);
		$readmemh(WEIGHTS_INPUT_FILE_7, weight_input_7);
		$readmemb(IMAGE_INPUT_FILE_8, image_input_8);
		$readmemh(WEIGHTS_INPUT_FILE_8, weight_input_8);
		image_output = $fopen(IMAGE_OUTPUT_FILE);
	end

	always #(SIMULATION_CLOCK) clk = ~ clk;

	always @(posedge clk) begin
		pxl_in1   <= image_input_1[i];
		valid_in1 <= 1'b1;
		if (i >= CHANNEL_NUM_IN_PIXEL/8) begin
			valid_in1 <= 1'b0;
		end
		weight_in1       <= weight_input_1[i];
		valid_weight_in1 <= 1'b1;
		if (i >= WEIGHT_NUM/8) begin
			valid_weight_in1 <= 1'b0;
		end
		pxl_in2   <= image_input_2[i];
		valid_in2 <= 1'b1;
		if (i >= CHANNEL_NUM_IN_PIXEL/8) begin
			valid_in2 <= 1'b0;
		end
		weight_in2       <= weight_input_2[i];
		valid_weight_in2 <= 1'b1;
		if (i >= WEIGHT_NUM/8) begin
			valid_weight_in2 <= 1'b0;
		end
		pxl_in3   <= image_input_3[i];
		valid_in3 <= 1'b1;
		if (i >= CHANNEL_NUM_IN_PIXEL/8) begin
			valid_in3 <= 1'b0;
		end
		weight_in3       <= weight_input_3[i];
		valid_weight_in3 <= 1'b1;
		if (i >= WEIGHT_NUM/8) begin
			valid_weight_in3 <= 1'b0;
		end
		pxl_in4   <= image_input_4[i];
		valid_in4 <= 1'b1;
		if (i >= CHANNEL_NUM_IN_PIXEL/8) begin
			valid_in4 <= 1'b0;
		end
		weight_in4       <= weight_input_4[i];
		valid_weight_in4 <= 1'b1;
		if (i >= WEIGHT_NUM/8) begin
			valid_weight_in4 <= 1'b0;
		end
		pxl_in5   <= image_input_5[i];
		valid_in5 <= 1'b1;
		if (i >= CHANNEL_NUM_IN_PIXEL/8) begin
			valid_in5 <= 1'b0;
		end
		weight_in5       <= weight_input_5[i];
		valid_weight_in5 <= 1'b1;
		if (i >= WEIGHT_NUM/8) begin
			valid_weight_in5 <= 1'b0;
		end
		pxl_in6   <= image_input_6[i];
		valid_in6 <= 1'b1;
		if (i >= CHANNEL_NUM_IN_PIXEL/8) begin
			valid_in6 <= 1'b0;
		end
		weight_in6       <= weight_input_6[i];
		valid_weight_in6 <= 1'b1;
		if (i >= WEIGHT_NUM/8) begin
			valid_weight_in6 <= 1'b0;
		end
		pxl_in7   <= image_input_7[i];
		valid_in7 <= 1'b1;
		if (i >= CHANNEL_NUM_IN_PIXEL/8) begin
			valid_in7 <= 1'b0;
		end
		weight_in7       <= weight_input_7[i];
		valid_weight_in7 <= 1'b1;
		if (i >= WEIGHT_NUM/8) begin
			valid_weight_in7 <= 1'b0;
		end
		pxl_in8   <= image_input_8[i];
		valid_in8 <= 1'b1;
		if (i >= CHANNEL_NUM_IN_PIXEL/8) begin
			valid_in8 <= 1'b0;
		end
		weight_in8       <= weight_input_8[i];
		valid_weight_in8 <= 1'b1;
		if (i >= WEIGHT_NUM/8) begin
			valid_weight_in8 <= 1'b0;
		end
		#(SIMULATION_CYCLE) i <= i + 1'b1;
		if(valid_out == 1'b1)begin
			$fdisplay(image_output,"%h",pxl_out);
		end
		if(i == ENDTIME/8) begin
			$finish;
		end
	end

cnn_conv_3x3_64_3 #(
	.IMAGE_WIDTH    (IMAGE_WIDTH    ),
	.IMAGE_HEIGHT   (IMAGE_HEIGHT   ),
	.CHANNEL_NUM_IN (CHANNEL_NUM_IN ),
	.CHANNEL_NUM_OUT(CHANNEL_NUM_OUT),
	.KERNEL         (KERNEL         ),
	.RATE           (RATE           )
) DUT (
	.clk             (clk             ),
	.reset           (reset           ),
	.stride2         (stride2         ),
	.valid_in1       (valid_in1       ),
	.pxl_in1         (pxl_in1         ),
	.valid_weight_in1(valid_weight_in1),
	.weight_in1      (weight_in1      ),
	.valid_in2       (valid_in2       ),
	.pxl_in2         (pxl_in2         ),
	.valid_weight_in2(valid_weight_in2),
	.weight_in2      (weight_in2      ),
	.valid_in3       (valid_in3       ),
	.pxl_in3         (pxl_in3         ),
	.valid_weight_in3(valid_weight_in3),
	.weight_in3      (weight_in3      ),
	.valid_in4       (valid_in4       ),
	.pxl_in4         (pxl_in4         ),
	.valid_weight_in4(valid_weight_in4),
	.weight_in4      (weight_in4      ),
	.valid_in5       (valid_in5       ),
	.pxl_in5         (pxl_in5         ),
	.valid_weight_in5(valid_weight_in5),
	.weight_in5      (weight_in5      ),
	.valid_in6       (valid_in6       ),
	.pxl_in6         (pxl_in6         ),
	.valid_weight_in6(valid_weight_in6),
	.weight_in6      (weight_in6      ),
	.valid_in7       (valid_in7       ),
	.pxl_in7         (pxl_in7         ),
	.valid_weight_in7(valid_weight_in7),
	.weight_in7      (weight_in7      ),
	.valid_in8       (valid_in8       ),
	.pxl_in8         (pxl_in8         ),
	.valid_weight_in8(valid_weight_in8),
	.weight_in8      (weight_in8      ),
	//output
	.pxl_out         (pxl_out         ),
	.valid_out       (valid_out       )
);

endmodule








