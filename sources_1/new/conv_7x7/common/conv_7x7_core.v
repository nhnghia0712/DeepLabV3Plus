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


floating_point_2_mul inst_mul_48 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_48       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_48    ),
  .m_axis_result_tdata (out_mul_48      ),
  .m_axis_result_tvalid(valid_out_mul_48)
);

floating_point_2_mul inst_mul_47 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_47       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_47    ),
  .m_axis_result_tdata (out_mul_47      ),
  .m_axis_result_tvalid(valid_out_mul_47)
);

floating_point_2_mul inst_mul_46 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_46       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_46    ),
  .m_axis_result_tdata (out_mul_46      ),
  .m_axis_result_tvalid(valid_out_mul_46)
);

floating_point_2_mul inst_mul_45 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_45       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_45    ),
  .m_axis_result_tdata (out_mul_45      ),
  .m_axis_result_tvalid(valid_out_mul_45)
);

floating_point_2_mul inst_mul_44 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_44       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_44    ),
  .m_axis_result_tdata (out_mul_44      ),
  .m_axis_result_tvalid(valid_out_mul_44)
);

floating_point_2_mul inst_mul_43 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_43       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_43    ),
  .m_axis_result_tdata (out_mul_43      ),
  .m_axis_result_tvalid(valid_out_mul_43)
);

floating_point_2_mul inst_mul_42 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_42       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_42    ),
  .m_axis_result_tdata (out_mul_42      ),
  .m_axis_result_tvalid(valid_out_mul_42)
);

floating_point_2_mul inst_mul_41 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_41       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_41    ),
  .m_axis_result_tdata (out_mul_41      ),
  .m_axis_result_tvalid(valid_out_mul_41)
);

floating_point_2_mul inst_mul_40 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_40       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_40    ),
  .m_axis_result_tdata (out_mul_40      ),
  .m_axis_result_tvalid(valid_out_mul_40)
);

floating_point_2_mul inst_mul_39 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_39       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_39    ),
  .m_axis_result_tdata (out_mul_39      ),
  .m_axis_result_tvalid(valid_out_mul_39)
);

floating_point_2_mul inst_mul_38 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_38       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_38    ),
  .m_axis_result_tdata (out_mul_38      ),
  .m_axis_result_tvalid(valid_out_mul_38)
);

floating_point_2_mul inst_mul_37 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_37       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_37    ),
  .m_axis_result_tdata (out_mul_37      ),
  .m_axis_result_tvalid(valid_out_mul_37)
);

floating_point_2_mul inst_mul_36 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_36       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_36    ),
  .m_axis_result_tdata (out_mul_36      ),
  .m_axis_result_tvalid(valid_out_mul_36)
);

floating_point_2_mul inst_mul_35 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_35       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_35    ),
  .m_axis_result_tdata (out_mul_35      ),
  .m_axis_result_tvalid(valid_out_mul_35)
);

floating_point_2_mul inst_mul_34 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_34       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_34    ),
  .m_axis_result_tdata (out_mul_34      ),
  .m_axis_result_tvalid(valid_out_mul_34)
);

floating_point_2_mul inst_mul_33 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_33       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_33    ),
  .m_axis_result_tdata (out_mul_33      ),
  .m_axis_result_tvalid(valid_out_mul_33)
);

floating_point_2_mul inst_mul_32 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_32       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_32    ),
  .m_axis_result_tdata (out_mul_32      ),
  .m_axis_result_tvalid(valid_out_mul_32)
);

floating_point_2_mul inst_mul_31 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_31       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_31    ),
  .m_axis_result_tdata (out_mul_31      ),
  .m_axis_result_tvalid(valid_out_mul_31)
);

floating_point_2_mul inst_mul_30 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_30       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_30    ),
  .m_axis_result_tdata (out_mul_30      ),
  .m_axis_result_tvalid(valid_out_mul_30)
);

floating_point_2_mul inst_mul_29 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_29       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_29    ),
  .m_axis_result_tdata (out_mul_29      ),
  .m_axis_result_tvalid(valid_out_mul_29)
);

