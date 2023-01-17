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

module avgp_3x3_core (
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
wire [DATA_WIDTH-1:0] out_add_07_08;
wire [DATA_WIDTH-1:0] out_add_05_06;
wire [DATA_WIDTH-1:0] out_add_03_04;
wire [DATA_WIDTH-1:0] out_add_01_02;

wire valid_out_add_07_08;
wire valid_out_add_05_06; 
wire valid_out_add_03_04;
wire valid_out_add_01_02;

// fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_07_08 (
//   .reset    (reset              ),
//   .clk      (clk                ),
//   .valid_in (valid_in           ),
//   .in_a     (pxl_in_08          ),
//   .in_b     (pxl_in_07          ),
//   .out      (out_add_07_08      ),
//   .valid_out(valid_out_add_07_08)
// );

// fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_05_06 (
//   .reset    (reset              ),
//   .clk      (clk                ),
//   .valid_in (valid_in           ),
//   .in_a     (pxl_in_06          ),
//   .in_b     (pxl_in_05          ),
//   .out      (out_add_05_06      ),
//   .valid_out(valid_out_add_05_06)
// );

// fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_03_04 (
//   .reset    (reset              ),
//   .clk      (clk                ),
//   .valid_in (valid_in           ),
//   .in_a     (pxl_in_04          ),
//   .in_b     (pxl_in_03          ),
//   .out      (out_add_03_04      ),
//   .valid_out(valid_out_add_03_04)
// );

// fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_01_02 (
//   .reset    (reset              ),
//   .clk      (clk                ),
//   .valid_in (valid_in           ),
//   .in_a     (pxl_in_02          ),
//   .in_b     (pxl_in_01          ),
//   .out      (out_add_01_02      ),
//   .valid_out(valid_out_add_01_02)
// );

floating_point_1_add inst_add_07_08 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_in           ),
  .s_axis_a_tdata      (pxl_in_08          ),
  .s_axis_b_tvalid     (valid_in           ),
  .s_axis_b_tdata      (pxl_in_07          ),
  .m_axis_result_tdata (out_add_07_08      ),
  .m_axis_result_tvalid(valid_out_add_07_08)
);

floating_point_1_add inst_add_05_06 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_in           ),
  .s_axis_a_tdata      (pxl_in_06          ),
  .s_axis_b_tvalid     (valid_in           ),
  .s_axis_b_tdata      (pxl_in_05          ),
  .m_axis_result_tdata (out_add_05_06      ),
  .m_axis_result_tvalid(valid_out_add_05_06)
);

floating_point_1_add inst_add_03_04 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_in           ),
  .s_axis_a_tdata      (pxl_in_04          ),
  .s_axis_b_tvalid     (valid_in           ),
  .s_axis_b_tdata      (pxl_in_03          ),
  .m_axis_result_tdata (out_add_03_04      ),
  .m_axis_result_tvalid(valid_out_add_03_04)
);

floating_point_1_add inst_add_01_02 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_in           ),
  .s_axis_a_tdata      (pxl_in_02          ),
  .s_axis_b_tvalid     (valid_in           ),
  .s_axis_b_tdata      (pxl_in_01          ),
  .m_axis_result_tdata (out_add_01_02      ),
  .m_axis_result_tvalid(valid_out_add_01_02)
);

/////////////////////////////////////////////////////////////////////////
//FIFO for Mul 00
wire [DATA_WIDTH-1:0] out_line_buffer_00      ;
wire                  valid_out_line_buffer_00;

line_buffer #(
  .IMAGE_WIDTH(33        ),
  .KERNEL     (1         ),
  .DIN_WIDTH  (DATA_WIDTH)
) line_buffer00 (
  .clk      (clk                     ),
  .reset    (reset                   ),
  .valid_in (valid_in                ),
  .data_in  (pxl_in_00               ),
  .data_out (out_line_buffer_00      ),
  .valid_out(valid_out_line_buffer_00)
);

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_add_05_06_07_08;
wire [DATA_WIDTH-1:0] out_add_01_02_03_04;

wire valid_out_add_05_06_07_08;
wire valid_out_add_01_02_03_04;

// fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_05_06_07_08 (
//   .reset    (reset                                    ),
//   .clk      (clk                                      ),
//   .valid_in (valid_out_add_05_06 & valid_out_add_07_08),
//   .in_a     (out_add_07_08                            ),
//   .in_b     (out_add_05_06                            ),
//   .out      (out_add_05_06_07_08                      ),
//   .valid_out(valid_out_add_05_06_07_08                )
// );

// fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_01_02_03_04 (
//   .reset    (reset                                    ),
//   .clk      (clk                                      ),
//   .valid_in (valid_out_add_01_02 & valid_out_add_03_04),
//   .in_a     (out_add_03_04                            ),
//   .in_b     (out_add_01_02                            ),
//   .out      (out_add_01_02_03_04                      ),
//   .valid_out(valid_out_add_01_02_03_04                )
// );

floating_point_1_add inst_add_05_06_07_08 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_07_08      ),
  .s_axis_a_tdata      (out_add_07_08            ),
  .s_axis_b_tvalid     (valid_out_add_05_06      ),
  .s_axis_b_tdata      (out_add_05_06            ),
  .m_axis_result_tdata (out_add_05_06_07_08      ),
  .m_axis_result_tvalid(valid_out_add_05_06_07_08)
);

floating_point_1_add inst_add_01_02_03_04 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_03_04      ),
  .s_axis_a_tdata      (out_add_03_04            ),
  .s_axis_b_tvalid     (valid_out_add_01_02      ),
  .s_axis_b_tdata      (out_add_01_02            ),
  .m_axis_result_tdata (out_add_01_02_03_04      ),
  .m_axis_result_tvalid(valid_out_add_01_02_03_04)
);

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_add_01_02_03_04_05_06_07_08;

wire valid_out_add_01_02_03_04_05_06_07_08;

// fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_01_02_03_04_05_06_07_08 (
//   .reset    (reset                                                ),
//   .clk      (clk                                                  ),
//   .valid_in (valid_out_add_01_02_03_04 & valid_out_add_05_06_07_08),
//   .in_a     (out_add_05_06_07_08                                  ),
//   .in_b     (out_add_01_02_03_04                                  ),
//   .out      (out_add_01_02_03_04_05_06_07_08                      ),
//   .valid_out(valid_out_add_01_02_03_04_05_06_07_08                )
// );

floating_point_1_add inst_add_01_02_03_04_05_06_07_08 (
  .aresetn             (~reset                               ),
  .aclk                (clk                                  ),
  .s_axis_a_tvalid     (valid_out_add_05_06_07_08            ),
  .s_axis_a_tdata      (out_add_05_06_07_08                  ),
  .s_axis_b_tvalid     (valid_out_add_01_02_03_04            ),
  .s_axis_b_tdata      (out_add_01_02_03_04                  ),
  .m_axis_result_tdata (out_add_01_02_03_04_05_06_07_08      ),
  .m_axis_result_tvalid(valid_out_add_01_02_03_04_05_06_07_08)
);

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_add_total;

wire valid_out_add_total;

// fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_out_total (
//   .reset    (reset                                                           ),
//   .clk      (clk                                                             ),
//   .valid_in (valid_out_add_01_02_03_04_05_06_07_08 & valid_out_line_buffer_00),
//   .in_a     (out_add_01_02_03_04_05_06_07_08                                 ),
//   .in_b     (out_line_buffer_00                                              ),
//   .out      (out_add_total                                                   ),
//   .valid_out(valid_out_add_total                                             )
// );

floating_point_1_add inst_add_out_total (
  .aresetn             (~reset                               ),
  .aclk                (clk                                  ),
  .s_axis_a_tvalid     (valid_out_add_01_02_03_04_05_06_07_08),
  .s_axis_a_tdata      (out_add_01_02_03_04_05_06_07_08      ),
  .s_axis_b_tvalid     (valid_out_line_buffer_00             ),
  .s_axis_b_tdata      (out_line_buffer_00                   ),
  .m_axis_result_tdata (out_add_total                        ),
  .m_axis_result_tvalid(valid_out_add_total                  )
);

/////////////////////////////////////////////////////////////////////////
// fp_div #(.DATA_WIDTH(DATA_WIDTH)) inst_div_out (
//   .reset    (reset              ),
//   .clk      (clk                ),
//   .valid_in (valid_out_add_total),
//   .in_a     (out_add_total      ),
//   .in_b     (32'h41100000       ),
//   .out      (pxl_out            ),
//   .valid_out(valid_out          )
// );

floating_point_0_div inst_div_out (
  .aclk                (clk                ),
  .aresetn             (~reset             ),
  .s_axis_a_tvalid     (valid_out_add_total),
  .s_axis_a_tdata      (out_add_total      ),
  .s_axis_b_tvalid     (valid_out_add_total),
  .s_axis_b_tdata      (32'h41100000       ),
  .m_axis_result_tvalid(valid_out          ),
  .m_axis_result_tdata (pxl_out            )
);

endmodule