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

module conv_7x7_buffer (
  clk, 
  reset,
  valid_in,
  in,

  pxl_out_00,
  pxl_out_01,
  pxl_out_02,
  pxl_out_03,
  pxl_out_04,
  pxl_out_05,
  pxl_out_06,
  pxl_out_07,
  pxl_out_08,
  pxl_out_09,
pxl_out_10,
pxl_out_11,
pxl_out_12,
pxl_out_13,
pxl_out_14,
pxl_out_15,
pxl_out_16,
pxl_out_17,
pxl_out_18,
pxl_out_19,
pxl_out_20,
pxl_out_21,
pxl_out_22,
pxl_out_23,
pxl_out_24,
pxl_out_25,
pxl_out_26,
pxl_out_27,
pxl_out_28,
pxl_out_29,
pxl_out_30,
pxl_out_31,
pxl_out_32,
pxl_out_33,
pxl_out_34,
pxl_out_35,
pxl_out_36,
pxl_out_37,
pxl_out_38,
pxl_out_39,
pxl_out_40,
pxl_out_41,
pxl_out_42,
pxl_out_43,
pxl_out_44,
pxl_out_45,
pxl_out_46,
pxl_out_47,
pxl_out_48,
  valid_out,

  load_weights
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// Parameter for submodule
parameter IMAGE_WIDTH = 12;
parameter KERNEL      = 7 ; //3*3 Kernel

// Parameter for submodule
parameter CNT_WIDTH_BUFFER = 7; // $clog2(IMAGE_HEIGHT_PADDING * (IMAGE_WIDTH_PADDING - (KERNEL - 1))) + 1

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk     ;
input                  reset   ;
input                  valid_in;
input [DATA_WIDTH-1:0] in      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out_00; output [DATA_WIDTH-1:0] pxl_out_01; output [DATA_WIDTH-1:0] pxl_out_02;
output [DATA_WIDTH-1:0] pxl_out_03; output [DATA_WIDTH-1:0] pxl_out_04; output [DATA_WIDTH-1:0] pxl_out_05;
output [DATA_WIDTH-1:0] pxl_out_06; output [DATA_WIDTH-1:0] pxl_out_07; output [DATA_WIDTH-1:0] pxl_out_08;
output [DATA_WIDTH-1:0] pxl_out_09;
output [DATA_WIDTH-1:0] pxl_out_10;
output [DATA_WIDTH-1:0] pxl_out_11;
output [DATA_WIDTH-1:0] pxl_out_12;
output [DATA_WIDTH-1:0] pxl_out_13;
output [DATA_WIDTH-1:0] pxl_out_14;
output [DATA_WIDTH-1:0] pxl_out_15;
output [DATA_WIDTH-1:0] pxl_out_16;
output [DATA_WIDTH-1:0] pxl_out_17;
output [DATA_WIDTH-1:0] pxl_out_18;
output [DATA_WIDTH-1:0] pxl_out_19;
output [DATA_WIDTH-1:0] pxl_out_20;
output [DATA_WIDTH-1:0] pxl_out_21;
output [DATA_WIDTH-1:0] pxl_out_22;
output [DATA_WIDTH-1:0] pxl_out_23;
output [DATA_WIDTH-1:0] pxl_out_24;
output [DATA_WIDTH-1:0] pxl_out_25;
output [DATA_WIDTH-1:0] pxl_out_26;
output [DATA_WIDTH-1:0] pxl_out_27;
output [DATA_WIDTH-1:0] pxl_out_28;
output [DATA_WIDTH-1:0] pxl_out_29;
output [DATA_WIDTH-1:0] pxl_out_30;
output [DATA_WIDTH-1:0] pxl_out_31;
output [DATA_WIDTH-1:0] pxl_out_32;
output [DATA_WIDTH-1:0] pxl_out_33;
output [DATA_WIDTH-1:0] pxl_out_34;
output [DATA_WIDTH-1:0] pxl_out_35;
output [DATA_WIDTH-1:0] pxl_out_36;
output [DATA_WIDTH-1:0] pxl_out_37;
output [DATA_WIDTH-1:0] pxl_out_38;
output [DATA_WIDTH-1:0] pxl_out_39;
output [DATA_WIDTH-1:0] pxl_out_40;
output [DATA_WIDTH-1:0] pxl_out_41;
output [DATA_WIDTH-1:0] pxl_out_42;
output [DATA_WIDTH-1:0] pxl_out_43;
output [DATA_WIDTH-1:0] pxl_out_44;
output [DATA_WIDTH-1:0] pxl_out_45;
output [DATA_WIDTH-1:0] pxl_out_46;
output [DATA_WIDTH-1:0] pxl_out_47;
output [DATA_WIDTH-1:0] pxl_out_48;

output valid_out   ;
output load_weights;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk     ;
wire                  reset   ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] in      ;

