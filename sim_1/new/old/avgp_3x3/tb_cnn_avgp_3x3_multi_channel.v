`timescale 1ns / 100ps

module tb_cnn_avgp_3x3_multi_channel ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// General
parameter IMAGE_WIDTH  = 153; //Width
parameter IMAGE_HEIGHT = 153; //Height
parameter CHANNEL_NUM  = 1  ; //The number of channel
parameter KERNEL       = 3  ; //3*3 Kernel
parameter PADDING      = 1  ; //3*3 Kernel

localparam IMAGE_SIZE        = IMAGE_WIDTH * IMAGE_HEIGHT;
localparam CHANNEL_NUM_PIXEL = CHANNEL_NUM * IMAGE_SIZE  ;

localparam IMAGE_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/R.txt";
localparam IMAGE_OUTPUT_FILE = "D:/GitHub/CNNs/Text_file/Output/Output_cnn_avgp_3x3_153x153_153x153.txt";


parameter ENDTIME          = 60000;
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

	$readmemb(IMAGE_INPUT_FILE, image_input);
	image_output = $fopen(IMAGE_OUTPUT_FILE);
end

always #(SIMULATION_CLOCK) clk = ~ clk;

always @(posedge clk) begin
	pxl_in   <= image_input[i];
	valid_in <= 1'b1;
	if (i >= CHANNEL_NUM_PIXEL) begin
		valid_in <= 1'b0;
	end
	#(SIMULATION_CYCLE) i <= i + 1'b1;
	if(valid_out == 1'b1)begin
		$fdisplay(image_output,"%h",pxl_out);
	end
	if(i == ENDTIME) begin
		$finish;
	end
end

	cnn_avgp_3x3_multi_channel #(
		.DATA_WIDTH  (DATA_WIDTH  ),
		.IMAGE_WIDTH (IMAGE_WIDTH ),
		.IMAGE_HEIGHT(IMAGE_HEIGHT),
		.CHANNEL_NUM (CHANNEL_NUM ),
		.KERNEL      (KERNEL      ),
		.PADDING     (PADDING     )
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








