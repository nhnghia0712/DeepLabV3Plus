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

module conv_loop_data_in_new (
  clk, 
  reset,
  valid_in,
  pxl_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH           = 32                              ;
parameter CHANNEL_NUM_IN       = 64                              ;
parameter CHANNEL_NUM_OUT      = 64                              ;
parameter CHANNEL_NUM_IN_PIXEL = 612                             ;
parameter IMAGE_WIDTH          = 12                              ;
parameter IMAGE_SIZE           = 12                              ;
parameter RATE                 = 4                               ;
parameter LOOP_CHANNEL_IN_CNT  = $clog2(CHANNEL_NUM_IN)          ;
parameter LOOP_COL_CNT         = $clog2(IMAGE_SIZE + IMAGE_WIDTH);
/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk             ;
input                  reset           ;
input                  valid_in        ;
input [DATA_WIDTH-1:0] pxl_in          ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out         ;
output                  valid_out       ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk             ;
wire                  reset           ;
wire                  valid_in        ;
wire [DATA_WIDTH-1:0] pxl_in          ;

wire [DATA_WIDTH-1:0] pxl_out         ;
wire                  valid_out       ;

wire [     DATA_WIDTH-1:0] mem_in      [CHANNEL_NUM_IN-1:0];
wire [CHANNEL_NUM_IN-1:0] mem_valid_in                     ;

assign mem_in[0]       = pxl_in;
assign mem_valid_in[0] = valid_in;

genvar i;

generate
	for (i = 0; i < CHANNEL_NUM_IN - 1; i=i+1) begin
		line_buffer #(
			.IMAGE_WIDTH(((IMAGE_WIDTH * RATE ) + RATE)),
			.KERNEL     (1                             ),
			.DIN_WIDTH  (DATA_WIDTH                    )
		) line_buffer (
			.clk      (clk              ),
			.reset    (reset            ),
			.valid_in (mem_valid_in[i]  ),
			.data_in  (mem_in[i]        ),
			.data_out (mem_in[i+1]      ),
			.valid_out(mem_valid_in[i+1])
		);
	end
endgenerate

reg [LOOP_CHANNEL_IN_CNT-1:0] channel_in_cnt;
reg [       LOOP_COL_CNT-1:0] col_cnt       ;
reg [         DATA_WIDTH-1:0] out_mem       ;
reg                           valid_mem     ;