wire [DATA_WIDTH-1:0] pxl_out_00;
wire [DATA_WIDTH-1:0] pxl_out_01;
wire [DATA_WIDTH-1:0] pxl_out_02;
wire [DATA_WIDTH-1:0] pxl_out_03;
wire [DATA_WIDTH-1:0] pxl_out_04;
wire [DATA_WIDTH-1:0] pxl_out_05;
wire [DATA_WIDTH-1:0] pxl_out_06;
wire [DATA_WIDTH-1:0] pxl_out_07;
wire [DATA_WIDTH-1:0] pxl_out_08;
wire [DATA_WIDTH-1:0] pxl_out_09;
wire [DATA_WIDTH-1:0] pxl_out_10;
wire [DATA_WIDTH-1:0] pxl_out_11;
wire [DATA_WIDTH-1:0] pxl_out_12;
wire [DATA_WIDTH-1:0] pxl_out_13;
wire [DATA_WIDTH-1:0] pxl_out_14;
wire [DATA_WIDTH-1:0] pxl_out_15;
wire [DATA_WIDTH-1:0] pxl_out_16;
wire [DATA_WIDTH-1:0] pxl_out_17;
wire [DATA_WIDTH-1:0] pxl_out_18;
wire [DATA_WIDTH-1:0] pxl_out_19;
wire [DATA_WIDTH-1:0] pxl_out_20;
wire [DATA_WIDTH-1:0] pxl_out_21;
wire [DATA_WIDTH-1:0] pxl_out_22;
wire [DATA_WIDTH-1:0] pxl_out_23;
wire [DATA_WIDTH-1:0] pxl_out_24;
wire [DATA_WIDTH-1:0] pxl_out_25;
wire [DATA_WIDTH-1:0] pxl_out_26;
wire [DATA_WIDTH-1:0] pxl_out_27;
wire [DATA_WIDTH-1:0] pxl_out_28;
wire [DATA_WIDTH-1:0] pxl_out_29;
wire [DATA_WIDTH-1:0] pxl_out_30;
wire [DATA_WIDTH-1:0] pxl_out_31;
wire [DATA_WIDTH-1:0] pxl_out_32;
wire [DATA_WIDTH-1:0] pxl_out_33;
wire [DATA_WIDTH-1:0] pxl_out_34;
wire [DATA_WIDTH-1:0] pxl_out_35;
wire [DATA_WIDTH-1:0] pxl_out_36;
wire [DATA_WIDTH-1:0] pxl_out_37;
wire [DATA_WIDTH-1:0] pxl_out_38;
wire [DATA_WIDTH-1:0] pxl_out_39;
wire [DATA_WIDTH-1:0] pxl_out_40;
wire [DATA_WIDTH-1:0] pxl_out_41;
wire [DATA_WIDTH-1:0] pxl_out_42;
wire [DATA_WIDTH-1:0] pxl_out_43;
wire [DATA_WIDTH-1:0] pxl_out_44;
wire [DATA_WIDTH-1:0] pxl_out_45;
wire [DATA_WIDTH-1:0] pxl_out_46;
wire [DATA_WIDTH-1:0] pxl_out_47;
wire [DATA_WIDTH-1:0] pxl_out_48;

wire valid_out   ;
reg  load_weights;

wire [DATA_WIDTH-1:0] pxl_00;
wire [DATA_WIDTH-1:0] pxl_01;
wire [DATA_WIDTH-1:0] pxl_02;
wire [DATA_WIDTH-1:0] pxl_03;
wire [DATA_WIDTH-1:0] pxl_04;
wire [DATA_WIDTH-1:0] pxl_05;
wire [DATA_WIDTH-1:0] pxl_06;
wire [DATA_WIDTH-1:0] pxl_07;
wire [DATA_WIDTH-1:0] pxl_08;
wire [DATA_WIDTH-1:0] pxl_09;
wire [DATA_WIDTH-1:0] pxl_10;
wire [DATA_WIDTH-1:0] pxl_11;
wire [DATA_WIDTH-1:0] pxl_12;
wire [DATA_WIDTH-1:0] pxl_13;
wire [DATA_WIDTH-1:0] pxl_14;
wire [DATA_WIDTH-1:0] pxl_15;
wire [DATA_WIDTH-1:0] pxl_16;
wire [DATA_WIDTH-1:0] pxl_17;
wire [DATA_WIDTH-1:0] pxl_18;
wire [DATA_WIDTH-1:0] pxl_19;
wire [DATA_WIDTH-1:0] pxl_20;
wire [DATA_WIDTH-1:0] pxl_21;
wire [DATA_WIDTH-1:0] pxl_22;
wire [DATA_WIDTH-1:0] pxl_23;
wire [DATA_WIDTH-1:0] pxl_24;
wire [DATA_WIDTH-1:0] pxl_25;
wire [DATA_WIDTH-1:0] pxl_26;
wire [DATA_WIDTH-1:0] pxl_27;
wire [DATA_WIDTH-1:0] pxl_28;
wire [DATA_WIDTH-1:0] pxl_29;
wire [DATA_WIDTH-1:0] pxl_30;
wire [DATA_WIDTH-1:0] pxl_31;
wire [DATA_WIDTH-1:0] pxl_32;
wire [DATA_WIDTH-1:0] pxl_33;
wire [DATA_WIDTH-1:0] pxl_34;
wire [DATA_WIDTH-1:0] pxl_35;
wire [DATA_WIDTH-1:0] pxl_36;
wire [DATA_WIDTH-1:0] pxl_37;
wire [DATA_WIDTH-1:0] pxl_38;
wire [DATA_WIDTH-1:0] pxl_39;
wire [DATA_WIDTH-1:0] pxl_40;
wire [DATA_WIDTH-1:0] pxl_41;
wire [DATA_WIDTH-1:0] pxl_42;
wire [DATA_WIDTH-1:0] pxl_43;
wire [DATA_WIDTH-1:0] pxl_44;
wire [DATA_WIDTH-1:0] pxl_45;
wire [DATA_WIDTH-1:0] pxl_46;
wire [DATA_WIDTH-1:0] pxl_47;
wire [DATA_WIDTH-1:0] pxl_48;

