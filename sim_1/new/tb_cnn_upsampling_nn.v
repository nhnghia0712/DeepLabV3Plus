`timescale 1ns / 100ps

module tb_cnn_upsampling_nn ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// General
parameter IMAGE_WIDTH  = 16; //Width
parameter IMAGE_HEIGHT = 16; //Height
parameter CHANNEL_NUM  = 4 ; //The number of channel

localparam IMAGE_SIZE        = IMAGE_WIDTH * IMAGE_HEIGHT;
localparam CHANNEL_NUM_PIXEL = CHANNEL_NUM * IMAGE_SIZE  ;

localparam IMAGE_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/Input_image/1499_satB_h.txt";
localparam IMAGE_OUTPUT_FILE = "D:/GitHub/CNNs/Text_file/Output/Output_cnn_upsampling_nn_testB.txt";


parameter ENDTIME          = 21000;
parameter SIMULATION_CLOCK = 5    ;
parameter SIMULATION_CYCLE = 10   ;


reg                  clk     ;
reg                  reset   ;
reg                  valid_in;
reg [DATA_WIDTH-1:0] pxl_in  ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;


integer i;

reg [DATA_WIDTH-1:0] image_input [CHANNEL_NUM_PIXEL-1:0];
reg [DATA_WIDTH-1:0] image_output                       ;

initial begin
	clk = 0;
	i=0;
	valid_in = 1'b0;
	reset = 1;
	#SIMULATION_CYCLE
		reset = 0;
	valid_in <= 1'b0;

	$readmemh(IMAGE_INPUT_FILE, image_input);
	image_output = $fopen(IMAGE_OUTPUT_FILE);
end

always #(SIMULATION_CLOCK) clk = ~ clk;

always @(posedge clk) begin
	if (!reset) begin
		pxl_in   <= image_input[i];
		valid_in <= 1'b1;
		if (i >= CHANNEL_NUM_PIXEL) begin
			valid_in <= 1'b0;
		end
		i <= i + 1'b1; #(SIMULATION_CYCLE)
			if(valid_out)begin
				$fdisplay(image_output,"%h",pxl_out);
			end
		if(i == ENDTIME) begin
			$finish;
		end
	end
end

	cnn_upsampling_nn_test DUT (
		.clk      (clk      ),
		.reset    (reset    ),
		.valid_in (valid_in ),
		.pxl_in   (pxl_in   ),
		//output
		.pxl_out  (pxl_out  ),
		.valid_out(valid_out)
	);
endmodule








