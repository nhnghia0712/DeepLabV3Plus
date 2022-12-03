`timescale 1ns / 100ps
// Convolution Kernel 3x3, Stride = 2, Padding = 0.

module tb_padding ();

	parameter DATA_WIDTH = 32;
	parameter STRIDE     = 2 ;

	parameter IMAGE_WIDTH  = 6; //Width
	parameter IMAGE_HEIGHT = 6; //Height

	parameter  PADDING            = 3                                                             ; //3*3 Kernel
	parameter  CHANNEL_NUM        = 4                                                           ; //Height
	localparam IMAGE_SIZE         = IMAGE_WIDTH*IMAGE_HEIGHT                                      ;
	localparam IMAGE_SIZE_PADDING = (IMAGE_WIDTH + (PADDING * 2)) * (IMAGE_HEIGHT + (PADDING * 2));

	parameter T = 10000;
	parameter C = 1.25 ;
	parameter I = 2.5  ;

reg                  clk     ;
reg                  reset   ;
reg                  valid_in;
reg [DATA_WIDTH-1:0] pxl_in  ;

wire [DATA_WIDTH-1:0] pxl_out;
wire valid_out;


integer i;

	// reg                  clk            ;
	// reg                  reset          ;
	// reg                  valid_in       ;
	// reg [DATA_WIDTH-1:0] pxl_in         ;
	// reg                  valid_in_weight;
	// reg [DATA_WIDTH-1:0] weight         ;

	// wire [DATA_WIDTH-1:0] pxl_out  ;
	// wire                  valid_out;

	reg [DATA_WIDTH-1:0] In         [        (IMAGE_SIZE*CHANNEL_NUM)-1:0];
	reg [DATA_WIDTH-1:0] out_padding[(IMAGE_SIZE_PADDING*CHANNEL_NUM)-1:0];
	reg [DATA_WIDTH-1:0] Out                                              ;

	initial begin
		clk = 0;
		i=0;
		valid_in = 1'b0;
		reset = 1;
		// stride = 1;
		#I
			reset = 0;
		valid_in <= 1'b0;
		$readmemb("D:/GitHub/CNNs/Floating_points/Floating_points.srcs/sources_1/new/data_test.txt", In);
		$readmemh("D:/GitHub/CNNs/Text_file/out_padding_4channel.txt", out_padding);
		Out = $fopen("D:/GitHub/CNNs/Text_file/out_padding_4channel.txt");
	end
	always #(C) clk = ~ clk;

	always @(posedge clk) begin
		pxl_in   <= In[i];
		valid_in <= 1'b1;
		if (i >= IMAGE_SIZE * CHANNEL_NUM) begin
			valid_in <= 1'b0;
		end
		#(I) i <= i + 1'b1;
		if(valid_out == 1'b1)begin
			$fdisplay(Out,"%b",pxl_out);
		end
		if(i == T) begin
			$finish;
		end
	end

	// conv_3x3_pad1_str2 #(
	// 	.DATA_WIDTH  (DATA_WIDTH  ),
	// 	.STRIDE      (STRIDE      ),
	// 	.IMAGE_WIDTH (IMAGE_WIDTH ),
	// 	.IMAGE_HEIGHT(IMAGE_HEIGHT),
	// 	.KERNEL_SIZE (KERNEL_SIZE )
	// ) DUT (
	// 	//input
	// 	.clk            (clk            ),
	// 	.reset          (reset          ),
	// 	.valid_in       (valid_in       ),
	// 	.pxl_in         (pxl_in         ),
	// 	//kernel 3x3
	// 	.weight         (weight         ),
	// 	.valid_in_weight(valid_in_weight),
	// 	//output
	// 	.pxl_out        (pxl_out        ),
	// 	.valid_out      (valid_out      )
	// );

	// buffer #(
	// 	.IMAGE_WIDTH(IMAGE_WIDTH),
	// 	.KERNEL_SIZE(KERNEL_SIZE),
	// 	.DIN_WIDTH  (DATA_WIDTH )
	// ) DUT (
	// 	clk,
	// 	reset,
	// 	valid_in,
	// 	in,
	// 	stride,

	// 	pxl_00,
	// 	pxl_01,
	// 	pxl_02,
	// 	pxl_03,
	// 	pxl_04,
	// 	pxl_05,
	// 	pxl_06,
	// 	pxl_07,
	// 	pxl_08,
	// 	valid_out
	// );

		conv_3x3_top #(
			.IMAGE_WIDTH (IMAGE_WIDTH ),
			.IMAGE_HEIGHT(IMAGE_HEIGHT),
			.PADDING     (PADDING     ),
			.DATA_WIDTH  (DATA_WIDTH  ),
			.CHANNEL_NUM (CHANNEL_NUM )
		) DUT (
			clk,
			reset,
			valid_in,
			pxl_in,
			
			pxl_out,
			valid_out
		);
endmodule








