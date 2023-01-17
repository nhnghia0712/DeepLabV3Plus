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

module conv_7x7_core (
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
pxl_in_09,
pxl_in_10,
pxl_in_11,
pxl_in_12,
pxl_in_13,
pxl_in_14,
pxl_in_15,
pxl_in_16,
pxl_in_17,
pxl_in_18,
pxl_in_19,
pxl_in_20,
pxl_in_21,
pxl_in_22,
pxl_in_23,
pxl_in_24,
pxl_in_25,
pxl_in_26,
pxl_in_27,
pxl_in_28,
pxl_in_29,
pxl_in_30,
pxl_in_31,
pxl_in_32,
pxl_in_33,
pxl_in_34,
pxl_in_35,
pxl_in_36,
pxl_in_37,
pxl_in_38,
pxl_in_39,
pxl_in_40,
pxl_in_41,
pxl_in_42,
pxl_in_43,
pxl_in_44,
pxl_in_45,
pxl_in_46,
pxl_in_47,
pxl_in_48,
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
weight_in_09,
weight_in_10,
weight_in_11,
weight_in_12,
weight_in_13,
weight_in_14,
weight_in_15,
weight_in_16,
weight_in_17,
weight_in_18,
weight_in_19,
weight_in_20,
weight_in_21,
weight_in_22,
weight_in_23,
weight_in_24,
weight_in_25,
weight_in_26,
weight_in_27,
weight_in_28,
weight_in_29,
weight_in_30,
weight_in_31,
weight_in_32,
weight_in_33,
weight_in_34,
weight_in_35,
weight_in_36,
weight_in_37,
weight_in_38,
weight_in_39,
weight_in_40,
weight_in_41,
weight_in_42,
weight_in_43,
weight_in_44,
weight_in_45,
weight_in_46,
weight_in_47,
weight_in_48,

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
input [DATA_WIDTH-1:0] pxl_in_09;
input [DATA_WIDTH-1:0] pxl_in_10;
input [DATA_WIDTH-1:0] pxl_in_11;
input [DATA_WIDTH-1:0] pxl_in_12;
input [DATA_WIDTH-1:0] pxl_in_13;
input [DATA_WIDTH-1:0] pxl_in_14;
input [DATA_WIDTH-1:0] pxl_in_15;
input [DATA_WIDTH-1:0] pxl_in_16;
input [DATA_WIDTH-1:0] pxl_in_17;
input [DATA_WIDTH-1:0] pxl_in_18;
input [DATA_WIDTH-1:0] pxl_in_19;
input [DATA_WIDTH-1:0] pxl_in_20;
input [DATA_WIDTH-1:0] pxl_in_21;
input [DATA_WIDTH-1:0] pxl_in_22;
input [DATA_WIDTH-1:0] pxl_in_23;
input [DATA_WIDTH-1:0] pxl_in_24;
input [DATA_WIDTH-1:0] pxl_in_25;
input [DATA_WIDTH-1:0] pxl_in_26;
input [DATA_WIDTH-1:0] pxl_in_27;
input [DATA_WIDTH-1:0] pxl_in_28;
input [DATA_WIDTH-1:0] pxl_in_29;
input [DATA_WIDTH-1:0] pxl_in_30;
input [DATA_WIDTH-1:0] pxl_in_31;
input [DATA_WIDTH-1:0] pxl_in_32;
input [DATA_WIDTH-1:0] pxl_in_33;
input [DATA_WIDTH-1:0] pxl_in_34;
input [DATA_WIDTH-1:0] pxl_in_35;
input [DATA_WIDTH-1:0] pxl_in_36;
input [DATA_WIDTH-1:0] pxl_in_37;
input [DATA_WIDTH-1:0] pxl_in_38;
input [DATA_WIDTH-1:0] pxl_in_39;
input [DATA_WIDTH-1:0] pxl_in_40;
input [DATA_WIDTH-1:0] pxl_in_41;
input [DATA_WIDTH-1:0] pxl_in_42;
input [DATA_WIDTH-1:0] pxl_in_43;
input [DATA_WIDTH-1:0] pxl_in_44;
input [DATA_WIDTH-1:0] pxl_in_45;
input [DATA_WIDTH-1:0] pxl_in_46;
input [DATA_WIDTH-1:0] pxl_in_47;
input [DATA_WIDTH-1:0] pxl_in_48;
//weights
input [DATA_WIDTH-1:0] weight_in_00; input [DATA_WIDTH-1:0] weight_in_01; input [DATA_WIDTH-1:0] weight_in_02;
input [DATA_WIDTH-1:0] weight_in_03; input [DATA_WIDTH-1:0] weight_in_04; input [DATA_WIDTH-1:0] weight_in_05;
input [DATA_WIDTH-1:0] weight_in_06; input [DATA_WIDTH-1:0] weight_in_07; input [DATA_WIDTH-1:0] weight_in_08;
input [DATA_WIDTH-1:0] weight_in_09; input [DATA_WIDTH-1:0] weight_in_10; input [DATA_WIDTH-1:0] weight_in_11;
input [DATA_WIDTH-1:0] weight_in_12; input [DATA_WIDTH-1:0] weight_in_13; input [DATA_WIDTH-1:0] weight_in_14;
input [DATA_WIDTH-1:0] weight_in_15; input [DATA_WIDTH-1:0] weight_in_16; input [DATA_WIDTH-1:0] weight_in_17;
input [DATA_WIDTH-1:0] weight_in_18; input [DATA_WIDTH-1:0] weight_in_19; input [DATA_WIDTH-1:0] weight_in_20;
input [DATA_WIDTH-1:0] weight_in_21; input [DATA_WIDTH-1:0] weight_in_22; input [DATA_WIDTH-1:0] weight_in_23;
input [DATA_WIDTH-1:0] weight_in_24; input [DATA_WIDTH-1:0] weight_in_25; input [DATA_WIDTH-1:0] weight_in_26;
input [DATA_WIDTH-1:0] weight_in_27; input [DATA_WIDTH-1:0] weight_in_28; input [DATA_WIDTH-1:0] weight_in_29;
input [DATA_WIDTH-1:0] weight_in_30; input [DATA_WIDTH-1:0] weight_in_31; input [DATA_WIDTH-1:0] weight_in_32;
input [DATA_WIDTH-1:0] weight_in_33; input [DATA_WIDTH-1:0] weight_in_34; input [DATA_WIDTH-1:0] weight_in_35;
input [DATA_WIDTH-1:0] weight_in_36; input [DATA_WIDTH-1:0] weight_in_37; input [DATA_WIDTH-1:0] weight_in_38;
input [DATA_WIDTH-1:0] weight_in_39; input [DATA_WIDTH-1:0] weight_in_40; input [DATA_WIDTH-1:0] weight_in_41;
input [DATA_WIDTH-1:0] weight_in_42; input [DATA_WIDTH-1:0] weight_in_43; input [DATA_WIDTH-1:0] weight_in_44;
input [DATA_WIDTH-1:0] weight_in_45; input [DATA_WIDTH-1:0] weight_in_46; input [DATA_WIDTH-1:0] weight_in_47;
input [DATA_WIDTH-1:0] weight_in_48;

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
wire [DATA_WIDTH-1:0] pxl_in_09;
wire [DATA_WIDTH-1:0] pxl_in_10;
wire [DATA_WIDTH-1:0] pxl_in_11;
wire [DATA_WIDTH-1:0] pxl_in_12;
wire [DATA_WIDTH-1:0] pxl_in_13;
wire [DATA_WIDTH-1:0] pxl_in_14;
wire [DATA_WIDTH-1:0] pxl_in_15;
wire [DATA_WIDTH-1:0] pxl_in_16;
wire [DATA_WIDTH-1:0] pxl_in_17;
wire [DATA_WIDTH-1:0] pxl_in_18;
wire [DATA_WIDTH-1:0] pxl_in_19;
wire [DATA_WIDTH-1:0] pxl_in_20;
wire [DATA_WIDTH-1:0] pxl_in_21;
wire [DATA_WIDTH-1:0] pxl_in_22;
wire [DATA_WIDTH-1:0] pxl_in_23;
wire [DATA_WIDTH-1:0] pxl_in_24;
wire [DATA_WIDTH-1:0] pxl_in_25;
wire [DATA_WIDTH-1:0] pxl_in_26;
wire [DATA_WIDTH-1:0] pxl_in_27;
wire [DATA_WIDTH-1:0] pxl_in_28;
wire [DATA_WIDTH-1:0] pxl_in_29;
wire [DATA_WIDTH-1:0] pxl_in_30;
wire [DATA_WIDTH-1:0] pxl_in_31;
wire [DATA_WIDTH-1:0] pxl_in_32;
wire [DATA_WIDTH-1:0] pxl_in_33;
wire [DATA_WIDTH-1:0] pxl_in_34;
wire [DATA_WIDTH-1:0] pxl_in_35;
wire [DATA_WIDTH-1:0] pxl_in_36;
wire [DATA_WIDTH-1:0] pxl_in_37;
wire [DATA_WIDTH-1:0] pxl_in_38;
wire [DATA_WIDTH-1:0] pxl_in_39;
wire [DATA_WIDTH-1:0] pxl_in_40;
wire [DATA_WIDTH-1:0] pxl_in_41;
wire [DATA_WIDTH-1:0] pxl_in_42;
wire [DATA_WIDTH-1:0] pxl_in_43;
wire [DATA_WIDTH-1:0] pxl_in_44;
wire [DATA_WIDTH-1:0] pxl_in_45;
wire [DATA_WIDTH-1:0] pxl_in_46;
wire [DATA_WIDTH-1:0] pxl_in_47;
wire [DATA_WIDTH-1:0] pxl_in_48;

//weights
wire [DATA_WIDTH-1:0] weight_in_00; wire [DATA_WIDTH-1:0] weight_in_01; wire [DATA_WIDTH-1:0] weight_in_02;
wire [DATA_WIDTH-1:0] weight_in_03; wire [DATA_WIDTH-1:0] weight_in_04; wire [DATA_WIDTH-1:0] weight_in_05;
wire [DATA_WIDTH-1:0] weight_in_06; wire [DATA_WIDTH-1:0] weight_in_07; wire [DATA_WIDTH-1:0] weight_in_08;
wire [DATA_WIDTH-1:0] weight_in_09; wire [DATA_WIDTH-1:0] weight_in_10; wire [DATA_WIDTH-1:0] weight_in_11;
wire [DATA_WIDTH-1:0] weight_in_12; wire [DATA_WIDTH-1:0] weight_in_13; wire [DATA_WIDTH-1:0] weight_in_14;
wire [DATA_WIDTH-1:0] weight_in_15; wire [DATA_WIDTH-1:0] weight_in_16; wire [DATA_WIDTH-1:0] weight_in_17;
wire [DATA_WIDTH-1:0] weight_in_18; wire [DATA_WIDTH-1:0] weight_in_19; wire [DATA_WIDTH-1:0] weight_in_20;
wire [DATA_WIDTH-1:0] weight_in_21; wire [DATA_WIDTH-1:0] weight_in_22; wire [DATA_WIDTH-1:0] weight_in_23;
wire [DATA_WIDTH-1:0] weight_in_24; wire [DATA_WIDTH-1:0] weight_in_25; wire [DATA_WIDTH-1:0] weight_in_26;
wire [DATA_WIDTH-1:0] weight_in_27; wire [DATA_WIDTH-1:0] weight_in_28; wire [DATA_WIDTH-1:0] weight_in_29;
wire [DATA_WIDTH-1:0] weight_in_30; wire [DATA_WIDTH-1:0] weight_in_31; wire [DATA_WIDTH-1:0] weight_in_32;
wire [DATA_WIDTH-1:0] weight_in_33; wire [DATA_WIDTH-1:0] weight_in_34; wire [DATA_WIDTH-1:0] weight_in_35;
wire [DATA_WIDTH-1:0] weight_in_36; wire [DATA_WIDTH-1:0] weight_in_37; wire [DATA_WIDTH-1:0] weight_in_38;
wire [DATA_WIDTH-1:0] weight_in_39; wire [DATA_WIDTH-1:0] weight_in_40; wire [DATA_WIDTH-1:0] weight_in_41;
wire [DATA_WIDTH-1:0] weight_in_42; wire [DATA_WIDTH-1:0] weight_in_43; wire [DATA_WIDTH-1:0] weight_in_44;
wire [DATA_WIDTH-1:0] weight_in_45; wire [DATA_WIDTH-1:0] weight_in_46; wire [DATA_WIDTH-1:0] weight_in_47;
wire [DATA_WIDTH-1:0] weight_in_48;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

//Multiple
wire [DATA_WIDTH-1:0] out_mul_48; wire [DATA_WIDTH-1:0] out_mul_47; wire [DATA_WIDTH-1:0] out_mul_46;
wire [DATA_WIDTH-1:0] out_mul_45; wire [DATA_WIDTH-1:0] out_mul_44; wire [DATA_WIDTH-1:0] out_mul_43;
wire [DATA_WIDTH-1:0] out_mul_42; wire [DATA_WIDTH-1:0] out_mul_41; wire [DATA_WIDTH-1:0] out_mul_40;
wire [DATA_WIDTH-1:0] out_mul_39;
wire [DATA_WIDTH-1:0] out_mul_38; wire [DATA_WIDTH-1:0] out_mul_37; wire [DATA_WIDTH-1:0] out_mul_36;
wire [DATA_WIDTH-1:0] out_mul_35; wire [DATA_WIDTH-1:0] out_mul_34; wire [DATA_WIDTH-1:0] out_mul_33;
wire [DATA_WIDTH-1:0] out_mul_32; wire [DATA_WIDTH-1:0] out_mul_31; wire [DATA_WIDTH-1:0] out_mul_30;
wire [DATA_WIDTH-1:0] out_mul_29;
wire [DATA_WIDTH-1:0] out_mul_28; wire [DATA_WIDTH-1:0] out_mul_27; wire [DATA_WIDTH-1:0] out_mul_26;
wire [DATA_WIDTH-1:0] out_mul_25; wire [DATA_WIDTH-1:0] out_mul_24; wire [DATA_WIDTH-1:0] out_mul_23;
wire [DATA_WIDTH-1:0] out_mul_22; wire [DATA_WIDTH-1:0] out_mul_21; wire [DATA_WIDTH-1:0] out_mul_20;
wire [DATA_WIDTH-1:0] out_mul_19;
wire [DATA_WIDTH-1:0] out_mul_18; wire [DATA_WIDTH-1:0] out_mul_17; wire [DATA_WIDTH-1:0] out_mul_16;
wire [DATA_WIDTH-1:0] out_mul_15; wire [DATA_WIDTH-1:0] out_mul_14; wire [DATA_WIDTH-1:0] out_mul_13;
wire [DATA_WIDTH-1:0] out_mul_12; wire [DATA_WIDTH-1:0] out_mul_11; wire [DATA_WIDTH-1:0] out_mul_10;
wire [DATA_WIDTH-1:0] out_mul_09;
wire [DATA_WIDTH-1:0] out_mul_08; wire [DATA_WIDTH-1:0] out_mul_07; wire [DATA_WIDTH-1:0] out_mul_06;
wire [DATA_WIDTH-1:0] out_mul_05; wire [DATA_WIDTH-1:0] out_mul_04; wire [DATA_WIDTH-1:0] out_mul_03;
wire [DATA_WIDTH-1:0] out_mul_02; wire [DATA_WIDTH-1:0] out_mul_01; wire [DATA_WIDTH-1:0] out_mul_00;

wire valid_out_mul_48; wire valid_out_mul_47; wire valid_out_mul_46;
wire valid_out_mul_45; wire valid_out_mul_44; wire valid_out_mul_43;
wire valid_out_mul_42; wire valid_out_mul_41; wire valid_out_mul_40;
wire valid_out_mul_39;
wire valid_out_mul_38; wire valid_out_mul_37; wire valid_out_mul_36;
wire valid_out_mul_35; wire valid_out_mul_34; wire valid_out_mul_33;
wire valid_out_mul_32; wire valid_out_mul_31; wire valid_out_mul_30;
wire valid_out_mul_29;
wire valid_out_mul_28; wire valid_out_mul_27; wire valid_out_mul_26;
wire valid_out_mul_25; wire valid_out_mul_24; wire valid_out_mul_23;
wire valid_out_mul_22; wire valid_out_mul_21; wire valid_out_mul_20;
wire valid_out_mul_19;
wire valid_out_mul_18; wire valid_out_mul_17; wire valid_out_mul_16;
wire valid_out_mul_15; wire valid_out_mul_14; wire valid_out_mul_13;
wire valid_out_mul_12; wire valid_out_mul_11; wire valid_out_mul_10;
wire valid_out_mul_09;
wire valid_out_mul_08; wire valid_out_mul_07; wire valid_out_mul_06;
wire valid_out_mul_05; wire valid_out_mul_04; wire valid_out_mul_03;
wire valid_out_mul_02; wire valid_out_mul_01; wire valid_out_mul_00;


fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_48 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_48       ),
  .in_b     (weight_in_48    ),
  .out      (out_mul_48      ),
  .valid_out(valid_out_mul_48)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_47 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_47       ),
  .in_b     (weight_in_47    ),
  .out      (out_mul_47      ),
  .valid_out(valid_out_mul_47)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_46 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_46       ),
  .in_b     (weight_in_46    ),
  .out      (out_mul_46      ),
  .valid_out(valid_out_mul_46)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_45 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_45       ),
  .in_b     (weight_in_45    ),
  .out      (out_mul_45      ),
  .valid_out(valid_out_mul_45)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_44 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_44       ),
  .in_b     (weight_in_44    ),
  .out      (out_mul_44      ),
  .valid_out(valid_out_mul_44)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_43 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_43       ),
  .in_b     (weight_in_43    ),
  .out      (out_mul_43      ),
  .valid_out(valid_out_mul_43)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_42 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_42       ),
  .in_b     (weight_in_42    ),
  .out      (out_mul_42      ),
  .valid_out(valid_out_mul_42)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_41 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_41       ),
  .in_b     (weight_in_41    ),
  .out      (out_mul_41      ),
  .valid_out(valid_out_mul_41)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_40 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_40       ),
  .in_b     (weight_in_40    ),
  .out      (out_mul_40      ),
  .valid_out(valid_out_mul_40)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_39 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_39       ),
  .in_b     (weight_in_39    ),
  .out      (out_mul_39      ),
  .valid_out(valid_out_mul_39)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_38 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_38       ),
  .in_b     (weight_in_38    ),
  .out      (out_mul_38      ),
  .valid_out(valid_out_mul_38)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_37 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_37       ),
  .in_b     (weight_in_37    ),
  .out      (out_mul_37      ),
  .valid_out(valid_out_mul_37)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_36 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_36       ),
  .in_b     (weight_in_36    ),
  .out      (out_mul_36      ),
  .valid_out(valid_out_mul_36)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_35 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_35       ),
  .in_b     (weight_in_35    ),
  .out      (out_mul_35      ),
  .valid_out(valid_out_mul_35)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_34 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_34       ),
  .in_b     (weight_in_34    ),
  .out      (out_mul_34      ),
  .valid_out(valid_out_mul_34)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_33 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_33       ),
  .in_b     (weight_in_33    ),
  .out      (out_mul_33      ),
  .valid_out(valid_out_mul_33)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_32 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_32       ),
  .in_b     (weight_in_32    ),
  .out      (out_mul_32      ),
  .valid_out(valid_out_mul_32)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_31 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_31       ),
  .in_b     (weight_in_31    ),
  .out      (out_mul_31      ),
  .valid_out(valid_out_mul_31)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_30 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_30       ),
  .in_b     (weight_in_30    ),
  .out      (out_mul_30      ),
  .valid_out(valid_out_mul_30)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_29 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_29       ),
  .in_b     (weight_in_29    ),
  .out      (out_mul_29      ),
  .valid_out(valid_out_mul_29)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_28 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_28       ),
  .in_b     (weight_in_28    ),
  .out      (out_mul_28      ),
  .valid_out(valid_out_mul_28)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_27 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_27       ),
  .in_b     (weight_in_27    ),
  .out      (out_mul_27      ),
  .valid_out(valid_out_mul_27)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_26 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_26       ),
  .in_b     (weight_in_26    ),
  .out      (out_mul_26      ),
  .valid_out(valid_out_mul_26)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_25 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_25       ),
  .in_b     (weight_in_25    ),
  .out      (out_mul_25      ),
  .valid_out(valid_out_mul_25)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_24 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_24       ),
  .in_b     (weight_in_24    ),
  .out      (out_mul_24      ),
  .valid_out(valid_out_mul_24)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_23 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_23       ),
  .in_b     (weight_in_23    ),
  .out      (out_mul_23      ),
  .valid_out(valid_out_mul_23)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_22 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_22       ),
  .in_b     (weight_in_22    ),
  .out      (out_mul_22      ),
  .valid_out(valid_out_mul_22)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_21 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_21       ),
  .in_b     (weight_in_21    ),
  .out      (out_mul_21      ),
  .valid_out(valid_out_mul_21)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_20 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_20       ),
  .in_b     (weight_in_20    ),
  .out      (out_mul_20      ),
  .valid_out(valid_out_mul_20)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_19 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_19       ),
  .in_b     (weight_in_19    ),
  .out      (out_mul_19      ),
  .valid_out(valid_out_mul_19)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_18 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_18       ),
  .in_b     (weight_in_18    ),
  .out      (out_mul_18      ),
  .valid_out(valid_out_mul_18)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_17 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_17       ),
  .in_b     (weight_in_17    ),
  .out      (out_mul_17      ),
  .valid_out(valid_out_mul_17)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_16 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_16       ),
  .in_b     (weight_in_16    ),
  .out      (out_mul_16      ),
  .valid_out(valid_out_mul_16)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_15 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_15       ),
  .in_b     (weight_in_15    ),
  .out      (out_mul_15      ),
  .valid_out(valid_out_mul_15)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_14 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_14       ),
  .in_b     (weight_in_14    ),
  .out      (out_mul_14      ),
  .valid_out(valid_out_mul_14)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_13 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_13       ),
  .in_b     (weight_in_13    ),
  .out      (out_mul_13      ),
  .valid_out(valid_out_mul_13)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_12 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_12       ),
  .in_b     (weight_in_12    ),
  .out      (out_mul_12      ),
  .valid_out(valid_out_mul_12)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_11 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_11       ),
  .in_b     (weight_in_11    ),
  .out      (out_mul_11      ),
  .valid_out(valid_out_mul_11)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_10 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_10       ),
  .in_b     (weight_in_10    ),
  .out      (out_mul_10      ),
  .valid_out(valid_out_mul_10)
);

