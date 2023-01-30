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

module conv_3x3_buffer_weights_15_16_17 (
  clk, 
  reset,
  valid_in,
  in,
  load_weights,

  weight_out_00,
  weight_out_01,
  weight_out_02,
  weight_out_03,
  weight_out_04,
  weight_out_05,
  weight_out_06,
  weight_out_07,
  weight_out_08,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// Parameter for submodule
parameter CNT_WIDTH_BUFFER_WEIGHTS = 4; // $clog2(KERNEL_SIZE) // For Buffer Weights = log2(KERNEL_SIZE)

// Localparam general
parameter KERNEL_SIZE = 9 ; //3x3 Kernel

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk         ;
input                  reset       ;
input                  valid_in    ;
input [DATA_WIDTH-1:0] in          ;
input                  load_weights;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] weight_out_00; output [DATA_WIDTH-1:0] weight_out_01; output [DATA_WIDTH-1:0] weight_out_02;
output [DATA_WIDTH-1:0] weight_out_03; output [DATA_WIDTH-1:0] weight_out_04; output [DATA_WIDTH-1:0] weight_out_05;
output [DATA_WIDTH-1:0] weight_out_06; output [DATA_WIDTH-1:0] weight_out_07; output [DATA_WIDTH-1:0] weight_out_08;


output valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk        ;
wire                  reset      ;
wire                  valid_in   ;
wire [DATA_WIDTH-1:0] in         ;
wire                  load_weights;

wire [DATA_WIDTH-1:0] weight_out_00;
wire [DATA_WIDTH-1:0] weight_out_01;
wire [DATA_WIDTH-1:0] weight_out_02;
wire [DATA_WIDTH-1:0] weight_out_03;
wire [DATA_WIDTH-1:0] weight_out_04;
wire [DATA_WIDTH-1:0] weight_out_05;
wire [DATA_WIDTH-1:0] weight_out_06;
wire [DATA_WIDTH-1:0] weight_out_07;
wire [DATA_WIDTH-1:0] weight_out_08;

reg valid_out;


////////////////Buffer
wire [DATA_WIDTH-1:0] weight_out_00_next;
wire [DATA_WIDTH-1:0] weight_out_01_next;
wire [DATA_WIDTH-1:0] weight_out_02_next;
wire [DATA_WIDTH-1:0] weight_out_03_next;
wire [DATA_WIDTH-1:0] weight_out_04_next;
wire [DATA_WIDTH-1:0] weight_out_05_next;
wire [DATA_WIDTH-1:0] weight_out_06_next;
wire [DATA_WIDTH-1:0] weight_out_07_next;
wire [DATA_WIDTH-1:0] weight_out_08_next;

wire valid_weight_out_00_next;
wire valid_weight_out_01_next;
wire valid_weight_out_02_next;
wire valid_weight_out_03_next;
wire valid_weight_out_04_next;
wire valid_weight_out_05_next;
wire valid_weight_out_06_next;
wire valid_weight_out_07_next;
wire valid_weight_out_08_next;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff88 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_in                ),
	.in       (in                      ),
	.out      (weight_out_08_next      ),
	.valid_out(valid_weight_out_08_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff77 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_08_next),
	.in       (weight_out_08_next      ),
	.out      (weight_out_07_next      ),
	.valid_out(valid_weight_out_07_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff66 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_07_next),
	.in       (weight_out_07_next      ),
	.out      (weight_out_06_next      ),
	.valid_out(valid_weight_out_06_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff55 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_06_next),
	.in       (weight_out_06_next      ),
	.out      (weight_out_05_next      ),
	.valid_out(valid_weight_out_05_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff44 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_05_next),
	.in       (weight_out_05_next      ),
	.out      (weight_out_04_next      ),
	.valid_out(valid_weight_out_04_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff33 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_04_next),
	.in       (weight_out_04_next      ),
	.out      (weight_out_03_next      ),
	.valid_out(valid_weight_out_03_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff22 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_03_next),
	.in       (weight_out_03_next      ),
	.out      (weight_out_02_next      ),
	.valid_out(valid_weight_out_02_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff11 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_02_next),
	.in       (weight_out_02_next      ),
	.out      (weight_out_01_next      ),
	.valid_out(valid_weight_out_01_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff00 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_01_next),
	.in       (weight_out_01_next      ),
	.out      (weight_out_00_next      ),
	.valid_out(valid_weight_out_00_next)
);