floating_point_2_mul inst_mul_28 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_28       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_28    ),
  .m_axis_result_tdata (out_mul_28      ),
  .m_axis_result_tvalid(valid_out_mul_28)
);

floating_point_2_mul inst_mul_27 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_27       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_27    ),
  .m_axis_result_tdata (out_mul_27      ),
  .m_axis_result_tvalid(valid_out_mul_27)
);

floating_point_2_mul inst_mul_26 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_26       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_26    ),
  .m_axis_result_tdata (out_mul_26      ),
  .m_axis_result_tvalid(valid_out_mul_26)
);

floating_point_2_mul inst_mul_25 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_25       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_25    ),
  .m_axis_result_tdata (out_mul_25      ),
  .m_axis_result_tvalid(valid_out_mul_25)
);

floating_point_2_mul inst_mul_24 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_24       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_24    ),
  .m_axis_result_tdata (out_mul_24      ),
  .m_axis_result_tvalid(valid_out_mul_24)
);

floating_point_2_mul inst_mul_23 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_23       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_23    ),
  .m_axis_result_tdata (out_mul_23      ),
  .m_axis_result_tvalid(valid_out_mul_23)
);

floating_point_2_mul inst_mul_22 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_22       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_22    ),
  .m_axis_result_tdata (out_mul_22      ),
  .m_axis_result_tvalid(valid_out_mul_22)
);

floating_point_2_mul inst_mul_21 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_21       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_21    ),
  .m_axis_result_tdata (out_mul_21      ),
  .m_axis_result_tvalid(valid_out_mul_21)
);

floating_point_2_mul inst_mul_20 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_20       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_20    ),
  .m_axis_result_tdata (out_mul_20      ),
  .m_axis_result_tvalid(valid_out_mul_20)
);

floating_point_2_mul inst_mul_19 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_19       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_19    ),
  .m_axis_result_tdata (out_mul_19      ),
  .m_axis_result_tvalid(valid_out_mul_19)
);

floating_point_2_mul inst_mul_18 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_18       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_18    ),
  .m_axis_result_tdata (out_mul_18      ),
  .m_axis_result_tvalid(valid_out_mul_18)
);

floating_point_2_mul inst_mul_17 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_17       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_17    ),
  .m_axis_result_tdata (out_mul_17      ),
  .m_axis_result_tvalid(valid_out_mul_17)
);

floating_point_2_mul inst_mul_16 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_16       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_16    ),
  .m_axis_result_tdata (out_mul_16      ),
  .m_axis_result_tvalid(valid_out_mul_16)
);

floating_point_2_mul inst_mul_15 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_15       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_15    ),
  .m_axis_result_tdata (out_mul_15      ),
  .m_axis_result_tvalid(valid_out_mul_15)
);

floating_point_2_mul inst_mul_14 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_14       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_14    ),
  .m_axis_result_tdata (out_mul_14      ),
  .m_axis_result_tvalid(valid_out_mul_14)
);

floating_point_2_mul inst_mul_13 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_13       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_13    ),
  .m_axis_result_tdata (out_mul_13      ),
  .m_axis_result_tvalid(valid_out_mul_13)
);

floating_point_2_mul inst_mul_12 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_12       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_12    ),
  .m_axis_result_tdata (out_mul_12      ),
  .m_axis_result_tvalid(valid_out_mul_12)
);

floating_point_2_mul inst_mul_11 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_11       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_11    ),
  .m_axis_result_tdata (out_mul_11      ),
  .m_axis_result_tvalid(valid_out_mul_11)
);

floating_point_2_mul inst_mul_10 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_10       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_10    ),
  .m_axis_result_tdata (out_mul_10      ),
  .m_axis_result_tvalid(valid_out_mul_10)
);

floating_point_2_mul inst_mul_09 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_09       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_09    ),
  .m_axis_result_tdata (out_mul_09      ),
  .m_axis_result_tvalid(valid_out_mul_09)
);

floating_point_2_mul inst_mul_08 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_08       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_08    ),
  .m_axis_result_tdata (out_mul_08      ),
  .m_axis_result_tvalid(valid_out_mul_08)
);

