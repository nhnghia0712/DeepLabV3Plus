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

module conv_7x7_top (
  clk, 
  reset,
  valid_in,
  pxl_in,
  valid_weight_in,
  weight_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
// General
parameter IMAGE_WIDTH     = 256; //Width
parameter IMAGE_HEIGHT    = 256; //Height
parameter CHANNEL_NUM_IN  = 3  ; //The number of channel in
parameter CHANNEL_NUM_OUT = 64 ; //The number of channel out
parameter KERNEL          = 7  ; //Kernel width

`include "D:/GitHub/CNNs/CNN_DeepLabV3Plus/CNN_DeepLabV3Plus.srcs/sources_1/new/param/param_def_conv_7x7.vh"
// KhaiT
// `include "/home/khait/Desktop/zipfile/deep/sources_1/new/param/param_def_conv_7x7.vh"

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk            ;
input                  reset          ;
input                  valid_in       ;
input [DATA_WIDTH-1:0] pxl_in         ;
input                  valid_weight_in;
input [DATA_WIDTH-1:0] weight_in      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk            ;
wire                  reset          ;
wire                  valid_in       ;
wire [DATA_WIDTH-1:0] pxl_in         ;
wire                  valid_weight_in;
wire [DATA_WIDTH-1:0] weight_in      ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

// Buffer 7x7
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

wire valid_out_buffer;

conv_7x7_buffer #(
	.DATA_WIDTH      (DATA_WIDTH      ),
	.IMAGE_WIDTH     (IMAGE_WIDTH     ),
	.KERNEL          (KERNEL          ),
	.CNT_WIDTH_BUFFER(CNT_WIDTH_BUFFER)
) inst_buffer (
	//input
	.clk         (clk             ),
	.reset       (reset           ),
	.valid_in    (valid_in        ),
	.in          (pxl_in          ),
	
	.pxl_out_00  (pxl_out_00      ),
	.pxl_out_01  (pxl_out_01      ),
	.pxl_out_02  (pxl_out_02      ),
	.pxl_out_03  (pxl_out_03      ),
	.pxl_out_04  (pxl_out_04      ),
	.pxl_out_05  (pxl_out_05      ),
	.pxl_out_06  (pxl_out_06      ),
	.pxl_out_07  (pxl_out_07      ),
	.pxl_out_08  (pxl_out_08      ),
	.pxl_out_09  (pxl_out_09      ),
	.pxl_out_10  (pxl_out_10      ),
	.pxl_out_11  (pxl_out_11      ),
	.pxl_out_12  (pxl_out_12      ),
	.pxl_out_13  (pxl_out_13      ),
	.pxl_out_14  (pxl_out_14      ),
	.pxl_out_15  (pxl_out_15      ),
	.pxl_out_16  (pxl_out_16      ),
	.pxl_out_17  (pxl_out_17      ),
	.pxl_out_18  (pxl_out_18      ),
	.pxl_out_19  (pxl_out_19      ),
	.pxl_out_20  (pxl_out_20      ),
	.pxl_out_21  (pxl_out_21      ),
	.pxl_out_22  (pxl_out_22      ),
	.pxl_out_23  (pxl_out_23      ),
	.pxl_out_24  (pxl_out_24      ),
	.pxl_out_25  (pxl_out_25      ),
	.pxl_out_26  (pxl_out_26      ),
	.pxl_out_27  (pxl_out_27      ),
	.pxl_out_28  (pxl_out_28      ),
	.pxl_out_29  (pxl_out_29      ),
	.pxl_out_30  (pxl_out_30      ),
	.pxl_out_31  (pxl_out_31      ),
	.pxl_out_32  (pxl_out_32      ),
	.pxl_out_33  (pxl_out_33      ),
	.pxl_out_34  (pxl_out_34      ),
	.pxl_out_35  (pxl_out_35      ),
	.pxl_out_36  (pxl_out_36      ),
	.pxl_out_37  (pxl_out_37      ),
	.pxl_out_38  (pxl_out_38      ),
	.pxl_out_39  (pxl_out_39      ),
	.pxl_out_40  (pxl_out_40      ),
	.pxl_out_41  (pxl_out_41      ),
	.pxl_out_42  (pxl_out_42      ),
	.pxl_out_43  (pxl_out_43      ),
	.pxl_out_44  (pxl_out_44      ),
	.pxl_out_45  (pxl_out_45      ),
	.pxl_out_46  (pxl_out_46      ),
	.pxl_out_47  (pxl_out_47      ),
	.pxl_out_48  (pxl_out_48      ),
	
	.valid_out   (valid_out_buffer),
	.load_weights(load_weights    )
);
// Buffer 7x7 Weights
//weights
wire [DATA_WIDTH-1:0] weight_out_00; wire [DATA_WIDTH-1:0] weight_out_01; wire [DATA_WIDTH-1:0] weight_out_02;
wire [DATA_WIDTH-1:0] weight_out_03; wire [DATA_WIDTH-1:0] weight_out_04; wire [DATA_WIDTH-1:0] weight_out_05;
wire [DATA_WIDTH-1:0] weight_out_06; wire [DATA_WIDTH-1:0] weight_out_07; wire [DATA_WIDTH-1:0] weight_out_08;
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

