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

module conv_channel_in_adder_256x256s2 (
  clk, 
  reset,
  valid_in,
  pxl_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH     = 32       ;
parameter IMAGE_SIZE     = 128 * 128;
parameter CHANNEL_NUM_IN = 3        ;
parameter IMAGE_WIDTH    = 128      ;
parameter RATE           = 3        ;

parameter POINTER_WIDTH_FIFO   = $clog2(IMAGE_SIZE * CHANNEL_NUM_IN * 64) + 1;
parameter WAIT_WIDTH           = $clog2(((IMAGE_WIDTH * RATE) + RATE)) + 1   ;
parameter POINTER_WIDTH        = $clog2(IMAGE_SIZE) + 1                      ;
parameter CNT_CHANNEL_IN_WIDTH = $clog2(CHANNEL_NUM_IN) + 1                  ;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk             ;
input                  reset           ;
input                  valid_in        ;
input [DATA_WIDTH-1:0] pxl_in;

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
wire                  valid_out;

reg [DATA_WIDTH-1:0] out_fifo_in      ;
reg                  valid_out_fifo_in;
// wire                  fifo_full_in     ;
// wire                  fifo_empty_in    ;

wire [DATA_WIDTH-1:0] out_fifo_in1  ;
wire                  fifo_full_in1 ;
wire                  fifo_empty_in1;

wire [DATA_WIDTH-1:0] out_fifo_in2  ;
wire                  fifo_full_in2 ;
wire                  fifo_empty_in2;

wire [DATA_WIDTH-1:0] out_fifo_in3  ;
wire                  fifo_full_in3 ;
wire                  fifo_empty_in3;

wire [DATA_WIDTH-1:0] out_fifo_in4  ;
wire                  fifo_full_in4 ;
wire                  fifo_empty_in4;

wire [DATA_WIDTH-1:0] out_fifo_in5  ;
wire                  fifo_full_in5 ;
wire                  fifo_empty_in5;

wire [DATA_WIDTH-1:0] out_fifo_in6  ;
wire                  fifo_full_in6 ;
wire                  fifo_empty_in6;

wire [DATA_WIDTH-1:0] out_fifo_in7  ;
wire                  fifo_full_in7 ;
wire                  fifo_empty_in7;

wire [DATA_WIDTH-1:0] out_fifo_in8  ;
wire                  fifo_full_in8 ;
wire                  fifo_empty_in8;

wire [DATA_WIDTH-1:0] out_fifo_in9  ;
wire                  fifo_full_in9 ;
wire                  fifo_empty_in9;

wire [DATA_WIDTH-1:0] out_fifo_in10  ;
wire                  fifo_full_in10 ;
wire                  fifo_empty_in10;

wire [DATA_WIDTH-1:0] out_fifo_in11  ;
wire                  fifo_full_in11 ;
wire                  fifo_empty_in11;

wire [DATA_WIDTH-1:0] out_fifo_in12  ;
wire                  fifo_full_in12 ;
wire                  fifo_empty_in12;

wire [DATA_WIDTH-1:0] out_fifo_in13  ;
wire                  fifo_full_in13 ;
wire                  fifo_empty_in13;

wire [DATA_WIDTH-1:0] out_fifo_in14  ;
wire                  fifo_full_in14 ;
wire                  fifo_empty_in14;

wire [DATA_WIDTH-1:0] out_fifo_in15  ;
wire                  fifo_full_in15 ;
wire                  fifo_empty_in15;

wire [DATA_WIDTH-1:0] out_fifo_in16  ;
wire                  fifo_full_in16 ;
wire                  fifo_empty_in16;

wire [DATA_WIDTH-1:0] out_fifo_in17  ;
wire                  fifo_full_in17 ;
wire                  fifo_empty_in17;

wire [DATA_WIDTH-1:0] out_fifo_in18  ;
wire                  fifo_full_in18 ;
wire                  fifo_empty_in18;

wire [DATA_WIDTH-1:0] out_fifo_in19  ;
wire                  fifo_full_in19 ;
wire                  fifo_empty_in19;

wire [DATA_WIDTH-1:0] out_fifo_in20  ;
wire                  fifo_full_in20 ;
wire                  fifo_empty_in20;

wire [DATA_WIDTH-1:0] out_fifo_in21  ;
wire                  fifo_full_in21 ;
wire                  fifo_empty_in21;

wire [DATA_WIDTH-1:0] out_fifo_in22  ;
wire                  fifo_full_in22 ;
wire                  fifo_empty_in22;

wire [DATA_WIDTH-1:0] out_fifo_in23  ;
wire                  fifo_full_in23 ;
wire                  fifo_empty_in23;

wire [DATA_WIDTH-1:0] out_fifo_in24  ;
wire                  fifo_full_in24 ;
wire                  fifo_empty_in24;

reg                     read_en_in ;
reg                     read_enable;
reg [POINTER_WIDTH-1:0] cnt_size_in;
reg [   WAIT_WIDTH-1:0] cnt_wait   ;

always @(posedge clk) begin
	if(reset) begin
		read_en_in <= 1'b0;
	end
	else if (fifo_full_in24 && (!fifo_empty_in24)) begin
		read_en_in <= 1'b1;
	end
end

always @(posedge clk) begin
	if(reset) begin
		cnt_size_in <= {POINTER_WIDTH{1'b0}};
		cnt_wait    <= {WAIT_WIDTH{1'b0}};
		read_enable <= 1'b0;
	end
	else if (read_en_in && (cnt_size_in < IMAGE_SIZE)) begin
		cnt_size_in <= cnt_size_in + 1'b1;
		cnt_wait    <= {WAIT_WIDTH{1'b0}};
		read_enable <= 1'b1;
	end
	else begin
		read_enable <= 1'b0;
		if (cnt_wait < ((IMAGE_WIDTH * RATE) + RATE)) begin
			cnt_wait <= cnt_wait + 1'b1;
		end
		else begin
			cnt_size_in <= {POINTER_WIDTH{1'b0}};
		end
	end
end

fifo_generator_0 inst_fifo_in1 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_in                    ),
	.rd_en(read_enable & fifo_full_in24),
	.din  (pxl_in                      ),
	//output
	.dout (out_fifo_in1                ),
	.full (fifo_full_in1               ),
	.empty(fifo_empty_in1              )
);

fifo_generator_0 inst_fifo_in2 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_in & fifo_full_in1    ),
	.rd_en(read_enable & fifo_empty_in1),
	.din  (pxl_in                      ),
	//output
	.dout (out_fifo_in2                ),
	.full (fifo_full_in2               ),
	.empty(fifo_empty_in2              )
);

fifo_generator_0 inst_fifo_in3 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_in & fifo_full_in2    ),
	.rd_en(read_enable & fifo_empty_in2),
	.din  (pxl_in                      ),
	//output
	.dout (out_fifo_in3                ),
	.full (fifo_full_in3               ),
	.empty(fifo_empty_in3              )
);

fifo_generator_0 inst_fifo_in4 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_in & fifo_full_in3    ),
	.rd_en(read_enable & fifo_empty_in3),
	.din  (pxl_in                      ),
	//output
	.dout (out_fifo_in4                ),
	.full (fifo_full_in4               ),
	.empty(fifo_empty_in4              )
);

fifo_generator_0 inst_fifo_in5 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_in & fifo_full_in4    ),
	.rd_en(read_enable & fifo_empty_in4),
	.din  (pxl_in                      ),
	//output
	.dout (out_fifo_in5                ),
	.full (fifo_full_in5               ),
	.empty(fifo_empty_in5              )
);

