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

// parameter IMAGE_WIDTH    = 32;
// parameter IMAGE_HEIGHT   = 32;
// parameter CHANNEL_NUM_IN = 32;
// parameter DELAY_01       = 62;
// parameter DELAY_02       = 62;
// parameter DELAY_03       = 62;
// parameter DELAY_04       = 62;
// parameter DELAY_05       = 62;

// parameter IMAGE_SIZE           = IMAGE_WIDTH * IMAGE_HEIGHT ;
// parameter CHANNEL_NUM_IN_PIXEL = IMAGE_SIZE * CHANNEL_NUM_IN;

// parameter SHIFT_WIDTH_01 = DELAY_02 - DELAY_01 - CHANNEL_NUM_IN_PIXEL        ;
// parameter SHIFT_WIDTH_03 = CHANNEL_NUM_IN_PIXEL       - (DELAY_03 - DELAY_02);
// parameter SHIFT_WIDTH_04 = (CHANNEL_NUM_IN_PIXEL * 2) - (DELAY_04 - DELAY_02);
// parameter SHIFT_WIDTH_05 = DELAY_02 - DELAY_05 + (CHANNEL_NUM_IN_PIXEL * 3)  ;

parameter IMAGE_WIDTH = 16;

localparam SHIFT_WIDTH_11 = 3014657 - (132352 * IMAGE_WIDTH);
localparam SHIFT_WIDTH_12 = 753641                          ;

localparam SHIFT_WIDTH_21 = 786432 - (128 * IMAGE_WIDTH);
localparam SHIFT_WIDTH_22 = 786432                      ;

localparam SHIFT_WIDTH_31 = 786432 - (128 * IMAGE_WIDTH);
localparam SHIFT_WIDTH_32 = 786432                      ;

localparam SHIFT_WIDTH_51 = 589824 + (16384 * IMAGE_WIDTH);
localparam SHIFT_WIDTH_52 = 629151                        ;

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
// line_buffer #(
//   .IMAGE_WIDTH(SHIFT_WIDTH_01),
//   .KERNEL     (1             ),
//   .DIN_WIDTH  (DATA_WIDTH    )
// ) line_buffer1 (
//   .clk      (clk                   ),
//   .reset    (reset                 ),
//   .valid_in (valid_in_no1          ),
//   .data_in  (in_no1                ),
//   .data_out (out_line_buffer1      ),
//   .valid_out(valid_out_line_buffer1)
// );

wire [ DATA_WIDTH-1:0] mem11      [IMAGE_WIDTH:0];
wire [IMAGE_WIDTH:0] mem_valid11                 ;

assign mem11[0]       = in_no1;
assign mem_valid11[0] = valid_in_no1;

genvar i;

generate
  for (i = 0; i < IMAGE_WIDTH; i= i + 1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_11),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk             ),
      .reset    (reset           ),
      .valid_in (mem_valid11[i]  ),
      .data_in  (mem11[i]        ),
      .data_out (mem11[i+1]      ),
      .valid_out(mem_valid11[i+1])
    );
  end
endgenerate

wire [DATA_WIDTH-1:0] mem12      [4:0];
wire [           4:0] mem_valid12     ;

assign mem12[0]       = mem11[IMAGE_WIDTH];
assign mem_valid12[0] = mem_valid11[IMAGE_WIDTH];

generate
  for (i = 0; i < 4; i= i + 1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_12),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk             ),
      .reset    (reset           ),
      .valid_in (mem_valid12[i]  ),
      .data_in  (mem12[i]        ),
      .data_out (mem12[i+1]      ),
      .valid_out(mem_valid12[i+1])
    );
  end
endgenerate

wire                  valid_out_line_buffer1;
wire [DATA_WIDTH-1:0] out_line_buffer1      ;

