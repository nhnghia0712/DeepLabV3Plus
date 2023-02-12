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
parameter DATA_WIDTH = 32;

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
// FIFO
wire [DATA_WIDTH-1:0] pxl_out_fifo_1;
wire                  fifo_empty_1  ;

wire fifo_full_4;

fifo_generator_1 inst_fifo1 (
	//input
	.clk  (clk            ),
	.srst (reset          ),
	.wr_en(valid_in_no1   ),
	.rd_en(fifo_full_4    ),
	.din  (in_no1         ),
	//output
	.dout (pxl_out_fifo_1 ),
	.full (/*fifo_full_1*/),
	.empty(fifo_empty_1   )
);

// FIFO
wire [DATA_WIDTH-1:0] pxl_out_fifo_2;
wire                  fifo_empty_2  ;

fifo_generator_1 inst_fifo2 (
  //input
  .clk  (clk            ),
  .srst (reset          ),
  .wr_en(valid_in_no2   ),
  .rd_en(fifo_empty_1   ),
  .din  (in_no2         ),
  //output
  .dout (pxl_out_fifo_2 ),
  .full (/*fifo_full_2*/),
  .empty(fifo_empty_2   )
);

// FIFO
wire [DATA_WIDTH-1:0] pxl_out_fifo_3;
wire                  fifo_empty_3  ;

fifo_generator_1 inst_fifo3 (
  //input
  .clk  (clk            ),
  .srst (reset          ),
  .wr_en(valid_in_no3   ),
  .rd_en(fifo_empty_2   ),
  .din  (in_no3         ),
  //output
  .dout (pxl_out_fifo_3 ),
  .full (/*fifo_full_3*/),
  .empty(fifo_empty_3   )
);

// FIFO
wire [DATA_WIDTH-1:0] pxl_out_fifo_4;
wire                  fifo_empty_4  ;

fifo_generator_1 inst_fifo4 (
  //input
  .clk  (clk           ),
  .srst (reset         ),
  .wr_en(valid_in_no4  ),
  .rd_en(fifo_empty_3  ),
  .din  (in_no4        ),
  //output
  .dout (pxl_out_fifo_4),
  .full (fifo_full_4   ),
  .empty(fifo_empty_4  )
);

// FIFO
wire [DATA_WIDTH-1:0] pxl_out_fifo_5;
wire                  fifo_empty_5  ;

fifo_generator_1 inst_fifo5 (
  //input
  .clk  (clk                        ),
  .srst (reset                      ),
  .wr_en(valid_in_no5               ),
  .rd_en(fifo_empty_4 & fifo_empty_1),
  .din  (in_no5                     ),
  //output
  .dout (pxl_out_fifo_5             ),
  .full (/*fifo_full_5*/            ),
  .empty(fifo_empty_5               )
);

reg fifo_full_4_next ;
reg fifo_empty_1_next;
reg fifo_empty_2_next;
reg fifo_empty_3_next;
reg fifo_empty_4_next;

always @(posedge clk) begin
  if(reset) begin
    fifo_full_4_next  <= 1'b0;
    fifo_empty_1_next <= 1'b0;
    fifo_empty_2_next <= 1'b0;
    fifo_empty_3_next <= 1'b0;
    fifo_empty_4_next <= 1'b0;
  end
  else begin
    fifo_full_4_next  <= fifo_full_4;
    fifo_empty_1_next <= fifo_empty_1;
    fifo_empty_2_next <= fifo_empty_2;
    fifo_empty_3_next <= fifo_empty_3;
    fifo_empty_4_next <= fifo_empty_4;
  end
end

always @(posedge clk) begin
  if(reset) begin
    out <= 32'd0;
  end
  else begin
    case ({fifo_empty_4_next,fifo_empty_3_next,fifo_empty_2_next,fifo_empty_1_next,fifo_full_4_next})
      5'd1    : out <= pxl_out_fifo_1;
      5'd3    : out <= pxl_out_fifo_2;
      5'd7    : out <= pxl_out_fifo_3;
      5'd14   : out <= pxl_out_fifo_4;
      5'd30   : out <= pxl_out_fifo_5;
      default : out <= out;
    endcase
  end
