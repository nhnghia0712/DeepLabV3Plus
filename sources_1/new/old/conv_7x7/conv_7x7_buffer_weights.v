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

module conv_7x7_buffer_weights (
  clk, 
  reset,
  valid_in,
  in,
  load_weights,

weight_out_00,
weight_out_01,
weight_out_02,
weight_out_03,
weight_out_04,
weight_out_05,
weight_out_06,
weight_out_07,
weight_out_08,
weight_out_09,
weight_out_10,
weight_out_11,
weight_out_12,
weight_out_13,
weight_out_14,
weight_out_15,
weight_out_16,
weight_out_17,
weight_out_18,
weight_out_19,
weight_out_20,
weight_out_21,
weight_out_22,
weight_out_23,
weight_out_24,
weight_out_25,
weight_out_26,
weight_out_27,
weight_out_28,
weight_out_29,
weight_out_30,
weight_out_31,
weight_out_32,
weight_out_33,
weight_out_34,
weight_out_35,
weight_out_36,
weight_out_37,
weight_out_38,
weight_out_39,
weight_out_40,
weight_out_41,
weight_out_42,
weight_out_43,
weight_out_44,
weight_out_45,
weight_out_46,
weight_out_47,
weight_out_48,

  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// Parameter for submodule
parameter POINTER_WIDTH_BUFFER_WEIGHTS = 8; // $clog2(WEIGHT_NUM) + 1 // For Buffer Weights = log2(WEIGHT_NUM)
parameter CNT_WIDTH_BUFFER_WEIGHTS     = 6; // $clog2(KERNEL_SIZE) // For Buffer Weights = log2(KERNEL_SIZE)

// Localparam general
parameter KERNEL_SIZE = 49 ; //7x7 Kernel
parameter WEIGHT_NUM  = 196; // 2x2x7x7


/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk         ;
input                  reset       ;
input                  valid_in    ;
input [DATA_WIDTH-1:0] in          ;
input                  load_weights;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] weight_out_00; output [DATA_WIDTH-1:0] weight_out_01; output [DATA_WIDTH-1:0] weight_out_02;
output [DATA_WIDTH-1:0] weight_out_03; output [DATA_WIDTH-1:0] weight_out_04; output [DATA_WIDTH-1:0] weight_out_05;
output [DATA_WIDTH-1:0] weight_out_06; output [DATA_WIDTH-1:0] weight_out_07; output [DATA_WIDTH-1:0] weight_out_08;
output [DATA_WIDTH-1:0] weight_out_09; output [DATA_WIDTH-1:0] weight_out_10; output [DATA_WIDTH-1:0] weight_out_11;
output [DATA_WIDTH-1:0] weight_out_12; output [DATA_WIDTH-1:0] weight_out_13; output [DATA_WIDTH-1:0] weight_out_14;
output [DATA_WIDTH-1:0] weight_out_15; output [DATA_WIDTH-1:0] weight_out_16; output [DATA_WIDTH-1:0] weight_out_17;
output [DATA_WIDTH-1:0] weight_out_18; output [DATA_WIDTH-1:0] weight_out_19; output [DATA_WIDTH-1:0] weight_out_20;
output [DATA_WIDTH-1:0] weight_out_21; output [DATA_WIDTH-1:0] weight_out_22; output [DATA_WIDTH-1:0] weight_out_23;
output [DATA_WIDTH-1:0] weight_out_24; output [DATA_WIDTH-1:0] weight_out_25; output [DATA_WIDTH-1:0] weight_out_26;
output [DATA_WIDTH-1:0] weight_out_27; output [DATA_WIDTH-1:0] weight_out_28; output [DATA_WIDTH-1:0] weight_out_29;
output [DATA_WIDTH-1:0] weight_out_30; output [DATA_WIDTH-1:0] weight_out_31; output [DATA_WIDTH-1:0] weight_out_32;
output [DATA_WIDTH-1:0] weight_out_33; output [DATA_WIDTH-1:0] weight_out_34; output [DATA_WIDTH-1:0] weight_out_35;
output [DATA_WIDTH-1:0] weight_out_36; output [DATA_WIDTH-1:0] weight_out_37; output [DATA_WIDTH-1:0] weight_out_38;
output [DATA_WIDTH-1:0] weight_out_39; output [DATA_WIDTH-1:0] weight_out_40; output [DATA_WIDTH-1:0] weight_out_41;
output [DATA_WIDTH-1:0] weight_out_42; output [DATA_WIDTH-1:0] weight_out_43; output [DATA_WIDTH-1:0] weight_out_44;
output [DATA_WIDTH-1:0] weight_out_45; output [DATA_WIDTH-1:0] weight_out_46; output [DATA_WIDTH-1:0] weight_out_47;
output [DATA_WIDTH-1:0] weight_out_48;

output valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk        ;
wire                  reset      ;
wire                  valid_in   ;
wire [DATA_WIDTH-1:0] in         ;
wire                  load_weights;

wire [DATA_WIDTH-1:0] weight_out_00;
wire [DATA_WIDTH-1:0] weight_out_01;
wire [DATA_WIDTH-1:0] weight_out_02;
wire [DATA_WIDTH-1:0] weight_out_03;
wire [DATA_WIDTH-1:0] weight_out_04;
wire [DATA_WIDTH-1:0] weight_out_05;
wire [DATA_WIDTH-1:0] weight_out_06;
wire [DATA_WIDTH-1:0] weight_out_07;
wire [DATA_WIDTH-1:0] weight_out_08;
wire [DATA_WIDTH-1:0] weight_out_09; wire [DATA_WIDTH-1:0] weight_out_10; wire [DATA_WIDTH-1:0] weight_out_11;
wire [DATA_WIDTH-1:0] weight_out_12; wire [DATA_WIDTH-1:0] weight_out_13; wire [DATA_WIDTH-1:0] weight_out_14;
wire [DATA_WIDTH-1:0] weight_out_15; wire [DATA_WIDTH-1:0] weight_out_16; wire [DATA_WIDTH-1:0] weight_out_17;
wire [DATA_WIDTH-1:0] weight_out_18; wire [DATA_WIDTH-1:0] weight_out_19; wire [DATA_WIDTH-1:0] weight_out_20;
wire [DATA_WIDTH-1:0] weight_out_21; wire [DATA_WIDTH-1:0] weight_out_22; wire [DATA_WIDTH-1:0] weight_out_23;
wire [DATA_WIDTH-1:0] weight_out_24; wire [DATA_WIDTH-1:0] weight_out_25; wire [DATA_WIDTH-1:0] weight_out_26;
wire [DATA_WIDTH-1:0] weight_out_27; wire [DATA_WIDTH-1:0] weight_out_28; wire [DATA_WIDTH-1:0] weight_out_29;
wire [DATA_WIDTH-1:0] weight_out_30; wire [DATA_WIDTH-1:0] weight_out_31; wire [DATA_WIDTH-1:0] weight_out_32;
wire [DATA_WIDTH-1:0] weight_out_33; wire [DATA_WIDTH-1:0] weight_out_34; wire [DATA_WIDTH-1:0] weight_out_35;
wire [DATA_WIDTH-1:0] weight_out_36; wire [DATA_WIDTH-1:0] weight_out_37; wire [DATA_WIDTH-1:0] weight_out_38;
wire [DATA_WIDTH-1:0] weight_out_39; wire [DATA_WIDTH-1:0] weight_out_40; wire [DATA_WIDTH-1:0] weight_out_41;
wire [DATA_WIDTH-1:0] weight_out_42; wire [DATA_WIDTH-1:0] weight_out_43; wire [DATA_WIDTH-1:0] weight_out_44;
wire [DATA_WIDTH-1:0] weight_out_45; wire [DATA_WIDTH-1:0] weight_out_46; wire [DATA_WIDTH-1:0] weight_out_47;
wire [DATA_WIDTH-1:0] weight_out_48;

reg valid_out;


