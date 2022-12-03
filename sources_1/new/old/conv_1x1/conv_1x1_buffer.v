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

module conv_1x1_buffer (
  clk, 
  reset,
  valid_in,
  in,
  stride2,

  out_buffer,
  valid_out,

  load_weights
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// Localparam TOP
parameter IMAGE_SIZE  = 36; // 6x6
parameter IMAGE_WIDTH = 6 ;

// Parameter of submodules
parameter CNT_WIDTH_BUFFER = 6; // $clog2(IMAGE_SIZE)  // For Buffer = log2(IMAGE_SIZE)

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk     ;
input                  reset   ;
input                  valid_in;
input [DATA_WIDTH-1:0] in      ;
input                  stride2 ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] out_buffer;

output valid_out   ;
output load_weights;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk     ;
wire                  reset   ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] in      ;
wire                  stride2 ;

wire [DATA_WIDTH-1:0] out_buffer;

wire valid_out   ;
reg  load_weights;

wire [DATA_WIDTH-1:0] out_buffer_next;

wire valid_out_buffer_next;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff8_general (
	.clk      (clk                  ),
	.reset    (reset                ),
	.valid_in (valid_in             ),
	.in       (in                   ),
	.out      (out_buffer_next      ),
	.valid_out(valid_out_buffer_next)
);

/////////////////////////////////////////////////////////////////////////
// 
wire [DATA_WIDTH-1:0] out_buffer_tmp;

wire valid_out_buffer_tmp;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff_tmp (
	.clk      (clk                  ),
	.reset    (reset                ),
	.valid_in (valid_out_buffer_next),
	.in       (out_buffer_next      ),
	.out      (out_buffer_tmp       ),
	.valid_out(valid_out_buffer_tmp )
);

/////////////////////////////////////////////////////////////////////////
d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff88 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_out_buffer_tmp),
	.in       (out_buffer_tmp      ),
	.out      (out_buffer          ),
	.valid_out(/*no use*/          )
);

// Logic valid out
reg [CNT_WIDTH_BUFFER-1:0] counter      ;
reg                        valid_out_tmp;

always @(posedge clk) begin
	if(reset) begin
		counter       <= {CNT_WIDTH_BUFFER{1'b0}};
		valid_out_tmp <= 1'b0;

		load_weights <= 1'b0;
	end
	else if (valid_out_buffer_next) begin
		if (counter < IMAGE_SIZE - 1) begin
			valid_out_tmp <= 1'b1;
			counter       <= counter + 1'b1;
			if (counter[0] && stride2) begin
				valid_out_tmp <= 1'b0;
			end
			if (!(|counter)) begin
				load_weights <= 1'b1;
			end
			else begin
				load_weights <= 1'b0;
			end
		end
		else begin
			counter <= {{CNT_WIDTH_BUFFER-1{1'b0}},1'b0};
		end
	end
	else begin
		valid_out_tmp <= 1'b0;
		load_weights  <= 1'b0;
	end
end

reg [CNT_WIDTH_BUFFER-1:0] counter_row  ;
reg                        valid_out_row;

always @(posedge clk) begin
	if(reset) begin
		counter_row   <= {CNT_WIDTH_BUFFER{1'b0}};
		valid_out_row <= 1'b0;
	end
	else if (valid_out_buffer_next && stride2) begin
		valid_out_row <= 1'b1;
		if (!(|(counter % IMAGE_WIDTH))) begin
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
reg valid_out_col;

always @(posedge clk) begin
	if(reset) begin
		valid_out_col <= 1'b0;
	end
	else begin
		valid_out_col <= valid_out_tmp;
	end
end

assign valid_out = valid_out_col & (valid_out_row ~^ stride2);

endmodule