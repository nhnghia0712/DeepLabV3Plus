`timescale 1ns / 1ps

module tb_model_top_cnn ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// General
	parameter IMAGE_WIDTH    = 256; //Width
	parameter IMAGE_HEIGHT   = 256; //Height
	parameter CHANNEL_NUM_IN = 3  ; //The number of channel in

	localparam IMAGE_SIZE           = IMAGE_WIDTH * IMAGE_HEIGHT ;
	localparam CHANNEL_NUM_IN_PIXEL = IMAGE_SIZE * CHANNEL_NUM_IN;

	localparam IMAGE_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/R.txt"; // Input Image
	localparam IMAGE_OUTPUT_FILE = "D:/GitHub/CNNs/Text_file/Output/Output_model_top_cnn.txt"; // Output Image

	localparam WEIGHTS_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt"; // General

	localparam WEIGHTS_INPUT_FILE_08 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_13 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_18 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_21 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_22 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_23 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_24 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_25 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_26 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_27 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_28 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_31 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";
	localparam WEIGHTS_INPUT_FILE_32 = "D:/GitHub/CNNs/Text_file/Input/weight_test.txt";

	localparam SIMULATION_CLOCK = 5 ;
	localparam SIMULATION_CYCLE = 10;

// Localparam general


localparam ENDTIME = 6724230;

reg                  clk            ;
reg                  reset          ;
reg                  valid_in       ;
reg [DATA_WIDTH-1:0] pxl_in         ;
reg                  valid_weight_in;
reg [DATA_WIDTH-1:0] weight_in      ;

reg                  valid_weight_in8;
reg [DATA_WIDTH-1:0] weight_in8      ;

reg                  valid_weight_in13;
reg [DATA_WIDTH-1:0] weight_in13      ;

reg                  valid_weight_in18;
reg [DATA_WIDTH-1:0] weight_in18      ;

reg                  valid_weight_in21;
reg [DATA_WIDTH-1:0] weight_in21      ;

reg                  valid_weight_in22;
reg [DATA_WIDTH-1:0] weight_in22      ;

reg                  valid_weight_in23;
reg [DATA_WIDTH-1:0] weight_in23      ;

reg                  valid_weight_in24;
reg [DATA_WIDTH-1:0] weight_in24      ;

reg                  valid_weight_in25;
reg [DATA_WIDTH-1:0] weight_in25      ;

reg                  valid_weight_in26;
reg [DATA_WIDTH-1:0] weight_in26      ;

reg                  valid_weight_in27;
reg [DATA_WIDTH-1:0] weight_in27      ;

reg                  valid_weight_in28;
reg [DATA_WIDTH-1:0] weight_in28      ;

reg                  valid_weight_in31;
reg [DATA_WIDTH-1:0] weight_in31      ;

reg                  valid_weight_in32;
reg [DATA_WIDTH-1:0] weight_in32      ;

// reg [DATA_WIDTH-1:0] sigmoid_in;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

wire done;
// wire [4:0] sigmoid_addr   ;
// wire       sigmoid_read_en;


	integer i;

	reg [DATA_WIDTH-1:0] image_input [CHANNEL_NUM_IN_PIXEL-1:0];
	reg [DATA_WIDTH-1:0] image_output                          ;

	reg [DATA_WIDTH-1:0] weight_input[(12246208)-1:0];

	reg [DATA_WIDTH-1:0] weight_input_08[ (1*1*64*128)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_13[(1*1*128*256)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_18[(1*1*256*512)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_21[(1*1*512*256)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_22[(3*3*512*512)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_23[(1*1*512*256)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_24[(3*3*512*512)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_25[(1*1*512*256)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_26[(3*3*512*512)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_27[(1*1*512*256)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_28[(1*1*512*256)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_31[ (3*3*64*256)-1:0];
	reg [DATA_WIDTH-1:0] weight_input_32[(1*1*256*256)-1:0];

	initial begin
		clk = 1'b0;
		i=0;
		valid_in = 1'b0;
		reset = 1'b1;
		valid_weight_in = 1'b0;
		valid_weight_in8 = 1'b0;
		valid_weight_in13 = 1'b0;
		valid_weight_in18 = 1'b0;
		valid_weight_in21 = 1'b0;
		valid_weight_in22 = 1'b0;
		valid_weight_in23 = 1'b0;
		valid_weight_in24 = 1'b0;
		valid_weight_in25 = 1'b0;
		valid_weight_in26 = 1'b0;
		valid_weight_in27 = 1'b0;
		valid_weight_in28 = 1'b0;
		valid_weight_in31 = 1'b0;
		valid_weight_in32 = 1'b0;
		#SIMULATION_CYCLE
			reset = 1'b0;

		$readmemb(IMAGE_INPUT_FILE, image_input);

		$readmemh(WEIGHTS_INPUT_FILE, weight_input);
		$readmemh(WEIGHTS_INPUT_FILE_08, weight_input_08);
		$readmemh(WEIGHTS_INPUT_FILE_13, weight_input_13);
		$readmemh(WEIGHTS_INPUT_FILE_18, weight_input_18);
		$readmemh(WEIGHTS_INPUT_FILE_21, weight_input_21);
		$readmemh(WEIGHTS_INPUT_FILE_22, weight_input_22);
		$readmemh(WEIGHTS_INPUT_FILE_23, weight_input_23);
		$readmemh(WEIGHTS_INPUT_FILE_24, weight_input_24);
		$readmemh(WEIGHTS_INPUT_FILE_25, weight_input_25);
		$readmemh(WEIGHTS_INPUT_FILE_26, weight_input_26);
		$readmemh(WEIGHTS_INPUT_FILE_27, weight_input_27);
		$readmemh(WEIGHTS_INPUT_FILE_28, weight_input_28);
		$readmemh(WEIGHTS_INPUT_FILE_31, weight_input_31);
		$readmemh(WEIGHTS_INPUT_FILE_32, weight_input_32);

		image_output = $fopen(IMAGE_OUTPUT_FILE);
	end

	always #(SIMULATION_CLOCK) clk = ~ clk;

	always @(posedge clk) begin
		if (~reset) begin
			pxl_in   <= image_input[i];
			valid_in <= 1'b1;
			if (i >= CHANNEL_NUM_IN_PIXEL) begin
				valid_in <= 1'b0;
			end
			weight_in       <= weight_input[i];
			valid_weight_in <= 1'b1;
			if (i >= 12246208) begin
				valid_weight_in <= 1'b0;
			end
			weight_in8       <= weight_input_08[i];
			valid_weight_in8 <= 1'b1;
			if (i >= (1*1*64*128)) begin
				valid_weight_in8 <= 1'b0;
			end
			weight_in13       <= weight_input_13[i];
			valid_weight_in13 <= 1'b1;
			if (i >= (1*1*128*256)) begin
				valid_weight_in13 <= 1'b0;
			end
			weight_in18       <= weight_input_18[i];
			valid_weight_in18 <= 1'b1;
			if (i >= (1*1*256*512)) begin
				valid_weight_in18 <= 1'b0;
			end
			weight_in21       <= weight_input_21[i];
			valid_weight_in21 <= 1'b1;
			if (i >= (1*1*512*256)) begin
				valid_weight_in21 <= 1'b0;
			end
			weight_in22       <= weight_input_22[i];
			valid_weight_in22 <= 1'b1;
			if (i >= (3*3*512*512)) begin
				valid_weight_in22 <= 1'b0;
			end
			weight_in23       <= weight_input_23[i];
			valid_weight_in23 <= 1'b1;
			if (i >= (1*1*512*256)) begin
				valid_weight_in23 <= 1'b0;
			end
			weight_in24       <= weight_input_24[i];
			valid_weight_in24 <= 1'b1;
			if (i >= (3*3*512*512)) begin
				valid_weight_in24 <= 1'b0;
			end
			weight_in25       <= weight_input_25[i];
			valid_weight_in25 <= 1'b1;
			if (i >= (1*1*512*256)) begin
				valid_weight_in25 <= 1'b0;
			end
			weight_in26       <= weight_input_26[i];
			valid_weight_in26 <= 1'b1;
			if (i >= (3*3*512*512)) begin
				valid_weight_in26 <= 1'b0;
			end
			weight_in27       <= weight_input_27[i];
			valid_weight_in27 <= 1'b1;
			if (i >= (1*1*512*256)) begin
				valid_weight_in27 <= 1'b0;
			end
			weight_in28       <= weight_input_28[i];
			valid_weight_in28 <= 1'b1;
			if (i >= (1*1*512*256)) begin
				valid_weight_in28 <= 1'b0;
			end
			weight_in31       <= weight_input_31[i];
			valid_weight_in31 <= 1'b1;
			if (i >= (3*3*64*256)) begin
				valid_weight_in31 <= 1'b0;
			end
			weight_in32       <= weight_input_32[i];
			valid_weight_in32 <= 1'b1;
			if (i >= (1*1*256*256)) begin
				valid_weight_in32 <= 1'b0;
			end
			i <= i + 1'b1; #(SIMULATION_CYCLE)
				if(valid_out)begin
					$fdisplay(image_output,"%h",pxl_out);
				end
			if(done) begin
				#(SIMULATION_CYCLE*10) $finish;
			end
		end
	end

// rom_cnn_sigmoid_synth sigmoid_rom (
// 	.clk    (clk            ),
// 	.rst_n  (~reset         ),
// 	.addr   (sigmoid_addr   ),
// 	.read_en(sigmoid_read_en),
// 	.data   (sigmoid_in     )
// );

model_top_cnn #(
	.DATA_WIDTH  (DATA_WIDTH  ),
	.IMAGE_WIDTH (IMAGE_WIDTH ),
	.IMAGE_HEIGHT(IMAGE_HEIGHT)
) DUT (
	.clk              (clk              ),
	.reset            (reset            ),
	.valid_in         (valid_in         ),
	.pxl_in           (pxl_in           ),
	
	.valid_weight_in  (valid_weight_in  ),
	.weight_in        (weight_in        ),
	
	.valid_weight_in8 (valid_weight_in8 ),
	.weight_in8       (weight_in8       ),
	
	.valid_weight_in13(valid_weight_in13),
	.weight_in13      (weight_in13      ),
	
	.valid_weight_in18(valid_weight_in18),
	.weight_in18      (weight_in18      ),
	
	.valid_weight_in21(valid_weight_in21),
	.weight_in21      (weight_in21      ),
	
	.valid_weight_in22(valid_weight_in22),
	.weight_in22      (weight_in22      ),
	
	.valid_weight_in23(valid_weight_in23),
	.weight_in23      (weight_in23      ),
	
	.valid_weight_in24(valid_weight_in24),
	.weight_in24      (weight_in24      ),
	
	.valid_weight_in25(valid_weight_in25),
	.weight_in25      (weight_in25      ),
	
	.valid_weight_in26(valid_weight_in26),
	.weight_in26      (weight_in26      ),
	
	.valid_weight_in27(valid_weight_in27),
	.weight_in27      (weight_in27      ),
	
	.valid_weight_in28(valid_weight_in28),
	.weight_in28      (weight_in28      ),
	
	.valid_weight_in31(valid_weight_in31),
	.weight_in31      (weight_in31      ),
	
	.valid_weight_in32(valid_weight_in32),
	.weight_in32      (weight_in32      ),
	
	// .sigmoid_in       (sigmoid_in       ),
	
	.pxl_out          (pxl_out          ),
	.valid_out        (valid_out        ),
	.done             (done             )
	
	// .sigmoid_addr     (sigmoid_addr     ),
	// .sigmoid_read_en  (sigmoid_read_en  )
);

endmodule








