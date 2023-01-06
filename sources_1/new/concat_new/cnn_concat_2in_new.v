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

parameter IMAGE_WIDTH = 4                        ;
parameter IMAGE_SIZE  = IMAGE_WIDTH * IMAGE_WIDTH;

// parameter DELAY0_LAYER2 = (12128 * (IMAGE_SIZE/16)) + (16384 * (IMAGE_WIDTH/4)) + 24785 + 9 + ((IMAGE_SIZE/16) * 127) - (IMAGE_WIDTH/4); // 51269786
// parameter DELAY1_LAYER2 = (32512 * (IMAGE_SIZE/64)) + (32768 * (IMAGE_WIDTH/8)) + 32987 + 9                                            ; // 34373860
// parameter DELAY_LAYER2  = DELAY0_LAYER2 + DELAY1_LAYER2                                                                                ; // 85643646 *

// parameter DELAY0_LAYER3 = (48832 * (IMAGE_SIZE/64)) + (65536 * (IMAGE_WIDTH/8)) + 98531 + 9 + ((IMAGE_SIZE/64) * 255) - (IMAGE_WIDTH/8); // 52460748
// parameter DELAY1_LAYER3 = (130560 * (IMAGE_SIZE/256)) + (131072 * (IMAGE_WIDTH/16)) + 131309 + 9                                       ; // 35651830
// parameter DELAY_LAYER3  = DELAY0_LAYER3 + DELAY1_LAYER3                                                                                ; // 88112578 *

// parameter DELAY0_LAYER4 = (392192 * (IMAGE_SIZE/256)) + (393216 * (IMAGE_WIDTH/16)) + 393461 + 9; // 107086078
// parameter DELAY1_LAYER4 = (523264 * (IMAGE_SIZE/256)) + (524288 * (IMAGE_WIDTH/16)) + 524543 + 9; // 142868744
// parameter DELAY_LAYER4  = DELAY0_LAYER4 + DELAY1_LAYER4                                         ; // 249954822 *

// // parameter DELAY_01_ASPP          = (130816 * (IMAGE_SIZE/256)) + (131071 * (IMAGE_WIDTH/16)) + 131162                  ; //  35717194
// // parameter DELAY_02_ASPP          = DELAY_01_ASPP + (261632 * (IMAGE_SIZE/256)) + (3145728 * (IMAGE_WIDTH/16)) + 3145855; // 156172489
// // parameter DELAY_ASPP             = DELAY_02_ASPP - (IMAGE_SIZE * 256)                                                  ; // 139395273 *
    
// parameter DELAY_ASPP             = (IMAGE_WIDTH/16) * (3014657 - (132352 * (IMAGE_WIDTH/16))) + 3014566  ; // 139395273 *
// parameter DELAY_CONV1X1_1280_256 = (327424 * (IMAGE_SIZE/256)) + (327679 * (IMAGE_WIDTH/16)) + 327787 + 1; //  89391196 *
// parameter DELAY_UP               = 1                                                                     ; //         1 *

// parameter DELAY_CONV1X1_256_48 = (12240 * (IMAGE_SIZE/16)) + (12287 * (IMAGE_WIDTH/4)) + 12368 + 1; // 50933777 *

// // parameter DELAY_TAIL = DELAY_LAYER2 + DELAY_LAYER3 + DELAY_LAYER4 + DELAY_ASPP + DELAY_CONV1X1_1280_256 + DELAY_UP + DELAY_CONV1X1_256_48; // 703 431 293 **
// parameter DELAY_TAIL = (((489851 * IMAGE_SIZE) + (18808792 * IMAGE_WIDTH))/64) + 4560394;

// parameter DELAY_CONV3X3_64_256 = (16128 * (IMAGE_SIZE/16)) + (19660 * (IMAGE_WIDTH/4)) + 196708   ; //  67515236 *
// parameter DELAY_CONV1X1_256    = (65280 * (IMAGE_SIZE/16)) + (65535 * (IMAGE_WIDTH/4)) + 65616 + 1; // 271646737 *
// // parameter DELAY_HEAD           = DELAY_CONV3X3_64_256 + DELAY_CONV1X1_256                         ; // 339161973 **
// parameter DELAY_HEAD           = (((20352 * IMAGE_SIZE) + (85195 * IMAGE_WIDTH)) / 4) + 262325;
                                 
// parameter SHIFT_WIDTH_CONCAT_2IN = DELAY_TAIL - DELAY_HEAD - ((IMAGE_SIZE/16) * 256); // 363 220 744 ***

// parameter SHIFT_WIDTH_CONCAT_2IN_01 = 163195 * (IMAGE_SIZE / 64);
// parameter SHIFT_WIDTH_CONCAT_2IN_02 = 545177 * (IMAGE_WIDTH / 2);
// parameter SHIFT_WIDTH_CONCAT_2IN_03 = IMAGE_WIDTH / 8           ;
// parameter SHIFT_WIDTH_CONCAT_2IN_04 = (429807 * 10) - 1         ;

//     parameter SHIFT_WIDTH_CONCAT_2IN_01 = 163195 * (IMAGE_SIZE / 64);
//     parameter SHIFT_WIDTH_CONCAT_2IN_02 = 545177 * (IMAGE_WIDTH / 2);
//     parameter SHIFT_WIDTH_CONCAT_2IN_03 = IMAGE_WIDTH / 8;
//     parameter SHIFT_WIDTH_CONCAT_2IN_04 = (429807 * 10) - 1;

localparam SHIFT_WIDTH_01 = 163195         ;
localparam SHIFT_WIDTH_02 = 545177         ;
localparam SHIFT_WIDTH_03 = IMAGE_WIDTH / 8;
localparam SHIFT_WIDTH_04 = 429807         ;

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