fifo_generator_0 inst_fifo_in6 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_in & fifo_full_in5    ),
	.rd_en(read_enable & fifo_empty_in5),
	.din  (pxl_in                      ),
	//output
	.dout (out_fifo_in6                ),
	.full (fifo_full_in6               ),
	.empty(fifo_empty_in6              )
);

fifo_generator_0 inst_fifo_in7 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_in & fifo_full_in6    ),
	.rd_en(read_enable & fifo_empty_in6),
	.din  (pxl_in                      ),
	//output
	.dout (out_fifo_in7                ),
	.full (fifo_full_in7               ),
	.empty(fifo_empty_in7              )
);

fifo_generator_0 inst_fifo_in8 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_in & fifo_full_in7    ),
	.rd_en(read_enable & fifo_empty_in7),
	.din  (pxl_in                      ),
	//output
	.dout (out_fifo_in8                ),
	.full (fifo_full_in8               ),
	.empty(fifo_empty_in8              )
);

fifo_generator_0 inst_fifo_in9 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_in & fifo_full_in8    ),
	.rd_en(read_enable & fifo_empty_in8),
	.din  (pxl_in                      ),
	//output
	.dout (out_fifo_in9                ),
	.full (fifo_full_in9               ),
	.empty(fifo_empty_in9              )
);