end

reg valid_out_tmp;

always @(posedge clk) begin
  if(reset) begin
    valid_out_tmp <= 1'b0;
  end
  else begin
    valid_out_tmp <= (!fifo_empty_5 & fifo_empty_4 & fifo_empty_1) | (fifo_empty_3  & !fifo_empty_4) | (fifo_empty_2 & !fifo_empty_3) | (fifo_empty_1 & !fifo_empty_2) | (fifo_full_4 & !fifo_empty_1);
  end
end

always @(posedge clk) begin
  if(reset) begin
    valid_out <= 1'b0;
  end
  else begin
    valid_out <= valid_out_tmp;
  end
end

endmodule


// `timescale 1ns/1ps
// /////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: Nguyen Hoang Nghia

// // Create Date:   
// // Design Name: 
// // Module Name: 
// // Project Name: 
// // Target Device: 
// // Tool Versions:
// // Description:

// // Dependencies:

// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:

// ///////////////////////////////////////////////////////////////////////

// module cnn_concat_5in (
//   clk, 
//   reset,
//   valid_in_no1,
//   in_no1, 
//   valid_in_no2,
//   in_no2, 
//   valid_in_no3,
//   in_no3, 
//   valid_in_no4,
//   in_no4,
//   valid_in_no5,
//   in_no5, 

//   out,
//   valid_out
//   );

// /////////////////////////////////////////////////////////////////////////
// // Parameter Declarations
// parameter DATA_WIDTH = 32;

// /////////////////////////////////////////////////////////////////////////
// // Port Declarations
// input                  clk         ;
// input                  reset       ;
// input                  valid_in_no1;
// input [DATA_WIDTH-1:0] in_no1      ;
// input                  valid_in_no2;
// input [DATA_WIDTH-1:0] in_no2      ;
// input                  valid_in_no3;
// input [DATA_WIDTH-1:0] in_no3      ;
// input                  valid_in_no4;
// input [DATA_WIDTH-1:0] in_no4      ;
// input                  valid_in_no5;
// input [DATA_WIDTH-1:0] in_no5      ;

// /////////////////////////////////////////////////////////////////////////
// // Output Declarations
// output [DATA_WIDTH-1:0] out      ;
// output                  valid_out;

// /////////////////////////////////////////////////////////////////////////
// // Local Logic and Instantiation
// wire                  clk         ;
// wire                  reset       ;
// wire                  valid_in_no1;
// wire [DATA_WIDTH-1:0] in_no1      ;
// wire                  valid_in_no2;
// wire [DATA_WIDTH-1:0] in_no2      ;
// wire                  valid_in_no3;
// wire [DATA_WIDTH-1:0] in_no3      ;
// wire                  valid_in_no4;
// wire [DATA_WIDTH-1:0] in_no4      ;
// wire                  valid_in_no5;
// wire [DATA_WIDTH-1:0] in_no5      ;

// reg [DATA_WIDTH-1:0] out      ;
// reg                  valid_out;

// /////////////////////////////////////////////////////////////////////////
// // FIFO
// reg [DATA_WIDTH-1:0] out_1_2      ;
// reg                  valid_out_1_2;

// always @(posedge clk) begin
//   if(reset) begin
//     out_1_2       <= 32'd0;
//     valid_out_1_2 <= 1'b0;
//   end
//   else if (valid_in_no1) begin
//     out_1_2       <= in_no1;
//     valid_out_1_2 <= valid_in_no1;
//   end
//   else if (valid_in_no2) begin
//     out_1_2       <= in_no2;
//     valid_out_1_2 <= valid_in_no2;
//   end
//   else begin
//     valid_out_1_2 <= 1'b0;
//   end
// end

// wire [DATA_WIDTH-1:0] pxl_out_fifo_1_2;
// wire                  fifo_empty_1_2  ;

