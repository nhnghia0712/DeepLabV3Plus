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

module conv_3x3_buffer_weights_19 (
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
parameter CNT_WIDTH_BUFFER_WEIGHTS     = 4; // $clog2(KERNEL_SIZE) // For Buffer Weights = log2(KERNEL_SIZE)

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

fifo_generator_0 inst_fifo08 (
	//input
	.clk  (clk               ),
	.srst (reset             ),
	.wr_en(write_req         ),
	.rd_en(load_weights      ),
	.din  (weight_out_08_next),
	//output
	.dout (weight_out_08     ),
	.full (/*no use*/        ),
	.empty(/*no use*/        )
);

fifo_generator_0 inst_fifo07 (
	//input
	.clk  (clk               ),
	.srst (reset             ),
	.wr_en(write_req         ),
	.rd_en(load_weights      ),
	.din  (weight_out_07_next),
	//output
	.dout (weight_out_07     ),
	.full (/*no use*/        ),
	.empty(/*no use*/        )
);

fifo_generator_0 inst_fifo06 (
	//input
	.clk  (clk               ),
	.srst (reset             ),
	.wr_en(write_req         ),
	.rd_en(load_weights      ),
	.din  (weight_out_06_next),
	//output
	.dout (weight_out_06     ),
	.full (/*no use*/        ),
	.empty(/*no use*/        )
);

fifo_generator_0 inst_fifo05 (
	//input
	.clk  (clk               ),
	.srst (reset             ),
	.wr_en(write_req         ),
	.rd_en(load_weights      ),
	.din  (weight_out_05_next),
	//output
	.dout (weight_out_05     ),
	.full (/*no use*/        ),
	.empty(/*no use*/        )
);


fifo_generator_0 inst_fifo04 (
	//input
	.clk  (clk               ),
	.srst (reset             ),
	.wr_en(write_req         ),
	.rd_en(load_weights      ),
	.din  (weight_out_04_next),
	//output
	.dout (weight_out_04     ),
	.full (/*no use*/        ),
	.empty(/*no use*/        )
);

fifo_generator_0 inst_fifo03 (
	//input
	.clk  (clk               ),
	.srst (reset             ),
	.wr_en(write_req         ),
	.rd_en(load_weights      ),
	.din  (weight_out_03_next),
	//output
	.dout (weight_out_03     ),
	.full (/*no use*/        ),
	.empty(/*no use*/        )
);

fifo_generator_0 inst_fifo02 (
	//input
	.clk  (clk               ),
	.srst (reset             ),
	.wr_en(write_req         ),
	.rd_en(load_weights      ),
	.din  (weight_out_02_next),
	//output
	.dout (weight_out_02     ),
	.full (/*no use*/        ),
	.empty(/*no use*/        )
);

fifo_generator_0 inst_fifo01 (
	//input
	.clk  (clk               ),
	.srst (reset             ),
	.wr_en(write_req         ),
	.rd_en(load_weights      ),
	.din  (weight_out_01_next),
	//output
	.dout (weight_out_01     ),
	.full (/*no use*/        ),
	.empty(/*no use*/        )
);

fifo_generator_0 inst_fifo00 (
	//input
	.clk  (clk               ),
	.srst (reset             ),
	.wr_en(write_req         ),
	.rd_en(load_weights      ),
	.din  (weight_out_00_next),
	//output
	.dout (weight_out_00     ),
	.full (/*no use*/        ),
	.empty(/*no use*/        )
);

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