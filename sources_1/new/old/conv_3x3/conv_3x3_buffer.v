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
parameter DATA_WIDTH           = 32;

// Parameter for submodule
parameter IMAGE_WIDTH          = 8 ;
parameter KERNEL               = 3 ; //3*3 Kernel

// Parameter for submodule
parameter CNT_WIDTH_BUFFER_COL = 6 ; // $clog2(IMAGE_HEIGHT_PADDING * (IMAGE_WIDTH_PADDING - (KERNEL - 1))) + 1
parameter CNT_WIDTH_BUFFER_ROW = 3 ; // $clog2(IMAGE_HEIGHT_PADDING - (KERNEL - 1)) + 1

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk     ;
input                  reset   ;
input                  valid_in;
input [DATA_WIDTH-1:0] in      ;

input stride2 ; //0=sride 1, 1=stride2

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

reg valid_out   ;
reg load_weights;

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

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff8_general (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_in    ),
	.in       (in          ),
	.out      (pxl_08      ),
	.valid_out(valid_pxl_08)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff7 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_08),
	.in       (pxl_08      ),
	.out      (pxl_07      ),
	.valid_out(valid_pxl_07)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff6 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_07),
	.in       (pxl_07      ),
	.out      (pxl_06      ),
	.valid_out(valid_pxl_06)
);

line_buffer #(
	.IMAGE_WIDTH(IMAGE_WIDTH),
	.KERNEL     (KERNEL     ),
	.DIN_WIDTH  (DATA_WIDTH )
) line_buffer5 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_06),
	.data_in  (pxl_06      ),
	.data_out (pxl_05      ),
	.valid_out(valid_pxl_05)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff4 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_05),
	.in       (pxl_05      ),
	.out      (pxl_04      ),
	.valid_out(valid_pxl_04)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_04),
	.in       (pxl_04      ),
	.out      (pxl_03      ),
	.valid_out(valid_pxl_03)
);

line_buffer #(
	.IMAGE_WIDTH(IMAGE_WIDTH),
	.KERNEL     (KERNEL     ),
	.DIN_WIDTH  (DATA_WIDTH )
) line_buffer2 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_03),
	.data_in  (pxl_03      ),
	.data_out (pxl_02      ),
	.valid_out(valid_pxl_02)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_02),
	.in       (pxl_02      ),
	.out      (pxl_01      ),
	.valid_out(valid_pxl_01)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff0 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_01),
	.in       (pxl_01      ),
	.out      (pxl_00      ),
	.valid_out(valid_pxl_00)
);

/////////////////////////////////////////////////////////////////////////
// 
wire [DATA_WIDTH-1:0] pxl_out_00;
wire [DATA_WIDTH-1:0] pxl_out_01;
wire [DATA_WIDTH-1:0] pxl_out_02;
wire [DATA_WIDTH-1:0] pxl_out_03;
wire [DATA_WIDTH-1:0] pxl_out_04;
wire [DATA_WIDTH-1:0] pxl_out_05;
wire [DATA_WIDTH-1:0] pxl_out_06;
wire [DATA_WIDTH-1:0] pxl_out_07;
wire [DATA_WIDTH-1:0] pxl_out_08;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff88 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_08),
	.in       (pxl_08      ),
	.out      (pxl_out_08  ),
	.valid_out(/*no use*/  )
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff77 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_07),
	.in       (pxl_07      ),
	.out      (pxl_out_07  ),
	.valid_out(/*no use*/  )
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff66 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_06),
	.in       (pxl_06      ),
	.out      (pxl_out_06  ),
	.valid_out(/*no use*/  )
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff55 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_05),
	.in       (pxl_05      ),
	.out      (pxl_out_05  ),
	.valid_out(/*no use*/  )
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff44 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_04),
	.in       (pxl_04      ),
	.out      (pxl_out_04  ),
	.valid_out(/*no use*/  )
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff33 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_03),
	.in       (pxl_03      ),
	.out      (pxl_out_03  ),
	.valid_out(/*no use*/  )
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff22 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_02),
	.in       (pxl_02      ),
	.out      (pxl_out_02  ),
	.valid_out(/*no use*/  )
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff11 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_01),
	.in       (pxl_01      ),
	.out      (pxl_out_01  ),
	.valid_out(/*no use*/  )
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff00 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_00),
	.in       (pxl_00      ),
	.out      (pxl_out_00  ),
	.valid_out(/*no use*/  )
);

// Logic valid out
wire total_valid;

reg set_new_channel;

assign total_valid = valid_pxl_02 &  valid_pxl_08 & set_new_channel;

reg [CNT_WIDTH_BUFFER_COL-1:0] counter_col  ;
reg                            valid_out_col;

always @(posedge clk) begin
	if(reset) begin
		counter_col   <= {CNT_WIDTH_BUFFER_COL{1'b0}};
		valid_out_col <= 1'b0;

		set_new_channel <= 1'b0;
		load_weights    <= 1'b0;
	end
	else if (total_valid) begin
		counter_col   <= counter_col + 1'b1;
		valid_out_col <= 1'b1;
		if ( !(|((counter_col + {{CNT_WIDTH_BUFFER_COL-2{1'b0}},2'b10}) % IMAGE_WIDTH)) ||
			!(|((counter_col + 1'b1) % IMAGE_WIDTH)) )begin
			valid_out_col <= 1'b0;
		end
		else if (counter_col[0]) begin
			if (stride2) begin
				valid_out_col <= 1'b0;
			end
		end
		if(!(|counter_col[CNT_WIDTH_BUFFER_COL-1:1]) && (counter_col[0])) begin
			load_weights <= 1'b1;
		end
		else begin
			load_weights <= 1'b0;
		end
	end
	else if(!valid_pxl_08)begin
		valid_out_col   <= 1'b0;
		set_new_channel <= 1'b0;
	end
	else if(!valid_pxl_02)begin
		set_new_channel <= 1'b1;
	end
	else begin
		counter_col <= {CNT_WIDTH_BUFFER_COL{1'b0}};
	end
end

reg [CNT_WIDTH_BUFFER_ROW-1:0] counter_row  ;
reg        valid_out_row;

always @(posedge clk) begin
	if(reset) begin
		counter_row   <= {CNT_WIDTH_BUFFER_ROW{1'b0}};
		valid_out_row <= 1'b0;
	end
	else if (total_valid  && stride2) begin
		valid_out_row <= 1'b1;
		if (!(|(counter_col  % IMAGE_WIDTH)))begin
			counter_row <= counter_row + 1'b1;
		end

		if (!(counter_row[0])) begin
			valid_out_row <= 1'b0;
		end
	end
	else begin
		counter_row   <= {CNT_WIDTH_BUFFER_ROW{1'b0}};
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

always @(posedge clk) begin
	if(reset) begin
		valid_out <= 1'b0;
	end
	else begin
		valid_out <= valid_out_col_next & (valid_out_row ~^ stride2);
	end
end

endmodule