wire valid_pxl_00;
wire valid_pxl_01;
wire valid_pxl_02;
wire valid_pxl_03;
wire valid_pxl_04;
wire valid_pxl_05;
wire valid_pxl_06;
wire valid_pxl_07;
wire valid_pxl_08;
wire valid_pxl_09;
wire valid_pxl_10;
wire valid_pxl_11;
wire valid_pxl_12;
wire valid_pxl_13;
wire valid_pxl_14;
wire valid_pxl_15;
wire valid_pxl_16;
wire valid_pxl_17;
wire valid_pxl_18;
wire valid_pxl_19;
wire valid_pxl_20;
wire valid_pxl_21;
wire valid_pxl_22;
wire valid_pxl_23;
wire valid_pxl_24;
wire valid_pxl_25;
wire valid_pxl_26;
wire valid_pxl_27;
wire valid_pxl_28;
wire valid_pxl_29;
wire valid_pxl_30;
wire valid_pxl_31;
wire valid_pxl_32;
wire valid_pxl_33;
wire valid_pxl_34;
wire valid_pxl_35;
wire valid_pxl_36;
wire valid_pxl_37;
wire valid_pxl_38;
wire valid_pxl_39;
wire valid_pxl_40;
wire valid_pxl_41;
wire valid_pxl_42;
wire valid_pxl_43;
wire valid_pxl_44;
wire valid_pxl_45;
wire valid_pxl_46;
wire valid_pxl_47;
wire valid_pxl_48;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff48 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_in    ),
	.in       (in          ),
	.out      (pxl_48      ),
	.valid_out(valid_pxl_48)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff47 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_48),
	.in       (pxl_48      ),
	.out      (pxl_47      ),
	.valid_out(valid_pxl_47)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff46 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_47),
	.in       (pxl_47      ),
	.out      (pxl_46      ),
	.valid_out(valid_pxl_46)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff45 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_46),
	.in       (pxl_46      ),
	.out      (pxl_45      ),
	.valid_out(valid_pxl_45)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff44 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_45),
	.in       (pxl_45      ),
	.out      (pxl_44      ),
	.valid_out(valid_pxl_44)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff43 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_44),
	.in       (pxl_44      ),
	.out      (pxl_43      ),
	.valid_out(valid_pxl_43)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff42 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_43),
	.in       (pxl_43      ),
	.out      (pxl_42      ),
	.valid_out(valid_pxl_42)
);

line_buffer #(
	.IMAGE_WIDTH(IMAGE_WIDTH),
	.KERNEL     (KERNEL     ),
	.DIN_WIDTH  (DATA_WIDTH )
) line_buffer41 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_42),
	.data_in  (pxl_42      ),
	.data_out (pxl_41      ),
	.valid_out(valid_pxl_41)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff40 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_41),
	.in       (pxl_41      ),
	.out      (pxl_40      ),
	.valid_out(valid_pxl_40)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff39 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_40),
	.in       (pxl_40      ),
	.out      (pxl_39      ),
	.valid_out(valid_pxl_39)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff38 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_39),
	.in       (pxl_39      ),
	.out      (pxl_38      ),
	.valid_out(valid_pxl_38)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff37 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_38),
	.in       (pxl_38      ),
	.out      (pxl_37      ),
	.valid_out(valid_pxl_37)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff36 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_37),
	.in       (pxl_37      ),
	.out      (pxl_36      ),
	.valid_out(valid_pxl_36)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff35 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_36),
	.in       (pxl_36      ),
	.out      (pxl_35      ),
	.valid_out(valid_pxl_35)
);

line_buffer #(
	.IMAGE_WIDTH(IMAGE_WIDTH),
	.KERNEL     (KERNEL     ),
	.DIN_WIDTH  (DATA_WIDTH )
) line_buffer34 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_35),
	.data_in  (pxl_35      ),
	.data_out (pxl_34      ),
	.valid_out(valid_pxl_34)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff33 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_34),
	.in       (pxl_34      ),
	.out      (pxl_33      ),
	.valid_out(valid_pxl_33)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff32 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_33),
	.in       (pxl_33      ),
	.out      (pxl_32      ),
	.valid_out(valid_pxl_32)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff31 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_32),
	.in       (pxl_32      ),
	.out      (pxl_31      ),
	.valid_out(valid_pxl_31)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff30 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_31),
	.in       (pxl_31      ),
	.out      (pxl_30      ),
	.valid_out(valid_pxl_30)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff29 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_30),
	.in       (pxl_30      ),
	.out      (pxl_29      ),
	.valid_out(valid_pxl_29)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff28 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_29),
	.in       (pxl_29      ),
	.out      (pxl_28      ),
	.valid_out(valid_pxl_28)
);