floating_point_2_mul inst_mul_07 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_07       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_07    ),
  .m_axis_result_tdata (out_mul_07      ),
  .m_axis_result_tvalid(valid_out_mul_07)
);

floating_point_2_mul inst_mul_06 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_06       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_06    ),
  .m_axis_result_tdata (out_mul_06      ),
  .m_axis_result_tvalid(valid_out_mul_06)
);

floating_point_2_mul inst_mul_05 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_05       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_05    ),
  .m_axis_result_tdata (out_mul_05      ),
  .m_axis_result_tvalid(valid_out_mul_05)
);

floating_point_2_mul inst_mul_04 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_04       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_04    ),
  .m_axis_result_tdata (out_mul_04      ),
  .m_axis_result_tvalid(valid_out_mul_04)
);

floating_point_2_mul inst_mul_03 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_03       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_03    ),
  .m_axis_result_tdata (out_mul_03      ),
  .m_axis_result_tvalid(valid_out_mul_03)
);

floating_point_2_mul inst_mul_02 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_02       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_02    ),
  .m_axis_result_tdata (out_mul_02      ),
  .m_axis_result_tvalid(valid_out_mul_02)
);

floating_point_2_mul inst_mul_01 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_01       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_01    ),
  .m_axis_result_tdata (out_mul_01      ),
  .m_axis_result_tvalid(valid_out_mul_01)
);

floating_point_2_mul inst_mul_00 (
  .aresetn             (~reset          ),
  .aclk                (clk             ),
  .s_axis_a_tvalid     (valid_in        ),
  .s_axis_a_tdata      (pxl_in_00       ),
  .s_axis_b_tvalid     (valid_in        ),
  .s_axis_b_tdata      (weight_in_00    ),
  .m_axis_result_tdata (out_mul_00      ),
  .m_axis_result_tvalid(valid_out_mul_00)
);

// Line buffer for Mul 00
wire [DATA_WIDTH-1:0] out_line_buffer_00      ;
wire                  valid_out_line_buffer_00;

line_buffer #(
  .IMAGE_WIDTH(44        ),
  .KERNEL     (1         ),
  .DIN_WIDTH  (DATA_WIDTH)
) line_buffer7 (
  .clk      (clk                     ),
  .reset    (reset                   ),
  .valid_in (valid_out_mul_00        ),
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

floating_point_1_add inst_add_48_47 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_48   ),
  .s_axis_a_tdata      (out_mul_48         ),
  .s_axis_b_tvalid     (valid_out_mul_48   ),
  .s_axis_b_tdata      (out_mul_47         ),
  .m_axis_result_tdata (out_add_48_47      ),
  .m_axis_result_tvalid(valid_out_add_48_47)
);

floating_point_1_add inst_add_46_45 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_46   ),
  .s_axis_a_tdata      (out_mul_46         ),
  .s_axis_b_tvalid     (valid_out_mul_45   ),
  .s_axis_b_tdata      (out_mul_45         ),
  .m_axis_result_tdata (out_add_46_45      ),
  .m_axis_result_tvalid(valid_out_add_46_45)
);

floating_point_1_add inst_add_44_43 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_44   ),
  .s_axis_a_tdata      (out_mul_44         ),
  .s_axis_b_tvalid     (valid_out_mul_43   ),
  .s_axis_b_tdata      (out_mul_43         ),
  .m_axis_result_tdata (out_add_44_43      ),
  .m_axis_result_tvalid(valid_out_add_44_43)
);

floating_point_1_add inst_add_42_41 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_42   ),
  .s_axis_a_tdata      (out_mul_42         ),
  .s_axis_b_tvalid     (valid_out_mul_41   ),
  .s_axis_b_tdata      (out_mul_41         ),
  .m_axis_result_tdata (out_add_42_41      ),
  .m_axis_result_tvalid(valid_out_add_42_41)
);

floating_point_1_add inst_add_40_39 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_40   ),
  .s_axis_a_tdata      (out_mul_40         ),
  .s_axis_b_tvalid     (valid_out_mul_39   ),
  .s_axis_b_tdata      (out_mul_39         ),
  .m_axis_result_tdata (out_add_40_39      ),
  .m_axis_result_tvalid(valid_out_add_40_39)
);