////////////////Buffer
wire [DATA_WIDTH-1:0] weight_out_00_next;
wire [DATA_WIDTH-1:0] weight_out_01_next;
wire [DATA_WIDTH-1:0] weight_out_02_next;
wire [DATA_WIDTH-1:0] weight_out_03_next;
wire [DATA_WIDTH-1:0] weight_out_04_next;
wire [DATA_WIDTH-1:0] weight_out_05_next;
wire [DATA_WIDTH-1:0] weight_out_06_next;
wire [DATA_WIDTH-1:0] weight_out_07_next;
wire [DATA_WIDTH-1:0] weight_out_08_next;
wire [DATA_WIDTH-1:0] weight_out_09_next; wire [DATA_WIDTH-1:0] weight_out_10_next; wire [DATA_WIDTH-1:0] weight_out_11_next;
wire [DATA_WIDTH-1:0] weight_out_12_next; wire [DATA_WIDTH-1:0] weight_out_13_next; wire [DATA_WIDTH-1:0] weight_out_14_next;
wire [DATA_WIDTH-1:0] weight_out_15_next; wire [DATA_WIDTH-1:0] weight_out_16_next; wire [DATA_WIDTH-1:0] weight_out_17_next;
wire [DATA_WIDTH-1:0] weight_out_18_next; wire [DATA_WIDTH-1:0] weight_out_19_next; wire [DATA_WIDTH-1:0] weight_out_20_next;
wire [DATA_WIDTH-1:0] weight_out_21_next; wire [DATA_WIDTH-1:0] weight_out_22_next; wire [DATA_WIDTH-1:0] weight_out_23_next;
wire [DATA_WIDTH-1:0] weight_out_24_next; wire [DATA_WIDTH-1:0] weight_out_25_next; wire [DATA_WIDTH-1:0] weight_out_26_next;
wire [DATA_WIDTH-1:0] weight_out_27_next; wire [DATA_WIDTH-1:0] weight_out_28_next; wire [DATA_WIDTH-1:0] weight_out_29_next;
wire [DATA_WIDTH-1:0] weight_out_30_next; wire [DATA_WIDTH-1:0] weight_out_31_next; wire [DATA_WIDTH-1:0] weight_out_32_next;
wire [DATA_WIDTH-1:0] weight_out_33_next; wire [DATA_WIDTH-1:0] weight_out_34_next; wire [DATA_WIDTH-1:0] weight_out_35_next;
wire [DATA_WIDTH-1:0] weight_out_36_next; wire [DATA_WIDTH-1:0] weight_out_37_next; wire [DATA_WIDTH-1:0] weight_out_38_next;
wire [DATA_WIDTH-1:0] weight_out_39_next; wire [DATA_WIDTH-1:0] weight_out_40_next; wire [DATA_WIDTH-1:0] weight_out_41_next;
wire [DATA_WIDTH-1:0] weight_out_42_next; wire [DATA_WIDTH-1:0] weight_out_43_next; wire [DATA_WIDTH-1:0] weight_out_44_next;
wire [DATA_WIDTH-1:0] weight_out_45_next; wire [DATA_WIDTH-1:0] weight_out_46_next; wire [DATA_WIDTH-1:0] weight_out_47_next;
wire [DATA_WIDTH-1:0] weight_out_48_next;

