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
parameter DATA_WIDTH = 32;

//     parameter SHIFT_WIDTH_CONCAT_2IN_01 = 163195 * (IMAGE_SIZE / 64);
//     parameter SHIFT_WIDTH_CONCAT_2IN_02 = 545177 * (IMAGE_WIDTH / 2);
//     parameter SHIFT_WIDTH_CONCAT_2IN_03 = IMAGE_WIDTH / 8;
//     parameter SHIFT_WIDTH_CONCAT_2IN_04 = (429807 * 10) - 1;

parameter SHIFT_WIDTH_CONCAT_2IN_01 = 163195         ;
parameter SHIFT_WIDTH_CONCAT_2IN_02 = 545177         ;
parameter SHIFT_WIDTH_CONCAT_2IN_03 = IMAGE_WIDTH / 8;
parameter SHIFT_WIDTH_CONCAT_2IN_04 = 429807         ;

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
wire [   DATA_WIDTH-1:0] mem_in      [(IMAGE_SIZE/64):0];
wire [(IMAGE_SIZE/64):0] mem_valid_in                   ;

assign mem_in[0]       = in_no1;
assign mem_valid_in[0] = valid_in_no1;

genvar i;

generate
  for (i = 0; i < (IMAGE_SIZE / 64); i=i+1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_01),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
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

wire [   DATA_WIDTH-1:0] mem_in2      [(IMAGE_WIDTH / 2):0];
wire [(IMAGE_WIDTH / 2):0] mem_valid_in2                   ;

assign mem_in2[0]       = mem_in[0]  ;
assign mem_valid_in2[0] = mem_valid_in[0];

generate
  for (i = 0; i < (IMAGE_WIDTH / 2); i=i+1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_02),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk               ),
      .reset    (reset             ),
      .valid_in (mem_valid_in2[i]  ),
      .data_in  (mem_in2[i]        ),
      .data_out (mem_in2[i+1]      ),
      .valid_out(mem_valid_in2[i+1])
    );
  end
endgenerate

wire                  valid_out_line_buffer;
wire [DATA_WIDTH-1:0] out_line_buffer      ;

line_buffer #(
  .IMAGE_WIDTH(SHIFT_WIDTH_03),
  .KERNEL     (1             ),
  .DIN_WIDTH  (DATA_WIDTH    )
) line_buffer (
  .clk      (clk                             ),
  .reset    (reset                           ),
  .valid_in (mem_valid_in2[(IMAGE_WIDTH / 2)]),
  .data_in  (mem_in2[(IMAGE_WIDTH / 2)]      ),
  .data_out (out_line_buffer                 ),
  .valid_out(valid_out_line_buffer           )
);

wire [DATA_WIDTH-1:0] mem_in4      [9:0];
wire [           9:0] mem_valid_in4     ;

assign mem_in4[0]       = out_line_buffer  ;
assign mem_valid_in4[0] = valid_out_line_buffer;

generate
  for (i = 0; i < (IMAGE_WIDTH / 2); i=i+1) begin
    line_buffer #(
      .IMAGE_WIDTH(SHIFT_WIDTH_04),
      .KERNEL     (1             ),
      .DIN_WIDTH  (DATA_WIDTH    )
    ) line_buffer (
      .clk      (clk               ),
      .reset    (reset             ),
      .valid_in (mem_valid_in4[i]  ),
      .data_in  (mem_in4[i]        ),
      .data_out (mem_in4[i+1]      ),
      .valid_out(mem_valid_in4[i+1])
    );
  end
endgenerate

wire                  valid_out_line_buffer2;
wire [DATA_WIDTH-1:0] out_line_buffer2      ;

line_buffer #(
  .IMAGE_WIDTH(SHIFT_WIDTH_04 - 1),
  .KERNEL     (1                 ),
  .DIN_WIDTH  (DATA_WIDTH        )
) line_buffer2 (
  .clk      (clk                   ),
  .reset    (reset                 ),
  .valid_in (mem_valid_in4[9]      ),
  .data_in  (mem_in4[9]            ),
  .data_out (out_line_buffer2      ),
  .valid_out(valid_out_line_buffer2)
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
  else if (valid_out_line_buffer2) begin
    out       <= out_line_buffer2;
    valid_out <= valid_out_line_buffer2;
  end
  else begin
    valid_out <= 1'b0;
  end
end

/////////////////////////////////////////////////////////////////////////

endmodule


