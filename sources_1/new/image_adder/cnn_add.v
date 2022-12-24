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

module cnn_add (
  clk, 
  reset,
  valid_in_no1,
  in_no1, 
  valid_in_no2,
  in_no2, 

  out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH        = 32                       ;
parameter CHANNEL_NUM_PIXEL = 612*612                  ; //The number of channel 6x6x4
parameter POINTER_WIDTH     = $clog2(CHANNEL_NUM_PIXEL); //$clog2(CHANNEL_NUM_PIXEL)

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk         ;
input                  reset       ;
input                  valid_in_no1;
input [DATA_WIDTH-1:0] in_no1      ;
input                  valid_in_no2;
input [DATA_WIDTH-1:0] in_no2      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] out      ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk         ;
wire                  reset       ;
wire                  valid_in_no1;
wire [DATA_WIDTH-1:0] in_no1      ;
wire                  valid_in_no2;
wire [DATA_WIDTH-1:0] in_no2      ;

wire [DATA_WIDTH-1:0] out      ;
wire                  valid_out;

/////////////////////////////////////////////////////////////////////////
reg read_req_no1;

wire [DATA_WIDTH-1:0] out_fifo_no1      ;
wire                  valid_out_fifo_no1;
wire                  fifo_full_no1     ;

cnn_fifo_other #(
  .DATA_WIDTH   (DATA_WIDTH       ),
  .DATA_DEPTH   (CHANNEL_NUM_PIXEL),
  .POINTER_WIDTH(POINTER_WIDTH    )
) inst_fifo_no1 (
  //input
  .clk      (clk                        ),
  .reset    (reset                      ),
  .write    (valid_in_no1               ),
  .read     (read_req_no1 & read_req_no2),
  .data_in  (in_no1                     ),
  //output
  .data_out (out_fifo_no1               ),
  .valid_out(valid_out_fifo_no1         ),
  .empty    (/*fifo_empty_no1 no use*/  ),
  .full     (fifo_full_no1              )
);                 

/////////////////////////////////////////////////////////////////////////
reg read_req_no2;

wire [DATA_WIDTH-1:0] out_fifo_no2      ;
wire                  valid_out_fifo_no2;
wire                  fifo_full_no1     ;

cnn_fifo_other #(
  .DATA_WIDTH   (DATA_WIDTH       ),
  .DATA_DEPTH   (CHANNEL_NUM_PIXEL),
  .POINTER_WIDTH(POINTER_WIDTH    )
) inst_fifo_no2 (
  //input
  .clk      (clk                       ),
  .reset    (reset                     ),
  .write    (valid_in_no2              ),
  .read     (read_req_no1 & read_req_no2),
  .data_in  (in_no2                    ),
  //output
  .data_out (out_fifo_no2              ),
  .valid_out(valid_out_fifo_no2        ),
  .empty    (/*fifo_empty_no2 no use*/ ),
  .full     (fifo_full_no2             )
);              

/////////////////////////////////////////////////////////////////////////
always @(posedge clk) begin
  if (reset) begin
    read_req_no1 <= 1'b0;
  end
  else if(fifo_full_no1) begin
    read_req_no1 <= 1'b1;
  end
end

always @(posedge clk) begin
  if (reset) begin
    read_req_no2 <= 1'b0;
  end
  else if(fifo_full_no2) begin
    read_req_no2 <= 1'b1;
  end
end

/////////////////////////////////////////////////////////////////////////
fp_add_sub #(.DATA_WIDTH(DATA_WIDTH)) inst_add (
  .reset    (reset                                  ),
  .clk      (clk                                    ),
  .valid_in (valid_out_fifo_no1 & valid_out_fifo_no2),
  .in_a     (out_fifo_no1                           ),
  .in_b     (out_fifo_no2                           ),
  .out      (out                                    ),
  .valid_out(valid_out                              )
);

/////////////////////////////////////////////////////////////////////////

endmodule


