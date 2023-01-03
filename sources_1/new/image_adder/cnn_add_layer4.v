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

module cnn_add_layer4 (
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
parameter DATA_WIDTH     = 32     ;
parameter IMAGE_WIDTH    = 16     ;
parameter IMAGE_SIZE     = 16     ;
parameter SHIFT_WIDTH_01 = 612*612; //The number of channel 6x6x4
parameter SHIFT_WIDTH_02 = 612*612; //The number of channel 6x6x4
parameter SHIFT_WIDTH_03 = 612*612; //The number of channel 6x6x4

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

wire [DATA_WIDTH-1:0] mem      [IMAGE_SIZE:0];
wire [  IMAGE_SIZE:0] mem_valid              ;

assign mem[0]       = in_no2;
assign mem_valid[0] = valid_in_no2;

genvar i;

generate
  for (i = 0; i < IMAGE_SIZE; i= i + 1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_01),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk           ),
      .reset    (reset         ),
      .valid_in (mem_valid[i]  ),
      .data_in  (mem[i]        ),
      .data_out (mem[i+1]      ),
      .valid_out(mem_valid[i+1])
    );
  end
endgenerate

wire [DATA_WIDTH-1:0] mem2      [IMAGE_WIDTH:0];
wire [ IMAGE_WIDTH:0] mem_valid2               ;

assign mem2[0]       = mem[IMAGE_SIZE];
assign mem_valid2[0] = mem_valid[IMAGE_SIZE];

generate
  for (i = 0; i < IMAGE_WIDTH; i= i + 1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_02),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk           ),
      .reset    (reset         ),
      .valid_in (mem_valid2[i]  ),
      .data_in  (mem2[i]        ),
      .data_out (mem2[i+1]      ),
      .valid_out(mem_valid2[i+1])
    );
  end
endgenerate

/////////////////////////////////////////////////////////////////////////
wire                  valid_out_line_buffer;
wire [DATA_WIDTH-1:0] out_line_buffer      ;

line_buffer #(
  .IMAGE_WIDTH(SHIFT_WIDTH_03),
  .KERNEL     (1             ),
  .DIN_WIDTH  (DATA_WIDTH    )
) line_buffer0 (
  .clk      (clk                     ),
  .reset    (reset                   ),
  .valid_in (mem_valid2[IMAGE_WIDTH-1]),
  .data_in  (mem2[IMAGE_WIDTH-1]      ),
  .data_out (out_line_buffer         ),
  .valid_out(valid_out_line_buffer   )
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