// FIFO
reg write_req;

wire                  fifo_full_08    ;
wire                  fifo_empty_08   ;
wire [DATA_WIDTH-1:0] weight_out_08_00;
wire [DATA_WIDTH-1:0] weight_out_08_01;

fifo_generator_4_256 inst_fifo08 (
	//input
	.clk        (clk               ),
	.srst       (reset             ),
	.wr_en      (write_req         ),
	.rd_en      (load_weights      ),
	.din        (weight_out_08_next),
	//output
	.dout       (weight_out_08_00  ),
	.full       (fifo_full_08      ),
	.empty      (fifo_empty_08     ),
	.almost_full(/*no use*/        )
);

fifo_generator_4_256 inst_fifo18 (
	//input
	.clk        (clk                         ),
	.srst       (reset                       ),
	.wr_en      (write_req & fifo_full_08    ),
	.rd_en      (load_weights & fifo_empty_08),
	.din        (weight_out_08_next          ),
	//output
	.dout       (weight_out_08_01            ),
	.full       (/*no use*/                  ),
	.empty      (/*no use*/                  ),
	.almost_full(/*no use*/                  )
);

assign weight_out_08 = (fifo_empty_08) ? weight_out_08_01:weight_out_08_00;

wire                  fifo_full_07    ;
wire                  fifo_empty_07   ;
wire [DATA_WIDTH-1:0] weight_out_07_00;
wire [DATA_WIDTH-1:0] weight_out_07_01;

fifo_generator_4_256 inst_fifo07 (
	//input
	.clk        (clk               ),
	.srst       (reset             ),
	.wr_en      (write_req         ),
	.rd_en      (load_weights      ),
	.din        (weight_out_07_next),
	//output
	.dout       (weight_out_07_00  ),
	.full       (fifo_full_07      ),
	.empty      (fifo_empty_07     ),
	.almost_full(/*no use*/        )
);

fifo_generator_4_256 inst_fifo17 (
	//input
	.clk        (clk                         ),
	.srst       (reset                       ),
	.wr_en      (write_req & fifo_full_07    ),
	.rd_en      (load_weights & fifo_empty_07),
	.din        (weight_out_07_next          ),
	//output
	.dout       (weight_out_07_01            ),
	.full       (/*no use*/                  ),
	.empty      (/*no use*/                  ),
	.almost_full(/*no use*/                  )
);

assign weight_out_07 = (fifo_empty_07) ? weight_out_07_01:weight_out_07_00;

wire                  fifo_full_06    ;
wire                  fifo_empty_06   ;
wire [DATA_WIDTH-1:0] weight_out_06_00;
wire [DATA_WIDTH-1:0] weight_out_06_01;

fifo_generator_4_256 inst_fifo06 (
	//input
	.clk        (clk               ),
	.srst       (reset             ),
	.wr_en      (write_req         ),
	.rd_en      (load_weights      ),
	.din        (weight_out_06_next),
	//output
	.dout       (weight_out_06_00  ),
	.full       (fifo_full_06      ),
	.empty      (fifo_empty_06     ),
	.almost_full(/*no use*/        )
);

fifo_generator_4_256 inst_fifo16 (
	//input
	.clk        (clk                         ),
	.srst       (reset                       ),
	.wr_en      (write_req & fifo_full_06    ),
	.rd_en      (load_weights & fifo_empty_06),
	.din        (weight_out_06_next          ),
	//output
	.dout       (weight_out_06_01            ),
	.full       (/*no use*/                  ),
	.empty      (/*no use*/                  ),
	.almost_full(/*no use*/                  )
);

assign weight_out_06 = (fifo_empty_06) ? weight_out_06_01:weight_out_06_00;

