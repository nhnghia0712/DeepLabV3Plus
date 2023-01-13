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

module cnn_add_layer14 (
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

wire [DATA_WIDTH-1:0] out      ;
wire                  valid_out;

/////////////////////////////////////////////////////////////////////////
// DFF
wire [DATA_WIDTH-1:0] in_no1_tmp;

wire valid_in_no1_tmp;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff_tmp (
  .clk      (clk             ),
  .reset    (reset           ),
  .valid_in (valid_in_no1    ),
  .in       (in_no1          ),
  .out      (in_no1_tmp      ),
  .valid_out(valid_in_no1_tmp)
);

// FIFO
wire [DATA_WIDTH-1:0] pxl_out_fifo_21;
wire                  fifo_full_21   ;
wire                  fifo_empty_21  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_22;
// wire                  fifo_full_22   ;
// wire                  fifo_empty_22  ;

fifo_generator_0 inst_fifo21 (
  //input
  .clk  (clk            ),
  .srst (reset          ),
  .wr_en(valid_in_no2   ),
  .rd_en(valid_in_no1   ),
  .din  (in_no2         ),
  //output
  .dout (pxl_out_fifo_21),
  .full (fifo_full_21   ),
  .empty(fifo_empty_21  )
);

fifo_generator_0 inst_fifo22 (
  //input
  .clk  (clk                        ),
  .srst (reset                      ),
  .wr_en(valid_in_no2 & fifo_full_21),
  .rd_en(valid_in_no1 & fifo_empty_21),
  .din  (in_no2                     ),
  //output
  .dout (pxl_out_fifo_22            ),
  .full (/* no use fifo_full_22 */  ),
  .empty(/* no use fifo_empty_22 */ )
);

wire [DATA_WIDTH-1:0] out_fifo_2     ;
reg                   valid_out_fifo2;

assign out_fifo_2 = (!fifo_empty_21) ? pxl_out_fifo_21:pxl_out_fifo_22;

always @(posedge clk) begin
  if(reset) begin
    valid_out_fifo2 <= 1'b0;
  end
  else begin
    valid_out_fifo2 <= valid_in_no1;
  end
end

/////////////////////////////////////////////////////////////////////////
fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add (
  .reset    (reset                             ),
  .clk      (clk                               ),
  .valid_in (valid_in_no1_tmp & valid_out_fifo2),
  .in_a     (in_no1_tmp                        ),
  .in_b     (out_fifo_2                        ),
  .out      (out                               ),
  .valid_out(valid_out                         )
);

/////////////////////////////////////////////////////////////////////////

endmodule