floating_point_1_add inst_add_38_37 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_38   ),
  .s_axis_a_tdata      (out_mul_38         ),
  .s_axis_b_tvalid     (valid_out_mul_38   ),
  .s_axis_b_tdata      (out_mul_37         ),
  .m_axis_result_tdata (out_add_38_37      ),
  .m_axis_result_tvalid(valid_out_add_38_37)
);

floating_point_1_add inst_add_36_35 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_36   ),
  .s_axis_a_tdata      (out_mul_36         ),
  .s_axis_b_tvalid     (valid_out_mul_35   ),
  .s_axis_b_tdata      (out_mul_35         ),
  .m_axis_result_tdata (out_add_36_35      ),
  .m_axis_result_tvalid(valid_out_add_36_35)
);

floating_point_1_add inst_add_34_33 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_34   ),
  .s_axis_a_tdata      (out_mul_34         ),
  .s_axis_b_tvalid     (valid_out_mul_33   ),
  .s_axis_b_tdata      (out_mul_33         ),
  .m_axis_result_tdata (out_add_34_33      ),
  .m_axis_result_tvalid(valid_out_add_34_33)
);

floating_point_1_add inst_add_32_31 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_32   ),
  .s_axis_a_tdata      (out_mul_32         ),
  .s_axis_b_tvalid     (valid_out_mul_31   ),
  .s_axis_b_tdata      (out_mul_31         ),
  .m_axis_result_tdata (out_add_32_31      ),
  .m_axis_result_tvalid(valid_out_add_32_31)
);

floating_point_1_add inst_add_30_29 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_30   ),
  .s_axis_a_tdata      (out_mul_30         ),
  .s_axis_b_tvalid     (valid_out_mul_29   ),
  .s_axis_b_tdata      (out_mul_29         ),
  .m_axis_result_tdata (out_add_30_29      ),
  .m_axis_result_tvalid(valid_out_add_30_29)
);

floating_point_1_add inst_add_28_27 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_28   ),
  .s_axis_a_tdata      (out_mul_28         ),
  .s_axis_b_tvalid     (valid_out_mul_28   ),
  .s_axis_b_tdata      (out_mul_27         ),
  .m_axis_result_tdata (out_add_28_27      ),
  .m_axis_result_tvalid(valid_out_add_28_27)
);

floating_point_1_add inst_add_26_25 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_26   ),
  .s_axis_a_tdata      (out_mul_26         ),
  .s_axis_b_tvalid     (valid_out_mul_25   ),
  .s_axis_b_tdata      (out_mul_25         ),
  .m_axis_result_tdata (out_add_26_25      ),
  .m_axis_result_tvalid(valid_out_add_26_25)
);

floating_point_1_add inst_add_24_23 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_24   ),
  .s_axis_a_tdata      (out_mul_24         ),
  .s_axis_b_tvalid     (valid_out_mul_23   ),
  .s_axis_b_tdata      (out_mul_23         ),
  .m_axis_result_tdata (out_add_24_23      ),
  .m_axis_result_tvalid(valid_out_add_24_23)
);

floating_point_1_add inst_add_22_21 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_22   ),
  .s_axis_a_tdata      (out_mul_22         ),
  .s_axis_b_tvalid     (valid_out_mul_21   ),
  .s_axis_b_tdata      (out_mul_21         ),
  .m_axis_result_tdata (out_add_22_21      ),
  .m_axis_result_tvalid(valid_out_add_22_21)
);

floating_point_1_add inst_add_20_19 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_20   ),
  .s_axis_a_tdata      (out_mul_20         ),
  .s_axis_b_tvalid     (valid_out_mul_19   ),
  .s_axis_b_tdata      (out_mul_19         ),
  .m_axis_result_tdata (out_add_20_19      ),
  .m_axis_result_tvalid(valid_out_add_20_19)
);

floating_point_1_add inst_add_18_17 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_18   ),
  .s_axis_a_tdata      (out_mul_18         ),
  .s_axis_b_tvalid     (valid_out_mul_18   ),
  .s_axis_b_tdata      (out_mul_17         ),
  .m_axis_result_tdata (out_add_18_17      ),
  .m_axis_result_tvalid(valid_out_add_18_17)
);

