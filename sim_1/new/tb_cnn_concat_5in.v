`timescale 1ns / 100ps

module tb_cnn_concat_5in ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH        = 32                         ;
parameter IMAGE_WIDTH       = 16                         ;
parameter CHANNEL_NUM_PIXEL = IMAGE_WIDTH*IMAGE_WIDTH*256;

parameter T = (CHANNEL_NUM_PIXEL * 10) + 10;
parameter C = 5                            ;
parameter I = 10                           ;


reg                  clk         ;
reg                  reset       ;
reg                  valid_in_no1;
reg [DATA_WIDTH-1:0] in_no1      ;
reg                  valid_in_no2;
reg [DATA_WIDTH-1:0] in_no2      ;
reg                  valid_in_no3;
reg [DATA_WIDTH-1:0] in_no3      ;
reg                  valid_in_no4;
reg [DATA_WIDTH-1:0] in_no4      ;
reg                  valid_in_no5;
reg [DATA_WIDTH-1:0] in_no5      ;

wire [DATA_WIDTH-1:0] out      ;
wire                  valid_out;


integer i;

reg [DATA_WIDTH-1:0] In_list_no1[CHANNEL_NUM_PIXEL-1:0];
reg [DATA_WIDTH-1:0] In_list_no2[CHANNEL_NUM_PIXEL-1:0];
reg [DATA_WIDTH-1:0] In_list_no3[CHANNEL_NUM_PIXEL-1:0];
reg [DATA_WIDTH-1:0] In_list_no4[CHANNEL_NUM_PIXEL-1:0];
reg [DATA_WIDTH-1:0] In_list_no5[CHANNEL_NUM_PIXEL-1:0];
reg [DATA_WIDTH-1:0] Out                               ;

initial begin
	clk = 1'b0;
	i=0;
	valid_in_no1 = 1'b0;
	reset = 1'b1;
	valid_in_no2 = 1'b0;
	valid_in_no3 = 1'b0;
	valid_in_no4 = 1'b0;
	valid_in_no5 = 1'b0;
	#I
		reset = 0;

	// $readmemh("D:/GitHub/CNNs/Text_file/Input/RGB.txt", In);
	$readmemh("D:/GitHub/CNNs/Text_file/Output/Output_cnn_conv_1x1_04_aspp.txt", In_list_no1);
	$readmemh("D:/GitHub/CNNs/Text_file/Output/Output_cnn_conv_1x1_05_aspp.txt", In_list_no2);
	$readmemh("D:/GitHub/CNNs/Text_file/Output/Output_cnn_conv_1x1_06_aspp.txt", In_list_no3);
	$readmemh("D:/GitHub/CNNs/Text_file/Output/Output_cnn_conv_1x1_07_aspp.txt", In_list_no4);
	$readmemh("D:/GitHub/CNNs/Text_file/Output/Output_cnn_conv_1x1_08_aspp.txt", In_list_no5);
	Out = $fopen("D:/GitHub/CNNs/Text_file/Output/Output_cnn_concat_5in.txt");
end

always #(C) clk = ~ clk;

always @(posedge clk) begin
	if (!reset) begin
		in_no1       <= In_list_no1[i];
		valid_in_no1 <= 1'b1;
		if (i >= CHANNEL_NUM_PIXEL) begin
			valid_in_no1 <= 1'b0;
			if (i >= (CHANNEL_NUM_PIXEL * 2)) begin
				in_no2       <= In_list_no2[i[16:0]];
				valid_in_no2 <= 1'b1;
				if (i >= (CHANNEL_NUM_PIXEL * 3)) begin
					valid_in_no2 <= 1'b0;
					if (i >= (CHANNEL_NUM_PIXEL * 4)) begin
						in_no3       <= In_list_no3[i[16:0]];
						valid_in_no3 <= 1'b1;
						if (i >= (CHANNEL_NUM_PIXEL * 5)) begin
							valid_in_no3 <= 1'b0;
							if (i >= (CHANNEL_NUM_PIXEL * 6)) begin
								in_no4       <= In_list_no4[i[16:0]];
								valid_in_no4 <= 1'b1;
								if (i >= (CHANNEL_NUM_PIXEL * 7)) begin
									valid_in_no4 <= 1'b0;
								end
							end
						end
					end
				end
			end
		end
		in_no5       <= In_list_no5[i];
		valid_in_no5 <= 1'b1;
		if (i >= (CHANNEL_NUM_PIXEL)) begin
			valid_in_no5 <= 1'b0;
		end
		i <= i + 1'b1;
		#(I)
			if(valid_out)begin
				$fdisplay(Out,"%h",out);
			end
		if(i == T) begin
			$finish;
		end
	end
end

	cnn_concat_5in #(.DATA_WIDTH(DATA_WIDTH)) DUT (
		.clk         (clk         ),
		.reset       (reset       ),
		.valid_in_no1(valid_in_no1),
		.in_no1      (in_no1      ),
		.valid_in_no2(valid_in_no2),
		.in_no2      (in_no2      ),
		.valid_in_no3(valid_in_no3),
		.in_no3      (in_no3      ),
		.valid_in_no4(valid_in_no4),
		.in_no4      (in_no4      ),
		.valid_in_no5(valid_in_no5),
		.in_no5      (in_no5      ),
		//output
		.out         (out         ),
		.valid_out   (valid_out   )
	);
endmodule








