`timescale 1ns/1ps
/////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Nguyen Hoang Nghia

// Create Date:   
// Design Name: 
// Module Name: 
// Project Name: 
// Target Device: 
// Tool Versions:
// Description:

// Dependencies:

// Revision:
// Revision 0.01 - File Created
// Additional Comments:

///////////////////////////////////////////////////////////////////////

module conv_3x3_buffer (
  clk, 
  reset,
  valid_in,
  in,
  stride2,

  pxl_out_00,
  pxl_out_01,
  pxl_out_02,
  pxl_out_03,
  pxl_out_04,
  pxl_out_05,
  pxl_out_06,
  pxl_out_07,
  pxl_out_08,
  valid_out,

  load_weights
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// General
parameter IMAGE_WIDTH = 14     ; // IMAGE_WIDTH_PADDING
parameter KERNEL      = 3      ; // Kernel
parameter RATE        = 4      ; //Rate of dialtion
parameter IMAGE_SIZE  = 14 * 14;

// Parameter for submodule
parameter CNT_WIDTH_BUFFER = 4; // $clog2(IMAGE_WIDTH_PADDING) + 1 // For Buffer = log2(IMAGE_WIDTH_PADDING)

// Localparam
parameter SHIFT_WIDTH = IMAGE_WIDTH * RATE       ;
parameter DELAY_WIDTH = KERNEL + ((RATE - 1) * 2);

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk     ;
input                  reset   ;
input                  valid_in;
input [DATA_WIDTH-1:0] in      ;

input stride2 ; //0=sride 1, 1=stride22

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out_00; output [DATA_WIDTH-1:0] pxl_out_01; output [DATA_WIDTH-1:0] pxl_out_02;
output [DATA_WIDTH-1:0] pxl_out_03; output [DATA_WIDTH-1:0] pxl_out_04; output [DATA_WIDTH-1:0] pxl_out_05;
output [DATA_WIDTH-1:0] pxl_out_06; output [DATA_WIDTH-1:0] pxl_out_07; output [DATA_WIDTH-1:0] pxl_out_08;


output valid_out   ;
output load_weights;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk     ;
wire                  reset   ;
wire                  stride2 ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] in      ;

wire [DATA_WIDTH-1:0] pxl_out_00; wire [DATA_WIDTH-1:0] pxl_out_01; wire [DATA_WIDTH-1:0] pxl_out_02;
wire [DATA_WIDTH-1:0] pxl_out_03; wire [DATA_WIDTH-1:0] pxl_out_04; wire [DATA_WIDTH-1:0] pxl_out_05;
wire [DATA_WIDTH-1:0] pxl_out_06; wire [DATA_WIDTH-1:0] pxl_out_07; wire [DATA_WIDTH-1:0] pxl_out_08;

wire valid_out   ;
reg  load_weights;

wire [DATA_WIDTH-1:0] pxl_00;
wire [DATA_WIDTH-1:0] pxl_01;
wire [DATA_WIDTH-1:0] pxl_02;
wire [DATA_WIDTH-1:0] pxl_03;
wire [DATA_WIDTH-1:0] pxl_04;
wire [DATA_WIDTH-1:0] pxl_05;
wire [DATA_WIDTH-1:0] pxl_06;
wire [DATA_WIDTH-1:0] pxl_07;
wire [DATA_WIDTH-1:0] pxl_08;

wire valid_pxl_00;
wire valid_pxl_01;
wire valid_pxl_02;
wire valid_pxl_03;
wire valid_pxl_04;
wire valid_pxl_05;
wire valid_pxl_06;
wire valid_pxl_07;
wire valid_pxl_08;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff8 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_in    ),
	.in       (in          ),
	.out      (pxl_08      ),
	.valid_out(valid_pxl_08)
);

line_buffer #(
	.IMAGE_WIDTH(RATE      ),
	.KERNEL     (1         ),
	.DIN_WIDTH  (DATA_WIDTH)
) line_buffer7 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_08),
	.data_in  (pxl_08      ),
	.data_out (pxl_07      ),
	.valid_out(valid_pxl_07)
);

line_buffer #(
	.IMAGE_WIDTH(RATE      ),
	.KERNEL     (1         ),
	.DIN_WIDTH  (DATA_WIDTH)
) line_buffer6 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_07),
	.data_in  (pxl_07      ),
	.data_out (pxl_06      ),
	.valid_out(valid_pxl_06)
);

line_buffer #(
	.IMAGE_WIDTH(SHIFT_WIDTH),
	.KERNEL     (DELAY_WIDTH),
	.DIN_WIDTH  (DATA_WIDTH )
) line_buffer5 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_06),
	.data_in  (pxl_06      ),
	.data_out (pxl_05      ),
	.valid_out(valid_pxl_05)
);

line_buffer #(
	.IMAGE_WIDTH(RATE      ),
	.KERNEL     (1         ),
	.DIN_WIDTH  (DATA_WIDTH)
) line_buffer4 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_05),
	.data_in  (pxl_05      ),
	.data_out (pxl_04      ),
	.valid_out(valid_pxl_04)
);

line_buffer #(
	.IMAGE_WIDTH(RATE      ),
	.KERNEL     (1         ),
	.DIN_WIDTH  (DATA_WIDTH)
) line_buffer3 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_04),
	.data_in  (pxl_04      ),
	.data_out (pxl_03      ),
	.valid_out(valid_pxl_03)
);

line_buffer #(
	.IMAGE_WIDTH(SHIFT_WIDTH),
	.KERNEL     (DELAY_WIDTH),
	.DIN_WIDTH  (DATA_WIDTH )
) line_buffer2 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_03),
	.data_in  (pxl_03      ),
	.data_out (pxl_02      ),
	.valid_out(valid_pxl_02)
);

line_buffer #(
	.IMAGE_WIDTH(RATE      ),
	.KERNEL     (1         ),
	.DIN_WIDTH  (DATA_WIDTH)
) line_buffer1 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_02),
	.data_in  (pxl_02      ),
	.data_out (pxl_01      ),
	.valid_out(valid_pxl_01)
);

line_buffer #(
	.IMAGE_WIDTH(RATE      ),
	.KERNEL     (1         ),
	.DIN_WIDTH  (DATA_WIDTH)
) line_buffer0 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_01),
	.data_in  (pxl_01      ),
	.data_out (pxl_00      ),
	.valid_out(valid_pxl_00)
);

/////////////////////////////////////////////////////////////////////////
// Delay
wire [DATA_WIDTH-1:0] pxl_00_next;
wire [DATA_WIDTH-1:0] pxl_01_next;
wire [DATA_WIDTH-1:0] pxl_02_next;
wire [DATA_WIDTH-1:0] pxl_03_next;
wire [DATA_WIDTH-1:0] pxl_04_next;
wire [DATA_WIDTH-1:0] pxl_05_next;
wire [DATA_WIDTH-1:0] pxl_06_next;
wire [DATA_WIDTH-1:0] pxl_07_next;
wire [DATA_WIDTH-1:0] pxl_08_next;

wire valid_pxl_00_next;
wire valid_pxl_01_next;
wire valid_pxl_02_next;
wire valid_pxl_03_next;
wire valid_pxl_04_next;
wire valid_pxl_05_next;
wire valid_pxl_06_next;
wire valid_pxl_07_next;
wire valid_pxl_08_next;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff88_next (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_pxl_08     ),
	.in       (pxl_08           ),
	.out      (pxl_08_next      ),
	.valid_out(valid_pxl_08_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff77_next (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_pxl_07     ),
	.in       (pxl_07           ),
	.out      (pxl_07_next      ),
	.valid_out(valid_pxl_07_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff66_next (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_pxl_06     ),
	.in       (pxl_06           ),
	.out      (pxl_06_next      ),
	.valid_out(valid_pxl_06_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff55_next (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_pxl_05     ),
	.in       (pxl_05           ),
	.out      (pxl_05_next      ),
	.valid_out(valid_pxl_05_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff44_next (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_pxl_04     ),
	.in       (pxl_04           ),
	.out      (pxl_04_next      ),
	.valid_out(valid_pxl_04_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff33_next (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_pxl_03     ),
	.in       (pxl_03           ),
	.out      (pxl_03_next      ),
	.valid_out(valid_pxl_03_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff22_next (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_pxl_02     ),
	.in       (pxl_02           ),
	.out      (pxl_02_next      ),
	.valid_out(valid_pxl_02_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff11_next (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_pxl_01     ),
	.in       (pxl_01           ),
	.out      (pxl_01_next      ),
	.valid_out(valid_pxl_01_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff00_next (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_pxl_00     ),
	.in       (pxl_00           ),
	.out      (pxl_00_next      ),
	.valid_out(valid_pxl_00_next)
);

/////////////////////////////////////////////////////////////////////////
// Select out normal or dilation
wire [DATA_WIDTH-1:0] pxl_out_dff_00; wire [DATA_WIDTH-1:0] pxl_out_dff_01; wire [DATA_WIDTH-1:0] pxl_out_dff_02;
wire [DATA_WIDTH-1:0] pxl_out_dff_03; wire [DATA_WIDTH-1:0] pxl_out_dff_04; wire [DATA_WIDTH-1:0] pxl_out_dff_05;
wire [DATA_WIDTH-1:0] pxl_out_dff_06; wire [DATA_WIDTH-1:0] pxl_out_dff_07; wire [DATA_WIDTH-1:0] pxl_out_dff_08;

wire valid_pxl_out_dff_00;
wire valid_pxl_out_dff_01;
wire valid_pxl_out_dff_02;
wire valid_pxl_out_dff_03;
wire valid_pxl_out_dff_04;
wire valid_pxl_out_dff_05;
wire valid_pxl_out_dff_06;
wire valid_pxl_out_dff_07;
wire valid_pxl_out_dff_08;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff88 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_08_next   ),
	.in       (pxl_08_next         ),
	.out      (pxl_out_dff_08      ),
	.valid_out(valid_pxl_out_dff_08)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff77 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_07_next   ),
	.in       (pxl_07_next         ),
	.out      (pxl_out_dff_07      ),
	.valid_out(valid_pxl_out_dff_07)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff66 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_06_next   ),
	.in       (pxl_06_next         ),
	.out      (pxl_out_dff_06      ),
	.valid_out(valid_pxl_out_dff_06)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff55 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_05_next   ),
	.in       (pxl_05_next         ),
	.out      (pxl_out_dff_05      ),
	.valid_out(valid_pxl_out_dff_05)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff44 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_04_next   ),
	.in       (pxl_04_next         ),
	.out      (pxl_out_dff_04      ),
	.valid_out(valid_pxl_out_dff_04)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff33 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_03_next   ),
	.in       (pxl_03_next         ),
	.out      (pxl_out_dff_03      ),
	.valid_out(valid_pxl_out_dff_03)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff22 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_02_next   ),
	.in       (pxl_02_next         ),
	.out      (pxl_out_dff_02      ),
	.valid_out(valid_pxl_out_dff_02)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff11 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_01_next   ),
	.in       (pxl_01_next         ),
	.out      (pxl_out_dff_01      ),
	.valid_out(valid_pxl_out_dff_01)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff00 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_00_next   ),
	.in       (pxl_00_next         ),
	.out      (pxl_out_dff_00      ),
	.valid_out(valid_pxl_out_dff_00)
);

// Logic valid out
wire total_valid;

assign total_valid =  valid_pxl_04;

reg [CNT_WIDTH_BUFFER-1:0] counter_col  ;
reg                        valid_out_col;

always @(posedge clk) begin
	if(reset) begin
		counter_col   <= {CNT_WIDTH_BUFFER{1'b0}};
		valid_out_col <= 1'b0;

		load_weights    <= 1'b0;
	end
	else if (total_valid) begin
		counter_col   <= counter_col + 1'b1;
		valid_out_col <= 1'b1;
		if (counter_col[0]) begin
			if (stride2) begin
				valid_out_col <= 1'b0;
			end
		end

		if (counter_col >= IMAGE_WIDTH) begin
			counter_col <= {{CNT_WIDTH_BUFFER-1{1'b0}},1'b1};
		end

		if (!(|counter_col)) begin
			load_weights <= 1'b1;
		end
		else begin
			load_weights <= 1'b0;
		end
	end
	else begin
		counter_col <= {CNT_WIDTH_BUFFER{1'b0}};
		valid_out_col <= 1'b0;
	end

end

reg [CNT_WIDTH_BUFFER-1:0] counter_row  ;
reg                        valid_out_row;

always @(posedge clk) begin
	if(reset) begin
		counter_row   <= {CNT_WIDTH_BUFFER{1'b0}};
		valid_out_row <= 1'b0;
	end
	else if (total_valid && stride2) begin
		valid_out_row <= 1'b1;
		if (!(|(counter_col  % IMAGE_WIDTH))) begin
			counter_row <= counter_row + 1'b1;
		end

		if (!counter_row[0]) begin
			valid_out_row <= 1'b0;
		end
	end
	else begin
		counter_row   <= {CNT_WIDTH_BUFFER{1'b0}};
		valid_out_row <= 1'b0;
	end
end

// DFF
reg valid_out_col_next;

always @(posedge clk) begin
	if(reset) begin
		valid_out_col_next <= 1'b0;
	end
	else begin
		valid_out_col_next <= valid_out_col;
	end
end

assign valid_out = valid_out_col_next & (valid_out_row ~^ stride2);

// Padding
reg [CNT_WIDTH_BUFFER-1:0] cnt_pad;

always @(posedge clk) begin
	if(reset) begin
		cnt_pad <= {CNT_WIDTH_BUFFER{1'b0}};
	end
	else begin
		cnt_pad <= counter_col;
	end
end

assign pxl_out_08 = ((cnt_pad == IMAGE_WIDTH) || !valid_pxl_out_dff_08) 						? {DATA_WIDTH{1'b0}} : pxl_out_dff_08;

assign pxl_out_07 = (!valid_pxl_out_dff_07) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_07;

assign pxl_out_06 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_06) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_06;

assign pxl_out_05 = ((cnt_pad == IMAGE_WIDTH) || !valid_pxl_out_dff_05) 						? {DATA_WIDTH{1'b0}} : pxl_out_dff_05;

assign pxl_out_04 = (!valid_pxl_out_dff_04) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_04;

assign pxl_out_03 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_03) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_03;

assign pxl_out_02 = ((cnt_pad == IMAGE_WIDTH) || !valid_pxl_out_dff_02) 						? {DATA_WIDTH{1'b0}} : pxl_out_dff_02;

assign pxl_out_01 = (!valid_pxl_out_dff_01) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_01;

assign pxl_out_00 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_00) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_00;

endmodule