fp_mul #(.DATA_WIDTH(DATA_WIDTH)) inst_mul_09 (
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_09       ),
  .in_b     (weight_in_09    ),
  .out      (out_mul_09      ),
  .valid_out(valid_out_mul_09)
);

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
  .reset    (reset           ),
  .clk      (clk             ),
  .valid_in (valid_in        ),
  .in_a     (pxl_in_00       ),
  .in_b     (weight_in_00    ),
  .out      (out_mul_00      ),
  .valid_out(valid_out_mul_00)
);

// Line buffer for Mul 00
wire [DATA_WIDTH-1:0] out_line_buffer_00      ;
wire                  valid_out_line_buffer_00;

line_buffer #(
  .IMAGE_WIDTH(36        ),
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
wire [DATA_WIDTH-1:0] out_add_48_47;
wire [DATA_WIDTH-1:0] out_add_46_45;
wire [DATA_WIDTH-1:0] out_add_44_43;
wire [DATA_WIDTH-1:0] out_add_42_41;
wire [DATA_WIDTH-1:0] out_add_40_39;
wire [DATA_WIDTH-1:0] out_add_38_37;
wire [DATA_WIDTH-1:0] out_add_36_35;
wire [DATA_WIDTH-1:0] out_add_34_33;
wire [DATA_WIDTH-1:0] out_add_32_31;
wire [DATA_WIDTH-1:0] out_add_30_29;
wire [DATA_WIDTH-1:0] out_add_28_27;
wire [DATA_WIDTH-1:0] out_add_26_25;
wire [DATA_WIDTH-1:0] out_add_24_23;
wire [DATA_WIDTH-1:0] out_add_22_21;
wire [DATA_WIDTH-1:0] out_add_20_19;
wire [DATA_WIDTH-1:0] out_add_18_17;
wire [DATA_WIDTH-1:0] out_add_16_15;
wire [DATA_WIDTH-1:0] out_add_14_13;
wire [DATA_WIDTH-1:0] out_add_12_11;
wire [DATA_WIDTH-1:0] out_add_10_09;
wire [DATA_WIDTH-1:0] out_add_08_07;
wire [DATA_WIDTH-1:0] out_add_06_05;
wire [DATA_WIDTH-1:0] out_add_04_03;
wire [DATA_WIDTH-1:0] out_add_02_01;