floating_point_1_add inst_add_16_15 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_16   ),
  .s_axis_a_tdata      (out_mul_16         ),
  .s_axis_b_tvalid     (valid_out_mul_15   ),
  .s_axis_b_tdata      (out_mul_15         ),
  .m_axis_result_tdata (out_add_16_15      ),
  .m_axis_result_tvalid(valid_out_add_16_15)
);

floating_point_1_add inst_add_14_13 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_14   ),
  .s_axis_a_tdata      (out_mul_14         ),
  .s_axis_b_tvalid     (valid_out_mul_13   ),
  .s_axis_b_tdata      (out_mul_13         ),
  .m_axis_result_tdata (out_add_14_13      ),
  .m_axis_result_tvalid(valid_out_add_14_13)
);

floating_point_1_add inst_add_12_11 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_12   ),
  .s_axis_a_tdata      (out_mul_12         ),
  .s_axis_b_tvalid     (valid_out_mul_11   ),
  .s_axis_b_tdata      (out_mul_11         ),
  .m_axis_result_tdata (out_add_12_11      ),
  .m_axis_result_tvalid(valid_out_add_12_11)
);

floating_point_1_add inst_add_10_09 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_10   ),
  .s_axis_a_tdata      (out_mul_10         ),
  .s_axis_b_tvalid     (valid_out_mul_09   ),
  .s_axis_b_tdata      (out_mul_09         ),
  .m_axis_result_tdata (out_add_10_09      ),
  .m_axis_result_tvalid(valid_out_add_10_09)
);

floating_point_1_add inst_add_08_07 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_08   ),
  .s_axis_a_tdata      (out_mul_08         ),
  .s_axis_b_tvalid     (valid_out_mul_07   ),
  .s_axis_b_tdata      (out_mul_07         ),
  .m_axis_result_tdata (out_add_08_07      ),
  .m_axis_result_tvalid(valid_out_add_08_07)
);

floating_point_1_add inst_add_06_05 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_06   ),
  .s_axis_a_tdata      (out_mul_06         ),
  .s_axis_b_tvalid     (valid_out_mul_05   ),
  .s_axis_b_tdata      (out_mul_05         ),
  .m_axis_result_tdata (out_add_06_05      ),
  .m_axis_result_tvalid(valid_out_add_06_05)
);

floating_point_1_add inst_add_04_03 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_04   ),
  .s_axis_a_tdata      (out_mul_04         ),
  .s_axis_b_tvalid     (valid_out_mul_03   ),
  .s_axis_b_tdata      (out_mul_03         ),
  .m_axis_result_tdata (out_add_04_03      ),
  .m_axis_result_tvalid(valid_out_add_04_03)
);

floating_point_1_add inst_add_02_01 (
  .aresetn             (~reset             ),
  .aclk                (clk                ),
  .s_axis_a_tvalid     (valid_out_mul_02   ),
  .s_axis_a_tdata      (out_mul_02         ),
  .s_axis_b_tvalid     (valid_out_mul_01   ),
  .s_axis_b_tdata      (out_mul_01         ),
  .m_axis_result_tdata (out_add_02_01      ),
  .m_axis_result_tvalid(valid_out_add_02_01)
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

floating_point_1_add inst_add_40_39_30_29 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_40_39      ),
  .s_axis_a_tdata      (out_add_40_39            ),
  .s_axis_b_tvalid     (valid_out_add_30_29      ),
  .s_axis_b_tdata      (out_add_30_29            ),
  .m_axis_result_tdata (out_add_40_39_30_29      ),
  .m_axis_result_tvalid(valid_out_add_40_39_30_29)
);

floating_point_1_add inst_add_20_19_10_09 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_20_19      ),
  .s_axis_a_tdata      (out_add_20_19            ),
  .s_axis_b_tvalid     (valid_out_add_10_09      ),
  .s_axis_b_tdata      (out_add_10_09            ),
  .m_axis_result_tdata (out_add_20_19_10_09      ),
  .m_axis_result_tvalid(valid_out_add_20_19_10_09)
);