wire                  fifo_full_05    ;
wire                  fifo_empty_05   ;
wire [DATA_WIDTH-1:0] weight_out_05_00;
wire [DATA_WIDTH-1:0] weight_out_05_01;

fifo_generator_4_256 inst_fifo05 (
	//input
	.clk        (clk               ),
	.srst       (reset             ),
	.wr_en      (write_req         ),
	.rd_en      (load_weights      ),
	.din        (weight_out_05_next),
	//output
	.dout       (weight_out_05_00  ),
	.full       (fifo_full_05      ),
	.empty      (fifo_empty_05     ),
	.almost_full(/*no use*/        )
);

fifo_generator_4_256 inst_fifo15 (
	//input
	.clk        (clk                         ),
	.srst       (reset                       ),
	.wr_en      (write_req & fifo_full_05    ),
	.rd_en      (load_weights & fifo_empty_05),
	.din        (weight_out_05_next          ),
	//output
	.dout       (weight_out_05_01            ),
	.full       (/*no use*/                  ),
	.empty      (/*no use*/                  ),
	.almost_full(/*no use*/                  )
);

assign weight_out_05 = (fifo_empty_05) ? weight_out_05_01:weight_out_05_00;

wire                  fifo_full_04    ;
wire                  fifo_empty_04   ;
wire [DATA_WIDTH-1:0] weight_out_04_00;
wire [DATA_WIDTH-1:0] weight_out_04_01;

fifo_generator_4_256 inst_fifo04 (
	//input
	.clk        (clk               ),
	.srst       (reset             ),
	.wr_en      (write_req         ),
	.rd_en      (load_weights      ),
	.din        (weight_out_04_next),
	//output
	.dout       (weight_out_04_00  ),
	.full       (fifo_full_04      ),
	.empty      (fifo_empty_04     ),
	.almost_full(/*no use*/        )
);

fifo_generator_4_256 inst_fifo14 (
	//input
	.clk        (clk                         ),
	.srst       (reset                       ),
	.wr_en      (write_req & fifo_full_04    ),
	.rd_en      (load_weights & fifo_empty_04),
	.din        (weight_out_04_next          ),
	//output
	.dout       (weight_out_04_01            ),
	.full       (/*no use*/                  ),
	.empty      (/*no use*/                  ),
	.almost_full(/*no use*/                  )
);

assign weight_out_04 = (fifo_empty_04) ? weight_out_04_01:weight_out_04_00;

wire                  fifo_full_03    ;
wire                  fifo_empty_03   ;
wire [DATA_WIDTH-1:0] weight_out_03_00;
wire [DATA_WIDTH-1:0] weight_out_03_01;

fifo_generator_4_256 inst_fifo03 (
	//input
	.clk        (clk               ),
	.srst       (reset             ),
	.wr_en      (write_req         ),
	.rd_en      (load_weights      ),
	.din        (weight_out_03_next),
	//output
	.dout       (weight_out_03_00  ),
	.full       (fifo_full_03      ),
	.empty      (fifo_empty_03     ),
	.almost_full(/*no use*/        )
);

fifo_generator_4_256 inst_fifo13 (
	//input
	.clk        (clk                         ),
	.srst       (reset                       ),
	.wr_en      (write_req & fifo_full_03    ),
	.rd_en      (load_weights & fifo_empty_03),
	.din        (weight_out_03_next          ),
	//output
	.dout       (weight_out_03_01            ),
	.full       (/*no use*/                  ),
	.empty      (/*no use*/                  ),
	.almost_full(/*no use*/                  )
);

assign weight_out_03 = (fifo_empty_03) ? weight_out_03_01:weight_out_03_00;

wire                  fifo_full_02    ;
wire                  fifo_empty_02   ;
wire [DATA_WIDTH-1:0] weight_out_02_00;
wire [DATA_WIDTH-1:0] weight_out_02_01;

fifo_generator_4_256 inst_fifo02 (
	//input
	.clk        (clk               ),
	.srst       (reset             ),
	.wr_en      (write_req         ),
	.rd_en      (load_weights      ),
	.din        (weight_out_02_next),
	//output
	.dout       (weight_out_02_00  ),
	.full       (fifo_full_02      ),
	.empty      (fifo_empty_02     ),
	.almost_full(/*no use*/        )
);

