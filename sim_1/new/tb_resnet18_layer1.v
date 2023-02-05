`timescale 1ns / 1ps

module tb_resnet18_layer1 ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
	parameter DATA_WIDTH = 32;

// General
	parameter IMAGE_WIDTH  = 16; //Width
	parameter IMAGE_HEIGHT = 16; //Height

	localparam IMAGE_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/Input_image/1499_satR_h.txt";
	localparam IMAGE_OUTPUT_FILE = "D:/GitHub/CNNs/Text_file/Output/Output_connect_moduleR.txt";

	localparam WEIGHTS_INPUT_FILE_01 = "D:/GitHub/CNNs/Text_file/Input/Weight_hex/Encoder/encoder.conv1.weight.txt";
	localparam WEIGHTS_INPUT_FILE_02 = "D:/GitHub/CNNs/Text_file/Input/Weight_hex/Encoder/encoder.layer1.0.conv1.weight.txt";
	localparam WEIGHTS_INPUT_FILE_03 = "D:/GitHub/CNNs/Text_file/Input/Weight_hex/Encoder/encoder.layer1.0.conv2.weight.txt";
	localparam SIMULATION_CLOCK = 5 ;
	localparam SIMULATION_CYCLE = 10;

// Localparam general
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

	wire [DATA_WIDTH-1:0] pxl_out  ;
	wire                  valid_out;


	integer i;

	reg [DATA_WIDTH-1:0] image_input [(16*16*4)-1:0];
	reg [DATA_WIDTH-1:0] image_output               ;

	reg [DATA_WIDTH-1:0] weight_input_01[(7*7*4*4)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_02[(3*3*4*4)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_03[(1*1*4*4)-1:0];

	initial begin
		clk = 1'b0;
		i=0;
		valid_in = 1'b0;
		reset = 1'b1;
		valid_weight_in1 = 1'b0;
		valid_weight_in2 = 1'b0;
		valid_weight_in3 = 1'b0;
		#SIMULATION_CYCLE
			reset = 1'b0;

		$readmemh(IMAGE_INPUT_FILE, image_input);
		$readmemh(WEIGHTS_INPUT_FILE_01, weight_input_01);
		$readmemh(WEIGHTS_INPUT_FILE_02, weight_input_02);
		$readmemh(WEIGHTS_INPUT_FILE_03, weight_input_03);
		image_output = $fopen(IMAGE_OUTPUT_FILE);
	end

	always #(SIMULATION_CLOCK) clk = ~ clk;

	always @(posedge clk) begin
		if (!reset) begin
			pxl_in   <= image_input[i];
			valid_in <= 1'b1;
			if (i >= (16*16*4)) begin
				valid_in <= 1'b0;
			end
			weight_in1       <= weight_input_01[i];
			valid_weight_in1 <= 1'b1;
			if (i >= (7*7*4*4)) begin
				valid_weight_in1 <= 1'b0;
			end
			weight_in2       <= weight_input_02[i];
			valid_weight_in2 <= 1'b1;
			if (i >= (3*3*4*4)) begin
				valid_weight_in2 <= 1'b0;
			end
			weight_in3       <= weight_input_03[i];
			valid_weight_in3 <= 1'b1;
			if (i >= (1*1*4*4)) begin
				valid_weight_in3 <= 1'b0;
			end
			i <= i + 1'b1;
			#(SIMULATION_CYCLE)
				if(valid_out)begin
					$fdisplay(image_output,"%h",pxl_out);
				end
			if(i == ENDTIME) begin
				$finish;
			end
		end
	end

wire [DATA_WIDTH-1:0] out_1x1      ;
wire                  valid_out_1x1;

cnn_conv_1x1_test DUT_1x1 (
	.clk            (clk             ),
	.reset          (reset           ),
	.valid_in       (valid_in        ),
	.pxl_in         (pxl_in          ),
	.valid_weight_in(valid_weight_in3),
	.weight_in      (weight_in3      ),
	//output
	.pxl_out        (out_1x1         ),
	.valid_out      (valid_out_1x1   )
);

wire [DATA_WIDTH-1:0] out_3x3      ;
wire                  valid_out_3x3;

cnn_conv_3x3_test DUT_3x3 (
	.clk            (clk             ),
	.reset          (reset           ),
	.valid_in       (valid_out_1x1   ),
	.pxl_in         (out_1x1         ),
	.valid_weight_in(valid_weight_in2),
	.weight_in      (weight_in2      ),
	//output
	.pxl_out        (out_3x3         ),
	.valid_out      (valid_out_3x3   )
);

cnn_conv_7x7_test DUT_7x7 (
	.clk            (clk             ),
	.reset          (reset           ),
	.valid_in       (valid_out_3x3   ),
	.pxl_in         (out_3x3         ),
	.valid_weight_in(valid_weight_in1),
	.weight_in      (weight_in1      ),
	//output
	.pxl_out        (pxl_out         ),
	.valid_out      (valid_out       )
);

endmodule