floating_point_1_add inst_add_48_47_46_45 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_48_47      ),
  .s_axis_a_tdata      (out_add_48_47            ),
  .s_axis_b_tvalid     (valid_out_add_46_45      ),
  .s_axis_b_tdata      (out_add_46_45            ),
  .m_axis_result_tdata (out_add_48_47_46_45      ),
  .m_axis_result_tvalid(valid_out_add_48_47_46_45)
);

floating_point_1_add inst_add_44_43_42_41 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_44_43      ),
  .s_axis_a_tdata      (out_add_44_43            ),
  .s_axis_b_tvalid     (valid_out_add_42_41      ),
  .s_axis_b_tdata      (out_add_42_41            ),
  .m_axis_result_tdata (out_add_44_43_42_41      ),
  .m_axis_result_tvalid(valid_out_add_44_43_42_41)
);

floating_point_1_add inst_add_38_37_36_35 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_38_37      ),
  .s_axis_a_tdata      (out_add_38_37            ),
  .s_axis_b_tvalid     (valid_out_add_36_35      ),
  .s_axis_b_tdata      (out_add_36_35            ),
  .m_axis_result_tdata (out_add_38_37_36_35      ),
  .m_axis_result_tvalid(valid_out_add_38_37_36_35)
);

floating_point_1_add inst_add_34_33_32_31 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_34_33      ),
  .s_axis_a_tdata      (out_add_34_33            ),
  .s_axis_b_tvalid     (valid_out_add_32_31      ),
  .s_axis_b_tdata      (out_add_32_31            ),
  .m_axis_result_tdata (out_add_34_33_32_31      ),
  .m_axis_result_tvalid(valid_out_add_34_33_32_31)
);

floating_point_1_add inst_add_28_27_26_25 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_28_27      ),
  .s_axis_a_tdata      (out_add_28_27            ),
  .s_axis_b_tvalid     (valid_out_add_26_25      ),
  .s_axis_b_tdata      (out_add_26_25            ),
  .m_axis_result_tdata (out_add_28_27_26_25      ),
  .m_axis_result_tvalid(valid_out_add_28_27_26_25)
);

floating_point_1_add inst_add_24_23_22_21 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_24_23      ),
  .s_axis_a_tdata      (out_add_24_23            ),
  .s_axis_b_tvalid     (valid_out_add_22_21      ),
  .s_axis_b_tdata      (out_add_22_21            ),
  .m_axis_result_tdata (out_add_24_23_22_21      ),
  .m_axis_result_tvalid(valid_out_add_24_23_22_21)
);

floating_point_1_add inst_add_18_17_16_15 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_18_17      ),
  .s_axis_a_tdata      (out_add_18_17            ),
  .s_axis_b_tvalid     (valid_out_add_16_15      ),
  .s_axis_b_tdata      (out_add_16_15            ),
  .m_axis_result_tdata (out_add_18_17_16_15      ),
  .m_axis_result_tvalid(valid_out_add_18_17_16_15)
);

floating_point_1_add inst_add_14_13_12_11 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_14_13      ),
  .s_axis_a_tdata      (out_add_14_13            ),
  .s_axis_b_tvalid     (valid_out_add_12_11      ),
  .s_axis_b_tdata      (out_add_12_11            ),
  .m_axis_result_tdata (out_add_14_13_12_11      ),
  .m_axis_result_tvalid(valid_out_add_14_13_12_11)
);

floating_point_1_add inst_add_08_07_06_05 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_08_07      ),
  .s_axis_a_tdata      (out_add_08_07            ),
  .s_axis_b_tvalid     (valid_out_add_06_05      ),
  .s_axis_b_tdata      (out_add_06_05            ),
  .m_axis_result_tdata (out_add_08_07_06_05      ),
  .m_axis_result_tvalid(valid_out_add_08_07_06_05)
);

