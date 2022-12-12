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

module conv_1024channel_adder_new (
  clk, 
  reset,
  valid_in,
  pxl_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH              = 32                 ;
parameter CHANNEL_NUM_IN          = 64                 ;
parameter IMAGE_SIZE              = 612                ;
parameter IMAGE_WIDTH             = 12                 ;
parameter CHANNEL_NUM             = 12                 ;
parameter RATE                    = 1                  ;
parameter ADD_CHANNEL_IN_CNT      = $clog2(CHANNEL_NUM);
parameter ADD_TEMP_CHANNEL_IN_CNT = $clog2(IMAGE_SIZE) ;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk             ;
input                  reset           ;
input                  valid_in        ;
input [DATA_WIDTH-1:0] pxl_in          ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out         ;
output                  valid_out       ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk             ;
wire                  reset           ;
wire                  valid_in        ;
wire [DATA_WIDTH-1:0] pxl_in          ;

wire [DATA_WIDTH-1:0] pxl_out         ;
wire                  valid_out       ;

wire [    DATA_WIDTH-1:0] mem      [CHANNEL_NUM_IN-1:0];
wire [CHANNEL_NUM_IN-1:0] mem_valid                    ;

assign mem[0]       = pxl_in;
assign mem_valid[0] = valid_in;

//generate function
genvar i;

generate
  for (i = 0; i < CHANNEL_NUM_IN - 1; i=i+1) begin
    line_buffer #(
      .IMAGE_WIDTH(IMAGE_SIZE + (IMAGE_WIDTH * RATE) + RATE),
      .KERNEL     (1                                       ),
      .DIN_WIDTH  (DATA_WIDTH                              )
    ) line_buffer (
      .clk      (clk           ),
      .reset    (reset         ),
      .valid_in (mem_valid[i]  ),
      .data_in  (mem[i]        ),
      .data_out (mem[i+1]      ),
      .valid_out(mem_valid[i+1])
    );
  end
endgenerate

reg [ADD_CHANNEL_IN_CNT-1:0] channel_cnt;

reg [ADD_TEMP_CHANNEL_IN_CNT-1:0] temp_channel_cnt;

