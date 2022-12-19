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

module conv_3x3_core (
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
  //weights
  weight_in_00,
  weight_in_01,
  weight_in_02,
  weight_in_03,
  weight_in_04,
  weight_in_05,
  weight_in_06,
  weight_in_07,
  weight_in_08,

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
//weights
input [DATA_WIDTH-1:0] weight_in_00; input [DATA_WIDTH-1:0] weight_in_01; input [DATA_WIDTH-1:0] weight_in_02;
input [DATA_WIDTH-1:0] weight_in_03; input [DATA_WIDTH-1:0] weight_in_04; input [DATA_WIDTH-1:0] weight_in_05;
input [DATA_WIDTH-1:0] weight_in_06; input [DATA_WIDTH-1:0] weight_in_07; input [DATA_WIDTH-1:0] weight_in_08;

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
//weights
wire [DATA_WIDTH-1:0] weight_in_00; wire [DATA_WIDTH-1:0] weight_in_01; wire [DATA_WIDTH-1:0] weight_in_02;
wire [DATA_WIDTH-1:0] weight_in_03; wire [DATA_WIDTH-1:0] weight_in_04; wire [DATA_WIDTH-1:0] weight_in_05;
wire [DATA_WIDTH-1:0] weight_in_06; wire [DATA_WIDTH-1:0] weight_in_07; wire [DATA_WIDTH-1:0] weight_in_08;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

//Multiple
wire [DATA_WIDTH-1:0] out_mul_08; wire [DATA_WIDTH-1:0] out_mul_07; wire [DATA_WIDTH-1:0] out_mul_06;
wire [DATA_WIDTH-1:0] out_mul_05; wire [DATA_WIDTH-1:0] out_mul_04; wire [DATA_WIDTH-1:0] out_mul_03;
wire [DATA_WIDTH-1:0] out_mul_02; wire [DATA_WIDTH-1:0] out_mul_01; wire [DATA_WIDTH-1:0] out_mul_00;

wire valid_out_mul_08; wire valid_out_mul_07; wire valid_out_mul_06;
wire valid_out_mul_05; wire valid_out_mul_04; wire valid_out_mul_03;
wire valid_out_mul_02; wire valid_out_mul_01; // wire valid_out_mul_00;

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_08 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_08       ),
  .in_b     (weight_in_08    ),
  .out      (out_mul_08      ),
  .valid_out(valid_out_mul_08)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_07 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_07       ),
  .in_b     (weight_in_07    ),
  .out      (out_mul_07      ),
  .valid_out(valid_out_mul_07)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_06 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_06       ),
  .in_b     (weight_in_06    ),
  .out      (out_mul_06      ),
  .valid_out(valid_out_mul_06)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_05 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_05       ),
  .in_b     (weight_in_05    ),
  .out      (out_mul_05      ),
  .valid_out(valid_out_mul_05)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_04 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_04       ),
  .in_b     (weight_in_04    ),
  .out      (out_mul_04      ),
  .valid_out(valid_out_mul_04)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_03 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_03       ),
  .in_b     (weight_in_03    ),
  .out      (out_mul_03      ),
  .valid_out(valid_out_mul_03)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_02 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_02       ),
  .in_b     (weight_in_02    ),
  .out      (out_mul_02      ),
  .valid_out(valid_out_mul_02)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_01 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_01       ),
  .in_b     (weight_in_01    ),
  .out      (out_mul_01      ),
  .valid_out(valid_out_mul_01)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_00 (
  .reset    (reset               ),
  .clk      (clk                 ),
  .valid_in (valid_in            ),
  .in_a     (pxl_in_00           ),
  .in_b     (weight_in_00        ),
  .out      (out_mul_00          ),
  .valid_out(/*valid_out_mul_00*/)
);

// Line buffer for Mul 00
wire [DATA_WIDTH-1:0] out_line_buffer_00      ;
wire                  valid_out_line_buffer_00;

line_buffer #(
  .IMAGE_WIDTH(27        ),
  .KERNEL     (1         ),
  .DIN_WIDTH  (DATA_WIDTH)
) line_buffer7 (
  .clk      (clk                     ),
  .reset    (reset                   ),
  .valid_in (1'b1                    ),
  .data_in  (out_mul_00              ),
  .data_out (out_line_buffer_00      ),
  .valid_out(valid_out_line_buffer_00)
);

//Add outputs of mul
wire [DATA_WIDTH-1:0] out_add_08_07;
wire [DATA_WIDTH-1:0] out_add_06_05;
wire [DATA_WIDTH-1:0] out_add_04_03;
wire [DATA_WIDTH-1:0] out_add_02_01;

wire [DATA_WIDTH-1:0] out_add_08_07_06_05;
wire [DATA_WIDTH-1:0] out_add_04_03_02_01;

wire [DATA_WIDTH-1:0] out_add_08_07_06_05_04_03_02_01;

wire valid_out_add_08_07;
wire valid_out_add_06_05;
wire valid_out_add_04_03;
wire valid_out_add_02_01;

wire valid_out_add_08_07_06_05;
wire valid_out_add_04_03_02_01;

wire valid_out_add_08_07_06_05_04_03_02_01;


fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_08_07 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_08 & valid_out_mul_07),
  .in_a     (out_mul_08                         ),
  .in_b     (out_mul_07                         ),
  .out      (out_add_08_07                      ),
  .valid_out(valid_out_add_08_07                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_06_05 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_06 & valid_out_mul_05),
  .in_a     (out_mul_06                         ),
  .in_b     (out_mul_05                         ),
  .out      (out_add_06_05                      ),
  .valid_out(valid_out_add_06_05                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_04_03 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_04 & valid_out_mul_03),
  .in_a     (out_mul_04                         ),
  .in_b     (out_mul_03                         ),
  .out      (out_add_04_03                      ),
  .valid_out(valid_out_add_04_03                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_02_01 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_02 & valid_out_mul_01),
  .in_a     (out_mul_02                         ),
  .in_b     (out_mul_01                         ),
  .out      (out_add_02_01                      ),
  .valid_out(valid_out_add_02_01                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_08_07_06_05 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_08_07 & valid_out_add_06_05),
  .in_a     (out_add_08_07                            ),
  .in_b     (out_add_06_05                            ),
  .out      (out_add_08_07_06_05                      ),
  .valid_out(valid_out_add_08_07_06_05                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_04_03_02_01 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_04_03 & valid_out_add_02_01),
  .in_a     (out_add_04_03                            ),
  .in_b     (out_add_02_01                            ),
  .out      (out_add_04_03_02_01                      ),
  .valid_out(valid_out_add_04_03_02_01                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_08_07_06_05_04_03_02_01 (
  .reset    (reset                                                ),
  .clk      (clk                                                  ),
  .valid_in (valid_out_add_08_07_06_05 & valid_out_add_04_03_02_01),
  .in_a     (out_add_08_07_06_05                                  ),
  .in_b     (out_add_04_03_02_01                                  ),
  .out      (out_add_08_07_06_05_04_03_02_01                      ),
  .valid_out(valid_out_add_08_07_06_05_04_03_02_01                )
);

/////////////////////////////////////////////////////////////////////////
fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_08_07_06_05_04_03_02_01_00 (
  .reset    (reset                                                           ),
  .clk      (clk                                                             ),
  .valid_in (valid_out_add_08_07_06_05_04_03_02_01 & valid_out_line_buffer_00),
  .in_a     (out_add_08_07_06_05_04_03_02_01                                 ),
  .in_b     (out_line_buffer_00                                              ),
  .out      (pxl_out                                                         ),
  .valid_out(valid_out                                                       )
);

endmodule