wire valid_out_buffer_weight;

conv_7x7_buffer_weights #(
	.DATA_WIDTH              (DATA_WIDTH              ),
	.KERNEL_SIZE             (KERNEL_SIZE             ),
	.CNT_WIDTH_BUFFER_WEIGHTS(CNT_WIDTH_BUFFER_WEIGHTS)
) inst_buffer_weights (
	//input
	.clk          (clk                    ),
	.reset        (reset                  ),
	.valid_in     (valid_weight_in        ),
	.in           (weight_in              ),
	.load_weights (load_weights           ),
	
	.weight_out_00(weight_out_00          ),
	.weight_out_01(weight_out_01          ),
	.weight_out_02(weight_out_02          ),
	.weight_out_03(weight_out_03          ),
	.weight_out_04(weight_out_04          ),
	.weight_out_05(weight_out_05          ),
	.weight_out_06(weight_out_06          ),
	.weight_out_07(weight_out_07          ),
	.weight_out_08(weight_out_08          ),
	.weight_out_09(weight_out_09          ),
	.weight_out_10(weight_out_10          ),
	.weight_out_11(weight_out_11          ),
	.weight_out_12(weight_out_12          ),
	.weight_out_13(weight_out_13          ),
	.weight_out_14(weight_out_14          ),
	.weight_out_15(weight_out_15          ),
	.weight_out_16(weight_out_16          ),
	.weight_out_17(weight_out_17          ),
	.weight_out_18(weight_out_18          ),
	.weight_out_19(weight_out_19          ),
	.weight_out_20(weight_out_20          ),
	.weight_out_21(weight_out_21          ),
	.weight_out_22(weight_out_22          ),
	.weight_out_23(weight_out_23          ),
	.weight_out_24(weight_out_24          ),
	.weight_out_25(weight_out_25          ),
	.weight_out_26(weight_out_26          ),
	.weight_out_27(weight_out_27          ),
	.weight_out_28(weight_out_28          ),
	.weight_out_29(weight_out_29          ),
	.weight_out_30(weight_out_30          ),
	.weight_out_31(weight_out_31          ),
	.weight_out_32(weight_out_32          ),
	.weight_out_33(weight_out_33          ),
	.weight_out_34(weight_out_34          ),
	.weight_out_35(weight_out_35          ),
	.weight_out_36(weight_out_36          ),
	.weight_out_37(weight_out_37          ),
	.weight_out_38(weight_out_38          ),
	.weight_out_39(weight_out_39          ),
	.weight_out_40(weight_out_40          ),
	.weight_out_41(weight_out_41          ),
	.weight_out_42(weight_out_42          ),
	.weight_out_43(weight_out_43          ),
	.weight_out_44(weight_out_44          ),
	.weight_out_45(weight_out_45          ),
	.weight_out_46(weight_out_46          ),
	.weight_out_47(weight_out_47          ),
	.weight_out_48(weight_out_48          ),
	
	.valid_out    (valid_out_buffer_weight)
);