wire valid_weight_out_00_next;
wire valid_weight_out_01_next;
wire valid_weight_out_02_next;
wire valid_weight_out_03_next;
wire valid_weight_out_04_next;
wire valid_weight_out_05_next;
wire valid_weight_out_06_next;
wire valid_weight_out_07_next;
wire valid_weight_out_08_next;
wire valid_weight_out_09_next; wire valid_weight_out_10_next; wire valid_weight_out_11_next;
wire valid_weight_out_12_next; wire valid_weight_out_13_next; wire valid_weight_out_14_next;
wire valid_weight_out_15_next; wire valid_weight_out_16_next; wire valid_weight_out_17_next;
wire valid_weight_out_18_next; wire valid_weight_out_19_next; wire valid_weight_out_20_next;
wire valid_weight_out_21_next; wire valid_weight_out_22_next; wire valid_weight_out_23_next;
wire valid_weight_out_24_next; wire valid_weight_out_25_next; wire valid_weight_out_26_next;
wire valid_weight_out_27_next; wire valid_weight_out_28_next; wire valid_weight_out_29_next;
wire valid_weight_out_30_next; wire valid_weight_out_31_next; wire valid_weight_out_32_next;
wire valid_weight_out_33_next; wire valid_weight_out_34_next; wire valid_weight_out_35_next;
wire valid_weight_out_36_next; wire valid_weight_out_37_next; wire valid_weight_out_38_next;
wire valid_weight_out_39_next; wire valid_weight_out_40_next; wire valid_weight_out_41_next;
wire valid_weight_out_42_next; wire valid_weight_out_43_next; wire valid_weight_out_44_next;
wire valid_weight_out_45_next; wire valid_weight_out_46_next; wire valid_weight_out_47_next;
wire valid_weight_out_48_next;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff48 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_in                ),
	.in       (in                      ),
	.out      (weight_out_48_next      ),
	.valid_out(valid_weight_out_48_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff47 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_48_next),
	.in       (weight_out_48_next      ),
	.out      (weight_out_47_next      ),
	.valid_out(valid_weight_out_47_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff46 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_47_next),
	.in       (weight_out_47_next      ),
	.out      (weight_out_46_next      ),
	.valid_out(valid_weight_out_46_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff45 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_46_next),
	.in       (weight_out_46_next      ),
	.out      (weight_out_45_next      ),
	.valid_out(valid_weight_out_45_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff44 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_45_next),
	.in       (weight_out_45_next      ),
	.out      (weight_out_44_next      ),
	.valid_out(valid_weight_out_44_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff43 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_44_next),
	.in       (weight_out_44_next      ),
	.out      (weight_out_43_next      ),
	.valid_out(valid_weight_out_43_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff42 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_43_next),
	.in       (weight_out_43_next      ),
	.out      (weight_out_42_next      ),
	.valid_out(valid_weight_out_42_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff41 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_42_next),
	.in       (weight_out_42_next      ),
	.out      (weight_out_41_next      ),
	.valid_out(valid_weight_out_41_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff40 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_41_next),
	.in       (weight_out_41_next      ),
	.out      (weight_out_40_next      ),
	.valid_out(valid_weight_out_40_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff39 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_40_next),
	.in       (weight_out_40_next      ),
	.out      (weight_out_39_next      ),
	.valid_out(valid_weight_out_39_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff38 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_39_next),
	.in       (weight_out_39_next      ),
	.out      (weight_out_38_next      ),
	.valid_out(valid_weight_out_38_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff37 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_38_next),
	.in       (weight_out_38_next      ),
	.out      (weight_out_37_next      ),
	.valid_out(valid_weight_out_37_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff36 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_37_next),
	.in       (weight_out_37_next      ),
	.out      (weight_out_36_next      ),
	.valid_out(valid_weight_out_36_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff35 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_36_next),
	.in       (weight_out_36_next      ),
	.out      (weight_out_35_next      ),
	.valid_out(valid_weight_out_35_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff34 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_35_next),
	.in       (weight_out_35_next      ),
	.out      (weight_out_34_next      ),
	.valid_out(valid_weight_out_34_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff33 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_34_next),
	.in       (weight_out_34_next      ),
	.out      (weight_out_33_next      ),
	.valid_out(valid_weight_out_33_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff32 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_33_next),
	.in       (weight_out_33_next      ),
	.out      (weight_out_32_next      ),
	.valid_out(valid_weight_out_32_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff31 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_32_next),
	.in       (weight_out_32_next      ),
	.out      (weight_out_31_next      ),
	.valid_out(valid_weight_out_31_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff30 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_31_next),
	.in       (weight_out_31_next      ),
	.out      (weight_out_30_next      ),
	.valid_out(valid_weight_out_30_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff29 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_30_next),
	.in       (weight_out_30_next      ),
	.out      (weight_out_29_next      ),
	.valid_out(valid_weight_out_29_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff28 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_29_next),
	.in       (weight_out_29_next      ),
	.out      (weight_out_28_next      ),
	.valid_out(valid_weight_out_28_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff27 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_28_next),
	.in       (weight_out_28_next      ),
	.out      (weight_out_27_next      ),
	.valid_out(valid_weight_out_27_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff26 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_27_next),
	.in       (weight_out_27_next      ),
	.out      (weight_out_26_next      ),
	.valid_out(valid_weight_out_26_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff25 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_26_next),
	.in       (weight_out_26_next      ),
	.out      (weight_out_25_next      ),
	.valid_out(valid_weight_out_25_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff24 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_25_next),
	.in       (weight_out_25_next      ),
	.out      (weight_out_24_next      ),
	.valid_out(valid_weight_out_24_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff23 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_24_next),
	.in       (weight_out_24_next      ),
	.out      (weight_out_23_next      ),
	.valid_out(valid_weight_out_23_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff22 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_23_next),
	.in       (weight_out_23_next      ),
	.out      (weight_out_22_next      ),
	.valid_out(valid_weight_out_22_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff21 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_22_next),
	.in       (weight_out_22_next      ),
	.out      (weight_out_21_next      ),
	.valid_out(valid_weight_out_21_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff20 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_21_next),
	.in       (weight_out_21_next      ),
	.out      (weight_out_20_next      ),
	.valid_out(valid_weight_out_20_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff19 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_20_next),
	.in       (weight_out_20_next      ),
	.out      (weight_out_19_next      ),
	.valid_out(valid_weight_out_19_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff18 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_19_next),
	.in       (weight_out_19_next      ),
	.out      (weight_out_18_next      ),
	.valid_out(valid_weight_out_18_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff17 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_18_next),
	.in       (weight_out_18_next      ),
	.out      (weight_out_17_next      ),
	.valid_out(valid_weight_out_17_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff16 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_17_next),
	.in       (weight_out_17_next      ),
	.out      (weight_out_16_next      ),
	.valid_out(valid_weight_out_16_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff15 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_16_next),
	.in       (weight_out_16_next      ),
	.out      (weight_out_15_next      ),
	.valid_out(valid_weight_out_15_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff14 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_15_next),
	.in       (weight_out_15_next      ),
	.out      (weight_out_14_next      ),
	.valid_out(valid_weight_out_14_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff13 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_14_next),
	.in       (weight_out_14_next      ),
	.out      (weight_out_13_next      ),
	.valid_out(valid_weight_out_13_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff12 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_13_next),
	.in       (weight_out_13_next      ),
	.out      (weight_out_12_next      ),
	.valid_out(valid_weight_out_12_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff11 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_12_next),
	.in       (weight_out_12_next      ),
	.out      (weight_out_11_next      ),
	.valid_out(valid_weight_out_11_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff10 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_11_next),
	.in       (weight_out_11_next      ),
	.out      (weight_out_10_next      ),
	.valid_out(valid_weight_out_10_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff99 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_10_next),
	.in       (weight_out_10_next      ),
	.out      (weight_out_09_next      ),
	.valid_out(valid_weight_out_09_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff88 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_09_next),
	.in       (weight_out_09_next      ),
	.out      (weight_out_08_next      ),
	.valid_out(valid_weight_out_08_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff77 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_08_next),
	.in       (weight_out_08_next      ),
	.out      (weight_out_07_next      ),
	.valid_out(valid_weight_out_07_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff66 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_07_next),
	.in       (weight_out_07_next      ),
	.out      (weight_out_06_next      ),
	.valid_out(valid_weight_out_06_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff55 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_06_next),
	.in       (weight_out_06_next      ),
	.out      (weight_out_05_next      ),
	.valid_out(valid_weight_out_05_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff444 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_05_next),
	.in       (weight_out_05_next      ),
	.out      (weight_out_04_next      ),
	.valid_out(valid_weight_out_04_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff333 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_04_next),
	.in       (weight_out_04_next      ),
	.out      (weight_out_03_next      ),
	.valid_out(valid_weight_out_03_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff222 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_03_next),
	.in       (weight_out_03_next      ),
	.out      (weight_out_02_next      ),
	.valid_out(valid_weight_out_02_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff111 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_02_next),
	.in       (weight_out_02_next      ),
	.out      (weight_out_01_next      ),
	.valid_out(valid_weight_out_01_next)
);

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff000 (
	.clk      (clk                     ),
	.reset    (reset                   ),
	.valid_in (valid_weight_out_01_next),
	.in       (weight_out_01_next      ),
	.out      (weight_out_00_next      ),
	.valid_out(valid_weight_out_00_next)
);

