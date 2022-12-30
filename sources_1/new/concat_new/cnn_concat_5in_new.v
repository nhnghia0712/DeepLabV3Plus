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

module cnn_concat_5in_new (
  clk, 
  reset,
  valid_in_no1,
  in_no1, 
  valid_in_no2,
  in_no2, 
  valid_in_no3,
  in_no3, 
  valid_in_no4,
  in_no4,
  valid_in_no5,
  in_no5, 

  out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

parameter IMAGE_WIDTH    = 32;
parameter IMAGE_HEIGHT   = 32;
parameter CHANNEL_NUM_IN = 32;
parameter DELAY_01       = 62;
parameter DELAY_02       = 62;
parameter DELAY_03       = 62;
parameter DELAY_04       = 62;
parameter DELAY_05       = 62;

parameter IMAGE_SIZE           = IMAGE_WIDTH * IMAGE_HEIGHT ;
parameter CHANNEL_NUM_IN_PIXEL = IMAGE_SIZE * CHANNEL_NUM_IN;

parameter SHIFT_WIDTH_01 = DELAY_02 - DELAY_01 - CHANNEL_NUM_IN_PIXEL        ;
parameter SHIFT_WIDTH_03 = CHANNEL_NUM_IN_PIXEL       - (DELAY_03 - DELAY_02);
parameter SHIFT_WIDTH_04 = (CHANNEL_NUM_IN_PIXEL * 2) - (DELAY_04 - DELAY_02);
parameter SHIFT_WIDTH_05 = DELAY_02 - DELAY_05 + (CHANNEL_NUM_IN_PIXEL * 3)  ;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk         ;
input                  reset       ;
input                  valid_in_no1;
input [DATA_WIDTH-1:0] in_no1      ;
input                  valid_in_no2;
input [DATA_WIDTH-1:0] in_no2      ;
input                  valid_in_no3;
input [DATA_WIDTH-1:0] in_no3      ;
input                  valid_in_no4;
input [DATA_WIDTH-1:0] in_no4      ;
input                  valid_in_no5;
input [DATA_WIDTH-1:0] in_no5      ;

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
wire                  valid_in_no3;
wire [DATA_WIDTH-1:0] in_no3      ;
wire                  valid_in_no4;
wire [DATA_WIDTH-1:0] in_no4      ;
wire                  valid_in_no5;
wire [DATA_WIDTH-1:0] in_no5      ;

reg [DATA_WIDTH-1:0] out      ;
reg                  valid_out;

/////////////////////////////////////////////////////////////////////////
wire                  valid_out_line_buffer1;
wire [DATA_WIDTH-1:0] out_line_buffer1      ;

line_buffer #(
  .IMAGE_WIDTH(SHIFT_WIDTH_01),
  .KERNEL     (1             ),
  .DIN_WIDTH  (DATA_WIDTH    )
) line_buffer1 (
  .clk      (clk                   ),
  .reset    (reset                 ),
  .valid_in (valid_in_no1          ),
  .data_in  (in_no1                ),
  .data_out (out_line_buffer1      ),
  .valid_out(valid_out_line_buffer1)
);

/////////////////////////////////////////////////////////////////////////
wire                  valid_out_line_buffer2;
wire [DATA_WIDTH-1:0] out_line_buffer2      ;

line_buffer #(
  .IMAGE_WIDTH(SHIFT_WIDTH_03),
  .KERNEL     (1             ),
  .DIN_WIDTH  (DATA_WIDTH    )
) line_buffer2 (
  .clk      (clk                   ),
  .reset    (reset                 ),
  .valid_in (valid_in_no3          ),
  .data_in  (in_no3                ),
  .data_out (out_line_buffer2      ),
  .valid_out(valid_out_line_buffer2)
);

/////////////////////////////////////////////////////////////////////////
wire                  valid_out_line_buffer3;
wire [DATA_WIDTH-1:0] out_line_buffer3      ;

line_buffer #(
  .IMAGE_WIDTH(SHIFT_WIDTH_04),
  .KERNEL     (1             ),
  .DIN_WIDTH  (DATA_WIDTH    )
) line_buffer3 (
  .clk      (clk                   ),
  .reset    (reset                 ),
  .valid_in (valid_in_no4          ),
  .data_in  (in_no4                ),
  .data_out (out_line_buffer3      ),
  .valid_out(valid_out_line_buffer3)
);

/////////////////////////////////////////////////////////////////////////
wire                  valid_out_line_buffer4;
wire [DATA_WIDTH-1:0] out_line_buffer4      ;

line_buffer #(
  .IMAGE_WIDTH(SHIFT_WIDTH_05),
  .KERNEL     (1             ),
  .DIN_WIDTH  (DATA_WIDTH    )
) line_buffer4 (
  .clk      (clk                   ),
  .reset    (reset                 ),
  .valid_in (valid_in_no5          ),
  .data_in  (in_no5                ),
  .data_out (out_line_buffer4      ),
  .valid_out(valid_out_line_buffer4)
);

always @(posedge clk) begin
  if(reset) begin
    out       <= {DATA_WIDTH{1'b0}};
    valid_out <= 1'b0;
  end
  else if (valid_in_no2) begin
    out       <= in_no2;
    valid_out <= valid_in_no2;
  end
  else if (valid_out_line_buffer1) begin
    out       <= out_line_buffer1;
    valid_out <= valid_out_line_buffer1;
  end
  else if (valid_out_line_buffer2) begin
    out       <= out_line_buffer2;
    valid_out <= valid_out_line_buffer2;
  end
  else if (valid_out_line_buffer3) begin
    out       <= out_line_buffer3;
    valid_out <= valid_out_line_buffer3;
  end
  else if (valid_out_line_buffer4) begin
    out       <= out_line_buffer4;
    valid_out <= valid_out_line_buffer4;
  end
  else begin
    valid_out <= 1'b0;
  end
end

/////////////////////////////////////////////////////////////////////////

endmodule


