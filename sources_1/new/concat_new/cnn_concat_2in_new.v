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

module cnn_concat_2in_new (
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
parameter DATA_WIDTH        = 32     ;
parameter CHANNEL_NUM_PIXEL = 612*612; //The number of channel 6x6x4

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
wire                  valid_out_line_buffer;
wire [DATA_WIDTH-1:0] out_line_buffer      ;

line_buffer #(
  .IMAGE_WIDTH(CHANNEL_NUM_PIXEL),
  .KERNEL     (1                ),
  .DIN_WIDTH  (DATA_WIDTH       )
) line_buffer0 (
  .clk      (clk                  ),
  .reset    (reset                ),
  .valid_in (valid_in_no2         ),
  .data_in  (in_no2               ),
  .data_out (out_line_buffer      ),
  .valid_out(valid_out_line_buffer)
);

always @(posedge clk) begin
  if(reset) begin
    out       <= {DATA_WIDTH{1'b0}};
    valid_out <= 1'b0;
  end
  else if (valid_in_no1) begin
    out       <= in_no1;
    valid_out <= valid_in_no1;
  end
  else if (valid_out_line_buffer) begin
    out       <= out_line_buffer;
    valid_out <= valid_out_line_buffer;
  end
  else begin
    valid_out <= 1'b0;
  end
end

/////////////////////////////////////////////////////////////////////////

endmodule


