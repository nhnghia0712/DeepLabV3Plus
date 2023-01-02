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

module conv_align_stride2_output (
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
parameter DATA_WIDTH  = 32 ;
parameter IMAGE_WIDTH = 256;

parameter ADDR_WIDTH = $clog2((IMAGE_WIDTH/2)) + 1;

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

assign pxl_out   = (stride2) ? out_filter2:pxl_in;
assign valid_out = (stride2) ? valid_out_filter2:valid_in;

endmodule