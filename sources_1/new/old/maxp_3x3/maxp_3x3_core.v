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

module maxp_3x3_core (
  clk, 
  reset,
  valid_in,
  pxl_in_00,
  pxl_in_01,
  pxl_in_02,
  pxl_in_03,
  pxl_in_04,
  pxl_in_05,
  pxl_in_06,
  pxl_in_07,
  pxl_in_08,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk      ;
input                  reset    ;
input                  valid_in ;
input [DATA_WIDTH-1:0] pxl_in_00; input [DATA_WIDTH-1:0] pxl_in_01; input [DATA_WIDTH-1:0] pxl_in_02;
input [DATA_WIDTH-1:0] pxl_in_03; input [DATA_WIDTH-1:0] pxl_in_04; input [DATA_WIDTH-1:0] pxl_in_05;
input [DATA_WIDTH-1:0] pxl_in_06; input [DATA_WIDTH-1:0] pxl_in_07; input [DATA_WIDTH-1:0] pxl_in_08;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

// Local Logic and Instantiation
wire                  clk      ;
wire                  reset    ;
wire                  valid_in ;
wire [DATA_WIDTH-1:0] pxl_in_00; wire [DATA_WIDTH-1:0] pxl_in_01; wire [DATA_WIDTH-1:0] pxl_in_02;
wire [DATA_WIDTH-1:0] pxl_in_03; wire [DATA_WIDTH-1:0] pxl_in_04; wire [DATA_WIDTH-1:0] pxl_in_05;
wire [DATA_WIDTH-1:0] pxl_in_06; wire [DATA_WIDTH-1:0] pxl_in_07; wire [DATA_WIDTH-1:0] pxl_in_08;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_comp_07_08;
wire [DATA_WIDTH-1:0] out_comp_05_06;
wire [DATA_WIDTH-1:0] out_comp_03_04;
wire [DATA_WIDTH-1:0] out_comp_01_02;

wire valid_out_comp_07_08;
wire valid_out_comp_05_06; 
wire valid_out_comp_03_04;
wire valid_out_comp_01_02;

fp_comp #(.DATA_WIDTH(DATA_WIDTH)) inst_comp_07_08 (
  .reset    (reset            ),
  .clk      (clk              ),
  .valid_in (valid_in         ),
  .in_a     (pxl_in_08        ),
  .in_b     (pxl_in_07        ),
  .out      (out_comp_07_08      ),
  .valid_out(valid_out_comp_07_08)
);

fp_comp #(.DATA_WIDTH(DATA_WIDTH)) inst_comp_05_06 (
  .reset    (reset               ),
  .clk      (clk                 ),
  .valid_in (valid_in            ),
  .in_a     (pxl_in_06           ),
  .in_b     (pxl_in_05           ),
  .out      (out_comp_05_06      ),
  .valid_out(valid_out_comp_05_06)
);

fp_comp #(.DATA_WIDTH(DATA_WIDTH)) inst_comp_03_04 (
  .reset    (reset               ),
  .clk      (clk                 ),
  .valid_in (valid_in            ),
  .in_a     (pxl_in_04           ),
  .in_b     (pxl_in_03           ),
  .out      (out_comp_03_04      ),
  .valid_out(valid_out_comp_03_04)
);

fp_comp #(.DATA_WIDTH(DATA_WIDTH)) inst_comp_01_02 (
  .reset    (reset               ),
  .clk      (clk                 ),
  .valid_in (valid_in            ),
  .in_a     (pxl_in_02           ),
  .in_b     (pxl_in_01           ),
  .out      (out_comp_01_02      ),
  .valid_out(valid_out_comp_01_02)
);

/////////////////////////////////////////////////////////////////////////
//FIFO for Mul 00
wire [DATA_WIDTH-1:0] out_line_buffer_00      ;
wire                  valid_out_line_buffer_00;

line_buffer #(
  .IMAGE_WIDTH(3         ),
  .KERNEL     (1         ),
  .DIN_WIDTH  (DATA_WIDTH)
) line_buffer00 (
  .clk      (clk                     ),
  .reset    (reset                   ),
  .valid_in (1'b1                    ),
  .data_in  (pxl_in_00               ),
  .data_out (out_line_buffer_00      ),
  .valid_out(valid_out_line_buffer_00)
);

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_comp_05_06_07_08;
wire [DATA_WIDTH-1:0] out_comp_01_02_03_04;

wire valid_out_comp_05_06_07_08;
wire valid_out_comp_01_02_03_04;

fp_comp #(.DATA_WIDTH(DATA_WIDTH)) inst_comp_05_06_07_08 (
  .reset    (reset                                      ),
  .clk      (clk                                        ),
  .valid_in (valid_out_comp_05_06 & valid_out_comp_07_08),
  .in_a     (out_comp_07_08                             ),
  .in_b     (out_comp_05_06                             ),
  .out      (out_comp_05_06_07_08                       ),
  .valid_out(valid_out_comp_05_06_07_08                 )
);

fp_comp #(.DATA_WIDTH(DATA_WIDTH)) inst_comp_01_02_03_04 (
  .reset    (reset                                      ),
  .clk      (clk                                        ),
  .valid_in (valid_out_comp_01_02 & valid_out_comp_03_04),
  .in_a     (out_comp_03_04                             ),
  .in_b     (out_comp_01_02                             ),
  .out      (out_comp_01_02_03_04                       ),
  .valid_out(valid_out_comp_01_02_03_04                 )
);

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_comp_01_02_03_04_05_06_07_08;

wire valid_out_comp_01_02_03_04_05_06_07_08;

fp_comp #(.DATA_WIDTH(DATA_WIDTH)) inst_comp_01_02_03_04_05_06_07_08 (
  .reset    (reset                                                  ),
  .clk      (clk                                                    ),
  .valid_in (valid_out_comp_01_02_03_04 & valid_out_comp_05_06_07_08),
  .in_a     (out_comp_05_06_07_08                                   ),
  .in_b     (out_comp_01_02_03_04                                   ),
  .out      (out_comp_01_02_03_04_05_06_07_08                       ),
  .valid_out(valid_out_comp_01_02_03_04_05_06_07_08                 )
);

/////////////////////////////////////////////////////////////////////////
fp_comp #(.DATA_WIDTH(DATA_WIDTH)) inst_comp_out (
  .reset    (reset                                                            ),
  .clk      (clk                                                              ),
  .valid_in (valid_out_comp_01_02_03_04_05_06_07_08 & valid_out_line_buffer_00),
  .in_a     (out_comp_01_02_03_04_05_06_07_08                                 ),
  .in_b     (out_line_buffer_00                                               ),
  .out      (pxl_out                                                          ),
  .valid_out(valid_out                                                        )
);

endmodule