line_buffer #(
  .IMAGE_WIDTH(2         ),
  .KERNEL     (1         ),
  .DIN_WIDTH  (DATA_WIDTH)
) line_buffer1 (
  .clk      (clk                   ),
  .reset    (reset                 ),
  .valid_in (mem_valid12[4]        ),
  .data_in  (mem12[4]              ),
  .data_out (out_line_buffer1      ),
  .valid_out(valid_out_line_buffer1)
);

/////////////////////////////////////////////////////////////////////////
// line_buffer #(
//   .IMAGE_WIDTH(SHIFT_WIDTH_03),
//   .KERNEL     (1             ),
//   .DIN_WIDTH  (DATA_WIDTH    )
// ) line_buffer2 (
//   .clk      (clk                   ),
//   .reset    (reset                 ),
//   .valid_in (valid_in_no3          ),
//   .data_in  (in_no3                ),
//   .data_out (out_line_buffer2      ),
//   .valid_out(valid_out_line_buffer2)
// );

wire [ DATA_WIDTH-1:0] mem21      [IMAGE_WIDTH*8:0];
wire [IMAGE_WIDTH*8:0] mem_valid21                 ;

assign mem21[0]       = in_no2;
assign mem_valid21[0] = valid_in_no2;

generate
  for (i = 0; i < IMAGE_WIDTH * 8; i= i + 1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_21),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk             ),
      .reset    (reset           ),
      .valid_in (mem_valid21[i]  ),
      .data_in  (mem21[i]        ),
      .data_out (mem21[i+1]      ),
      .valid_out(mem_valid21[i+1])
    );
  end
endgenerate

wire [DATA_WIDTH-1:0] mem22      [8:0];
wire [           8:0] mem_valid22     ;

assign mem22[0]       = mem21[IMAGE_WIDTH * 8];
assign mem_valid22[0] = mem_valid21[IMAGE_WIDTH * 8];

generate
  for (i = 0; i < 8; i= i + 1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_22),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk             ),
      .reset    (reset           ),
      .valid_in (mem_valid22[i]  ),
      .data_in  (mem22[i]        ),
      .data_out (mem22[i+1]      ),
      .valid_out(mem_valid22[i+1])
    );
  end
endgenerate

wire                  valid_out_line_buffer2;
wire [DATA_WIDTH-1:0] out_line_buffer2      ;

assign out_line_buffer2       = mem22[8];
assign valid_out_line_buffer2 = mem_valid22[8];

/////////////////////////////////////////////////////////////////////////
// wire                  valid_out_line_buffer3;
// wire [DATA_WIDTH-1:0] out_line_buffer3      ;

// line_buffer #(
//   .IMAGE_WIDTH(SHIFT_WIDTH_04),
//   .KERNEL     (1             ),
//   .DIN_WIDTH  (DATA_WIDTH    )
// ) line_buffer3 (
//   .clk      (clk                   ),
//   .reset    (reset                 ),
//   .valid_in (valid_in_no4          ),
//   .data_in  (in_no4                ),
//   .data_out (out_line_buffer3      ),
//   .valid_out(valid_out_line_buffer3)
// );

wire [ DATA_WIDTH-1:0] mem31      [IMAGE_WIDTH*4:0];
wire [IMAGE_WIDTH*4:0] mem_valid31                 ;

assign mem31[0]       = in_no3;
assign mem_valid31[0] = valid_in_no3;

generate
  for (i = 0; i < IMAGE_WIDTH * 4; i= i + 1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_31),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk             ),
      .reset    (reset           ),
      .valid_in (mem_valid31[i]  ),
      .data_in  (mem31[i]        ),
      .data_out (mem31[i+1]      ),
      .valid_out(mem_valid31[i+1])
    );
  end
endgenerate

wire [DATA_WIDTH-1:0] mem32      [4:0];
wire [           4:0] mem_valid32     ;

assign mem32[0]       = mem31[IMAGE_WIDTH * 4];
assign mem_valid32[0] = mem_valid31[IMAGE_WIDTH * 4];

