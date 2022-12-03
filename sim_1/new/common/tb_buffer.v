`timescale 1ns / 100ps
// Convolution Kernel 3x3, Stride = 2, Padding = 0.

module tb_buffer ();
parameter DATA_WIDTH  = 32;

parameter IMAGE_WIDTH     = 6; //Width
parameter IMAGE_HEIGHT    = 6; //Height
parameter CHANNEL_NUM_IN  = 2; //The number of channel
parameter CHANNEL_NUM_OUT = 2; //The number of channel
parameter KERNEL          = 1; //3*3 Kernel
parameter PADDING         = 0; //3*3 Kernel
// parameter RATE            = 1;
localparam KERNEL_SIZE = KERNEL * KERNEL                 ;
localparam CHANNEL_NUM = CHANNEL_NUM_IN * CHANNEL_NUM_OUT;
localparam IMAGE_SIZE  = IMAGE_WIDTH * IMAGE_HEIGHT      ;

parameter T = 100000;
parameter C = 0.1   ;
parameter I = 0.2   ;
// parameter C = 0.1;
// parameter I = 0.2;

	reg                  clk            ;
	reg                  reset          ;
	reg                  valid_in       ;
	reg [DATA_WIDTH-1:0] pxl_in         ;
	// reg                  stride2        ;
	reg                  valid_weight_in;
	reg [DATA_WIDTH-1:0] weight_in      ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;


integer i;

	reg [DATA_WIDTH-1:0] In         [(IMAGE_SIZE*CHANNEL_NUM_IN)-1:0];
	reg [DATA_WIDTH-1:0] weight_list[  (KERNEL_SIZE*CHANNEL_NUM)-1:0];
	reg [DATA_WIDTH-1:0] Out                                         ;

	initial begin
		clk = 0;
		i=0;
		valid_in = 1'b0;
		reset = 1;
		// stride2 = 1;
		valid_weight_in = 1'b0;
		#I
			reset = 0;
		valid_in <= 1'b0;
		valid_weight_in = 1'b0;
		// $readmemh("D:/GitHub/CNNs/Text_file/Input/RGB.txt", In);
		$readmemb("D:/GitHub/CNNs/Floating_points/Floating_points.srcs/sources_1/new/data_test.txt", In);
		$readmemh("D:/GitHub/CNNs/Text_file/Input/encoder.conv1.weight.txt", weight_list);
		Out = $fopen("D:/GitHub/CNNs/Text_file/Output/Output_cnn_conv_1x1_multi_channel.txt");
	end
	always #(C) clk = ~ clk;

	always @(posedge clk) begin
		pxl_in   <= In[i];
		valid_in <= 1'b1;
		if (i >= IMAGE_SIZE * CHANNEL_NUM_IN) begin
			valid_in <= 1'b0;
		end
		weight_in       <= weight_list[i];
		valid_weight_in <= 1'b1;
		if (i >= (KERNEL_SIZE * CHANNEL_NUM)) begin
			valid_weight_in <= 1'b0;
		end
		#(I) i <= i + 1'b1;
		if(valid_out == 1'b1)begin
			$fdisplay(Out,"%h",pxl_out);
		end
		if(i == T) begin
			$finish;
		end
	end

	cnn_conv_1x1_multi_channel #(
		.IMAGE_WIDTH    (IMAGE_WIDTH    ),
		.IMAGE_HEIGHT   (IMAGE_HEIGHT   ),
		// .PADDING        (PADDING        ),
		.DATA_WIDTH     (DATA_WIDTH     ),
		.CHANNEL_NUM_IN (CHANNEL_NUM_IN ),
		.CHANNEL_NUM_OUT(CHANNEL_NUM_OUT),
		.KERNEL         (KERNEL         )//,
		// .RATE           (RATE           )
	) DUT (
		clk,
		reset,
		// stride2,
		valid_in,
		pxl_in,
		valid_weight_in,
		weight_in,
		
		pxl_out,
		valid_out
	);
endmodule








