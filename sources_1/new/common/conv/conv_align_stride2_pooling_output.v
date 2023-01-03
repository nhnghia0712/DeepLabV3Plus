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

module conv_align_stride2_pooling_output (
  clk, 
  reset,
  stride2,
  valid_in,
  pxl_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH     = 32   ;
parameter IMAGE_WIDTH    = 32   ;
parameter CHANNEL_NUM_IN = 64   ;
parameter IMAGE_SIZE     = 32*32;

parameter ADDR_WIDTH      = $clog2((IMAGE_WIDTH/2)) + 1;
parameter ADDR_WIDTH2     = $clog2((IMAGE_SIZE/4)) + 1 ;
parameter ADDR_WIDTH_TMP2 = $clog2(CHANNEL_NUM_IN) + 1 ;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk     ;
input                  reset   ;
input                  stride2 ;
input                  valid_in;
input [DATA_WIDTH-1:0] pxl_in  ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk     ;
wire                  reset   ;
wire                  stride2 ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] pxl_in  ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

wire [ DATA_WIDTH-1:0] mem      [(IMAGE_WIDTH/2)-1:0];
wire [(IMAGE_WIDTH/2)-1:0] mem_valid                 ;

assign mem[0]       = pxl_in;
assign mem_valid[0] = valid_in;

genvar i;

generate
	for (i = 0; i < (IMAGE_WIDTH/2) - 1; i= i + 1) begin
		d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff (
			.clk      (clk           ),
			.reset    (reset         ),
			.valid_in (mem_valid[i]  ),
			.in       (mem[i]        ),
			.out      (mem[i+1]      ),
			.valid_out(mem_valid[i+1])
		);

	end
endgenerate

reg [ADDR_WIDTH-1:0] addr;