generate
  for (i = 0; i < 4; i= i + 1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_32),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk             ),
      .reset    (reset           ),
      .valid_in (mem_valid32[i]  ),
      .data_in  (mem32[i]        ),
      .data_out (mem32[i+1]      ),
      .valid_out(mem_valid32[i+1])
    );
  end
endgenerate

wire                  valid_out_line_buffer3;
wire [DATA_WIDTH-1:0] out_line_buffer3      ;

assign out_line_buffer3       = mem32[4];
assign valid_out_line_buffer3 = mem_valid32[4];

/////////////////////////////////////////////////////////////////////////
// wire                  valid_out_line_buffer4;
// wire [DATA_WIDTH-1:0] out_line_buffer4      ;

// line_buffer #(
//   .IMAGE_WIDTH(SHIFT_WIDTH_05),
//   .KERNEL     (1             ),
//   .DIN_WIDTH  (DATA_WIDTH    )
// ) line_buffer4 (
//   .clk      (clk                   ),
//   .reset    (reset                 ),
//   .valid_in (valid_in_no5          ),
//   .data_in  (in_no5                ),
//   .data_out (out_line_buffer4      ),
//   .valid_out(valid_out_line_buffer4)
// );

wire [ DATA_WIDTH-1:0] mem51      [IMAGE_WIDTH*16:0];
wire [IMAGE_WIDTH*16:0] mem_valid51                 ;

assign mem51[0]       = in_no5;
assign mem_valid51[0] = valid_in_no5;

generate
  for (i = 0; i < IMAGE_WIDTH * 15; i= i + 1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_51),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk             ),
      .reset    (reset           ),
      .valid_in (mem_valid51[i]  ),
      .data_in  (mem51[i]        ),
      .data_out (mem51[i+1]      ),
      .valid_out(mem_valid51[i+1])
    );
  end
endgenerate

line_buffer #(
  .IMAGE_WIDTH(SHIFT_WIDTH_51 - IMAGE_WIDTH),
  .KERNEL     (1                           ),
  .DIN_WIDTH  (DATA_WIDTH                  )
) line_buffer2 (
  .clk      (clk                        ),
  .reset    (reset                      ),
  .valid_in (mem_valid51[IMAGE_WIDTH*15]),
  .data_in  (mem51[IMAGE_WIDTH*15]      ),
  .data_out (mem51[IMAGE_WIDTH*16]      ),
  .valid_out(mem_valid51[IMAGE_WIDTH*16])
);

wire [DATA_WIDTH-1:0] mem52      [15:0];
wire [           15:0] mem_valid52     ;

assign mem52[0]       = mem51[IMAGE_WIDTH * 16];
assign mem_valid52[0] = mem_valid51[IMAGE_WIDTH * 16];

generate
  for (i = 0; i < 15; i= i + 1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_52),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk             ),
      .reset    (reset           ),
      .valid_in (mem_valid52[i]  ),
      .data_in  (mem52[i]        ),
      .data_out (mem52[i+1]      ),
      .valid_out(mem_valid52[i+1])
    );
  end
endgenerate

wire                  valid_out_line_buffer5;
wire [DATA_WIDTH-1:0] out_line_buffer5      ;

assign out_line_buffer5       = mem52[15];
assign valid_out_line_buffer5 = mem_valid52[15];


always @(posedge clk) begin
  if(reset) begin
    out       <= {DATA_WIDTH{1'b0}};
    valid_out <= 1'b0;
  end
  else if (valid_in_no4) begin
    out       <= in_no4;
    valid_out <= valid_in_no4;
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
  else if (valid_out_line_buffer5) begin
    out       <= out_line_buffer5;
    valid_out <= valid_out_line_buffer5;
  end
  else begin
    valid_out <= 1'b0;
  end
end

/////////////////////////////////////////////////////////////////////////

endmodule