// FIFO
reg write_req;

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo48 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_48_next),
	//output
	.data_out(weight_out_48     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo47 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_47_next),
	//output
	.data_out(weight_out_47     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo46 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_46_next),
	//output
	.data_out(weight_out_46     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo45 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_45_next),
	//output
	.data_out(weight_out_45     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);


cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo44 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_44_next),
	//output
	.data_out(weight_out_44     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo43 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_43_next),
	//output
	.data_out(weight_out_43     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo42 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_42_next),
	//output
	.data_out(weight_out_42     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo41 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_41_next),
	//output
	.data_out(weight_out_41     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo40 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_40_next),
	//output
	.data_out(weight_out_40     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo39 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_39_next),
	//output
	.data_out(weight_out_39     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo38 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_38_next),
	//output
	.data_out(weight_out_38     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo37 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_37_next),
	//output
	.data_out(weight_out_37     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo36 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_36_next),
	//output
	.data_out(weight_out_36     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo35 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_35_next),
	//output
	.data_out(weight_out_35     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);


cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo34 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_34_next),
	//output
	.data_out(weight_out_34     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo33 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_33_next),
	//output
	.data_out(weight_out_33     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo32 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_32_next),
	//output
	.data_out(weight_out_32     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo31 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_31_next),
	//output
	.data_out(weight_out_31     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo30 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_30_next),
	//output
	.data_out(weight_out_30     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo29 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_29_next),
	//output
	.data_out(weight_out_29     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo28 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_28_next),
	//output
	.data_out(weight_out_28     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo27 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_27_next),
	//output
	.data_out(weight_out_27     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo26 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_26_next),
	//output
	.data_out(weight_out_26     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo25 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_25_next),
	//output
	.data_out(weight_out_25     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);


cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo24 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_24_next),
	//output
	.data_out(weight_out_24     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo23 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_23_next),
	//output
	.data_out(weight_out_23     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo22 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_22_next),
	//output
	.data_out(weight_out_22     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo21 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_21_next),
	//output
	.data_out(weight_out_21     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo20 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_20_next),
	//output
	.data_out(weight_out_20     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo19 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_19_next),
	//output
	.data_out(weight_out_19     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo18 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_18_next),
	//output
	.data_out(weight_out_18     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo17 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_17_next),
	//output
	.data_out(weight_out_17     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo16 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_16_next),
	//output
	.data_out(weight_out_16     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo15 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_15_next),
	//output
	.data_out(weight_out_15     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);


cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo14 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_14_next),
	//output
	.data_out(weight_out_14     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo13 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_13_next),
	//output
	.data_out(weight_out_13     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo12 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_12_next),
	//output
	.data_out(weight_out_12     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo11 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_11_next),
	//output
	.data_out(weight_out_11     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo10 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_10_next),
	//output
	.data_out(weight_out_10     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo09 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_09_next),
	//output
	.data_out(weight_out_09     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo08 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_08_next),
	//output
	.data_out(weight_out_08     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo07 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_07_next),
	//output
	.data_out(weight_out_07     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo06 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_06_next),
	//output
	.data_out(weight_out_06     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo05 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_05_next),
	//output
	.data_out(weight_out_05     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);


cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo04 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_04_next),
	//output
	.data_out(weight_out_04     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo03 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_03_next),
	//output
	.data_out(weight_out_03     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo02 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_02_next),
	//output
	.data_out(weight_out_02     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo01 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_01_next),
	//output
	.data_out(weight_out_01     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

cnn_fifo #(
	.DATA_WIDTH   (DATA_WIDTH                  ),
	.DATA_DEPTH   (WEIGHT_NUM                  ),
	.POINTER_WIDTH(POINTER_WIDTH_BUFFER_WEIGHTS)
) inst_fifo00 (
	//input
	.clk     (clk               ),
	.reset   (reset             ),
	.write   (write_req         ),
	.read    (load_weights      ),
	.data_in (weight_out_00_next),
	//output
	.data_out(weight_out_00     ),
	.full    (/*no use*/        ),
	.empty   (/*no use*/        )
);

reg [CNT_WIDTH_BUFFER_WEIGHTS-1:0] counter_weights;

always @(posedge clk) begin
	if(reset) begin
		counter_weights <= {CNT_WIDTH_BUFFER_WEIGHTS{1'b0}};
		write_req       <= 1'b0;
	end
	else if (valid_weight_out_01_next && counter_weights <= KERNEL_SIZE - 2) begin
		counter_weights <= counter_weights + 1'b1;
		if (!(|counter_weights))begin
			write_req <= 1'b1;
		end
		else begin
			write_req <= 1'b0;
		end
	end
	else begin
		counter_weights <= {CNT_WIDTH_BUFFER_WEIGHTS{1'b0}};
	end
end

// DFF
always @(posedge clk) begin
	if(reset) begin
		valid_out <= 1'b0;
	end
	else if (load_weights) begin
		valid_out <= 1'b1;
	end
end
endmodule