line_buffer #(
	.IMAGE_WIDTH(IMAGE_WIDTH),
	.KERNEL     (KERNEL     ),
	.DIN_WIDTH  (DATA_WIDTH )
) line_buffer27 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_28),
	.data_in  (pxl_28      ),
	.data_out (pxl_27      ),
	.valid_out(valid_pxl_27)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff26 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_27),
	.in       (pxl_27      ),
	.out      (pxl_26      ),
	.valid_out(valid_pxl_26)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff25 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_26),
	.in       (pxl_26      ),
	.out      (pxl_25      ),
	.valid_out(valid_pxl_25)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff24 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_25),
	.in       (pxl_25      ),
	.out      (pxl_24      ),
	.valid_out(valid_pxl_24)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff23 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_24),
	.in       (pxl_24      ),
	.out      (pxl_23      ),
	.valid_out(valid_pxl_23)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff22 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_23),
	.in       (pxl_23      ),
	.out      (pxl_22      ),
	.valid_out(valid_pxl_22)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff21 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_22),
	.in       (pxl_22      ),
	.out      (pxl_21      ),
	.valid_out(valid_pxl_21)
);

line_buffer #(
	.IMAGE_WIDTH(IMAGE_WIDTH),
	.KERNEL     (KERNEL     ),
	.DIN_WIDTH  (DATA_WIDTH )
) line_buffer20 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_21),
	.data_in  (pxl_21      ),
	.data_out (pxl_20      ),
	.valid_out(valid_pxl_20)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff19 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_20),
	.in       (pxl_20      ),
	.out      (pxl_19      ),
	.valid_out(valid_pxl_19)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff18 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_19),
	.in       (pxl_19      ),
	.out      (pxl_18      ),
	.valid_out(valid_pxl_18)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff17 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_18),
	.in       (pxl_18      ),
	.out      (pxl_17      ),
	.valid_out(valid_pxl_17)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff16 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_17),
	.in       (pxl_17      ),
	.out      (pxl_16      ),
	.valid_out(valid_pxl_16)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff15 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_16),
	.in       (pxl_16      ),
	.out      (pxl_15      ),
	.valid_out(valid_pxl_15)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff14 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_15),
	.in       (pxl_15      ),
	.out      (pxl_14      ),
	.valid_out(valid_pxl_14)
);

line_buffer #(
	.IMAGE_WIDTH(IMAGE_WIDTH),
	.KERNEL     (KERNEL     ),
	.DIN_WIDTH  (DATA_WIDTH )
) line_buffer13 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_14),
	.data_in  (pxl_14      ),
	.data_out (pxl_13      ),
	.valid_out(valid_pxl_13)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff12 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_13),
	.in       (pxl_13      ),
	.out      (pxl_12      ),
	.valid_out(valid_pxl_12)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff11 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_12),
	.in       (pxl_12      ),
	.out      (pxl_11      ),
	.valid_out(valid_pxl_11)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff10 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_11),
	.in       (pxl_11      ),
	.out      (pxl_10      ),
	.valid_out(valid_pxl_10)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff09 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_10),
	.in       (pxl_10      ),
	.out      (pxl_09      ),
	.valid_out(valid_pxl_09)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff08 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_09),
	.in       (pxl_09      ),
	.out      (pxl_08      ),
	.valid_out(valid_pxl_08)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff07 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_08),
	.in       (pxl_08      ),
	.out      (pxl_07      ),
	.valid_out(valid_pxl_07)
);

line_buffer #(
	.IMAGE_WIDTH(IMAGE_WIDTH),
	.KERNEL     (KERNEL     ),
	.DIN_WIDTH  (DATA_WIDTH )
) line_buffer06 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_07),
	.data_in  (pxl_07      ),
	.data_out (pxl_06      ),
	.valid_out(valid_pxl_06)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff05 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_06),
	.in       (pxl_06      ),
	.out      (pxl_05      ),
	.valid_out(valid_pxl_05)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff04 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_05),
	.in       (pxl_05      ),
	.out      (pxl_04      ),
	.valid_out(valid_pxl_04)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff03 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_04),
	.in       (pxl_04      ),
	.out      (pxl_03      ),
	.valid_out(valid_pxl_03)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff02 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_03),
	.in       (pxl_03      ),
	.out      (pxl_02      ),
	.valid_out(valid_pxl_02)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff01 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_02),
	.in       (pxl_02      ),
	.out      (pxl_01      ),
	.valid_out(valid_pxl_01)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff00 (
	.clk      (clk         ),
	.reset    (reset       ),
	.valid_in (valid_pxl_01),
	.in       (pxl_01      ),
	.out      (pxl_00      ),
	.valid_out(valid_pxl_00)
);