fifo_generator_0 inst_fifo_in10 (
	//input
	.clk  (clk                         ),
	.srst (reset                       ),
	.wr_en(valid_in & fifo_full_in9    ),
	.rd_en(read_enable & fifo_empty_in9),
	.din  (pxl_in                      ),
	//output
	.dout (out_fifo_in10               ),
	.full (fifo_full_in10              ),
	.empty(fifo_empty_in10             )
);

fifo_generator_0 inst_fifo_in11 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in10    ),
	.rd_en(read_enable & fifo_empty_in10),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in11                ),
	.full (fifo_full_in11               ),
	.empty(fifo_empty_in11              )
);

fifo_generator_0 inst_fifo_in12 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in11    ),
	.rd_en(read_enable & fifo_empty_in11),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in12                ),
	.full (fifo_full_in12               ),
	.empty(fifo_empty_in12              )
);

fifo_generator_0 inst_fifo_in13 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in12    ),
	.rd_en(read_enable & fifo_empty_in12),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in13                ),
	.full (fifo_full_in13               ),
	.empty(fifo_empty_in13              )
);

fifo_generator_0 inst_fifo_in14 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in13    ),
	.rd_en(read_enable & fifo_empty_in13),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in14                ),
	.full (fifo_full_in14               ),
	.empty(fifo_empty_in14              )
);

fifo_generator_0 inst_fifo_in15 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in14    ),
	.rd_en(read_enable & fifo_empty_in14),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in15                ),
	.full (fifo_full_in15               ),
	.empty(fifo_empty_in15              )
);

fifo_generator_0 inst_fifo_in16 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in15    ),
	.rd_en(read_enable & fifo_empty_in15),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in16                ),
	.full (fifo_full_in16               ),
	.empty(fifo_empty_in16              )
);

fifo_generator_0 inst_fifo_in17 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in16    ),
	.rd_en(read_enable & fifo_empty_in16),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in17                ),
	.full (fifo_full_in17               ),
	.empty(fifo_empty_in17              )
);

fifo_generator_0 inst_fifo_in18 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in17    ),
	.rd_en(read_enable & fifo_empty_in17),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in18                ),
	.full (fifo_full_in18               ),
	.empty(fifo_empty_in18              )
);

fifo_generator_0 inst_fifo_in19 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in18    ),
	.rd_en(read_enable & fifo_empty_in18),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in19                ),
	.full (fifo_full_in19               ),
	.empty(fifo_empty_in19              )
);

fifo_generator_0 inst_fifo_in20 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in19    ),
	.rd_en(read_enable & fifo_empty_in19),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in20                ),
	.full (fifo_full_in20               ),
	.empty(fifo_empty_in20              )
);

fifo_generator_0 inst_fifo_in21 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in20    ),
	.rd_en(read_enable & fifo_empty_in20),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in21                ),
	.full (fifo_full_in21               ),
	.empty(fifo_empty_in21              )
);

fifo_generator_0 inst_fifo_in22 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in21    ),
	.rd_en(read_enable & fifo_empty_in21),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in22                ),
	.full (fifo_full_in22               ),
	.empty(fifo_empty_in22              )
);

fifo_generator_0 inst_fifo_in23 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in22    ),
	.rd_en(read_enable & fifo_empty_in22),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in23                ),
	.full (fifo_full_in23               ),
	.empty(fifo_empty_in23              )
);

fifo_generator_0 inst_fifo_in24 (
	//input
	.clk  (clk                          ),
	.srst (reset                        ),
	.wr_en(valid_in & fifo_full_in23    ),
	.rd_en(read_enable & fifo_empty_in23),
	.din  (pxl_in                       ),
	//output
	.dout (out_fifo_in24                ),
	.full (fifo_full_in24               ),
	.empty(fifo_empty_in24              )
);

// fifo_generator_2 inst_fifo_in1 (
//   //input
//   .clk  (clk          ),
//   .srst (reset        ),
//   .wr_en(valid_in     ),
//   .rd_en(read_enable  ),
//   .din  (pxl_in       ),
//   //output
//   .dout (out_fifo_in1  ),
//   .full (fifo_full_in1 ),
//   .empty(fifo_empty_in1)
// );

// fifo_generator_3_16384 inst_fifo_in2 (
//   //input
//   .clk  (clk                         ),
//   .srst (reset                       ),
//   .wr_en(valid_in & fifo_full_in1    ),
//   .rd_en(read_enable & fifo_empty_in1),
//   .din  (pxl_in                      ),
//   //output
//   .dout (out_fifo_in2                ),
//   .full (fifo_full_in2               ),
//   .empty(fifo_empty_in2              )
// );