fifo_generator_4_256 inst_fifo12 (
	//input
	.clk        (clk                         ),
	.srst       (reset                       ),
	.wr_en      (write_req & fifo_full_02    ),
	.rd_en      (load_weights & fifo_empty_02),
	.din        (weight_out_02_next          ),
	//output
	.dout       (weight_out_02_01            ),
	.full       (/*no use*/                  ),
	.empty      (/*no use*/                  ),
	.almost_full(/*no use*/                  )
);

assign weight_out_02 = (fifo_empty_02) ? weight_out_02_01:weight_out_02_00;

wire                  fifo_full_01    ;
wire                  fifo_empty_01   ;
wire [DATA_WIDTH-1:0] weight_out_01_00;
wire [DATA_WIDTH-1:0] weight_out_01_01;

fifo_generator_4_256 inst_fifo01 (
	//input
	.clk        (clk               ),
	.srst       (reset             ),
	.wr_en      (write_req         ),
	.rd_en      (load_weights      ),
	.din        (weight_out_01_next),
	//output
	.dout       (weight_out_01_00  ),
	.full       (fifo_full_01      ),
	.empty      (fifo_empty_01     ),
	.almost_full(/*no use*/        )
);

fifo_generator_4_256 inst_fifo11 (
	//input
	.clk        (clk                         ),
	.srst       (reset                       ),
	.wr_en      (write_req & fifo_full_01    ),
	.rd_en      (load_weights & fifo_empty_01),
	.din        (weight_out_01_next          ),
	//output
	.dout       (weight_out_01_01            ),
	.full       (/*no use*/                  ),
	.empty      (/*no use*/                  ),
	.almost_full(/*no use*/                  )
);

assign weight_out_01 = (fifo_empty_01) ? weight_out_01_01:weight_out_01_00;

wire                  fifo_full_00    ;
wire                  fifo_empty_00   ;
wire [DATA_WIDTH-1:0] weight_out_00_00;
wire [DATA_WIDTH-1:0] weight_out_00_01;

fifo_generator_4_256 inst_fifo00 (
	//input
	.clk        (clk               ),
	.srst       (reset             ),
	.wr_en      (write_req         ),
	.rd_en      (load_weights      ),
	.din        (weight_out_00_next),
	//output
	.dout       (weight_out_00_00  ),
	.full       (fifo_full_00      ),
	.empty      (fifo_empty_00     ),
	.almost_full(/*no use*/        )
);

fifo_generator_4_256 inst_fifo10 (
	//input
	.clk        (clk                         ),
	.srst       (reset                       ),
	.wr_en      (write_req & fifo_full_00    ),
	.rd_en      (load_weights & fifo_empty_00),
	.din        (weight_out_00_next          ),
	//output
	.dout       (weight_out_00_01            ),
	.full       (/*no use*/                  ),
	.empty      (/*no use*/                  ),
	.almost_full(/*no use*/                  )
);

assign weight_out_00 = (fifo_empty_00) ? weight_out_00_01:weight_out_00_00;

//Shift
reg [CNT_WIDTH_BUFFER_WEIGHTS-1:0] counter_weights;

always @(posedge clk) begin
	if(reset) begin
		counter_weights <= {CNT_WIDTH_BUFFER_WEIGHTS{1'b0}};
		write_req       <= 1'b0;
	end
	else if (valid_weight_out_01_next && counter_weights <= KERNEL_SIZE - 2) begin
		counter_weights <= counter_weights + 1'b1;
		if (counter_weights == {CNT_WIDTH_BUFFER_WEIGHTS{1'b0}})begin
			write_req <= 1'b1;
		end
		else begin
			write_req <= 1'b0;
		end
	end
	else begin
		counter_weights <= {CNT_WIDTH_BUFFER_WEIGHTS{1'b0}};
	end
end

// DFF
always @(posedge clk) begin
	if(reset) begin
		valid_out <= 1'b0;
	end
	else if (load_weights) begin
		valid_out <= 1'b1;
	end
end
endmodule