/////////////////////////////////////////////////////////////////////////
// 
wire [DATA_WIDTH-1:0] pxl_out_dff_00;
wire [DATA_WIDTH-1:0] pxl_out_dff_01;
wire [DATA_WIDTH-1:0] pxl_out_dff_02;
wire [DATA_WIDTH-1:0] pxl_out_dff_03;
wire [DATA_WIDTH-1:0] pxl_out_dff_04;
wire [DATA_WIDTH-1:0] pxl_out_dff_05;
wire [DATA_WIDTH-1:0] pxl_out_dff_06;
wire [DATA_WIDTH-1:0] pxl_out_dff_07;
wire [DATA_WIDTH-1:0] pxl_out_dff_08;
wire [DATA_WIDTH-1:0] pxl_out_dff_09;
wire [DATA_WIDTH-1:0] pxl_out_dff_10;
wire [DATA_WIDTH-1:0] pxl_out_dff_11;
wire [DATA_WIDTH-1:0] pxl_out_dff_12;
wire [DATA_WIDTH-1:0] pxl_out_dff_13;
wire [DATA_WIDTH-1:0] pxl_out_dff_14;
wire [DATA_WIDTH-1:0] pxl_out_dff_15;
wire [DATA_WIDTH-1:0] pxl_out_dff_16;
wire [DATA_WIDTH-1:0] pxl_out_dff_17;
wire [DATA_WIDTH-1:0] pxl_out_dff_18;
wire [DATA_WIDTH-1:0] pxl_out_dff_19;
wire [DATA_WIDTH-1:0] pxl_out_dff_20;
wire [DATA_WIDTH-1:0] pxl_out_dff_21;
wire [DATA_WIDTH-1:0] pxl_out_dff_22;
wire [DATA_WIDTH-1:0] pxl_out_dff_23;
wire [DATA_WIDTH-1:0] pxl_out_dff_24;
wire [DATA_WIDTH-1:0] pxl_out_dff_25;
wire [DATA_WIDTH-1:0] pxl_out_dff_26;
wire [DATA_WIDTH-1:0] pxl_out_dff_27;
wire [DATA_WIDTH-1:0] pxl_out_dff_28;
wire [DATA_WIDTH-1:0] pxl_out_dff_29;
wire [DATA_WIDTH-1:0] pxl_out_dff_30;
wire [DATA_WIDTH-1:0] pxl_out_dff_31;
wire [DATA_WIDTH-1:0] pxl_out_dff_32;
wire [DATA_WIDTH-1:0] pxl_out_dff_33;
wire [DATA_WIDTH-1:0] pxl_out_dff_34;
wire [DATA_WIDTH-1:0] pxl_out_dff_35;
wire [DATA_WIDTH-1:0] pxl_out_dff_36;
wire [DATA_WIDTH-1:0] pxl_out_dff_37;
wire [DATA_WIDTH-1:0] pxl_out_dff_38;
wire [DATA_WIDTH-1:0] pxl_out_dff_39;
wire [DATA_WIDTH-1:0] pxl_out_dff_40;
wire [DATA_WIDTH-1:0] pxl_out_dff_41;
wire [DATA_WIDTH-1:0] pxl_out_dff_42;
wire [DATA_WIDTH-1:0] pxl_out_dff_43;
wire [DATA_WIDTH-1:0] pxl_out_dff_44;
wire [DATA_WIDTH-1:0] pxl_out_dff_45;
wire [DATA_WIDTH-1:0] pxl_out_dff_46;
wire [DATA_WIDTH-1:0] pxl_out_dff_47;
wire [DATA_WIDTH-1:0] pxl_out_dff_48;

