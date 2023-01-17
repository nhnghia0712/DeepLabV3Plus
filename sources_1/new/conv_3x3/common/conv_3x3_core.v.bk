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

// Mul
reg [DATA_WIDTH-1:0] fp_in      [8:0];
reg                  fp_valid_in     ;

always @(posedge clk) begin
  if (reset) begin
    fp_in[8]    <= {DATA_WIDTH{1'b0}};
    fp_in[7]    <= {DATA_WIDTH{1'b0}};
    fp_in[6]    <= {DATA_WIDTH{1'b0}};
    fp_in[5]    <= {DATA_WIDTH{1'b0}};
    fp_in[4]    <= {DATA_WIDTH{1'b0}};
    fp_in[3]    <= {DATA_WIDTH{1'b0}};
    fp_in[2]    <= {DATA_WIDTH{1'b0}};
    fp_in[1]    <= {DATA_WIDTH{1'b0}};
    fp_in[0]    <= {DATA_WIDTH{1'b0}};
    fp_valid_in <= 1'b0;
  end
  else if (valid_in) begin
    fp_in[8]    <= pxl_in_08;
    fp_in[7]    <= pxl_in_07;
    fp_in[6]    <= pxl_in_06;
    fp_in[5]    <= pxl_in_05;
    fp_in[4]    <= pxl_in_04;
    fp_in[3]    <= pxl_in_03;
    fp_in[2]    <= pxl_in_02;
    fp_in[1]    <= pxl_in_01;
    fp_in[0]    <= pxl_in_00;
    fp_valid_in <= 1'b1;
  end
  else begin
    fp_valid_in <= 1'b0;
  end
end

reg [DATA_WIDTH-1:0] weight      [8:0];

always @(posedge clk) begin
  if (reset) begin
    weight[8]    <= {DATA_WIDTH{1'b0}};
    weight[7]    <= {DATA_WIDTH{1'b0}};
    weight[6]    <= {DATA_WIDTH{1'b0}};
    weight[5]    <= {DATA_WIDTH{1'b0}};
    weight[4]    <= {DATA_WIDTH{1'b0}};
    weight[3]    <= {DATA_WIDTH{1'b0}};
    weight[2]    <= {DATA_WIDTH{1'b0}};
    weight[1]    <= {DATA_WIDTH{1'b0}};
    weight[0]    <= {DATA_WIDTH{1'b0}};
  end
  else if (valid_in) begin
    weight[8]    <= weight_in_08;
    weight[7]    <= weight_in_07;
    weight[6]    <= weight_in_06;
    weight[5]    <= weight_in_05;
    weight[4]    <= weight_in_04;
    weight[3]    <= weight_in_03;
    weight[2]    <= weight_in_02;
    weight[1]    <= weight_in_01;
    weight[0]    <= weight_in_00;
  end
end

wire [DATA_WIDTH-1:0] out_mult      [8:0];
wire [           8:0] valid_out_mult     ;

genvar i;

generate
  for (i = 0; i < 9; i = i + 1) begin: initial_mult
    fp_mul inst_mul (
      .reset    (reset            ),
      .clk      (clk              ),
      .valid_in (fp_valid_in      ),
      .in_a     (fp_in[i]         ),
      .in_b     (weight[i]        ),
      .out      (out_mult[i]      ),
      .valid_out(valid_out_mult[i])
    );
  end
endgenerate

// Line buffer for Mul 00
wire [DATA_WIDTH-1:0] out_line_buffer_08      ;
wire                  valid_out_line_buffer_08;

// reg enable_lb;

// always @(posedge clk) begin
//   if(reset) begin
//     enable_lb <= 1'b0;
//   end
//   else if (valid_out_mult[8]) begin
//     enable_lb <= 1'b1;
//   end
// end

line_buffer #(
  .IMAGE_WIDTH(27        ),
  .KERNEL     (1         ),
  .DIN_WIDTH  (DATA_WIDTH)
) line_buffer7 (
  .clk      (clk                     ),
  .reset    (reset                   ),
  .valid_in (valid_out_mult[8]       ),
  .data_in  (out_mult[8]             ),
  .data_out (out_line_buffer_08      ),
  .valid_out(valid_out_line_buffer_08)
);

// line_buffer #(
//   .IMAGE_WIDTH(25),
//   .KERNEL     (1 ),
//   .DIN_WIDTH  (1 )
// ) line_buffer8 (
//   .clk      (clk                         ),
//   .reset    (reset                       ),
//   .valid_in (enable_lb                   ),
//   .data_in  (valid_out_mult[8]           ),
//   .data_out (valid_out_line_buffer_08    ),
//   .valid_out(/*valid_out_line_buffer_08*/)
// );

// Add
wire [DATA_WIDTH-1:0] out_add1      [3:0];
wire [           3:0] valid_out_add1     ;

generate
  for (i = 0; i < 4; i = i + 1) begin: initial_add1
    fp_add_sub inst_add1 (
      .reset    (reset                                    ),
      .clk      (clk                                      ),
      .valid_in (valid_out_mult[i] & valid_out_mult[i + 4]),
      .in_a     (out_mult[i]                              ),
      .in_b     (out_mult[i + 4]                          ),
      .out      (out_add1[i]                              ),
      .valid_out(valid_out_add1[i]                        )
    );
  end
endgenerate

wire [DATA_WIDTH-1:0] out_add2      [1:0];
wire [           1:0] valid_out_add2     ;

generate
  for (i = 0; i < 2; i = i + 1) begin: initial_add2
    fp_add_sub inst_add2 (
      .reset    (reset                                    ),
      .clk      (clk                                      ),
      .valid_in (valid_out_add1[i] & valid_out_add1[i + 2]),
      .in_a     (out_add1[i]                              ),
      .in_b     (out_add1[i + 2]                          ),
      .out      (out_add2[i]                              ),
      .valid_out(valid_out_add2[i]                        )
    );
  end
endgenerate

wire [DATA_WIDTH-1:0] out_add3      ;
wire                  valid_out_add3;

fp_add_sub inst_add3 (
  .reset    (reset                                ),
  .clk      (clk                                  ),
  .valid_in (valid_out_add2[0] & valid_out_add2[1]),
  .in_a     (out_add2[0]                          ),
  .in_b     (out_add2[1]                          ),
  .out      (out_add3                             ),
  .valid_out(valid_out_add3                       )
);

fp_add_sub inst_add4 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add3 & valid_out_line_buffer_08),
  .in_a     (out_add3                                 ),
  .in_b     (out_line_buffer_08                       ),
  .out      (pxl_out                                  ),
  .valid_out(valid_out                                )
);

endmodule