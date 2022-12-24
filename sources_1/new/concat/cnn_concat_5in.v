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

module cnn_concat_5in (
  clk, 
  reset,
  valid_in_no1,
  in_no1, 
  valid_in_no2,
  in_no2, 
  valid_in_no3,
  in_no3, 
  valid_in_no4,
  in_no4,
  valid_in_no5,
  in_no5, 

  out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH        = 32                       ;
parameter CHANNEL_NUM_PIXEL = 153*153                  ; //The number of channel 6x6x4
parameter POINTER_WIDTH     = $clog2(CHANNEL_NUM_PIXEL); //$clog2(CHANNEL_NUM_PIXEL)

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk         ;
input                  reset       ;
input                  valid_in_no1;
input [DATA_WIDTH-1:0] in_no1      ;
input                  valid_in_no2;
input [DATA_WIDTH-1:0] in_no2      ;
input                  valid_in_no3;
input [DATA_WIDTH-1:0] in_no3      ;
input                  valid_in_no4;
input [DATA_WIDTH-1:0] in_no4      ;
input                  valid_in_no5;
input [DATA_WIDTH-1:0] in_no5      ;

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
wire                  valid_in_no3;
wire [DATA_WIDTH-1:0] in_no3      ;
wire                  valid_in_no4;
wire [DATA_WIDTH-1:0] in_no4      ;
wire                  valid_in_no5;
wire [DATA_WIDTH-1:0] in_no5      ;

reg [DATA_WIDTH-1:0] out      ;
reg                  valid_out;

/////////////////////////////////////////////////////////////////////////
reg read_req_no1;

wire [DATA_WIDTH-1:0] out_fifo_no1      ;
wire                  valid_out_fifo_no1;
wire                  fifo_full_no1     ;
wire                  fifo_empty_no1    ;

cnn_fifo_other #(
  .DATA_WIDTH   (DATA_WIDTH       ),
  .DATA_DEPTH   (CHANNEL_NUM_PIXEL),
  .POINTER_WIDTH(POINTER_WIDTH    )
) inst_fifo_no1 (
  //input
  .clk      (clk               ),
  .reset    (reset             ),
  .write    (valid_in_no1      ),
  .read     (read_req_no1      ),
  .data_in  (in_no1            ),
  //output
  .data_out (out_fifo_no1      ),
  .valid_out(valid_out_fifo_no1),
  .empty    (fifo_empty_no1    ),
  .full     (fifo_full_no1     )
);              

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_fifo_no2      ;
wire                  valid_out_fifo_no2;
wire                  fifo_full_no2     ;
wire                  fifo_empty_no2    ;

cnn_fifo_other #(
  .DATA_WIDTH   (DATA_WIDTH       ),
  .DATA_DEPTH   (CHANNEL_NUM_PIXEL),
  .POINTER_WIDTH(POINTER_WIDTH    )
) inst_fifo_no2 (
  //input
  .clk      (clk               ),
  .reset    (reset             ),
  .write    (valid_in_no2      ),
  .read     (fifo_empty_no1    ),
  .data_in  (in_no2            ),
  //output
  .data_out (out_fifo_no2      ),
  .valid_out(valid_out_fifo_no2),
  .empty    (fifo_empty_no2    ),
  .full     (fifo_full_no2     )
);            

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_fifo_no3      ;
wire                  valid_out_fifo_no3;
wire                  fifo_full_no3     ;
wire                  fifo_empty_no3    ;

cnn_fifo_other #(
  .DATA_WIDTH   (DATA_WIDTH       ),
  .DATA_DEPTH   (CHANNEL_NUM_PIXEL),
  .POINTER_WIDTH(POINTER_WIDTH    )
) inst_fifo_no3 (
  //input
  .clk      (clk               ),
  .reset    (reset             ),
  .write    (valid_in_no3      ),
  .read     (fifo_empty_no2    ),
  .data_in  (in_no3            ),
  //output
  .data_out (out_fifo_no3      ),
  .valid_out(valid_out_fifo_no3),
  .empty    (fifo_empty_no3    ),
  .full     (fifo_full_no3     )
);  

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_fifo_no4      ;
wire                  valid_out_fifo_no4;
wire                  fifo_full_no4     ;
wire                  fifo_empty_no4    ;

cnn_fifo_other #(
  .DATA_WIDTH   (DATA_WIDTH       ),
  .DATA_DEPTH   (CHANNEL_NUM_PIXEL),
  .POINTER_WIDTH(POINTER_WIDTH    )
) inst_fifo_no4 (
  //input
  .clk      (clk               ),
  .reset    (reset             ),
  .write    (valid_in_no4      ),
  .read     (fifo_empty_no3    ),
  .data_in  (in_no4            ),
  //output
  .data_out (out_fifo_no4      ),
  .valid_out(valid_out_fifo_no4),
  .empty    (fifo_empty_no4    ),
  .full     (fifo_full_no4     )
);  

/////////////////////////////////////////////////////////////////////////
wire [DATA_WIDTH-1:0] out_fifo_no5      ;
wire                  valid_out_fifo_no5;
// wire                  fifo_full_no5     ;
// wire                  fifo_empty_no5    ;

cnn_fifo_other #(
  .DATA_WIDTH   (DATA_WIDTH       ),
  .DATA_DEPTH   (CHANNEL_NUM_PIXEL),
  .POINTER_WIDTH(POINTER_WIDTH    )
) inst_fifo_no5 (
  //input
  .clk      (clk               ),
  .reset    (reset             ),
  .write    (valid_in_no5      ),
  .read     (fifo_empty_no4    ),
  .data_in  (in_no5            ),
  //output
  .data_out (out_fifo_no5      ),
  .valid_out(valid_out_fifo_no5),
  .empty    (/*fifo_empty_no5*/),
  .full     (/*fifo_full_no5 */)
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

/////////////////////////////////////////////////////////////////////////
always @(posedge clk) begin
  if (reset) begin
    out       <= {DATA_WIDTH{1'b0}};
    valid_out <= 1'b0;
  end
  else if(valid_out_fifo_no1) begin
    out       <= out_fifo_no1;
    valid_out <= valid_out_fifo_no1;
  end
  else if(valid_out_fifo_no2) begin
    out       <= out_fifo_no2;
    valid_out <= valid_out_fifo_no2;
  end
  else if(valid_out_fifo_no3) begin
    out       <= out_fifo_no3;
    valid_out <= valid_out_fifo_no3;
  end
  else if(valid_out_fifo_no4) begin
    out       <= out_fifo_no4;
    valid_out <= valid_out_fifo_no4;
  end
  else if(valid_out_fifo_no5) begin
    out       <= out_fifo_no5;
    valid_out <= valid_out_fifo_no5;
  end
  else begin
    valid_out <= 1'b0;
  end
end

/////////////////////////////////////////////////////////////////////////

endmodule


