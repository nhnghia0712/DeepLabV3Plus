`timescale 1ns / 100ps

module tb_cnn_sigmoid ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH        = 32       ;
parameter CHANNEL_NUM_PIXEL = 2448*2448;

localparam IMAGE_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/outputR_h.txt";
localparam IMAGE_OUTPUT_FILE = "D:/GitHub/CNNs/Text_file/Output/Output_cnn_sigmoid.txt";


parameter ENDTIME          = (CHANNEL_NUM_PIXEL + 5) * SIMULATION_CYCLE;
parameter SIMULATION_CLOCK = 5                                         ;
parameter SIMULATION_CYCLE = 10                                        ;


reg                  clk     ;
reg                  reset   ;
reg                  valid_in;
reg [DATA_WIDTH-1:0] in      ;

wire [DATA_WIDTH-1:0] out      ;
wire                  valid_out;
wire                  done     ;

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
	in       <= image_input[i];
	valid_in <= 1'b1;
	if (i >= CHANNEL_NUM_PIXEL) begin
		valid_in <= 1'b0;
	end
	#(SIMULATION_CYCLE) i <= i + 1'b1;
	if(valid_out)begin
		$fdisplay(image_output,"%h",out);
	end
	if(done) begin
		#(SIMULATION_CYCLE) $finish;
	end
end

	cnn_sigmoid DUT (
		.clk      (clk      ),
		.reset    (reset    ),
		.valid_in (valid_in ),
		.in       (in       ),
		//output
		.out      (out      ),
		.valid_out(valid_out),
		.done     (done     )
	);
endmodule








