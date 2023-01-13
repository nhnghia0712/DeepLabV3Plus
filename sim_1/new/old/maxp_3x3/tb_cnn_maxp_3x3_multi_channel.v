`timescale 1ns / 100ps

module tb_cnn_maxp_3x3_multi_channel ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// General
parameter IMAGE_WIDTH  = 128; //Width
parameter IMAGE_HEIGHT = 128; //Height
parameter KERNEL       = 3  ; //3*3 Kernel
parameter RATE         = 1  ; //3*3 Kernel

localparam CHANNEL_NUM_IN       = 64                         ; //The number of channel
localparam IMAGE_SIZE           = IMAGE_WIDTH * IMAGE_HEIGHT ;
localparam CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE;

localparam IMAGE_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/R.txt";
localparam IMAGE_OUTPUT_FILE = "D:/GitHub/CNNs/Text_file/Output/Output_cnn_maxp_3x3_test.txt";


parameter ENDTIME          = IMAGE_WIDTH + 9 + (CHANNEL_NUM_IN * (IMAGE_SIZE + IMAGE_WIDTH + 1)) + ((IMAGE_SIZE/4) * CHANNEL_NUM_IN);
parameter SIMULATION_CLOCK = 5                                                                                                      ;
parameter SIMULATION_CYCLE = 10                                                                                                     ;


reg                  clk     ;
reg                  reset   ;
reg                  valid_in;
reg [DATA_WIDTH-1:0] pxl_in  ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;


integer i;

reg [DATA_WIDTH-1:0] image_input [CHANNEL_NUM_IN_PIXEL-1:0];
reg [DATA_WIDTH-1:0] image_output                          ;

initial begin
	clk = 0;
	i=0;
	valid_in = 1'b0;
	reset = 1'b1;
	#SIMULATION_CYCLE
		reset = 1'b0;
	valid_in = 1'b0;

	$readmemb(IMAGE_INPUT_FILE, image_input);
	image_output = $fopen(IMAGE_OUTPUT_FILE);
end

always #(SIMULATION_CLOCK) clk = ~ clk;

always @(posedge clk) begin
	if (!reset) begin
		pxl_in   <= image_input[i];
		valid_in <= 1'b1;
		if (i >= CHANNEL_NUM_IN_PIXEL) begin
			valid_in <= 1'b0;
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

	cnn_maxp_01_3x3 #(
		.DATA_WIDTH    (DATA_WIDTH    ),
		.IMAGE_WIDTH   (IMAGE_WIDTH   ),
		.IMAGE_HEIGHT  (IMAGE_HEIGHT  ),
		.KERNEL        (KERNEL        ),
		.RATE          (RATE          ),
		.CHANNEL_NUM_IN(CHANNEL_NUM_IN)
	) DUT (
		.clk      (clk      ),
		.reset    (reset    ),
		.valid_in (valid_in ),
		.pxl_in   (pxl_in   ),
		//output
		.pxl_out  (pxl_out  ),
		.valid_out(valid_out)
	);
endmodule








