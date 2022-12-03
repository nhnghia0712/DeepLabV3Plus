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

module conv_padding(
  clk
  ,reset
  ,enable
  ,data_in

  ,read_data
  ,data_out
  ,valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations    	  
parameter DATA_WIDTH  = 32;

// General
parameter IMAGE_WIDTH  = 6 ; //Width
parameter IMAGE_HEIGHT = 6 ; //Height
parameter PADDING      = 1 ; //Padding

// Localparm in TOP
parameter IMAGE_SIZE   = 36; // 6x6

// Localparam general
parameter CHANNEL_NUM = 2; //The number of channel 

// Localparam
parameter PAD_H = PADDING * ((PADDING * 2) + IMAGE_WIDTH); // Height of top/bot padding

// Parameter of counter
parameter CNT_PAD_H_1_WIDTH     = 4; //  $clog2(PAD_H) + 1 //Optimize the number of bit in data
parameter CNT_PAD_H_2_WIDTH     = 4; // $clog2(PAD_H) + 1
parameter CNT_PAD_WIDTH         = 2; // $clog2(PADDING) + 2
parameter CNT_PAD_WH_WIDTH      = 3; // $clog2(IMAGE_WIDTH) + 1
parameter CNT_PAD_CHANNEL_WIDTH = 3; // $clog2(CHANNEL_NUM) + 1

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk    ;
input                  reset  ;
input                  enable ;
input [DATA_WIDTH-1:0] data_in;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output                  read_data;
output [DATA_WIDTH-1:0] data_out ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk    ;
wire                  reset  ;
wire                  enable ;
wire [DATA_WIDTH-1:0] data_in;

reg                   read_data;
wire [DATA_WIDTH-1:0] data_out ;
reg                   valid_out;

reg enable_req;

always @(posedge clk)begin
	if(reset)begin
		enable_req <= 1'b0;
	end
	else if (enable) begin
		enable_req <= 1'b1;
	end
end

/////////////////////////////////////////////////////////////////////////
reg [DATA_WIDTH-1:0] data_out_next;

reg [CNT_PAD_H_1_WIDTH-1:0] cnt_pad_h_1;

reg [ CNT_PAD_WH_WIDTH-1:0] cnt_h      ;
reg [CNT_PAD_WIDTH-1:0] cnt_pad_w_1;
reg [ CNT_PAD_WH_WIDTH-1:0] cnt_w      ;
reg [CNT_PAD_WIDTH-1:0] cnt_pad_w_2;

reg [CNT_PAD_H_2_WIDTH-1:0] cnt_pad_h_2;

reg [CNT_PAD_CHANNEL_WIDTH-1:0] cnt_channel    ;
reg                         set_new_channel;

always @(posedge clk)begin
	if(reset) begin
		data_out_next <= {DATA_WIDTH{1'b0}};
		valid_out     <= 1'b0;

		cnt_pad_h_1 <= {CNT_PAD_H_1_WIDTH{1'b0}};

		cnt_h       <= {CNT_PAD_WH_WIDTH{1'b0}};
		cnt_pad_w_1 <= {CNT_PAD_WIDTH{1'b0}};
		cnt_w       <= {CNT_PAD_WH_WIDTH{1'b0}};
		cnt_pad_w_2 <= {CNT_PAD_WIDTH{1'b0}};

		cnt_pad_h_2 <= {CNT_PAD_H_2_WIDTH{1'b0}};

		read_data <= 1'b0;

		set_new_channel <= 1'b0;
		cnt_channel     <= {CNT_PAD_CHANNEL_WIDTH{1'b0}};
		end
		else if(enable_req)begin // Need optimzie
			set_new_channel <= 1'b0;
			valid_out       <= 1'b1;
			if( cnt_pad_h_1 < PAD_H ) begin 				// Height of top/bot padding (the top of input matrix)
				data_out_next <= {DATA_WIDTH{1'b0}};
				cnt_pad_h_1   <= cnt_pad_h_1 + 1'b1;
			end
			else if (cnt_h < IMAGE_HEIGHT)begin 			// The middle of input matrix
				if (cnt_pad_h_1 == PAD_H && cnt_channel == {CNT_PAD_CHANNEL_WIDTH{1'b0}} && cnt_pad_w_1 == {CNT_PAD_WIDTH{1'b0}}) begin
					read_data <= 1'b1;
				end
				else begin
					read_data <= 1'b0;
				end

				if (cnt_pad_w_1 < PADDING) begin
					data_out_next <= {DATA_WIDTH{1'b0}};
					cnt_pad_w_1   <= cnt_pad_w_1 + 1'b1; 	//The left side
				end
				else if ( cnt_w < IMAGE_WIDTH)begin 		// The center
					read_data <= 1'b1;
					cnt_w     <= cnt_w + 1'b1;
				end
				else if (cnt_pad_w_2 < PADDING) begin 		// The right side
					read_data     <= 1'b0;
					data_out_next <= {DATA_WIDTH{1'b0}};
					cnt_pad_w_2   <= cnt_pad_w_2 + 1'b1;
				end
				else begin									// Back loop
					cnt_h       <= cnt_h + 1'b1;
					cnt_pad_w_1 <= {{CNT_PAD_WIDTH-1{1'b0}},1'b1};
					cnt_w       <= {CNT_PAD_WH_WIDTH{1'b0}};
					cnt_pad_w_2 <= {CNT_PAD_WIDTH{1'b0}};
				end
			end
			else if( cnt_pad_h_2 < ( PAD_H - 1) ) begin		// Height of bot padding (the bottom of input matrix)
				data_out_next <= {DATA_WIDTH{1'b0}};
				cnt_pad_h_2   <= cnt_pad_h_2 + 1'b1;
			end
			else if(set_new_channel) begin
				cnt_pad_h_1 <= {{CNT_PAD_H_1_WIDTH-1{1'b0}},1'b1};

				cnt_h       <= {CNT_PAD_WH_WIDTH{1'b0}};
				cnt_pad_w_1 <= {CNT_PAD_WIDTH{1'b0}};

				cnt_pad_h_2 <= {CNT_PAD_H_2_WIDTH{1'b0}};

				set_new_channel <= 1'b0;
				cnt_channel     <= cnt_channel + 1'b1;
			end
		else begin
			valid_out <= 1'b0;
			if(cnt_channel < CHANNEL_NUM - 1) begin
				set_new_channel <= 1'b1;
			end
			else begin
				set_new_channel <= 1'b0;
			end
		end
	end
end

assign data_out = (read_data) ? data_in:data_out_next;

// always @(posedge clk)begin
// 	if(set_new_channel) begin
// 		cnt_pad_h_1 <= {CNT_PAD_H_1_WIDTH{1'b0}};

// 		cnt_h       <= {CNT_PAD_WH_WIDTH{1'b0}};
// 		cnt_pad_w_1 <= {CNT_PAD_WIDTH{1'b0}};

// 		cnt_pad_h_2 <= {CNT_PAD_H_2_WIDTH{1'b0}};

// 		set_new_channel <= 1'b0;
// 		cnt_channel     <= cnt_channel + 1'b1;
// 	end
// end
endmodule