always @(posedge clk) begin
	if(reset) begin
		channel_in_cnt <= {LOOP_CHANNEL_IN_CNT{1'b0}};
		col_cnt        <= {LOOP_COL_CNT{1'b0}};
		valid_mem      <= 1'b0;
		out_mem        <= {DATA_WIDTH{1'b0}};
	end
	else if (mem_valid_in[channel_in_cnt] && channel_in_cnt < CHANNEL_NUM_IN) begin
		out_mem   <= mem_in[channel_in_cnt];
		valid_mem <= mem_valid_in[channel_in_cnt];
		col_cnt   <= col_cnt + 1'b1;
		if (col_cnt >= IMAGE_SIZE + ((IMAGE_WIDTH * RATE) + RATE) - 1) begin
			channel_in_cnt <= channel_in_cnt + 1'b1;
			col_cnt        <= {LOOP_COL_CNT{1'b0}};
		end

		if (col_cnt >= IMAGE_SIZE) begin
			valid_mem <= 1'b0;
		end
	end
	else begin
		channel_in_cnt <= {LOOP_CHANNEL_IN_CNT{1'b0}};
		col_cnt        <= {LOOP_COL_CNT{1'b0}};
		valid_mem      <= 1'b0;
	end
end

wire [     DATA_WIDTH-1:0] mem      [CHANNEL_NUM_OUT-1:0];
wire [CHANNEL_NUM_OUT-1:0] mem_valid                     ;

assign mem[0]       = (valid_mem) ? out_mem:{DATA_WIDTH{1'b0}};
assign mem_valid[0] = valid_mem;

wire [     DATA_WIDTH-1:0] mem_temp1      [CHANNEL_NUM_OUT-2:0];
wire [CHANNEL_NUM_OUT-2:0] mem_valid_temp1                     ;

wire [     DATA_WIDTH-1:0] mem_temp2      [CHANNEL_NUM_OUT-2:0];
wire [CHANNEL_NUM_OUT-2:0] mem_valid_temp2                     ;

wire [     DATA_WIDTH-1:0] mem_temp3      [CHANNEL_NUM_OUT-2:0];
wire [CHANNEL_NUM_OUT-2:0] mem_valid_temp3                     ;

wire [     DATA_WIDTH-1:0] mem_temp4      [CHANNEL_NUM_OUT-2:0];
wire [CHANNEL_NUM_OUT-2:0] mem_valid_temp4                     ;

wire [     DATA_WIDTH-1:0] mem_temp5      [CHANNEL_NUM_OUT-2:0];
wire [CHANNEL_NUM_OUT-2:0] mem_valid_temp5                     ;

wire [     DATA_WIDTH-1:0] mem_temp6      [CHANNEL_NUM_OUT-2:0];
wire [CHANNEL_NUM_OUT-2:0] mem_valid_temp6                     ;

wire [     DATA_WIDTH-1:0] mem_temp7      [CHANNEL_NUM_OUT-2:0];
wire [CHANNEL_NUM_OUT-2:0] mem_valid_temp7                     ;

generate
	for (i = 0; i < CHANNEL_NUM_OUT - 1; i = i + 1) begin
		line_buffer #(
			.IMAGE_WIDTH((CHANNEL_NUM_IN_PIXEL + (((IMAGE_WIDTH * RATE) + RATE) * CHANNEL_NUM_IN))/8),
			.KERNEL     (1                                                                          ),
			.DIN_WIDTH  (DATA_WIDTH                                                                 )
		) line_buffer1 (
			.clk      (clk               ),
			.reset    (reset             ),
			.valid_in (mem_valid[i]      ),
			.data_in  (mem[i]            ),
			.data_out (mem_temp1[i]      ),
			.valid_out(mem_valid_temp1[i])
		);

		line_buffer #(
			.IMAGE_WIDTH((CHANNEL_NUM_IN_PIXEL + (((IMAGE_WIDTH * RATE) + RATE) * CHANNEL_NUM_IN))/8),
			.KERNEL     (1                                                                          ),
			.DIN_WIDTH  (DATA_WIDTH                                                                 )
		) line_buffer2 (
			.clk      (clk               ),
			.reset    (reset             ),
			.valid_in (mem_valid_temp1[i]),
			.data_in  (mem_temp1[i]      ),
			.data_out (mem_temp2[i]      ),
			.valid_out(mem_valid_temp2[i])
		);

		line_buffer #(
			.IMAGE_WIDTH((CHANNEL_NUM_IN_PIXEL + (((IMAGE_WIDTH * RATE) + RATE) * CHANNEL_NUM_IN))/8),
			.KERNEL     (1                                                                          ),
			.DIN_WIDTH  (DATA_WIDTH                                                                 )
		) line_buffer3 (
			.clk      (clk               ),
			.reset    (reset             ),
			.valid_in (mem_valid_temp2[i]),
			.data_in  (mem_temp2[i]      ),
			.data_out (mem_temp3[i]      ),
			.valid_out(mem_valid_temp3[i])
		);

		line_buffer #(
			.IMAGE_WIDTH((CHANNEL_NUM_IN_PIXEL + (((IMAGE_WIDTH * RATE) + RATE) * CHANNEL_NUM_IN))/8),
			.KERNEL     (1                                                                          ),
			.DIN_WIDTH  (DATA_WIDTH                                                                 )
		) line_buffer4 (
			.clk      (clk               ),
			.reset    (reset             ),
			.valid_in (mem_valid_temp3[i]),
			.data_in  (mem_temp3[i]      ),
			.data_out (mem_temp4[i]      ),
			.valid_out(mem_valid_temp4[i])
		);

		line_buffer #(
			.IMAGE_WIDTH((CHANNEL_NUM_IN_PIXEL + (((IMAGE_WIDTH * RATE) + RATE) * CHANNEL_NUM_IN) + 8)/8),
			.KERNEL     (1                                                                              ),
			.DIN_WIDTH  (DATA_WIDTH                                                                     )
		) line_buffer5 (
			.clk      (clk               ),
			.reset    (reset             ),
			.valid_in (mem_valid_temp4[i]),
			.data_in  (mem_temp4[i]      ),
			.data_out (mem_temp5[i]      ),
			.valid_out(mem_valid_temp5[i])
		);

		line_buffer #(
			.IMAGE_WIDTH((CHANNEL_NUM_IN_PIXEL + (((IMAGE_WIDTH * RATE) + RATE) * CHANNEL_NUM_IN) + 8)/8),
			.KERNEL     (1                                                                              ),
			.DIN_WIDTH  (DATA_WIDTH                                                                     )
		) line_buffer6 (
			.clk      (clk               ),
			.reset    (reset             ),
			.valid_in (mem_valid_temp5[i]),
			.data_in  (mem_temp5[i]      ),
			.data_out (mem_temp6[i]      ),
			.valid_out(mem_valid_temp6[i])
		);

		line_buffer #(
			.IMAGE_WIDTH((CHANNEL_NUM_IN_PIXEL + (((IMAGE_WIDTH * RATE) + RATE) * CHANNEL_NUM_IN) + 8)/8),
			.KERNEL     (1                                                                              ),
			.DIN_WIDTH  (DATA_WIDTH                                                                     )
		) line_buffer7 (
			.clk      (clk               ),
			.reset    (reset             ),
			.valid_in (mem_valid_temp6[i]),
			.data_in  (mem_temp6[i]      ),
			.data_out (mem_temp7[i]      ),
			.valid_out(mem_valid_temp7[i])
		);

		line_buffer #(
			.IMAGE_WIDTH((CHANNEL_NUM_IN_PIXEL + (((IMAGE_WIDTH * RATE) + RATE) * CHANNEL_NUM_IN) + 8)/8),
			.KERNEL     (1                                                                              ),
			.DIN_WIDTH  (DATA_WIDTH                                                                     )
		) line_buffer8 (
			.clk      (clk               ),
			.reset    (reset             ),
			.valid_in (mem_valid_temp7[i]),
			.data_in  (mem_temp7[i]      ),
			.data_out (mem[i+1]          ),
			.valid_out(mem_valid[i+1]    )
		);
	end
endgenerate

// function gen bit
// function integer gen_bit;
// 	input [CHANNEL_NUM_OUT-1:0] value;
// 	integer 	i;
// 	begin
// 		gen_bit = 0;
// 		while (value) begin
// 			gen_bit = gen_bit+1;
// 			value = value >> 1;
// 		end
// 	end
// endfunction

function [CHANNEL_NUM_OUT-1:0] clogb2 (input [CHANNEL_NUM_OUT-1:0] value);
	begin
		clogb2 = {CHANNEL_NUM_OUT{1'b0}};
		value = value - 1'b1;
		for(integer i = 0; i < CHANNEL_NUM_OUT; i = i + 1) begin
			if (value > 0) begin
				value = value >> 1;
				clogb2 = clogb2 + 1'b1;
			end
		end
	end
endfunction

assign pxl_out   = mem[clogb2(mem_valid)];
assign valid_out = mem_valid[clogb2(mem_valid)];

endmodule