//NghiaNg cnn_fifo_delay #(
//NghiaNg   .DATA_WIDTH   (DATA_WIDTH                      ),
//NghiaNg   .DATA_DEPTH   (IMAGE_SIZE * CHANNEL_NUM_IN * 64),
//NghiaNg   .POINTER_WIDTH(POINTER_WIDTH_FIFO              )
//NghiaNg ) inst_fifo (
//NghiaNg   //input
//NghiaNg   .clk     (clk          ),
//NghiaNg   .reset   (reset        ),
//NghiaNg   .write   (valid_in     ),
//NghiaNg   .read    (read_enable  ),
//NghiaNg   .data_in (pxl_in       ),
//NghiaNg   //output
//NghiaNg   .data_out(out_fifo_in  ),
//NghiaNg   .full    (fifo_full_in ),
//NghiaNg   .empty   (fifo_empty_in)
//NghiaNg );

always @(posedge clk) begin
  if(reset) begin
    out_fifo_in <= 32'd0;
  end
  else begin
     // case ({fifo_empty_in7,fifo_empty_in6,fifo_empty_in5,fifo_empty_in4,fifo_empty_in3,fifo_empty_in2,fifo_empty_in1,fifo_full_in8})
     //  8'd1       : out_fifo_in <= out_fifo_in1;
     //  8'd2       : out_fifo_in <= out_fifo_in2;
     //  8'd4       : out_fifo_in <= out_fifo_in3;
     //  8'd8       : out_fifo_in <= out_fifo_in4;
     //  8'd16      : out_fifo_in <= out_fifo_in5;
     //  8'd32      : out_fifo_in <= out_fifo_in6;
     //  8'd64      : out_fifo_in <= out_fifo_in7;
     //  8'd128     : out_fifo_in <= out_fifo_in8;
	case ({fifo_empty_in23,fifo_empty_in22,fifo_empty_in21,fifo_empty_in20,fifo_empty_in19,fifo_empty_in18
				,fifo_empty_in17,fifo_empty_in16,fifo_empty_in15,fifo_empty_in14,fifo_empty_in13,fifo_empty_in12
				,fifo_empty_in11,fifo_empty_in10,fifo_empty_in9,fifo_empty_in8,fifo_empty_in7,fifo_empty_in6
				,fifo_empty_in5,fifo_empty_in4,fifo_empty_in3,fifo_empty_in2,fifo_empty_in1,fifo_full_in24})
		24'd1       : out_fifo_in <= out_fifo_in1;
		24'd2       : out_fifo_in <= out_fifo_in2;
		24'd4       : out_fifo_in <= out_fifo_in3;
		24'd8       : out_fifo_in <= out_fifo_in4;
		24'd16      : out_fifo_in <= out_fifo_in5;
		24'd32      : out_fifo_in <= out_fifo_in6;
		24'd64      : out_fifo_in <= out_fifo_in7;
		24'd128     : out_fifo_in <= out_fifo_in8;
		24'd256     : out_fifo_in <= out_fifo_in9;
		24'd512     : out_fifo_in <= out_fifo_in10;
		24'd1024    : out_fifo_in <= out_fifo_in11;
		24'd2048    : out_fifo_in <= out_fifo_in12;
		24'd4096    : out_fifo_in <= out_fifo_in13;
		24'd8192    : out_fifo_in <= out_fifo_in14;
		24'd16834   : out_fifo_in <= out_fifo_in15;
		24'd32768   : out_fifo_in <= out_fifo_in16;
		24'd65536   : out_fifo_in <= out_fifo_in17;
		24'd131072  : out_fifo_in <= out_fifo_in18;
		24'd262144  : out_fifo_in <= out_fifo_in19;
		24'd524288  : out_fifo_in <= out_fifo_in20;
		24'd1048576 : out_fifo_in <= out_fifo_in21;
		24'd2097152 : out_fifo_in <= out_fifo_in22;
		24'd4194304 : out_fifo_in <= out_fifo_in23;
		24'd8388608 : out_fifo_in <= out_fifo_in24;
      default     : out_fifo_in <= out_fifo_in;
    endcase
  end
end

reg valid_out_fifo_in_tmp;

always @(posedge clk) begin
	if(reset) begin
		valid_out_fifo_in_tmp <= 1'b0;
	end
	else begin
		valid_out_fifo_in_tmp <= read_enable & !fifo_empty_in24;
	end