// fifo_generator_0 inst_fifo1_2 (
//   //input
//   .clk  (clk              ),
//   .srst (reset            ),
//   .wr_en(valid_out_1_2    ),
//   .rd_en(fifo_full_3_4    ),
//   .din  (out_1_2          ),
//   //output
//   .dout (pxl_out_fifo_1_2 ),
//   .full (/*fifo_full_1_2*/),
//   .empty(fifo_empty_1_2   )
// );


// // FIFO
// reg [DATA_WIDTH-1:0] out_3_4      ;
// reg                  valid_out_3_4;

// always @(posedge clk) begin
//   if(reset) begin
//     out_3_4       <= 32'd0;
//     valid_out_3_4 <= 1'b0;
//   end
//   else if (valid_in_no3) begin
//     out_3_4       <= in_no3;
//     valid_out_3_4 <= valid_in_no3;
//   end
//   else if (valid_in_no4) begin
//     out_3_4       <= in_no4;
//     valid_out_3_4 <= valid_in_no4;
//   end
//   else begin
//     valid_out_3_4 <= 1'b0;
//   end
// end

// wire [DATA_WIDTH-1:0] pxl_out_fifo_3_4;
// wire                  fifo_full_3_4   ;
// wire                  fifo_empty_3_4  ;

// fifo_generator_0 inst_fifo3_4 (
//   //input
//   .clk  (clk             ),
//   .srst (reset           ),
//   .wr_en(valid_out_3_4   ),
//   .rd_en(fifo_empty_1_2  ),
//   .din  (out_3_4         ),
//   //output
//   .dout (pxl_out_fifo_3_4),
//   .full (fifo_full_3_4   ),
//   .empty(fifo_empty_3_4  )
// );

// // FIFO
// wire [DATA_WIDTH-1:0] pxl_out_fifo_5;
// wire                  fifo_empty_5  ;

// fifo_generator_1 inst_fifo5 (
//   //input
//   .clk  (clk            ),
//   .srst (reset          ),
//   .wr_en(valid_in_no5   ),
//   .rd_en(fifo_empty_3_4 ),
//   .din  (in_no5         ),
//   //output
//   .dout (pxl_out_fifo_5 ),
//   .full (/*fifo_full_5*/),
//   .empty(fifo_empty_5   )
// );

// reg fifo_full_3_4_next ;
// reg fifo_empty_1_2_next;
// reg fifo_empty_3_4_next;

// always @(posedge clk) begin
//   if(reset) begin
//     fifo_full_3_4_next  <= 1'b0;
//     fifo_empty_1_2_next <= 1'b0;
//     fifo_empty_3_4_next <= 1'b0;
//   end
//   else begin
//     fifo_full_3_4_next  <= fifo_full_3_4;
//     fifo_empty_1_2_next <= fifo_empty_1_2;
//     fifo_empty_3_4_next <= fifo_empty_3_4;
//   end
// end

// always @(posedge clk) begin
//   if(reset) begin
//     out <= 32'd0;
//   end
//   else begin
//     case ({fifo_empty_3_4_next,fifo_empty_1_2_next,fifo_full_3_4_next})
//       3'd1    : out <= pxl_out_fifo_1_2;
//       3'd2    : out <= pxl_out_fifo_3_4;
//       3'd6    : out <= pxl_out_fifo_5;
//       default : out <= out;
//     endcase
//   end
// end

// reg valid_out_tmp;

// always @(posedge clk) begin
//   if(reset) begin
//     valid_out_tmp <= 1'b0;
//   end
//   else begin
//     valid_out_tmp <= (fifo_empty_1_2 & !fifo_empty_3_4) | (fifo_empty_3_4 & !fifo_empty_5) | (fifo_full_3_4 & !fifo_empty_1_2);
//   end
// end

// always @(posedge clk) begin
//   if(reset) begin
//     valid_out <= 1'b0;
//   end
//   else begin
//     valid_out <= valid_out_tmp;
//   end
// end

// endmodule