wire valid_pxl_out_dff_00;
wire valid_pxl_out_dff_01;
wire valid_pxl_out_dff_02;
wire valid_pxl_out_dff_03;
wire valid_pxl_out_dff_04;
wire valid_pxl_out_dff_05;
wire valid_pxl_out_dff_06;
wire valid_pxl_out_dff_07;
wire valid_pxl_out_dff_08;
wire valid_pxl_out_dff_09;
wire valid_pxl_out_dff_10;
wire valid_pxl_out_dff_11;
wire valid_pxl_out_dff_12;
wire valid_pxl_out_dff_13;
wire valid_pxl_out_dff_14;
wire valid_pxl_out_dff_15;
wire valid_pxl_out_dff_16;
wire valid_pxl_out_dff_17;
wire valid_pxl_out_dff_18;
wire valid_pxl_out_dff_19;
wire valid_pxl_out_dff_20;
wire valid_pxl_out_dff_21;
wire valid_pxl_out_dff_22;
wire valid_pxl_out_dff_23;
wire valid_pxl_out_dff_24;
wire valid_pxl_out_dff_25;
wire valid_pxl_out_dff_26;
wire valid_pxl_out_dff_27;
wire valid_pxl_out_dff_28;
wire valid_pxl_out_dff_29;
wire valid_pxl_out_dff_30;
wire valid_pxl_out_dff_31;
wire valid_pxl_out_dff_32;
wire valid_pxl_out_dff_33;
wire valid_pxl_out_dff_34;
wire valid_pxl_out_dff_35;
wire valid_pxl_out_dff_36;
wire valid_pxl_out_dff_37;
wire valid_pxl_out_dff_38;
wire valid_pxl_out_dff_39;
wire valid_pxl_out_dff_40;
wire valid_pxl_out_dff_41;
wire valid_pxl_out_dff_42;
wire valid_pxl_out_dff_43;
wire valid_pxl_out_dff_44;
wire valid_pxl_out_dff_45;
wire valid_pxl_out_dff_46;
wire valid_pxl_out_dff_47;
wire valid_pxl_out_dff_48;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff4848 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_48        ),
	.in       (pxl_48              ),
	.out      (pxl_out_dff_48      ),
	.valid_out(valid_pxl_out_dff_48)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff4747 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_47        ),
	.in       (pxl_47              ),
	.out      (pxl_out_dff_47      ),
	.valid_out(valid_pxl_out_dff_47)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff4646 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_46        ),
	.in       (pxl_46              ),
	.out      (pxl_out_dff_46      ),
	.valid_out(valid_pxl_out_dff_46)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff4545 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_45        ),
	.in       (pxl_45              ),
	.out      (pxl_out_dff_45      ),
	.valid_out(valid_pxl_out_dff_45)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff4444 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_44        ),
	.in       (pxl_44              ),
	.out      (pxl_out_dff_44      ),
	.valid_out(valid_pxl_out_dff_44)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff4343 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_43        ),
	.in       (pxl_43              ),
	.out      (pxl_out_dff_43      ),
	.valid_out(valid_pxl_out_dff_43)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff4242 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_42        ),
	.in       (pxl_42              ),
	.out      (pxl_out_dff_42      ),
	.valid_out(valid_pxl_out_dff_42)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff4141 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_41        ),
	.in       (pxl_41              ),
	.out      (pxl_out_dff_41      ),
	.valid_out(valid_pxl_out_dff_41)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff4040 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_40        ),
	.in       (pxl_40              ),
	.out      (pxl_out_dff_40      ),
	.valid_out(valid_pxl_out_dff_40)
);
d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3939 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_39        ),
	.in       (pxl_39              ),
	.out      (pxl_out_dff_39      ),
	.valid_out(valid_pxl_out_dff_39)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3838 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_38        ),
	.in       (pxl_38              ),
	.out      (pxl_out_dff_38      ),
	.valid_out(valid_pxl_out_dff_38)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3737 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_37        ),
	.in       (pxl_37              ),
	.out      (pxl_out_dff_37      ),
	.valid_out(valid_pxl_out_dff_37)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3636 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_36        ),
	.in       (pxl_36              ),
	.out      (pxl_out_dff_36      ),
	.valid_out(valid_pxl_out_dff_36)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3535 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_35        ),
	.in       (pxl_35              ),
	.out      (pxl_out_dff_35      ),
	.valid_out(valid_pxl_out_dff_35)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3434 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_34        ),
	.in       (pxl_34              ),
	.out      (pxl_out_dff_34      ),
	.valid_out(valid_pxl_out_dff_34)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3333 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_33        ),
	.in       (pxl_33              ),
	.out      (pxl_out_dff_33      ),
	.valid_out(valid_pxl_out_dff_33)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3232 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_32        ),
	.in       (pxl_32              ),
	.out      (pxl_out_dff_32      ),
	.valid_out(valid_pxl_out_dff_32)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3131 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_31        ),
	.in       (pxl_31              ),
	.out      (pxl_out_dff_31      ),
	.valid_out(valid_pxl_out_dff_31)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff3030 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_30        ),
	.in       (pxl_30              ),
	.out      (pxl_out_dff_30      ),
	.valid_out(valid_pxl_out_dff_30)
);
d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff2929 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_29        ),
	.in       (pxl_29              ),
	.out      (pxl_out_dff_29      ),
	.valid_out(valid_pxl_out_dff_29)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff2828 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_28        ),
	.in       (pxl_28              ),
	.out      (pxl_out_dff_28      ),
	.valid_out(valid_pxl_out_dff_28)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff2727 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_27        ),
	.in       (pxl_27              ),
	.out      (pxl_out_dff_27      ),
	.valid_out(valid_pxl_out_dff_27)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff2626 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_26        ),
	.in       (pxl_26              ),
	.out      (pxl_out_dff_26      ),
	.valid_out(valid_pxl_out_dff_26)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff2525 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_25        ),
	.in       (pxl_25              ),
	.out      (pxl_out_dff_25      ),
	.valid_out(valid_pxl_out_dff_25)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff2424 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_24        ),
	.in       (pxl_24              ),
	.out      (pxl_out_dff_24      ),
	.valid_out(valid_pxl_out_dff_24)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff2323 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_23        ),
	.in       (pxl_23              ),
	.out      (pxl_out_dff_23      ),
	.valid_out(valid_pxl_out_dff_23)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff2222 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_22        ),
	.in       (pxl_22              ),
	.out      (pxl_out_dff_22      ),
	.valid_out(valid_pxl_out_dff_22)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff2121 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_21        ),
	.in       (pxl_21              ),
	.out      (pxl_out_dff_21      ),
	.valid_out(valid_pxl_out_dff_21)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff2020 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_20        ),
	.in       (pxl_20              ),
	.out      (pxl_out_dff_20      ),
	.valid_out(valid_pxl_out_dff_20)
);
d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1919 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_19        ),
	.in       (pxl_19              ),
	.out      (pxl_out_dff_19      ),
	.valid_out(valid_pxl_out_dff_19)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1818 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_18        ),
	.in       (pxl_18              ),
	.out      (pxl_out_dff_18      ),
	.valid_out(valid_pxl_out_dff_18)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1717 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_17        ),
	.in       (pxl_17              ),
	.out      (pxl_out_dff_17      ),
	.valid_out(valid_pxl_out_dff_17)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1616 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_16        ),
	.in       (pxl_16              ),
	.out      (pxl_out_dff_16      ),
	.valid_out(valid_pxl_out_dff_16)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1515 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_15        ),
	.in       (pxl_15              ),
	.out      (pxl_out_dff_15      ),
	.valid_out(valid_pxl_out_dff_15)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1414 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_14        ),
	.in       (pxl_14              ),
	.out      (pxl_out_dff_14      ),
	.valid_out(valid_pxl_out_dff_14)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1313 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_13        ),
	.in       (pxl_13              ),
	.out      (pxl_out_dff_13      ),
	.valid_out(valid_pxl_out_dff_13)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1212 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_12        ),
	.in       (pxl_12              ),
	.out      (pxl_out_dff_12      ),
	.valid_out(valid_pxl_out_dff_12)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1111 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_11        ),
	.in       (pxl_11              ),
	.out      (pxl_out_dff_11      ),
	.valid_out(valid_pxl_out_dff_11)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff1010 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_10        ),
	.in       (pxl_10              ),
	.out      (pxl_out_dff_10      ),
	.valid_out(valid_pxl_out_dff_10)
);
d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff99 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_09        ),
	.in       (pxl_09              ),
	.out      (pxl_out_dff_09      ),
	.valid_out(valid_pxl_out_dff_09)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff88 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_08        ),
	.in       (pxl_08              ),
	.out      (pxl_out_dff_08      ),
	.valid_out(valid_pxl_out_dff_08)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff77 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_07        ),
	.in       (pxl_07              ),
	.out      (pxl_out_dff_07      ),
	.valid_out(valid_pxl_out_dff_07)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff66 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_06        ),
	.in       (pxl_06              ),
	.out      (pxl_out_dff_06      ),
	.valid_out(valid_pxl_out_dff_06)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff55 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_05        ),
	.in       (pxl_05              ),
	.out      (pxl_out_dff_05      ),
	.valid_out(valid_pxl_out_dff_05)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff444 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_04        ),
	.in       (pxl_04              ),
	.out      (pxl_out_dff_04      ),
	.valid_out(valid_pxl_out_dff_04)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff333 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_03        ),
	.in       (pxl_03              ),
	.out      (pxl_out_dff_03      ),
	.valid_out(valid_pxl_out_dff_03)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff222 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_02        ),
	.in       (pxl_02              ),
	.out      (pxl_out_dff_02      ),
	.valid_out(valid_pxl_out_dff_02)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff111 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_01        ),
	.in       (pxl_01              ),
	.out      (pxl_out_dff_01      ),
	.valid_out(valid_pxl_out_dff_01)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff000 (
	.clk      (clk                 ),
	.reset    (reset               ),
	.valid_in (valid_pxl_00        ),
	.in       (pxl_00              ),
	.out      (pxl_out_dff_00      ),
	.valid_out(valid_pxl_out_dff_00)
);