end

always @(posedge clk) begin
	if(reset) begin
		valid_out_fifo_in <= 1'b0;
	end
	else begin
		valid_out_fifo_in <= valid_out_fifo_in_tmp;
	end
end

wire [DATA_WIDTH-1:0] pxl_in_next  ;
wire                  valid_in_next;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff00 (
	.clk      (clk              ),
	.reset    (reset            ),
	.valid_in (valid_out_fifo_in),
	.in       (out_fifo_in      ),
	.out      (pxl_in_next      ),
	.valid_out(valid_in_next    )
);

wire [DATA_WIDTH-1:0] pxl_in_dff  ;
wire                  valid_in_dff;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff01 (
	.clk      (clk          ),
	.reset    (reset        ),
	.valid_in (valid_in_next),
	.in       (pxl_in_next  ),
	.out      (pxl_in_dff   ),
	.valid_out(valid_in_dff )
);

reg [POINTER_WIDTH-1:0] cnt_size;

always @(posedge clk) begin
	if(reset) begin
		cnt_size <= {POINTER_WIDTH{1'b0}};
	end
	else if (valid_out_fifo_in && cnt_size < IMAGE_SIZE) begin
		cnt_size <= cnt_size + 1'b1;
	end
	else begin
		cnt_size <= {POINTER_WIDTH{1'b0}};
	end
end

reg [CNT_CHANNEL_IN_WIDTH-1:0] cnt_channel;

always @(posedge clk) begin
	if(reset) begin
		cnt_channel <= {CNT_CHANNEL_IN_WIDTH{1'b0}};
	end
	else if (!(|cnt_size[POINTER_WIDTH-1:1]) && cnt_size[0]) begin
		if (cnt_channel < CHANNEL_NUM_IN) begin
			cnt_channel <= cnt_channel + 1'b1;
		end
		else begin
			cnt_channel <= {{CNT_CHANNEL_IN_WIDTH-1{1'b0}},1'b1};
		end
	end
end

wire [DATA_WIDTH-1:0] out_sel      ;
wire                  valid_out_sel;

assign out_sel       = (cnt_channel < {{CNT_CHANNEL_IN_WIDTH-2{1'b0}},1'b1,1'b0}) ? 32'd0:out_fifo;
assign valid_out_sel = (cnt_channel < {{CNT_CHANNEL_IN_WIDTH-2{1'b0}},1'b1,1'b0}) ? 1'b1:valid_out_fifo;


assign pxl_out   = ((cnt_channel == CHANNEL_NUM_IN) && valid_out_add) ? out_add:32'd0;
assign valid_out = ((cnt_channel == CHANNEL_NUM_IN) && valid_out_add) ? valid_out_add:1'b0;

wire [DATA_WIDTH-1:0] out_add      ;
wire                  valid_out_add;

wire [DATA_WIDTH-1:0] out_fifo      ;
wire                  valid_out_fifo;
wire                  fifo_full     ;

fp_add_sub inst_add1 (
	.reset    (reset                       ),
	.clk      (clk                         ),
	.valid_in (valid_in_dff & valid_out_sel),
	.in_a     (pxl_in_dff                  ),
	.in_b     (out_sel                     ),
	.out      (out_add                     ),
	.valid_out(valid_out_add               )
);

reg read_en;

always @(posedge clk) begin
	if(reset) begin
		read_en <= 1'b0;
	end
	else if (fifo_full) begin
		read_en <= 1'b1;
	end
end

wire [DATA_WIDTH-1:0] out_fifo_next      ;
reg                   valid_out_fifo_next;

fifo_generator_3_16384 inst_fifo07 (
	//input
	.clk  (clk                        ),
	.srst (reset                      ),
	.wr_en(valid_out_add              ),
	.rd_en(valid_out_fifo_in & read_en),
	.din  (out_add                    ),
	//output
	.dout (out_fifo_next              ),
	.full (fifo_full                  ),
	.empty(/*no use*/                 )
);

always @(posedge clk) begin
	if(reset) begin
		valid_out_fifo_next <= 1'b0;
	end
	else begin
		valid_out_fifo_next <= valid_out_fifo_in & read_en;
	end
end

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff02 (
	.clk      (clk                ),
	.reset    (reset              ),
	.valid_in (valid_out_fifo_next),
	.in       (out_fifo_next      ),
	.out      (out_fifo           ),
	.valid_out(valid_out_fifo     )
);

endmodule
