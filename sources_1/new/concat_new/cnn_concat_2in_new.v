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

reg [DATA_WIDTH-1:0] out      ;
reg                  valid_out;

/////////////////////////////////////////////////////////////////////////
wire [         DATA_WIDTH-1:0] mem_in      [(SHIFT_WIDTH/1000000):0];
wire [(SHIFT_WIDTH/1000000):0] mem_valid_in                         ;

assign mem_in[0]       = in_no1;
assign mem_valid_in[0] = valid_in_no1;

genvar i;

generate
  for (i = 0; i < (SHIFT_WIDTH/1000000); i=i+1) begin
    line_buffer #(
      .IMAGE_WIDTH(1000000   ),
      .KERNEL     (1         ),
      .DIN_WIDTH  (DATA_WIDTH)
    ) line_buffer (
      .clk      (clk              ),
      .reset    (reset            ),
      .valid_in (mem_valid_in[i]  ),
      .data_in  (mem_in[i]        ),
      .data_out (mem_in[i+1]      ),
      .valid_out(mem_valid_in[i+1])
    );
  end
endgenerate

always @(posedge clk) begin
  if(reset) begin
    out       <= {DATA_WIDTH{1'b0}};
    valid_out <= 1'b0;
  end
  else if (valid_in_no2) begin
    out       <= in_no2;
    valid_out <= valid_in_no2;
  end
  else if (mem_valid_in[(SHIFT_WIDTH/1000000)]) begin
    out       <= mem_in[(SHIFT_WIDTH/1000000)];
    valid_out <= mem_valid_in[(SHIFT_WIDTH/1000000)];
  end
  else begin
    valid_out <= 1'b0;
  end
end

/////////////////////////////////////////////////////////////////////////

endmodule