always @(posedge clk) begin
	if(reset) begin
		addr <= {ADDR_WIDTH{1'b0}};
	end
	else if (mem_valid[(IMAGE_WIDTH/2) - 1] || mem_valid[0]) begin
		addr <= addr + 1'b1;
	end
	else begin
		addr <= {ADDR_WIDTH{1'b0}};
	end
end

wire [DATA_WIDTH-1:0] out_filter      ;
wire                  valid_out_filter;

assign out_filter       = (mem_valid[(IMAGE_WIDTH/2) - addr] === 1'b1) ? mem[(IMAGE_WIDTH/2) - addr]:{DATA_WIDTH{1'b0}};
assign valid_out_filter = (mem_valid[(IMAGE_WIDTH/2) - addr] === 1'b1) ? 1'b1:1'b0;


wire [ DATA_WIDTH-1:0] mem2      [(IMAGE_WIDTH/2)-1:0];
wire [(IMAGE_WIDTH/2)-1:0] mem_valid2                 ;

assign mem2[0]       = out_filter;
assign mem_valid2[0] = valid_out_filter;

generate
	for (i = 0; i < (IMAGE_WIDTH/2) - 1; i= i + 1) begin
		line_buffer #(
			.IMAGE_WIDTH(IMAGE_WIDTH + (IMAGE_WIDTH/2)),
			.KERNEL     (1                            ),
			.DIN_WIDTH  (DATA_WIDTH                   )
		) line_buffer1 (
			.clk      (clk            ),
			.reset    (reset          ),
			.valid_in (mem_valid2[i]  ),
			.data_in  (mem2[i]        ),
			.data_out (mem2[i+1]      ),
			.valid_out(mem_valid2[i+1])
		);
	end
endgenerate

wire [     DATA_WIDTH-1:0] mem_dff      [(IMAGE_WIDTH/2)-1:0];
wire [(IMAGE_WIDTH/2)-1:0] mem_valid_dff                     ;

generate
	for (i = 0; i < (IMAGE_WIDTH/2); i= i + 1) begin
		d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff (
			.clk      (clk                                ),
			.reset    (reset                              ),
			.valid_in (mem_valid2[(IMAGE_WIDTH/2) - 1 - i]),
			.in       (mem2[(IMAGE_WIDTH/2) - 1 - i]      ),
			.out      (mem_dff[i]                         ),
			.valid_out(mem_valid_dff[i]                   )
		);
	end
endgenerate

reg [ADDR_WIDTH-1:0] cnt    ;
reg [ADDR_WIDTH-1:0] cnt_tmp;

always @(posedge clk) begin
	if(reset) begin
		cnt     <= {{ADDR_WIDTH-1{1'b0}},1'b1};
		cnt_tmp <= {ADDR_WIDTH{1'b0}};
	end
	else if (mem_valid2[(IMAGE_WIDTH/2) - 1]) begin
		cnt <= cnt + 1'b1;
		if (!(|cnt[ADDR_WIDTH-1:1]) && cnt[0]) begin
			cnt_tmp <= cnt_tmp + 1'b1;
		end
		else if (cnt_tmp >= (IMAGE_WIDTH/2)) begin
			cnt_tmp <= {ADDR_WIDTH{1'b0}};
		end
	end
	else if (cnt >= (IMAGE_WIDTH/2)) begin
		cnt <= {{ADDR_WIDTH-1{1'b0}},1'b1};
	end
end

wire [DATA_WIDTH-1:0] out_filter2      ;
wire                  valid_out_filter2;

function [3:0] clogb2 (input [3:0] value);
	begin
		clogb2 =3'd0;
		value = value - 1'b1;
		for(integer i = 0; i < 3; i = i + 1) begin
			if (value > 0) begin
				value = value >> 1;
				clogb2 = clogb2 + 1'b1;
			end
		end
	end
endfunction

assign out_filter2       = ((cnt_tmp < (IMAGE_WIDTH/8) + 1) && (cnt_tmp > 0)) ? mem_dff[clogb2(mem_valid_dff[(4*(cnt_tmp - 1))+:4])]:{DATA_WIDTH{1'b0}};
assign valid_out_filter2 = ((cnt_tmp < (IMAGE_WIDTH/8) + 1) && (cnt_tmp > 0)) ? mem_valid_dff[clogb2(mem_valid_dff[(4*(cnt_tmp - 1))+:4])]:1'b0;

wire [     DATA_WIDTH-1:0] mem3      [CHANNEL_NUM_IN-1:0];
wire [CHANNEL_NUM_IN-1:0] mem_valid3                     ;

assign mem3[0]       = out_filter2;
assign mem_valid3[0] = valid_out_filter2;

generate
	for (i = 0; i < CHANNEL_NUM_IN - 1; i= i + 1) begin
		line_buffer #(
			.IMAGE_WIDTH(IMAGE_WIDTH + 1 + (3 * (IMAGE_SIZE/4))),
			.KERNEL     (1                                     ),
			.DIN_WIDTH  (DATA_WIDTH                            )
		) line_buffer (
			.clk      (clk           ),
			.reset    (reset         ),
			.valid_in (mem_valid3[i]  ),
			.data_in  (mem3[i]        ),
			.data_out (mem3[i+1]      ),
			.valid_out(mem_valid3[i+1])
		);
	end
endgenerate

reg [    ADDR_WIDTH2-1:0] cnt2    ;
reg [ADDR_WIDTH_TMP2-1:0] cnt_tmp2;

always @(posedge clk) begin
	if(reset) begin
		cnt2     <= {{ADDR_WIDTH2-1{1'b0}},1'b1};
		cnt_tmp2 <= {ADDR_WIDTH_TMP2{1'b0}};
	end
	else if (mem_valid3[CHANNEL_NUM_IN - 1]) begin
		cnt2 <= cnt2 + 1'b1;
		if (!(|cnt2[ADDR_WIDTH2-1:1]) && cnt2[0]) begin
			cnt_tmp2 <= cnt_tmp2 + 1'b1;
		end
		else if (cnt_tmp2 > CHANNEL_NUM_IN) begin
			cnt_tmp2 <= {ADDR_WIDTH_TMP2{1'b0}};
		end
	end
	else if (cnt2 > (IMAGE_SIZE/4)) begin
		cnt2 <= {{ADDR_WIDTH2-1{1'b0}},1'b1};
	end
end

wire [                       DATA_WIDTH-1:0] mem_dff2      [(CHANNEL_NUM_IN*(CHANNEL_NUM_IN/4))-1:0];
wire [(CHANNEL_NUM_IN*(CHANNEL_NUM_IN/4))-1:0] mem_valid_dff2                                       ;

generate
	for (i = 0; i < CHANNEL_NUM_IN; i= i + 1) begin
		d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff (
			.clk      (clk                               ),
			.reset    (reset                             ),
			.valid_in (mem_valid3[CHANNEL_NUM_IN - 1 - i]),
			.in       (mem3[CHANNEL_NUM_IN - 1 - i]      ),
			.out      (mem_dff2[i]                       ),
			.valid_out(mem_valid_dff2[i]                 )
		);
	end
endgenerate

genvar j;

generate
	for (j = 0; j < CHANNEL_NUM_IN/4 - 1; j = j + 1) begin
		for (i = 0; i < CHANNEL_NUM_IN; i= i + 1) begin
			line_buffer #(
				.IMAGE_WIDTH(IMAGE_WIDTH + 1),
				.KERNEL     (1              ),
				.DIN_WIDTH  (DATA_WIDTH     )
			) line_buffer (
				.clk      (clk                                         ),
				.reset    (reset                                       ),
				.valid_in (mem_valid_dff2[(CHANNEL_NUM_IN * j) + i]    ),
				.data_in  (mem_dff2[(CHANNEL_NUM_IN * j) + i]          ),
				.data_out (mem_dff2[(CHANNEL_NUM_IN * (j+1)) + i]      ),
				.valid_out(mem_valid_dff2[(CHANNEL_NUM_IN * (j+1)) + i])
			);
		end
	end
endgenerate

reg [DATA_WIDTH-1:0] out_filter3      ;
reg                  valid_out_filter3;

always @(posedge clk) begin : proc_
	if(reset) begin
		out_filter3       <= {DATA_WIDTH{1'b0}};
		valid_out_filter3 <= 1'b0;
	end
	else begin
		case (cnt_tmp2)
			'd1 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[3:0])];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[3:0])];
			end
			'd2 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[CHANNEL_NUM_IN + 8 - 1:CHANNEL_NUM_IN + 4]) + CHANNEL_NUM_IN + 4];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[CHANNEL_NUM_IN + 8 - 1:CHANNEL_NUM_IN + 4]) + CHANNEL_NUM_IN + 4];
			end
			'd3 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*2) + 12 - 1:(CHANNEL_NUM_IN*2) + 8]) + (CHANNEL_NUM_IN*2) + 8];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*2) + 12 - 1:(CHANNEL_NUM_IN*2) + 8]) + (CHANNEL_NUM_IN*2) + 8];
			end
			'd4 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*3) + 16 - 1:(CHANNEL_NUM_IN*3) + 12]) + (CHANNEL_NUM_IN*3) + 12];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*3) + 16 - 1:(CHANNEL_NUM_IN*3) + 12]) + (CHANNEL_NUM_IN*3) + 12];
			end
			'd5 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*4) + 20 - 1:(CHANNEL_NUM_IN*4) + 16]) + (CHANNEL_NUM_IN*4) + 16];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*4) + 20 - 1:(CHANNEL_NUM_IN*4) + 16]) + (CHANNEL_NUM_IN*4) + 16];
			end
			'd6 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*5) + 24 - 1:(CHANNEL_NUM_IN*5) + 20]) + (CHANNEL_NUM_IN*5) + 20];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*5) + 24 - 1:(CHANNEL_NUM_IN*5) + 20]) + (CHANNEL_NUM_IN*5) + 20];
			end
			'd7 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*6) + 28 - 1:(CHANNEL_NUM_IN*6) + 24]) + (CHANNEL_NUM_IN*6) + 24];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*6) + 28 - 1:(CHANNEL_NUM_IN*6) + 24]) + (CHANNEL_NUM_IN*6) + 24];
			end
			'd8 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*7) + 32 - 1:(CHANNEL_NUM_IN*7) + 28]) + (CHANNEL_NUM_IN*7) + 28];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*7) + 32 - 1:(CHANNEL_NUM_IN*7) + 28]) + (CHANNEL_NUM_IN*7) + 28];
			end
			'd9 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*8) + 36 - 1:(CHANNEL_NUM_IN*8) + 32]) + (CHANNEL_NUM_IN*8) + 32];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*8) + 36 - 1:(CHANNEL_NUM_IN*8) + 32]) + (CHANNEL_NUM_IN*8) + 32];
			end
			'd10 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*9) + 40 - 1:(CHANNEL_NUM_IN*9) + 36]) + (CHANNEL_NUM_IN*9) + 36];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*9) + 40 - 1:(CHANNEL_NUM_IN*9) + 36]) + (CHANNEL_NUM_IN*9) + 36];
			end
			'd11 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*10) + 44 - 1:(CHANNEL_NUM_IN*10) + 40]) + (CHANNEL_NUM_IN*10) + 40];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*10) + 44 - 1:(CHANNEL_NUM_IN*10) + 40]) + (CHANNEL_NUM_IN*10) + 40];
			end
			'd12 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*11) + 48 - 1:(CHANNEL_NUM_IN*11) + 44]) + (CHANNEL_NUM_IN*11) + 44];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*11) + 48 - 1:(CHANNEL_NUM_IN*11) + 44]) + (CHANNEL_NUM_IN*11) + 44];
			end
			'd13 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*12) + 52 - 1:(CHANNEL_NUM_IN*12) + 48]) + (CHANNEL_NUM_IN*12) + 48];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*12) + 52 - 1:(CHANNEL_NUM_IN*12) + 48]) + (CHANNEL_NUM_IN*12) + 48];
			end
			'd14 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*13) + 56 - 1:(CHANNEL_NUM_IN*13) + 52]) + (CHANNEL_NUM_IN*13) + 52];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*13) + 56 - 1:(CHANNEL_NUM_IN*13) + 52]) + (CHANNEL_NUM_IN*13) + 52];
			end
			'd15 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*14) + 60 - 1:(CHANNEL_NUM_IN*14) + 56]) + (CHANNEL_NUM_IN*14) + 56];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*14) + 60 - 1:(CHANNEL_NUM_IN*14) + 56]) + (CHANNEL_NUM_IN*14) + 56];
			end
			'd16 : begin
				out_filter3       <= mem_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*15) + 64 - 1:(CHANNEL_NUM_IN*15) + 60]) + (CHANNEL_NUM_IN*15) + 60];
				valid_out_filter3 <= mem_valid_dff2[clogb2(mem_valid_dff2[(CHANNEL_NUM_IN*15) + 64 - 1:(CHANNEL_NUM_IN*15) + 60]) + (CHANNEL_NUM_IN*15) + 60];
			end
			default : /* default */;
		endcase
	end
end

// assign out_filter3       = ((cnt_tmp2 < (CHANNEL_NUM_IN/4) + 1) && (cnt_tmp2 > 0)) ? mem_dff2[clogb2(mem_valid_dff2[((CHANNEL_NUM_IN*(cnt_tmp2 - 1)) + (2**cnt_tmp2))+:4])]:{DATA_WIDTH{1'b0}};
// assign valid_out_filter3 = ((cnt_tmp2 < (CHANNEL_NUM_IN/4) + 1) && (cnt_tmp2 > 0)) ? mem_valid_dff2[clogb2(mem_valid_dff2[((CHANNEL_NUM_IN*(cnt_tmp2 - 1)) + (2**cnt_tmp2))+:4])]:1'b0;

assign pxl_out   = (stride2) ? out_filter3:pxl_in;
assign valid_out = (stride2) ? valid_out_filter3:valid_in;

endmodule
