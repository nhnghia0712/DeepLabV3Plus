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

module conv_loop_data_in_64x64x64 (
  clk, 
  reset,
  valid_in,
  pxl_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH           = 64                         ;
parameter IMAGE_WIDTH          = 64                         ;
parameter CHANNEL_NUM_IN       = 64                         ;
parameter CHANNEL_NUM_OUT      = 64                         ;
parameter RATE                 = 1                          ;
parameter IMAGE_SIZE           = IMAGE_WIDTH * IMAGE_WIDTH  ;
parameter CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE;

parameter ADDR_WIDTH = $clog2(CHANNEL_NUM_IN_PIXEL) + 1         ;
parameter CNT_WIDTH  = $clog2(CHANNEL_NUM_OUT) + 2              ;
parameter WAIT_WIDTH = $clog2(((IMAGE_WIDTH * RATE) + RATE)) + 1;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk     ;
input                  reset   ;
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
wire                  valid_in;
wire [DATA_WIDTH-1:0] pxl_in  ;

wire [DATA_WIDTH-1:0] pxl_out  ;
reg                   valid_out;

reg  [ADDR_WIDTH-1:0] addra        ;
reg                   rd_wr_sel_tmp;
wire                  rd_wr_sel    ;
reg  [ CNT_WIDTH-1:0] cnt_channel  ;
reg                   enable       ;
reg                   valid_out_tmp;

reg [WAIT_WIDTH-1:0] cnt_wait;

reg [DATA_WIDTH-1:0] pxl_in_next;

always @(posedge clk) begin
	if(reset) begin
		pxl_in_next <= 32'd0;
	end
	else begin
		pxl_in_next <= pxl_in;
	end
end

always @(posedge clk) begin
	if(reset) begin
		addra         <= {ADDR_WIDTH{1'b0}};
		valid_out_tmp <= 1'b0;
		cnt_wait      <= {WAIT_WIDTH{1'b0}};
	end
	else if (enable || valid_in) begin
		if (addra < CHANNEL_NUM_IN_PIXEL) begin
			if (cnt_channel > 1) begin
				if ( !(|((addra) % IMAGE_SIZE)) ) begin
					addra         <= addra + 1'b1;
					cnt_wait      <= {WAIT_WIDTH{1'b0}};
					valid_out_tmp <= 1'b1;
				end
				else if ((cnt_wait < ((IMAGE_WIDTH * RATE) + RATE)) && (addra > (IMAGE_SIZE))) begin
					cnt_wait      <= cnt_wait + 1'b1;
					valid_out_tmp <= 1'b0;
				end
				else begin
					addra         <= addra + 1'b1;
					valid_out_tmp <= 1'b1;
				end
			end
			else begin
				addra         <= addra + 1'b1;
				valid_out_tmp <= 1'b0;
			end
		end
		else if (cnt_channel == CHANNEL_NUM_OUT + 1) begin
			addra         <= addra;
			valid_out_tmp <= 1'b0;
		end
		else begin
			if ((cnt_wait < ((IMAGE_WIDTH * RATE) + RATE)) && (cnt_channel > 1)) begin
				cnt_wait      <= cnt_wait + 1'b1;
				valid_out_tmp <= 1'b0;
			end
			else begin
				addra         <= {ADDR_WIDTH{1'b0}};
				valid_out_tmp <= 1'b0;
			end
		end
	end
end

wire sel_signal;

assign sel_signal = ( (!(|addra[ADDR_WIDTH-1:2]) && addra[1] && !addra[0]) && (cnt_channel > 1) ) ? 1'b1:1'b0;

always @(posedge clk) begin
	if(reset) begin
		rd_wr_sel_tmp <= 1'b0;
	end
	else if (cnt_channel < 1) begin
		rd_wr_sel_tmp <= 1'b1;
	end
	else begin
		rd_wr_sel_tmp <= 1'b0;
	end
end

assign rd_wr_sel = rd_wr_sel_tmp | ((!(|cnt_channel[CNT_WIDTH-1:1]) & cnt_channel[0]) & (addra > 1));

always @(posedge clk) begin
	if(reset) begin
		enable <= 1'b0;
	end
	else if (valid_in) begin
		enable <= 1'b1;
	end
end

always @(posedge clk) begin
	if(reset) begin
		cnt_channel <= {CNT_WIDTH{1'b0}};
	end
	else if ((!(|addra[ADDR_WIDTH-1:1]) && addra[0]) && (cnt_channel < CHANNEL_NUM_OUT + 1)) begin
		cnt_channel <= cnt_channel + 1'b1;
	end
end

blk_mem_gen_2_262144 inst_mem (
	.clka (clk        ),
	.ena  (enable     ),
	.wea  (rd_wr_sel  ),
	.addra(addra      ),
	.dina (pxl_in_next),
	.douta(pxl_out    )
);

// reg valid_out_next;

// always @(posedge clk) begin
// 	if(reset) begin
// 		valid_out_next <= 1'b0;
// 	end
// 	else begin
// 		valid_out_next <= valid_out_tmp;
// 	end
// end

always @(posedge clk) begin
	if(reset) begin
		valid_out <= 1'b0;
	end
	else begin
		valid_out <= valid_out_tmp | sel_signal;
	end
end

endmodule