//Core
conv_7x7_core #(.DATA_WIDTH(DATA_WIDTH)) inst_core (
	.clk         (clk                                       ),
	.reset       (reset                                     ),
	.valid_in    (valid_out_buffer & valid_out_buffer_weight),
	.pxl_in_00   (pxl_out_00                                ),
	.pxl_in_01   (pxl_out_01                                ),
	.pxl_in_02   (pxl_out_02                                ),
	.pxl_in_03   (pxl_out_03                                ),
	.pxl_in_04   (pxl_out_04                                ),
	.pxl_in_05   (pxl_out_05                                ),
	.pxl_in_06   (pxl_out_06                                ),
	.pxl_in_07   (pxl_out_07                                ),
	.pxl_in_08   (pxl_out_08                                ),
	.pxl_in_09   (pxl_out_09                                ),
	.pxl_in_10   (pxl_out_10                                ),
	.pxl_in_11   (pxl_out_11                                ),
	.pxl_in_12   (pxl_out_12                                ),
	.pxl_in_13   (pxl_out_13                                ),
	.pxl_in_14   (pxl_out_14                                ),
	.pxl_in_15   (pxl_out_15                                ),
	.pxl_in_16   (pxl_out_16                                ),
	.pxl_in_17   (pxl_out_17                                ),
	.pxl_in_18   (pxl_out_18                                ),
	.pxl_in_19   (pxl_out_19                                ),
	.pxl_in_20   (pxl_out_20                                ),
	.pxl_in_21   (pxl_out_21                                ),
	.pxl_in_22   (pxl_out_22                                ),
	.pxl_in_23   (pxl_out_23                                ),
	.pxl_in_24   (pxl_out_24                                ),
	.pxl_in_25   (pxl_out_25                                ),
	.pxl_in_26   (pxl_out_26                                ),
	.pxl_in_27   (pxl_out_27                                ),
	.pxl_in_28   (pxl_out_28                                ),
	.pxl_in_29   (pxl_out_29                                ),
	.pxl_in_30   (pxl_out_30                                ),
	.pxl_in_31   (pxl_out_31                                ),
	.pxl_in_32   (pxl_out_32                                ),
	.pxl_in_33   (pxl_out_33                                ),
	.pxl_in_34   (pxl_out_34                                ),
	.pxl_in_35   (pxl_out_35                                ),
	.pxl_in_36   (pxl_out_36                                ),
	.pxl_in_37   (pxl_out_37                                ),
	.pxl_in_38   (pxl_out_38                                ),
	.pxl_in_39   (pxl_out_39                                ),
	.pxl_in_40   (pxl_out_40                                ),
	.pxl_in_41   (pxl_out_41                                ),
	.pxl_in_42   (pxl_out_42                                ),
	.pxl_in_43   (pxl_out_43                                ),
	.pxl_in_44   (pxl_out_44                                ),
	.pxl_in_45   (pxl_out_45                                ),
	.pxl_in_46   (pxl_out_46                                ),
	.pxl_in_47   (pxl_out_47                                ),
	.pxl_in_48   (pxl_out_48                                ),
	//weights
	.weight_in_00(weight_out_00                             ),
	.weight_in_01(weight_out_01                             ),
	.weight_in_02(weight_out_02                             ),
	.weight_in_03(weight_out_03                             ),
	.weight_in_04(weight_out_04                             ),
	.weight_in_05(weight_out_05                             ),
	.weight_in_06(weight_out_06                             ),
	.weight_in_07(weight_out_07                             ),
	.weight_in_08(weight_out_08                             ),
	.weight_in_09(weight_out_09                             ),
	.weight_in_10(weight_out_10                             ),
	.weight_in_11(weight_out_11                             ),
	.weight_in_12(weight_out_12                             ),
	.weight_in_13(weight_out_13                             ),
	.weight_in_14(weight_out_14                             ),
	.weight_in_15(weight_out_15                             ),
	.weight_in_16(weight_out_16                             ),
	.weight_in_17(weight_out_17                             ),
	.weight_in_18(weight_out_18                             ),
	.weight_in_19(weight_out_19                             ),
	.weight_in_20(weight_out_20                             ),
	.weight_in_21(weight_out_21                             ),
	.weight_in_22(weight_out_22                             ),
	.weight_in_23(weight_out_23                             ),
	.weight_in_24(weight_out_24                             ),
	.weight_in_25(weight_out_25                             ),
	.weight_in_26(weight_out_26                             ),
	.weight_in_27(weight_out_27                             ),
	.weight_in_28(weight_out_28                             ),
	.weight_in_29(weight_out_29                             ),
	.weight_in_30(weight_out_30                             ),
	.weight_in_31(weight_out_31                             ),
	.weight_in_32(weight_out_32                             ),
	.weight_in_33(weight_out_33                             ),
	.weight_in_34(weight_out_34                             ),
	.weight_in_35(weight_out_35                             ),
	.weight_in_36(weight_out_36                             ),
	.weight_in_37(weight_out_37                             ),
	.weight_in_38(weight_out_38                             ),
	.weight_in_39(weight_out_39                             ),
	.weight_in_40(weight_out_40                             ),
	.weight_in_41(weight_out_41                             ),
	.weight_in_42(weight_out_42                             ),
	.weight_in_43(weight_out_43                             ),
	.weight_in_44(weight_out_44                             ),
	.weight_in_45(weight_out_45                             ),
	.weight_in_46(weight_out_46                             ),
	.weight_in_47(weight_out_47                             ),
	.weight_in_48(weight_out_48                             ),
	
	.pxl_out     (pxl_out                                   ),
	.valid_out   (valid_out                                 )
);

endmodule