wire valid_out_add_48_47;
wire valid_out_add_46_45;
wire valid_out_add_44_43;
wire valid_out_add_42_41;
wire valid_out_add_40_39;
wire valid_out_add_38_37;
wire valid_out_add_36_35;
wire valid_out_add_34_33;
wire valid_out_add_32_31;
wire valid_out_add_30_29;
wire valid_out_add_28_27;
wire valid_out_add_26_25;
wire valid_out_add_24_23;
wire valid_out_add_22_21;
wire valid_out_add_20_19;
wire valid_out_add_18_17;
wire valid_out_add_16_15;
wire valid_out_add_14_13;
wire valid_out_add_12_11;
wire valid_out_add_10_09;
wire valid_out_add_08_07;
wire valid_out_add_06_05;
wire valid_out_add_04_03;
wire valid_out_add_02_01;

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_48_47 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_48 & valid_out_mul_48),
  .in_a     (out_mul_48                         ),
  .in_b     (out_mul_47                         ),
  .out      (out_add_48_47                      ),
  .valid_out(valid_out_add_48_47                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_46_45 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_46 & valid_out_mul_45),
  .in_a     (out_mul_46                         ),
  .in_b     (out_mul_45                         ),
  .out      (out_add_46_45                      ),
  .valid_out(valid_out_add_46_45                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_44_43 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_44 & valid_out_mul_43),
  .in_a     (out_mul_44                         ),
  .in_b     (out_mul_43                         ),
  .out      (out_add_44_43                      ),
  .valid_out(valid_out_add_44_43                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_42_41 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_42 & valid_out_mul_41),
  .in_a     (out_mul_42                         ),
  .in_b     (out_mul_41                         ),
  .out      (out_add_42_41                      ),
  .valid_out(valid_out_add_42_41                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_40_39 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_40 & valid_out_mul_39),
  .in_a     (out_mul_40                         ),
  .in_b     (out_mul_39                         ),
  .out      (out_add_40_39                      ),
  .valid_out(valid_out_add_40_39                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_38_37 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_38 & valid_out_mul_38),
  .in_a     (out_mul_38                         ),
  .in_b     (out_mul_37                         ),
  .out      (out_add_38_37                      ),
  .valid_out(valid_out_add_38_37                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_36_35 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_36 & valid_out_mul_35),
  .in_a     (out_mul_36                         ),
  .in_b     (out_mul_35                         ),
  .out      (out_add_36_35                      ),
  .valid_out(valid_out_add_36_35                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_34_33 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_34 & valid_out_mul_33),
  .in_a     (out_mul_34                         ),
  .in_b     (out_mul_33                         ),
  .out      (out_add_34_33                      ),
  .valid_out(valid_out_add_34_33                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_32_31 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_32 & valid_out_mul_31),
  .in_a     (out_mul_32                         ),
  .in_b     (out_mul_31                         ),
  .out      (out_add_32_31                      ),
  .valid_out(valid_out_add_32_31                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_30_29 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_30 & valid_out_mul_29),
  .in_a     (out_mul_30                         ),
  .in_b     (out_mul_29                         ),
  .out      (out_add_30_29                      ),
  .valid_out(valid_out_add_30_29                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_28_27 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_28 & valid_out_mul_28),
  .in_a     (out_mul_28                         ),
  .in_b     (out_mul_27                         ),
  .out      (out_add_28_27                      ),
  .valid_out(valid_out_add_28_27                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_26_25 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_26 & valid_out_mul_25),
  .in_a     (out_mul_26                         ),
  .in_b     (out_mul_25                         ),
  .out      (out_add_26_25                      ),
  .valid_out(valid_out_add_26_25                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_24_23 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_24 & valid_out_mul_23),
  .in_a     (out_mul_24                         ),
  .in_b     (out_mul_23                         ),
  .out      (out_add_24_23                      ),
  .valid_out(valid_out_add_24_23                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_22_21 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_22 & valid_out_mul_21),
  .in_a     (out_mul_22                         ),
  .in_b     (out_mul_21                         ),
  .out      (out_add_22_21                      ),
  .valid_out(valid_out_add_22_21                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_20_19 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_20 & valid_out_mul_19),
  .in_a     (out_mul_20                         ),
  .in_b     (out_mul_19                         ),
  .out      (out_add_20_19                      ),
  .valid_out(valid_out_add_20_19                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_18_17 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_18 & valid_out_mul_18),
  .in_a     (out_mul_18                         ),
  .in_b     (out_mul_17                         ),
  .out      (out_add_18_17                      ),
  .valid_out(valid_out_add_18_17                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_16_15 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_16 & valid_out_mul_15),
  .in_a     (out_mul_16                         ),
  .in_b     (out_mul_15                         ),
  .out      (out_add_16_15                      ),
  .valid_out(valid_out_add_16_15                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_14_13 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_14 & valid_out_mul_13),
  .in_a     (out_mul_14                         ),
  .in_b     (out_mul_13                         ),
  .out      (out_add_14_13                      ),
  .valid_out(valid_out_add_14_13                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_12_11 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_12 & valid_out_mul_11),
  .in_a     (out_mul_12                         ),
  .in_b     (out_mul_11                         ),
  .out      (out_add_12_11                      ),
  .valid_out(valid_out_add_12_11                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_10_09 (
  .reset    (reset                              ),
  .clk      (clk                                ),
  .valid_in (valid_out_mul_10 & valid_out_mul_09),
  .in_a     (out_mul_10                         ),
  .in_b     (out_mul_09                         ),
  .out      (out_add_10_09                      ),
  .valid_out(valid_out_add_10_09                )
);

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

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_add_48_47_46_45;
wire [DATA_WIDTH-1:0] out_add_44_43_42_41;
wire [DATA_WIDTH-1:0] out_add_38_37_36_35;
wire [DATA_WIDTH-1:0] out_add_34_33_32_31;
wire [DATA_WIDTH-1:0] out_add_28_27_26_25;
wire [DATA_WIDTH-1:0] out_add_24_23_22_21;
wire [DATA_WIDTH-1:0] out_add_18_17_16_15;
wire [DATA_WIDTH-1:0] out_add_14_13_12_11;
wire [DATA_WIDTH-1:0] out_add_08_07_06_05;
wire [DATA_WIDTH-1:0] out_add_04_03_02_01;

wire [DATA_WIDTH-1:0] out_add_20_19_10_09;
wire [DATA_WIDTH-1:0] out_add_40_39_30_29;


wire valid_out_add_48_47_46_45;
wire valid_out_add_44_43_42_41;
wire valid_out_add_38_37_36_35;
wire valid_out_add_34_33_32_31;
wire valid_out_add_28_27_26_25;
wire valid_out_add_24_23_22_21;
wire valid_out_add_18_17_16_15;
wire valid_out_add_14_13_12_11;
wire valid_out_add_08_07_06_05;
wire valid_out_add_04_03_02_01;

wire valid_out_add_20_19_10_09;
wire valid_out_add_40_39_30_29;

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_40_39_30_29 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_40_39 & valid_out_add_30_29),
  .in_a     (out_add_40_39                            ),
  .in_b     (out_add_30_29                           ),
  .out      (out_add_40_39_30_29                      ),
  .valid_out(valid_out_add_40_39_30_29                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_20_19_10_09 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_20_19 & valid_out_add_10_09),
  .in_a     (out_add_20_19                            ),
  .in_b     (out_add_10_09                           ),
  .out      (out_add_20_19_10_09                      ),
  .valid_out(valid_out_add_20_19_10_09                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_48_47_46_45 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_48_47 & valid_out_add_46_45),
  .in_a     (out_add_48_47                            ),
  .in_b     (out_add_46_45                            ),
  .out      (out_add_48_47_46_45                      ),
  .valid_out(valid_out_add_48_47_46_45                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_44_43_42_41 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_44_43 & valid_out_add_42_41),
  .in_a     (out_add_44_43                            ),
  .in_b     (out_add_42_41                            ),
  .out      (out_add_44_43_42_41                      ),
  .valid_out(valid_out_add_44_43_42_41                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_38_37_36_35 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_38_37 & valid_out_add_36_35),
  .in_a     (out_add_38_37                            ),
  .in_b     (out_add_36_35                            ),
  .out      (out_add_38_37_36_35                      ),
  .valid_out(valid_out_add_38_37_36_35                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_34_33_32_31 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_34_33 & valid_out_add_32_31),
  .in_a     (out_add_34_33                            ),
  .in_b     (out_add_32_31                            ),
  .out      (out_add_34_33_32_31                      ),
  .valid_out(valid_out_add_34_33_32_31                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_28_27_26_25 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_28_27 & valid_out_add_26_25),
  .in_a     (out_add_28_27                            ),
  .in_b     (out_add_26_25                            ),
  .out      (out_add_28_27_26_25                      ),
  .valid_out(valid_out_add_28_27_26_25                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_24_23_22_21 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_24_23 & valid_out_add_22_21),
  .in_a     (out_add_24_23                            ),
  .in_b     (out_add_22_21                            ),
  .out      (out_add_24_23_22_21                      ),
  .valid_out(valid_out_add_24_23_22_21                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_18_17_16_15 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_18_17 & valid_out_add_16_15),
  .in_a     (out_add_18_17                            ),
  .in_b     (out_add_16_15                            ),
  .out      (out_add_18_17_16_15                      ),
  .valid_out(valid_out_add_18_17_16_15                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_14_13_12_11 (
  .reset    (reset                                    ),
  .clk      (clk                                      ),
  .valid_in (valid_out_add_14_13 & valid_out_add_12_11),
  .in_a     (out_add_14_13                            ),
  .in_b     (out_add_12_11                            ),
  .out      (out_add_14_13_12_11                      ),
  .valid_out(valid_out_add_14_13_12_11                )
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

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_add_08_07_06_05_04_03_02_01;
wire [DATA_WIDTH-1:0] out_add_18_17_16_15_14_13_12_11;
wire [DATA_WIDTH-1:0] out_add_28_27_26_25_24_23_22_21;
wire [DATA_WIDTH-1:0] out_add_38_37_36_35_34_33_32_31;
wire [DATA_WIDTH-1:0] out_add_48_47_46_45_44_43_42_41;

wire [DATA_WIDTH-1:0] out_add_40_39_30_29_20_19_10_09;

wire valid_out_add_08_07_06_05_04_03_02_01;
wire valid_out_add_18_17_16_15_14_13_12_11;
wire valid_out_add_28_27_26_25_24_23_22_21;
wire valid_out_add_38_37_36_35_34_33_32_31;
wire valid_out_add_48_47_46_45_44_43_42_41;

wire valid_out_add_40_39_30_29_20_19_10_09;

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_40_39_30_29_20_19_10_09 (
  .reset    (reset                                                ),
  .clk      (clk                                                  ),
  .valid_in (valid_out_add_40_39_30_29 & valid_out_add_20_19_10_09),
  .in_a     (out_add_40_39_30_29                                  ),
  .in_b     (out_add_20_19_10_09                                  ),
  .out      (out_add_40_39_30_29_20_19_10_09                      ),
  .valid_out(valid_out_add_40_39_30_29_20_19_10_09                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_48_47_46_45_44_43_42_41 (
  .reset    (reset                                                ),
  .clk      (clk                                                  ),
  .valid_in (valid_out_add_48_47_46_45 & valid_out_add_44_43_42_41),
  .in_a     (out_add_48_47_46_45                                  ),
  .in_b     (out_add_44_43_42_41                                  ),
  .out      (out_add_48_47_46_45_44_43_42_41                      ),
  .valid_out(valid_out_add_48_47_46_45_44_43_42_41                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_38_37_36_35_34_33_32_31 (
  .reset    (reset                                                ),
  .clk      (clk                                                  ),
  .valid_in (valid_out_add_38_37_36_35 & valid_out_add_34_33_32_31),
  .in_a     (out_add_38_37_36_35                                  ),
  .in_b     (out_add_34_33_32_31                                  ),
  .out      (out_add_38_37_36_35_34_33_32_31                      ),
  .valid_out(valid_out_add_38_37_36_35_34_33_32_31                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_28_27_26_25_24_23_22_21 (
  .reset    (reset                                                ),
  .clk      (clk                                                  ),
  .valid_in (valid_out_add_28_27_26_25 & valid_out_add_24_23_22_21),
  .in_a     (out_add_28_27_26_25                                  ),
  .in_b     (out_add_24_23_22_21                                  ),
  .out      (out_add_28_27_26_25_24_23_22_21                      ),
  .valid_out(valid_out_add_28_27_26_25_24_23_22_21                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_18_17_16_15_14_13_12_11 (
  .reset    (reset                                                ),
  .clk      (clk                                                  ),
  .valid_in (valid_out_add_18_17_16_15 & valid_out_add_14_13_12_11),
  .in_a     (out_add_18_17_16_15                                  ),
  .in_b     (out_add_14_13_12_11                                  ),
  .out      (out_add_18_17_16_15_14_13_12_11                      ),
  .valid_out(valid_out_add_18_17_16_15_14_13_12_11                )
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
wire [DATA_WIDTH-1:0] out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01;
wire [DATA_WIDTH-1:0] out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21;
wire [DATA_WIDTH-1:0] out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09;

wire valid_out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01;
wire valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21;
wire valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09;

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09 (
  .reset    (reset                                                                        ),
  .clk      (clk                                                                          ),
  .valid_in (valid_out_add_48_47_46_45_44_43_42_41 & valid_out_add_40_39_30_29_20_19_10_09),
  .in_a     (out_add_48_47_46_45_44_43_42_41                                              ),
  .in_b     (out_add_40_39_30_29_20_19_10_09                                              ),
  .out      (out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09                      ),
  .valid_out(valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21 (
  .reset    (reset                                                                        ),
  .clk      (clk                                                                          ),
  .valid_in (valid_out_add_38_37_36_35_34_33_32_31 & valid_out_add_28_27_26_25_24_23_22_21),
  .in_a     (out_add_38_37_36_35_34_33_32_31                                              ),
  .in_b     (out_add_28_27_26_25_24_23_22_21                                              ),
  .out      (out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21                      ),
  .valid_out(valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01 (
  .reset    (reset                                                                        ),
  .clk      (clk                                                                          ),
  .valid_in (valid_out_add_18_17_16_15_14_13_12_11 & valid_out_add_08_07_06_05_04_03_02_01),
  .in_a     (out_add_18_17_16_15_14_13_12_11                                              ),
  .in_b     (out_add_08_07_06_05_04_03_02_01                                              ),
  .out      (out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01                      ),
  .valid_out(valid_out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01                )
);

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01;
wire [DATA_WIDTH-1:0] out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00;

wire valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01;
wire valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00;

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01 (
  .reset    (reset                                                                                                                        ),
  .clk      (clk                                                                                                                          ),
  .valid_in (valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21 & valid_out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01),
  .in_a     (out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21                                                                      ),
  .in_b     (out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01                                                                      ),
  .out      (out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01                      ),
  .valid_out(valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01                )
);

fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00 (
  .reset    (reset                                                                                       ),
  .clk      (clk                                                                                         ),
  .valid_in (valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09 & valid_out_line_buffer_00),
  .in_a     (out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09                                     ),
  .in_b     (out_line_buffer_00                                                                          ),
  .out      (out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00                                  ),
  .valid_out(valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00                            )
);

/////////////////////////////////////////////////////////////////////////
fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add_out (
  .reset    (reset                                                                                                                                                                           ),
  .clk      (clk                                                                                                                                                                             ),
  .valid_in (valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00 & valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01),
  .in_a     (out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00                                                                                                                      ),
  .in_b     (out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01                                                                         ),
  .out      (pxl_out                                                                                                                                                                         ),
  .valid_out(valid_out                                                                                                                                                                       )
);

endmodule