`timescale 1ns / 100ps

module tb_cnn_concat_2in ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH        = 32                       ;
parameter POINTER_WIDTH     = $clog2(CHANNEL_NUM_PIXEL); // $clog2(WEIGHT_NUM)
parameter CHANNEL_NUM_PIXEL = 612*612                  ;

parameter T = 100000000;
parameter C = 5        ;
parameter I = 10       ;


reg                  clk         ;
reg                  reset       ;
reg                  valid_in_no1;
reg [DATA_WIDTH-1:0] in_no1      ;
reg                  valid_in_no2;
reg [DATA_WIDTH-1:0] in_no2      ;

wire [DATA_WIDTH-1:0] out      ;
wire                  valid_out;


integer i;

reg [DATA_WIDTH-1:0] In_list_no1[CHANNEL_NUM_PIXEL-1:0];
reg [DATA_WIDTH-1:0] In_list_no2[CHANNEL_NUM_PIXEL-1:0];
reg [DATA_WIDTH-1:0] Out                               ;

initial begin
	clk = 0;
	i=0;
	valid_in_no1 = 1'b0;
	reset = 1;
	valid_in_no2 = 1'b0;
	#I
		reset = 0;
	valid_in_no1 <= 1'b0;
	valid_in_no2 = 1'b0;
	// $readmemh("D:/GitHub/CNNs/Text_file/Input/RGB.txt", In);
	$readmemb("D:/GitHub/CNNs/Text_file/Input/R.txt", In_list_no1);
	$readmemh("D:/GitHub/CNNs/Text_file/Input/weight_test.txt", In_list_no2);
	Out = $fopen("D:/GitHub/CNNs/Text_file/Output/Output_cnn_concat_2in.txt");
end

always #(C) clk = ~ clk;

always @(posedge clk) begin
	in_no1       <= In_list_no1[i];
	valid_in_no1 <= 1'b1;
	if (i >= CHANNEL_NUM_PIXEL) begin
		valid_in_no1 <= 1'b0;
	end
	in_no2       <= In_list_no2[i];
	valid_in_no2 <= 1'b1;
	if (i >= CHANNEL_NUM_PIXEL) begin
		valid_in_no2 <= 1'b0;
	end
	#(I) i <= i + 1'b1;
	if(valid_out == 1'b1)begin
		$fdisplay(Out,"%h",out);
	end
	if(i == T) begin
		$finish;
	end
end

	cnn_concat_2in #(
		.DATA_WIDTH       (DATA_WIDTH       ),
		.CHANNEL_NUM_PIXEL(CHANNEL_NUM_PIXEL),
		.POINTER_WIDTH    (POINTER_WIDTH    )
	) DUT (
		.clk         (clk         ),
		.reset       (reset       ),
		.valid_in_no1(valid_in_no1),
		.in_no1      (in_no1      ),
		.valid_in_no2(valid_in_no2),
		.in_no2      (in_no2      ),
		//output
		.out         (out         ),
		.valid_out   (valid_out   )
	);
endmodule








