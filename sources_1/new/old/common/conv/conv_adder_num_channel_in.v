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

module conv_adder_num_channel_in(
			reset,
			clk,
			valid_in,
			pxl_in,

			pxl_out,
			valid_out
);
/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH              = 32;
parameter IMAGE_SIZE              = 36;
parameter IMAGE_WIDTH             = 6 ; //Width
parameter PADDING                 = 1 ; //Padding
parameter CHANNEL_NUM             = 16;
parameter CHANNEL_NUM_IN          = 4 ;
parameter CHANNEL_NUM_OUT         = 4 ;
parameter CNT_WIDTH_ADDER         = 6 ;
parameter CNT_WIDTH_CHANNEL_ADDER = 5 ;
parameter CNT_WIDTH_NUM_ADDER     = 3 ;
parameter SHIFT_NUM_ADDER         = 1 ;

localparam CNT_NUM         = CHANNEL_NUM/CHANNEL_NUM_IN                                                                         ;
localparam SHIFT_WIDTH_IN  = IMAGE_SIZE + ((PADDING * 2) * (IMAGE_WIDTH - 1)) + (IMAGE_WIDTH * 2) + 7                           ;
localparam SHIFT_WIDTH_OUT = (IMAGE_SIZE * CHANNEL_NUM) + (((PADDING * 2 * (IMAGE_WIDTH - 1)) + IMAGE_SIZE) * (CHANNEL_NUM - 1));

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  reset   ;
input                  clk     ;
input                  valid_in;
input [DATA_WIDTH-1:0] pxl_in  ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  reset   ;
wire                  clk     ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] pxl_in  ;

reg [DATA_WIDTH-1:0] pxl_out  ;
reg                  valid_out;

/////////////////////////////////////////////////////////////////////////
reg sel_req;

reg [CNT_WIDTH_CHANNEL_ADDER-1:0] counter_channel;

reg [CNT_WIDTH_NUM_ADDER-1:0] counter_add;

