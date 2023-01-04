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

module line_buffer(
  clk
  ,reset
  ,data_in
  ,valid_in
  ,data_out
  ,valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter IMAGE_WIDTH = 32;
parameter KERNEL      = 1 ; //3*3 Kernel
parameter DIN_WIDTH   = 32;

parameter DATA_WIDTH = IMAGE_WIDTH - (KERNEL - 1);

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                 clk     ;
input                 reset   ;
input                 valid_in;
input [DIN_WIDTH-1:0] data_in ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DIN_WIDTH-1:0] data_out ;
output                 valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                 clk     ;
wire                 reset   ;
wire                 valid_in;
wire [DIN_WIDTH-1:0] data_in ;

wire [DIN_WIDTH-1:0] data_out ;
wire                 valid_out;

// wire [ DIN_WIDTH-1:0] mem      [0:DATA_WIDTH-1];
// wire [0:DATA_WIDTH-1] mem_valid                ;

// assign data_out  = mem[DATA_WIDTH-1];
// assign valid_out = mem_valid[DATA_WIDTH-1];

// //generate function
// genvar i;

// generate
//   for (i = 0; i < DATA_WIDTH/2; i=i+1) begin
//     if (i == 0) begin
//       d_flip_flop #(.DATA_WIDTH(DIN_WIDTH)) dff_in (
//         .clk      (clk         ),
//         .reset    (reset       ),
//         .valid_in (valid_in    ),
//         .in       (data_in     ),
//         .out      (mem[i]      ),
//         .valid_out(mem_valid[i])
//       );
//     end
//     else begin
//       d_flip_flop #(.DATA_WIDTH(DIN_WIDTH)) dff (
//         .clk      (clk           ),
//         .reset    (reset         ),
//         .valid_in (mem_valid[i-1]),
//         .in       (mem[i-1]      ),
//         .out      (mem[i]        ),
//         .valid_out(mem_valid[i]  )
//       );
//     end
//   end
// endgenerate

// generate
//   for (i = DATA_WIDTH/2; i < DATA_WIDTH; i=i+1) begin
//     d_flip_flop #(.DATA_WIDTH(DIN_WIDTH)) dff1 (
//       .clk      (clk           ),
//       .reset    (reset         ),
//       .valid_in (mem_valid[i-1]),
//       .in       (mem[i-1]      ),
//       .out      (mem[i]        ),
//       .valid_out(mem_valid[i]  )
//     );
//   end
// endgenerate
reg [DATA_WIDTH-1:0] hr_0 ; reg [DATA_WIDTH-1:0] hr_1 ; reg [DATA_WIDTH-1:0] hr_2 ; reg [DATA_WIDTH-1:0] hr_3 ; reg [DATA_WIDTH-1:0] hr_4 ;
reg [DATA_WIDTH-1:0] hr_5 ; reg [DATA_WIDTH-1:0] hr_6 ; reg [DATA_WIDTH-1:0] hr_7 ; reg [DATA_WIDTH-1:0] hr_8 ; reg [DATA_WIDTH-1:0] hr_9 ;
reg [DATA_WIDTH-1:0] hr_10; reg [DATA_WIDTH-1:0] hr_11; reg [DATA_WIDTH-1:0] hr_12; reg [DATA_WIDTH-1:0] hr_13; reg [DATA_WIDTH-1:0] hr_14;
reg [DATA_WIDTH-1:0] hr_15; reg [DATA_WIDTH-1:0] hr_16; reg [DATA_WIDTH-1:0] hr_17; reg [DATA_WIDTH-1:0] hr_18; reg [DATA_WIDTH-1:0] hr_19;
reg [DATA_WIDTH-1:0] hr_20; reg [DATA_WIDTH-1:0] hr_21; reg [DATA_WIDTH-1:0] hr_22; reg [DATA_WIDTH-1:0] hr_23; reg [DATA_WIDTH-1:0] hr_24;
reg [DATA_WIDTH-1:0] hr_25; reg [DATA_WIDTH-1:0] hr_26; reg [DATA_WIDTH-1:0] hr_27; reg [DATA_WIDTH-1:0] hr_28; reg [DATA_WIDTH-1:0] hr_29;
reg [DATA_WIDTH-1:0] hr_30; reg [DATA_WIDTH-1:0] hr_31;

reg [DATA_WIDTH-1:0] valid_out_next;

// assign enable = (valid_in) ? 1'b1:1'b1;
reg enable;

always @ (*) begin
    if (reset) begin
        enable <= 1'b0;
    end
    else if (valid_in) begin
        enable <= 1'b1;
    end
end