always @(posedge clk) begin
  if(reset) begin
    temp_channel_cnt <= {ADD_TEMP_CHANNEL_IN_CNT{1'b0}};
    channel_cnt <= {ADD_CHANNEL_IN_CNT{1'b0}};
  end
  else if (mem_valid[0]) begin
    temp_channel_cnt <= temp_channel_cnt + 1'b1;
    if (!(|temp_channel_cnt)) begin
      channel_cnt <= channel_cnt + 1'b1;
    end
  end
  else begin
    temp_channel_cnt <= {ADD_TEMP_CHANNEL_IN_CNT{1'b0}};
  end
end

wire channel_enable;

assign channel_enable = ( !(|(channel_cnt%CHANNEL_NUM_IN)) && |(channel_cnt) ) ? 1'b1:1'b0;

wire [    DATA_WIDTH-1:0] mem_dff      [CHANNEL_NUM_IN-1:0];
wire [CHANNEL_NUM_IN-1:0] mem_dff_valid                    ;

generate
  for (i = 0; i < CHANNEL_NUM_IN; i=i+1) begin
    d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff (
      .clk      (clk             ),
      .reset    (reset           ),
      .valid_in (mem_valid[i]    ),
      .in       (mem[i]          ),
      .out      (mem_dff[i]      ),
      .valid_out(mem_dff_valid[i])
    );
  end
endgenerate

// Add
wire [        DATA_WIDTH-1:0] out_add1      [(CHANNEL_NUM_IN/2)-1:0];
wire [(CHANNEL_NUM_IN/2)-1:0] valid_out_add1                        ;

generate
  for (i = 0; i < (CHANNEL_NUM_IN/2); i = i + 1) begin
    fp_add_sub inst_add1 (
      .reset    (reset                                                                    ),
      .clk      (clk                                                                      ),
      .valid_in (mem_dff_valid[i] & mem_dff_valid[i + (CHANNEL_NUM_IN/2)] & channel_enable),
      .in_a     (mem_dff[i]                                                               ),
      .in_b     (mem_dff[i + (CHANNEL_NUM_IN/2)]                                          ),
      .out      (out_add1[i]                                                              ),
      .valid_out(valid_out_add1[i]                                                        )
    );
  end
endgenerate

wire [        DATA_WIDTH-1:0] out_add2      [(CHANNEL_NUM_IN/4)-1:0];
wire [(CHANNEL_NUM_IN/4)-1:0] valid_out_add2                        ;

generate
  for (i = 0; i < (CHANNEL_NUM_IN/4); i = i + 1) begin
    fp_add_sub inst_add1 (
      .reset    (reset                                                     ),
      .clk      (clk                                                       ),
      .valid_in (valid_out_add1[i] & valid_out_add1[i + (CHANNEL_NUM_IN/4)]),
      .in_a     (out_add1[i]                                               ),
      .in_b     (out_add1[i + (CHANNEL_NUM_IN/4)]                          ),
      .out      (out_add2[i]                                               ),
      .valid_out(valid_out_add2[i]                                         )
    );
  end
endgenerate

wire [        DATA_WIDTH-1:0] out_add3      [(CHANNEL_NUM_IN/8)-1:0];
wire [(CHANNEL_NUM_IN/8)-1:0] valid_out_add3                        ;

generate
  for (i = 0; i < (CHANNEL_NUM_IN/8); i = i + 1) begin
    fp_add_sub inst_add1 (
      .reset    (reset                                                     ),
      .clk      (clk                                                       ),
      .valid_in (valid_out_add2[i] & valid_out_add2[i + (CHANNEL_NUM_IN/8)]),
      .in_a     (out_add2[i]                                               ),
      .in_b     (out_add2[i + (CHANNEL_NUM_IN/8)]                          ),
      .out      (out_add3[i]                                               ),
      .valid_out(valid_out_add3[i]                                         )
    );
  end
endgenerate

wire [         DATA_WIDTH-1:0] out_add4      [(CHANNEL_NUM_IN/16)-1:0];
wire [(CHANNEL_NUM_IN/16)-1:0] valid_out_add4                         ;

generate
  for (i = 0; i < (CHANNEL_NUM_IN/16); i = i + 1) begin
    fp_add_sub inst_add1 (
      .reset    (reset                                                      ),
      .clk      (clk                                                        ),
      .valid_in (valid_out_add3[i] & valid_out_add3[i + (CHANNEL_NUM_IN/16)]),
      .in_a     (out_add3[i]                                                ),
      .in_b     (out_add3[i + (CHANNEL_NUM_IN/16)]                          ),
      .out      (out_add4[i]                                                ),
      .valid_out(valid_out_add4[i]                                          )
    );
  end
endgenerate

wire [         DATA_WIDTH-1:0] out_add5      [(CHANNEL_NUM_IN/32)-1:0];
wire [(CHANNEL_NUM_IN/32)-1:0] valid_out_add5                         ;

generate
  for (i = 0; i < (CHANNEL_NUM_IN/32); i = i + 1) begin
    fp_add_sub inst_add1 (
      .reset    (reset                                                      ),
      .clk      (clk                                                        ),
      .valid_in (valid_out_add4[i] & valid_out_add4[i + (CHANNEL_NUM_IN/32)]),
      .in_a     (out_add4[i]                                                ),
      .in_b     (out_add4[i + (CHANNEL_NUM_IN/32)]                          ),
      .out      (out_add5[i]                                                ),
      .valid_out(valid_out_add5[i]                                          )
    );
  end
endgenerate

wire [         DATA_WIDTH-1:0] out_add6      [(CHANNEL_NUM_IN/64)-1:0];
wire [(CHANNEL_NUM_IN/64)-1:0] valid_out_add6                         ;

generate
  for (i = 0; i < (CHANNEL_NUM_IN/64); i = i + 1) begin
    fp_add_sub inst_add1 (
      .reset    (reset                                                      ),
      .clk      (clk                                                        ),
      .valid_in (valid_out_add5[i] & valid_out_add5[i + (CHANNEL_NUM_IN/64)]),
      .in_a     (out_add5[i]                                                ),
      .in_b     (out_add5[i + (CHANNEL_NUM_IN/64)]                          ),
      .out      (out_add6[i]                                                ),
      .valid_out(valid_out_add6[i]                                          )
    );
  end
endgenerate

wire [          DATA_WIDTH-1:0] out_add7      [(CHANNEL_NUM_IN/128)-1:0];
wire [(CHANNEL_NUM_IN/128)-1:0] valid_out_add7                          ;

generate
  for (i = 0; i < (CHANNEL_NUM_IN/128); i = i + 1) begin
    fp_add_sub inst_add1 (
      .reset    (reset                                                       ),
      .clk      (clk                                                         ),
      .valid_in (valid_out_add6[i] & valid_out_add6[i + (CHANNEL_NUM_IN/128)]),
      .in_a     (out_add6[i]                                                 ),
      .in_b     (out_add6[i + (CHANNEL_NUM_IN/128)]                          ),
      .out      (out_add7[i]                                                 ),
      .valid_out(valid_out_add7[i]                                           )
    );
  end
endgenerate

wire [          DATA_WIDTH-1:0] out_add8      [(CHANNEL_NUM_IN/256)-1:0];
wire [(CHANNEL_NUM_IN/256)-1:0] valid_out_add8                          ;

generate
  for (i = 0; i < (CHANNEL_NUM_IN/256); i = i + 1) begin
    fp_add_sub inst_add1 (
      .reset    (reset                                                       ),
      .clk      (clk                                                         ),
      .valid_in (valid_out_add7[i] & valid_out_add7[i + (CHANNEL_NUM_IN/256)]),
      .in_a     (out_add7[i]                                                 ),
      .in_b     (out_add7[i + (CHANNEL_NUM_IN/256)]                          ),
      .out      (out_add8[i]                                                 ),
      .valid_out(valid_out_add8[i]                                           )
    );
  end
endgenerate

wire [          DATA_WIDTH-1:0] out_add9      [(CHANNEL_NUM_IN/512)-1:0];
wire [(CHANNEL_NUM_IN/512)-1:0] valid_out_add9                          ;

generate
  for (i = 0; i < (CHANNEL_NUM_IN/512); i = i + 1) begin
    fp_add_sub inst_add1 (
      .reset    (reset                                                       ),
      .clk      (clk                                                         ),
      .valid_in (valid_out_add8[i] & valid_out_add8[i + (CHANNEL_NUM_IN/512)]),
      .in_a     (out_add8[i]                                                 ),
      .in_b     (out_add8[i + (CHANNEL_NUM_IN/512)]                          ),
      .out      (out_add9[i]                                                 ),
      .valid_out(valid_out_add9[i]                                           )
    );
  end
endgenerate

fp_add_sub inst_add1 (
  .reset    (reset                                ),
  .clk      (clk                                  ),
  .valid_in (valid_out_add9[0] & valid_out_add9[1]),
  .in_a     (out_add9[0]                          ),
  .in_b     (out_add9[1]                          ),
  .out      (pxl_out                              ),
  .valid_out(valid_out                            )
);

endmodule