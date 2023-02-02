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

module conv_channel_in_adder_32x32 (
  clk, 
  reset,
  valid_in,
  pxl_in,

  pxl_out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH           = 32                        ;
parameter IMAGE_SIZE           = 32 * 32                   ;
parameter CHANNEL_NUM_IN       = 256                       ;
parameter POINTER_WIDTH        = $clog2(IMAGE_SIZE) + 1    ;
parameter CNT_CHANNEL_IN_WIDTH = $clog2(CHANNEL_NUM_IN) + 1;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk             ;
input                  reset           ;
input                  valid_in        ;
input [DATA_WIDTH-1:0] pxl_in;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] pxl_out  ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk     ;
wire                  reset   ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] pxl_in  ;

wire [DATA_WIDTH-1:0] pxl_out  ;
wire                  valid_out;

wire [DATA_WIDTH-1:0] pxl_in_next  ;
wire                  valid_in_next;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff00 (
  .clk      (clk          ),
  .reset    (reset        ),
  .valid_in (valid_in     ),
  .in       (pxl_in       ),
  .out      (pxl_in_next  ),
  .valid_out(valid_in_next)
);

wire [DATA_WIDTH-1:0] pxl_in_dff  ;
wire                  valid_in_dff;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff01 (
  .clk      (clk          ),
  .reset    (reset        ),
  .valid_in (valid_in_next),
  .in       (pxl_in_next  ),
  .out      (pxl_in_dff   ),
  .valid_out(valid_in_dff )
);

reg [POINTER_WIDTH-1:0] cnt_size;

always @(posedge clk) begin
  if(reset) begin
    cnt_size <= {POINTER_WIDTH{1'b0}};
  end
  else if (valid_in && cnt_size < IMAGE_SIZE) begin
    cnt_size <= cnt_size + 1'b1;
  end
  else begin
    cnt_size <= {POINTER_WIDTH{1'b0}};
  end
end

reg [CNT_CHANNEL_IN_WIDTH-1:0] cnt_channel;

always @(posedge clk) begin
  if(reset) begin
    cnt_channel <= {CNT_CHANNEL_IN_WIDTH{1'b0}};
  end
  else if (!(|cnt_size[POINTER_WIDTH-1:1]) && cnt_size[0]) begin
    if (cnt_channel < CHANNEL_NUM_IN) begin
      cnt_channel <= cnt_channel + 1'b1;
    end
    else begin
      cnt_channel <= {{CNT_CHANNEL_IN_WIDTH-1{1'b0}},1'b1};
    end
  end
end

wire [DATA_WIDTH-1:0] out_add      ;
wire                  valid_out_add;

wire [DATA_WIDTH-1:0] out_fifo      ;
wire                  valid_out_fifo;

wire [DATA_WIDTH-1:0] out_sel      ;
wire                  valid_out_sel;

assign out_sel       = (cnt_channel < {{CNT_CHANNEL_IN_WIDTH-2{1'b0}},1'b1,1'b0}) ? 32'd0:out_fifo;
assign valid_out_sel = (cnt_channel < {{CNT_CHANNEL_IN_WIDTH-2{1'b0}},1'b1,1'b0}) ? 1'b1:valid_out_fifo;

reg [POINTER_WIDTH-1:0] cnt_size_add;

always @(posedge clk) begin
  if(reset) begin
    cnt_size_add <= {POINTER_WIDTH{1'b0}};
  end
  else if (valid_out_add && cnt_size_add < IMAGE_SIZE) begin
    cnt_size_add <= cnt_size_add + 1'b1;
  end
  else begin
    cnt_size_add <= {POINTER_WIDTH{1'b0}};
  end
end

reg [CNT_CHANNEL_IN_WIDTH-1:0] cnt_channel_add;

always @(posedge clk) begin
  if(reset) begin
    cnt_channel_add <= {CNT_CHANNEL_IN_WIDTH{1'b0}};
  end
  else if (!(|cnt_size_add[POINTER_WIDTH-1:0]) && valid_out_add) begin
    if (cnt_channel_add < CHANNEL_NUM_IN) begin
      cnt_channel_add <= cnt_channel_add + 1'b1;
    end
    else begin
      cnt_channel_add <= {{CNT_CHANNEL_IN_WIDTH-1{1'b0}},1'b1};
    end
  end
end

assign pxl_out   = ((cnt_channel_add == CHANNEL_NUM_IN) && valid_out_add_next && (|cnt_size_add[POINTER_WIDTH-1:0])) ? out_add_next:32'd0;
assign valid_out = ((cnt_channel_add == CHANNEL_NUM_IN) && valid_out_add_next && (|cnt_size_add[POINTER_WIDTH-1:0])) ? valid_out_add_next:1'b0;

wire fifo_full;

// fp_add_sub inst_add1 (
//   .reset    (reset                       ),
//   .clk      (clk                         ),
//   .valid_in (valid_in_dff & valid_out_sel),
//   .in_a     (pxl_in_dff                  ),
//   .in_b     (out_sel                     ),
//   .out      (out_add                     ),
//   .valid_out(valid_out_add               )
// );

floating_point_1_add inst_add1 (
  .aresetn             (~reset       ),
  .aclk                (clk          ),
  .s_axis_a_tvalid     (valid_in_dff ),
  .s_axis_a_tdata      (pxl_in_dff   ),
  .s_axis_b_tvalid     (valid_out_sel),
  .s_axis_b_tdata      (out_sel      ),
  .m_axis_result_tdata (out_add      ),
  .m_axis_result_tvalid(valid_out_add)
);

// DFF
wire [DATA_WIDTH-1:0] out_add_next      ;
wire                  valid_out_add_next;

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff03 (
  .clk      (clk               ),
  .reset    (reset             ),
  .valid_in (valid_out_add     ),
  .in       (out_add           ),
  .out      (out_add_next      ),
  .valid_out(valid_out_add_next)
);

reg read_en;

always @(posedge clk) begin
  if(reset) begin
    read_en <= 1'b0;
  end
  else if (fifo_full) begin
    read_en <= 1'b1;
  end
end

wire [DATA_WIDTH-1:0] out_fifo_next      ;
reg                   valid_out_fifo_next;

fifo_generator_7_1024 inst_fifo07 (
  //input
  .clk  (clk               ),
  .srst (reset             ),
  .wr_en(valid_out_add     ),
  .rd_en(valid_in & read_en),
  .din  (out_add           ),
  //output
  .dout (out_fifo_next     ),
  .full (fifo_full         ),
  .empty(/*no use*/        )
);

always @(posedge clk) begin
  if(reset) begin
    valid_out_fifo_next <= 1'b0;
  end
  else begin
    valid_out_fifo_next <= valid_in & read_en;
  end
end

d_flip_flop #(.DATA_WIDTH(DATA_WIDTH)) dff02 (
  .clk      (clk                ),
  .reset    (reset              ),
  .valid_in (valid_out_fifo_next),
  .in       (out_fifo_next      ),
  .out      (out_fifo           ),
  .valid_out(valid_out_fifo     )
);

endmodule