always @ (posedge clk) begin
    if(reset)begin
        hr_0[DATA_WIDTH-1:0]  <= {DATA_WIDTH{1'b0}};
        hr_1[DATA_WIDTH-1:0]  <= {DATA_WIDTH{1'b0}};
        hr_2[DATA_WIDTH-1:0]  <= {DATA_WIDTH{1'b0}};
        hr_3[DATA_WIDTH-1:0]  <= {DATA_WIDTH{1'b0}};
        hr_4[DATA_WIDTH-1:0]  <= {DATA_WIDTH{1'b0}};
        hr_5[DATA_WIDTH-1:0]  <= {DATA_WIDTH{1'b0}};
        hr_6[DATA_WIDTH-1:0]  <= {DATA_WIDTH{1'b0}};
        hr_7[DATA_WIDTH-1:0]  <= {DATA_WIDTH{1'b0}};
        hr_8[DATA_WIDTH-1:0]  <= {DATA_WIDTH{1'b0}};
        hr_9[DATA_WIDTH-1:0]  <= {DATA_WIDTH{1'b0}};
        hr_10[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_11[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_12[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_13[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_14[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_15[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_16[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_17[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_18[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_19[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_20[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_21[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_22[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_23[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_24[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_25[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_26[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_27[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_28[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_29[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_30[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
        hr_31[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
    end
    else if (enable)begin
        if (DATA_WIDTH > 1) begin
            hr_0[DATA_WIDTH-1:0]  <= {hr_0[DATA_WIDTH-2:0], data_in[0]};
            hr_1[DATA_WIDTH-1:0]  <= {hr_1[DATA_WIDTH-2:0], data_in[1]};
            hr_2[DATA_WIDTH-1:0]  <= {hr_2[DATA_WIDTH-2:0], data_in[2]};
            hr_3[DATA_WIDTH-1:0]  <= {hr_3[DATA_WIDTH-2:0], data_in[3]};
            hr_4[DATA_WIDTH-1:0]  <= {hr_4[DATA_WIDTH-2:0], data_in[4]};
            hr_5[DATA_WIDTH-1:0]  <= {hr_5[DATA_WIDTH-2:0], data_in[5]};
            hr_6[DATA_WIDTH-1:0]  <= {hr_6[DATA_WIDTH-2:0], data_in[6]};
            hr_7[DATA_WIDTH-1:0]  <= {hr_7[DATA_WIDTH-2:0], data_in[7]};
            hr_8[DATA_WIDTH-1:0]  <= {hr_8[DATA_WIDTH-2:0], data_in[8]};
            hr_9[DATA_WIDTH-1:0]  <= {hr_9[DATA_WIDTH-2:0], data_in[9]};
            hr_10[DATA_WIDTH-1:0] <= {hr_10[DATA_WIDTH-2:0], data_in[10]};
            hr_11[DATA_WIDTH-1:0] <= {hr_11[DATA_WIDTH-2:0], data_in[11]};
            hr_12[DATA_WIDTH-1:0] <= {hr_12[DATA_WIDTH-2:0], data_in[12]};
            hr_13[DATA_WIDTH-1:0] <= {hr_13[DATA_WIDTH-2:0], data_in[13]};
            hr_14[DATA_WIDTH-1:0] <= {hr_14[DATA_WIDTH-2:0], data_in[14]};
            hr_15[DATA_WIDTH-1:0] <= {hr_15[DATA_WIDTH-2:0], data_in[15]};
            hr_16[DATA_WIDTH-1:0] <= {hr_16[DATA_WIDTH-2:0], data_in[16]};
            hr_17[DATA_WIDTH-1:0] <= {hr_17[DATA_WIDTH-2:0], data_in[17]};
            hr_18[DATA_WIDTH-1:0] <= {hr_18[DATA_WIDTH-2:0], data_in[18]};
            hr_19[DATA_WIDTH-1:0] <= {hr_19[DATA_WIDTH-2:0], data_in[19]};
            hr_20[DATA_WIDTH-1:0] <= {hr_20[DATA_WIDTH-2:0], data_in[20]};
            hr_21[DATA_WIDTH-1:0] <= {hr_21[DATA_WIDTH-2:0], data_in[21]};
            hr_22[DATA_WIDTH-1:0] <= {hr_22[DATA_WIDTH-2:0], data_in[22]};
            hr_23[DATA_WIDTH-1:0] <= {hr_23[DATA_WIDTH-2:0], data_in[23]};
            hr_24[DATA_WIDTH-1:0] <= {hr_24[DATA_WIDTH-2:0], data_in[24]};
            hr_25[DATA_WIDTH-1:0] <= {hr_25[DATA_WIDTH-2:0], data_in[25]};
            hr_26[DATA_WIDTH-1:0] <= {hr_26[DATA_WIDTH-2:0], data_in[26]};
            hr_27[DATA_WIDTH-1:0] <= {hr_27[DATA_WIDTH-2:0], data_in[27]};
            hr_28[DATA_WIDTH-1:0] <= {hr_28[DATA_WIDTH-2:0], data_in[28]};
            hr_29[DATA_WIDTH-1:0] <= {hr_29[DATA_WIDTH-2:0], data_in[29]};
            hr_30[DATA_WIDTH-1:0] <= {hr_30[DATA_WIDTH-2:0], data_in[30]};
            hr_31[DATA_WIDTH-1:0] <= {hr_31[DATA_WIDTH-2:0], data_in[31]};
        end
        else if (DATA_WIDTH == 1) begin
            hr_0[0]  <= data_in[0];
            hr_1[0]  <= data_in[1];
            hr_2[0]  <= data_in[2];
            hr_3[0]  <= data_in[3];
            hr_4[0]  <= data_in[4];
            hr_5[0]  <= data_in[5];
            hr_6[0]  <= data_in[6];
            hr_7[0]  <= data_in[7];
            hr_8[0]  <= data_in[8];
            hr_9[0]  <= data_in[9];
            hr_10[0] <= data_in[10];
            hr_11[0] <= data_in[11];
            hr_12[0] <= data_in[12];
            hr_13[0] <= data_in[13];
            hr_14[0] <= data_in[14];
            hr_15[0] <= data_in[15];
            hr_16[0] <= data_in[16];
            hr_17[0] <= data_in[17];
            hr_18[0] <= data_in[18];
            hr_19[0] <= data_in[19];
            hr_20[0] <= data_in[20];
            hr_21[0] <= data_in[21];
            hr_22[0] <= data_in[22];
            hr_23[0] <= data_in[23];
            hr_24[0] <= data_in[24];
            hr_25[0] <= data_in[25];
            hr_26[0] <= data_in[26];
            hr_27[0] <= data_in[27];
            hr_28[0] <= data_in[28];
            hr_29[0] <= data_in[29];
            hr_30[0] <= data_in[30];
            hr_31[0] <= data_in[31];
        end
    end
end

always @ (posedge clk) begin
    if(reset)begin
        valid_out_next[DATA_WIDTH-1:0] <= {DATA_WIDTH{1'b0}};
    end
    else if (enable)begin
        if (DATA_WIDTH > 1) begin
            valid_out_next[DATA_WIDTH-1:0] <= {valid_out_next[DATA_WIDTH-2:0], valid_in};
        end
        else if (DATA_WIDTH == 1) begin
            valid_out_next[0] <= valid_in;
        end
    end
end

assign data_out[0]  = hr_0[DATA_WIDTH-1]; assign data_out[1] = hr_1[DATA_WIDTH-1];
assign data_out[2]  = hr_2[DATA_WIDTH-1]; assign data_out[3] = hr_3[DATA_WIDTH-1];
assign data_out[4]  = hr_4[DATA_WIDTH-1]; assign data_out[5] = hr_5[DATA_WIDTH-1];
assign data_out[6]  = hr_6[DATA_WIDTH-1]; assign data_out[7] = hr_7[DATA_WIDTH-1];
assign data_out[8]  = hr_8[DATA_WIDTH-1]; assign data_out[9] = hr_9[DATA_WIDTH-1];
assign data_out[10] = hr_10[DATA_WIDTH-1]; assign data_out[11] = hr_11[DATA_WIDTH-1];
assign data_out[12] = hr_12[DATA_WIDTH-1]; assign data_out[13] = hr_13[DATA_WIDTH-1];
assign data_out[14] = hr_14[DATA_WIDTH-1]; assign data_out[15] = hr_15[DATA_WIDTH-1];
assign data_out[16] = hr_16[DATA_WIDTH-1]; assign data_out[17] = hr_17[DATA_WIDTH-1];
assign data_out[18] = hr_18[DATA_WIDTH-1]; assign data_out[19] = hr_19[DATA_WIDTH-1];
assign data_out[20] = hr_20[DATA_WIDTH-1]; assign data_out[21] = hr_21[DATA_WIDTH-1];
assign data_out[22] = hr_22[DATA_WIDTH-1]; assign data_out[23] = hr_23[DATA_WIDTH-1];
assign data_out[24] = hr_24[DATA_WIDTH-1]; assign data_out[25] = hr_25[DATA_WIDTH-1];
assign data_out[26] = hr_26[DATA_WIDTH-1]; assign data_out[27] = hr_27[DATA_WIDTH-1];
assign data_out[28] = hr_28[DATA_WIDTH-1]; assign data_out[29] = hr_29[DATA_WIDTH-1];
assign data_out[30] = hr_30[DATA_WIDTH-1]; assign data_out[31] = hr_31[DATA_WIDTH-1];

assign valid_out = valid_out_next[DATA_WIDTH-1];

endmodule




