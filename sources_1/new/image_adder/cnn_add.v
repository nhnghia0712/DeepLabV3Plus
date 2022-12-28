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

module cnn_add (
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
parameter DATA_WIDTH  = 32     ;
parameter SHIFT_WIDTH = 612*612; //The number of channel 6x6x4

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
wire                  valid_out_line_buffer;
wire [DATA_WIDTH-1:0] out_line_buffer      ;

line_buffer #(
  .IMAGE_WIDTH(SHIFT_WIDTH),
  .KERNEL     (1          ),
  .DIN_WIDTH  (DATA_WIDTH )
) line_buffer0 (
  .clk      (clk                  ),
  .reset    (reset                ),
  .valid_in (valid_in_no2         ),
  .data_in  (in_no2               ),
  .data_out (out_line_buffer      ),
  .valid_out(valid_out_line_buffer)
);

/////////////////////////////////////////////////////////////////////////
fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add (
  .reset    (reset                               ),
  .clk      (clk                                 ),
  .valid_in (valid_in_no1 & valid_out_line_buffer),
  .in_a     (in_no1                              ),
  .in_b     (out_line_buffer                     ),
  .out      (out                                 ),
  .valid_out(valid_out                           )
);

/////////////////////////////////////////////////////////////////////////

endmodule