always @(posedge clk) begin
	if(reset) begin
		counter_add <= {{CNT_WIDTH_NUM_ADDER-1{1'b0}},1'b1};
		sel_req     <= 1'b0;
	end
	else if (counter_channel == CHANNEL_NUM/counter_add) begin
		counter_add     <= counter_add * 2;
		counter_channel <= {CNT_WIDTH_CHANNEL_ADDER{1'b0}};
		sel_req         <= 1'b1;
	end

	if (counter_add == CNT_NUM) begin
		sel_req <= 1'b0;
	end
end

reg [DATA_WIDTH-1:0] out_mux      ;
reg                  valid_out_mux;

wire [DATA_WIDTH-1:0] pxl_out_next  ;
wire                  valid_out_next;

always @(posedge clk) begin
	if(reset) begin
		out_mux       <= {DATA_WIDTH{1'b0}};
		valid_out_mux <= 1'b0;

		pxl_out   <= {DATA_WIDTH{1'b0}};
		valid_out <= 1'b0;;
	end
	else if (sel_req) begin
		out_mux       <= pxl_out_next;
		valid_out_mux <= valid_out_next;
	end
	else begin
		out_mux       <= pxl_in;
		valid_out_mux <= valid_in;
		pxl_out       <= pxl_out_next;
		valid_out     <= valid_out_next;
	end
end

/////////////////////////////////////////////////////////////////////////
localparam SHIFT_NUM  = SHIFT_NUM_ADDER[12+:12];

wire [DATA_WIDTH-1:0] out_line_buffer      ;
wire                  valid_out_line_buffer;

line_buffer #(
	.IMAGE_WIDTH(SHIFT_WIDTH_IN * SHIFT_NUM),
	.KERNEL     (1                         ),
	.DIN_WIDTH  (DATA_WIDTH                )
) line_buffer1 (
	.clk      (clk            ),
	.reset    (reset          ),
	.valid_in (1'b1           ),
	.data_in  (out_mux        ),
	
	.data_out (out_line_buffer),
	.valid_out(/*no use*/     )
);

line_buffer #(
	.IMAGE_WIDTH(SHIFT_WIDTH_IN * SHIFT_NUM),
	.KERNEL     (1                         ),
	.DIN_WIDTH  (1                         )
) line_buffer2 (
	.clk      (clk                  ),
	.reset    (reset                ),
	.valid_in (1'b1                 ),
	.data_in  (valid_out_mux        ),
	
	.data_out (valid_out_line_buffer),
	.valid_out(/*no use*/           )
);         

//////////////////////////////
reg [CNT_WIDTH_ADDER-1:0] counter;

always @(posedge clk) begin
	if(reset) begin
		counter <= {CNT_WIDTH_ADDER{1'b0}};
	end
	else if (valid_out_line_buffer) begin
		counter <= counter + 1'b1;
	end
	else if (counter > IMAGE_SIZE - 1) begin
		counter <= 0;
	end
end

//////////////////////////////
// reg [CNT_WIDTH_CHANNEL_ADDER:0] counter_channel;

always @(posedge clk) begin
	if(reset) begin
		counter_channel <= {CNT_WIDTH_CHANNEL_ADDER{1'b0}};
	end
	else if (valid_out_line_buffer) begin
		if (!(|counter)) begin
			counter_channel <= counter_channel + 1'b1;
		end
	end
end

//////////////////////////////
reg sel_channel;

always @(posedge clk) begin
	if(reset) begin
		sel_channel <= 1'b0;
	end
	else if (counter_channel[0]) begin
		sel_channel <= 1'b1;
	end
	else begin
		sel_channel <= 1'b0;
	end
end

//////////////////////////////
wire [DATA_WIDTH-1:0] out_ff_1      ;
wire                  valid_out_ff_1;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1 (
	.clk      (clk                  ),
	.reset    (reset                ),
	.valid_in (valid_out_line_buffer),
	.in       (out_line_buffer      ),
	.out      (out_ff_1             ),
	.valid_out(valid_out_ff_1       )
);

//////////////////////////////
wire [DATA_WIDTH-1:0] out_ff_2      ;
wire                  valid_out_ff_2;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff2 (
	.clk      (clk           ),
	.reset    (reset         ),
	.valid_in (valid_out_ff_1),
	.in       (out_ff_1      ),
	.out      (out_ff_2      ),
	.valid_out(valid_out_ff_2)
);

//////////////////////////////
wire [DATA_WIDTH-1:0] out_ff_3      ;
wire                  valid_out_ff_3;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3 (
	.clk      (clk           ),
	.reset    (reset         ),
	.valid_in (valid_out_mux ),
	.in       (out_mux       ),
	.out      (out_ff_3      ),
	.valid_out(valid_out_ff_3)
);

//////////////////////////////
wire [DATA_WIDTH-1:0] out_ff_4      ;
wire                  valid_out_ff_4;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff4 (
	.clk      (clk           ),
	.reset    (reset         ),
	.valid_in (valid_out_ff_3),
	.in       (out_ff_3      ),
	.out      (out_ff_4      ),
	.valid_out(valid_out_ff_4)
);

//////////////////////////////
wire sel_matrix;

assign sel_matrix = valid_out_ff_2 & sel_channel;

// Adder
wire [DATA_WIDTH-1:0] out_add      ;
wire                  valid_out_add;

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add (
	.reset    (reset     ),
	.clk      (clk       ),
	.valid_in (sel_matrix),
	.in_a     (out_ff_2  ),
	.in_b     (out_ff_4  ),
	.out      (out_add   ),
	.valid_out(valid_out_add )
);

/////////////////////////////////////////////////////////////////////////
line_buffer #(
	.IMAGE_WIDTH(SHIFT_WIDTH_OUT),
	.KERNEL     (1              ),
	.DIN_WIDTH  (DATA_WIDTH     )
) line_buffer3 (
	.clk      (clk       ),
	.reset    (reset     ),
	.valid_in (1'b1      ),
	.data_in  (out_add   ),
	
	.data_out (pxl_out_next   ),
	.valid_out(/*no use*/)
);

line_buffer #(
	.IMAGE_WIDTH(SHIFT_WIDTH_OUT),
	.KERNEL     (1              ),
	.DIN_WIDTH  (1              )
) line_buffer4 (
	.clk      (clk          ),
	.reset    (reset        ),
	.valid_in (1'b1         ),
	.data_in  (valid_out_add),
	
	.data_out (valid_out_next    ),
	.valid_out(/*no use*/   )
);                

endmodule