// Logic valid out
wire total_valid;

assign total_valid = valid_pxl_25;

reg [CNT_WIDTH_BUFFER-1:0] counter_col  ;
reg                        valid_out_col;

always @(posedge clk) begin
	if(reset) begin
		counter_col   <= {CNT_WIDTH_BUFFER{1'b0}};
		valid_out_col <= 1'b0;

		load_weights <= 1'b0;
	end
	else if (total_valid) begin
		counter_col   <= counter_col + 1'b1;
		valid_out_col <= 1'b1;
		if (counter_col[0]) begin
			valid_out_col <= 1'b0;
		end
		if (counter_col >= IMAGE_WIDTH) begin
			counter_col <= {{CNT_WIDTH_BUFFER-1{1'b0}},1'b1};
		end
		if (!(|counter_col)) begin
			load_weights <= 1'b1;
		end
		else begin
			load_weights <= 1'b0;
		end
	end
	else begin
		counter_col   <= {CNT_WIDTH_BUFFER{1'b0}};
		valid_out_col <= 1'b0;
	end

end

reg [CNT_WIDTH_BUFFER-1:0] counter_row  ;
reg                        valid_out_row;

always @(posedge clk) begin
	if(reset) begin
		counter_row   <= {CNT_WIDTH_BUFFER{1'b0}};
		valid_out_row <= 1'b0;
	end
	else if (total_valid) begin
		valid_out_row <= 1'b1;
		if (!(|(counter_col  % IMAGE_WIDTH))) begin
			counter_row <= counter_row + 1'b1;
		end

		if (!(counter_row[0])) begin
			valid_out_row <= 1'b0;
		end
	end
	else begin
		counter_row   <= {CNT_WIDTH_BUFFER{1'b0}};
		valid_out_row <= 1'b0;
	end
end

// DFF
reg valid_out_col_next;

always @(posedge clk) begin
	if(reset) begin
		valid_out_col_next <= 1'b0;
	end
	else begin
		valid_out_col_next <= valid_out_col;
	end
end

assign valid_out = valid_out_col_next & valid_out_row;

// Padding
reg [CNT_WIDTH_BUFFER-1:0] cnt_pad;

always @(posedge clk) begin
	if(reset) begin
		cnt_pad <= {CNT_WIDTH_BUFFER{1'b0}};
	end
	else begin
		cnt_pad <= counter_col;
	end
end

assign pxl_out_48 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_48) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_48;
assign pxl_out_47 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_47) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_47;
assign pxl_out_46 = (!valid_pxl_out_dff_46) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_46;
assign pxl_out_45 = (!valid_pxl_out_dff_45) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_45;
assign pxl_out_44 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_44) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_44;
assign pxl_out_43 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_43) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_43;
assign pxl_out_42 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:2]) && cnt_pad[0] || !valid_pxl_out_dff_42) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_42;

assign pxl_out_41 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_41) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_41;
assign pxl_out_40 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_40) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_40;
assign pxl_out_39 = (!valid_pxl_out_dff_39) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_39;
assign pxl_out_38 = (!valid_pxl_out_dff_38) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_38;
assign pxl_out_37 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_37) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_37;
assign pxl_out_36 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_36) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_36;
assign pxl_out_35 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:2]) && cnt_pad[0] || !valid_pxl_out_dff_35) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_35;

