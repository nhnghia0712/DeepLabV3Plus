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

module cnn_concat_2in (
  clk, 
  reset,
   valid_in_no1,
  in_no1, 
  valid_in_no2,
  in_no2, 

  out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk         ;
input                  reset       ;
input                  valid_in_no1;
input [DATA_WIDTH-1:0] in_no1      ;
input                  valid_in_no2;
input [DATA_WIDTH-1:0] in_no2      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] out      ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk         ;
wire                  reset       ;
wire                  valid_in_no1;
wire [DATA_WIDTH-1:0] in_no1      ;
wire                  valid_in_no2;
wire [DATA_WIDTH-1:0] in_no2      ;

reg [DATA_WIDTH-1:0] out      ;
reg                  valid_out;

/////////////////////////////////////////////////////////////////////////
// FIFO
wire [DATA_WIDTH-1:0] pxl_out_fifo_1;
wire                  fifo_full_1   ;
wire                  fifo_empty_1  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_2;
wire                  fifo_full_2   ;
wire                  fifo_empty_2  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_3;
wire                  fifo_full_3   ;
wire                  fifo_empty_3  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_4;
wire                  fifo_full_4   ;
wire                  fifo_empty_4  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_5;
wire                  fifo_full_5   ;
wire                  fifo_empty_5  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_6;
wire                  fifo_full_6   ;
wire                  fifo_empty_6  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_7;
wire                  fifo_full_7   ;
wire                  fifo_empty_7  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_8;
wire                  fifo_full_8   ;
wire                  fifo_empty_8  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_9;
wire                  fifo_full_9   ;
wire                  fifo_empty_9  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_10;
wire                  fifo_full_10   ;
wire                  fifo_empty_10  ;

fifo_generator_0 inst_fifo1 (
	//input
	.clk  (clk           ),
	.srst (reset         ),
	.wr_en(valid_in_no1  ),
	.rd_en(fifo_full_10  ),
	.din  (in_no1        ),
	//output
	.dout (pxl_out_fifo_1),
	.full (fifo_full_1   ),
	.empty(fifo_empty_1  )
);

fifo_generator_0 inst_fifo2 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_in_no1 & fifo_full_1),
	.rd_en(fifo_empty_1              ),
	.din  (in_no1                    ),
	//output
	.dout (pxl_out_fifo_2            ),
	.full (fifo_full_2               ),
	.empty(fifo_empty_2              )
);

fifo_generator_0 inst_fifo3 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_in_no1 & fifo_full_2),
	.rd_en(fifo_empty_2              ),
	.din  (in_no1                    ),
	//output
	.dout (pxl_out_fifo_3            ),
	.full (fifo_full_3               ),
	.empty(fifo_empty_3              )
);

fifo_generator_0 inst_fifo4 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_in_no1 & fifo_full_3),
	.rd_en(fifo_empty_3              ),
	.din  (in_no1                    ),
	//output
	.dout (pxl_out_fifo_4            ),
	.full (fifo_full_4               ),
	.empty(fifo_empty_4              )
);

fifo_generator_0 inst_fifo5 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_in_no1 & fifo_full_4),
	.rd_en(fifo_empty_4              ),
	.din  (in_no1                    ),
	//output
	.dout (pxl_out_fifo_5            ),
	.full (fifo_full_5               ),
	.empty(fifo_empty_5              )
);

fifo_generator_0 inst_fifo6 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_in_no1 & fifo_full_5),
	.rd_en(fifo_empty_5              ),
	.din  (in_no1                    ),
	//output
	.dout (pxl_out_fifo_6            ),
	.full (fifo_full_6               ),
	.empty(fifo_empty_6              )
);

fifo_generator_0 inst_fifo7 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_in_no1 & fifo_full_6),
	.rd_en(fifo_empty_6              ),
	.din  (in_no1                    ),
	//output
	.dout (pxl_out_fifo_7            ),
	.full (fifo_full_7               ),
	.empty(fifo_empty_7              )
);

fifo_generator_0 inst_fifo8 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_in_no1 & fifo_full_7),
	.rd_en(fifo_empty_7              ),
	.din  (in_no1                    ),
	//output
	.dout (pxl_out_fifo_8            ),
	.full (fifo_full_8               ),
	.empty(fifo_empty_8              )
);

fifo_generator_0 inst_fifo9 (
	//input
	.clk  (clk           ),
	.srst (reset         ),
	.wr_en(valid_in_no2  ),
	.rd_en(fifo_empty_8  ),
	.din  (in_no2        ),
	//output
	.dout (pxl_out_fifo_9),
	.full (fifo_full_9   ),
	.empty(fifo_empty_9  )
);

fifo_generator_1 inst_fifo10 (
	//input
	.clk  (clk                       ),
	.srst (reset                     ),
	.wr_en(valid_in_no2 & fifo_full_9),
	.rd_en(fifo_empty_9              ),
	.din  (in_no2                    ),
	//output
	.dout (pxl_out_fifo_10           ),
	.full (fifo_full_10              ),
	.empty(fifo_empty_10             )
);

always @(posedge clk) begin
  if(reset) begin
    out <= 32'd0;
  end
  else begin
    case ({fifo_empty_9,fifo_empty_8,fifo_empty_7,fifo_empty_6,fifo_empty_5,fifo_empty_4,fifo_empty_3,fifo_empty_2,fifo_empty_1,fifo_full_10})
      10'd1   : out <= pxl_out_fifo_1;
      10'd2   : out <= pxl_out_fifo_2;
      10'd4   : out <= pxl_out_fifo_3;
      10'd8   : out <= pxl_out_fifo_4;
      10'd16  : out <= pxl_out_fifo_5;
      10'd32  : out <= pxl_out_fifo_6;
      10'd64  : out <= pxl_out_fifo_7;
      10'd128 : out <= pxl_out_fifo_8;
      10'd256 : out <= pxl_out_fifo_9;
      10'd512 : out <= pxl_out_fifo_10;
      default : out <= out;
    endcase
  end
end

reg valid_out_tmp;

always @(posedge clk) begin
  if(reset) begin
    valid_out_tmp <= 1'b0;
  end
  else begin
    valid_out_tmp <= (fifo_empty_9 & !fifo_empty_10) | (fifo_empty_8 & !fifo_empty_9) | (fifo_empty_7 & !fifo_empty_8) | (fifo_empty_6 & !fifo_empty_7) | (fifo_empty_5 & !fifo_empty_6) |
      (fifo_empty_4 & !fifo_empty_5) | (fifo_empty_3 & !fifo_empty_4) | (fifo_empty_2 & !fifo_empty_3) | (fifo_empty_1 & !fifo_empty_2) | (fifo_full_10 & !fifo_empty_1);
  end
end

always @(posedge clk) begin
  if(reset) begin
    valid_out <= 1'b0;
  end
  else begin
    valid_out <= valid_out_tmp;
  end
end

endmodule


