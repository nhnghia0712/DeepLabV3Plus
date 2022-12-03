`timescale 1ns / 100ps
// 9 clk
module tb_fp_mul ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

parameter NUM = 2448*2448; //Width

parameter T = 6000000;
parameter C = 1       ;
parameter I = 2       ;


reg                  clk     ;
reg                  reset   ;
reg                  valid_in;
reg [DATA_WIDTH-1:0] in_a    ;
reg [DATA_WIDTH-1:0] in_b    ;

wire [DATA_WIDTH-1:0] out      ;
wire                  valid_out;


integer i;

reg [DATA_WIDTH-1:0] mem_a  [NUM-1:0];
reg [DATA_WIDTH-1:0] mem_b  [NUM-1:0];
reg [DATA_WIDTH-1:0] mem_out         ;

initial begin
	clk = 0;
	i=0;
	valid_in = 1'b0;
	reset = 1;
	#I
		reset = 0;
	valid_in <= 1'b0;
	// $readmemh("D:/GitHub/CNNs/Text_file/Input/RGB.txt", In);
	$readmemh("D:/GitHub/CNNs/Text_file/Input/mul_ina.txt", mem_a);
	$readmemh("D:/GitHub/CNNs/Text_file/Input/mul_inb.txt", mem_b);
	mem_out = $fopen("D:/GitHub/CNNs/Text_file/Output/Output_fp_mul.txt");
end

always #(C) clk = ~ clk;

always @(posedge clk) begin
	in_a <= mem_a[i];
	in_b <= mem_b[i];
	valid_in <= 1'b1;
	if (i >= NUM) begin
		valid_in <= 1'b0;
	end
	#(I) i <= i + 1'b1;
	if(valid_out)begin
		$fdisplay(mem_out,"%h",out);
	end
	if(i == T) begin
		$finish;
	end
end

	fp_mul #(.DATA_WIDTH(DATA_WIDTH)) DUT (
		.clk      (clk      ),
		.reset    (reset    ),
		.valid_in (valid_in ),
		.in_a     (in_a     ),
		.in_b     (in_b     ),
		//output
		.out      (out      ),
		.valid_out(valid_out)
	);
endmodule