floating_point_1_add inst_add_04_03_02_01 (
  .aresetn             (~reset                   ),
  .aclk                (clk                      ),
  .s_axis_a_tvalid     (valid_out_add_04_03      ),
  .s_axis_a_tdata      (out_add_04_03            ),
  .s_axis_b_tvalid     (valid_out_add_02_01      ),
  .s_axis_b_tdata      (out_add_02_01            ),
  .m_axis_result_tdata (out_add_04_03_02_01      ),
  .m_axis_result_tvalid(valid_out_add_04_03_02_01)
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

floating_point_1_add inst_add_40_39_30_29_20_19_10_09 (
  .aresetn             (~reset                               ),
  .aclk                (clk                                  ),
  .s_axis_a_tvalid     (valid_out_add_40_39_30_29            ),
  .s_axis_a_tdata      (out_add_40_39_30_29                  ),
  .s_axis_b_tvalid     (valid_out_add_20_19_10_09            ),
  .s_axis_b_tdata      (out_add_20_19_10_09                  ),
  .m_axis_result_tdata (out_add_40_39_30_29_20_19_10_09      ),
  .m_axis_result_tvalid(valid_out_add_40_39_30_29_20_19_10_09)
);

floating_point_1_add inst_add_48_47_46_45_44_43_42_41 (
  .aresetn             (~reset                               ),
  .aclk                (clk                                  ),
  .s_axis_a_tvalid     (valid_out_add_48_47_46_45            ),
  .s_axis_a_tdata      (out_add_48_47_46_45                  ),
  .s_axis_b_tvalid     (valid_out_add_44_43_42_41            ),
  .s_axis_b_tdata      (out_add_44_43_42_41                  ),
  .m_axis_result_tdata (out_add_48_47_46_45_44_43_42_41      ),
  .m_axis_result_tvalid(valid_out_add_48_47_46_45_44_43_42_41)
);

floating_point_1_add inst_add_38_37_36_35_34_33_32_31 (
  .aresetn             (~reset                               ),
  .aclk                (clk                                  ),
  .s_axis_a_tvalid     (valid_out_add_38_37_36_35            ),
  .s_axis_a_tdata      (out_add_38_37_36_35                  ),
  .s_axis_b_tvalid     (valid_out_add_34_33_32_31            ),
  .s_axis_b_tdata      (out_add_34_33_32_31                  ),
  .m_axis_result_tdata (out_add_38_37_36_35_34_33_32_31      ),
  .m_axis_result_tvalid(valid_out_add_38_37_36_35_34_33_32_31)
);

floating_point_1_add inst_add_28_27_26_25_24_23_22_21 (
  .aresetn             (~reset                               ),
  .aclk                (clk                                  ),
  .s_axis_a_tvalid     (valid_out_add_28_27_26_25            ),
  .s_axis_a_tdata      (out_add_28_27_26_25                  ),
  .s_axis_b_tvalid     (valid_out_add_24_23_22_21            ),
  .s_axis_b_tdata      (out_add_24_23_22_21                  ),
  .m_axis_result_tdata (out_add_28_27_26_25_24_23_22_21      ),
  .m_axis_result_tvalid(valid_out_add_28_27_26_25_24_23_22_21)
);

floating_point_1_add inst_add_18_17_16_15_14_13_12_11 (
  .aresetn             (~reset                               ),
  .aclk                (clk                                  ),
  .s_axis_a_tvalid     (valid_out_add_18_17_16_15            ),
  .s_axis_a_tdata      (out_add_18_17_16_15                  ),
  .s_axis_b_tvalid     (valid_out_add_14_13_12_11            ),
  .s_axis_b_tdata      (out_add_14_13_12_11                  ),
  .m_axis_result_tdata (out_add_18_17_16_15_14_13_12_11      ),
  .m_axis_result_tvalid(valid_out_add_18_17_16_15_14_13_12_11)
);

floating_point_1_add inst_add_08_07_06_05_04_03_02_01 (
  .aresetn             (~reset                               ),
  .aclk                (clk                                  ),
  .s_axis_a_tvalid     (valid_out_add_08_07_06_05            ),
  .s_axis_a_tdata      (out_add_08_07_06_05                  ),
  .s_axis_b_tvalid     (valid_out_add_04_03_02_01            ),
  .s_axis_b_tdata      (out_add_04_03_02_01                  ),
  .m_axis_result_tdata (out_add_08_07_06_05_04_03_02_01      ),
  .m_axis_result_tvalid(valid_out_add_08_07_06_05_04_03_02_01)
);

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01;
wire [DATA_WIDTH-1:0] out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21;
wire [DATA_WIDTH-1:0] out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09;

wire valid_out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01;
wire valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21;
wire valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09;

floating_point_1_add inst_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09 (
  .aresetn             (~reset                                                       ),
  .aclk                (clk                                                          ),
  .s_axis_a_tvalid     (valid_out_add_48_47_46_45_44_43_42_41                        ),
  .s_axis_a_tdata      (out_add_48_47_46_45_44_43_42_41                              ),
  .s_axis_b_tvalid     (valid_out_add_40_39_30_29_20_19_10_09                        ),
  .s_axis_b_tdata      (out_add_40_39_30_29_20_19_10_09                              ),
  .m_axis_result_tdata (out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09      ),
  .m_axis_result_tvalid(valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09)
);

floating_point_1_add inst_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21 (
  .aresetn             (~reset                                                       ),
  .aclk                (clk                                                          ),
  .s_axis_a_tvalid     (valid_out_add_38_37_36_35_34_33_32_31                        ),
  .s_axis_a_tdata      (out_add_38_37_36_35_34_33_32_31                              ),
  .s_axis_b_tvalid     (valid_out_add_28_27_26_25_24_23_22_21                        ),
  .s_axis_b_tdata      (out_add_28_27_26_25_24_23_22_21                              ),
  .m_axis_result_tdata (out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21      ),
  .m_axis_result_tvalid(valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21)
);

floating_point_1_add inst_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01 (
  .aresetn             (~reset                                                       ),
  .aclk                (clk                                                          ),
  .s_axis_a_tvalid     (valid_out_add_18_17_16_15_14_13_12_11                        ),
  .s_axis_a_tdata      (out_add_18_17_16_15_14_13_12_11                              ),
  .s_axis_b_tvalid     (valid_out_add_08_07_06_05_04_03_02_01                        ),
  .s_axis_b_tdata      (out_add_08_07_06_05_04_03_02_01                              ),
  .m_axis_result_tdata (out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01      ),
  .m_axis_result_tvalid(valid_out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01)
);

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01;
wire [DATA_WIDTH-1:0] out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00;

wire valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01;
wire valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00;

floating_point_1_add inst_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01 (
  .aresetn             (~reset                                                                                                       ),
  .aclk                (clk                                                                                                          ),
  .s_axis_a_tvalid     (valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21                                                ),
  .s_axis_a_tdata      (out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21                                                      ),
  .s_axis_b_tvalid     (valid_out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01                                                ),
  .s_axis_b_tdata      (out_add_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01                                                      ),
  .m_axis_result_tdata (out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01      ),
  .m_axis_result_tvalid(valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01)
);

floating_point_1_add inst_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00 (
  .aresetn             (~reset                                                          ),
  .aclk                (clk                                                             ),
  .s_axis_a_tvalid     (valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09   ),
  .s_axis_a_tdata      (out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09         ),
  .s_axis_b_tvalid     (valid_out_line_buffer_00                                        ),
  .s_axis_b_tdata      (out_line_buffer_00                                              ),
  .m_axis_result_tdata (out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00      ),
  .m_axis_result_tvalid(valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00)
);

/////////////////////////////////////////////////////////////////////////
floating_point_1_add inst_add_out (
  .aresetn             (~reset                                                                                                       ),
  .aclk                (clk                                                                                                          ),
  .s_axis_a_tvalid     (valid_out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00                                             ),
  .s_axis_a_tdata      (out_add_48_47_46_45_44_43_42_41_40_39_30_29_20_19_10_09_00                                                   ),
  .s_axis_b_tvalid     (valid_out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01),
  .s_axis_b_tdata      (out_add_38_37_36_35_34_33_32_31_28_27_26_25_24_23_22_21_18_17_16_15_14_13_12_11_08_07_06_05_04_03_02_01      ),
  .m_axis_result_tdata (pxl_out                                                                                                      ),
  .m_axis_result_tvalid(valid_out                                                                                                    )
);

endmodule