assign pxl_out_34 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_34) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_34;
assign pxl_out_33 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_33) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_33;
assign pxl_out_32 = (!valid_pxl_out_dff_32) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_32;
assign pxl_out_31 = (!valid_pxl_out_dff_31) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_31;
assign pxl_out_30 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_30) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_30;
assign pxl_out_29 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_29) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_29;
assign pxl_out_28 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:2]) && cnt_pad[0] || !valid_pxl_out_dff_28) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_28;

assign pxl_out_27 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_27) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_27;
assign pxl_out_26 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_26) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_26;
assign pxl_out_25 = (!valid_pxl_out_dff_25) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_25;
assign pxl_out_24 = (!valid_pxl_out_dff_24) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_24;
assign pxl_out_23 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_23) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_23;
assign pxl_out_22 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_22) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_22;
assign pxl_out_21 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:2]) && cnt_pad[0] || !valid_pxl_out_dff_21) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_21;

assign pxl_out_20 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_20) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_20;
assign pxl_out_19 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_19) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_19;
assign pxl_out_18 = (!valid_pxl_out_dff_18) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_18;
assign pxl_out_17 = (!valid_pxl_out_dff_17) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_17;
assign pxl_out_16 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_16) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_16;
assign pxl_out_15 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_15) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_15;
assign pxl_out_14 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:2]) && cnt_pad[0] || !valid_pxl_out_dff_14) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_14;

assign pxl_out_13 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_13) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_13;
assign pxl_out_12 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_12) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_12;
assign pxl_out_11 = (!valid_pxl_out_dff_11) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_11;
assign pxl_out_10 = (!valid_pxl_out_dff_10) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_10;
assign pxl_out_09 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_09) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_09;
assign pxl_out_08 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_08) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_08;
assign pxl_out_07 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:2]) && cnt_pad[0] || !valid_pxl_out_dff_07) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_07;

assign pxl_out_06 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_06) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_06;
assign pxl_out_05 = ((cnt_pad == IMAGE_WIDTH - 1) || !valid_pxl_out_dff_05) 					? {DATA_WIDTH{1'b0}} : pxl_out_dff_05;
assign pxl_out_04 = (!valid_pxl_out_dff_04) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_04;
assign pxl_out_03 = (!valid_pxl_out_dff_03) 													? {DATA_WIDTH{1'b0}} : pxl_out_dff_03;
assign pxl_out_02 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_02) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_02;
assign pxl_out_01 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:1]) && cnt_pad[0] || !valid_pxl_out_dff_01) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_01;
assign pxl_out_00 = (!(|cnt_pad[CNT_WIDTH_BUFFER-1:2]) && cnt_pad[0] || !valid_pxl_out_dff_00) 	? {DATA_WIDTH{1'b0}} : pxl_out_dff_00;

endmodule