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
module cnn_sigmoid_top_synth (
	clk
	,rst_n
	,start
	,in_fp 
	,rom_val

	,addr
	,read_en
	,out_fp
	,top_overflow
	,top_underflow
	,done
);
/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input        clk    ;
input        rst_n  ;
input        start  ;
input [31:0] in_fp  ;
input [31:0] rom_val;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [ 4:0] addr         ;
output        read_en      ;
output [31:0] out_fp       ;
output        top_overflow ;
output        top_underflow;
output        done         ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire        clk    ;
wire        rst_n  ;
wire        start  ;
wire [31:0] in_fp  ;
wire [31:0] rom_val;

wire [ 4:0] addr         ;
wire        read_en      ;
wire [31:0] out_fp       ;
wire        top_overflow ;
wire        top_underflow;
wire        done         ;

/////////////////////////////////////////////////////////////////////////
// Align output
// FIFO
reg start_sigmoid;

wire [DATA_WIDTH-1:0] pxl_out_fifo_1;
wire                  fifo_full_1   ;
wire                  fifo_empty_1  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_2;
wire                  fifo_full_2   ;
wire                  fifo_empty_2  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_3;
wire                  fifo_full_3   ;
wire                  fifo_empty_3  ;

wire [DATA_WIDTH-1:0] pxl_out_fifo_4;
wire                  fifo_full_4   ;
wire                  fifo_empty_4  ;

reg [DATA_WIDTH-1:0] out_pre_sigmoid      ;
reg                  valid_out_pre_sigmoid;

fifo_generator_0 inst_fifo1 (
	//input
	.clk  (clk                        ),
	.srst (~rst_n                     ),
	.wr_en(start                      ),
	.rd_en(start_sigmoid & fifo_full_4),
	.din  (in_fp                      ),
	//output
	.dout (pxl_out_fifo_1             ),
	.full (fifo_full_1                ),
	.empty(fifo_empty_1               )
);

fifo_generator_0 inst_fifo2 (
	//input
	.clk  (clk                         ),
	.srst (~rst_n                      ),
	.wr_en(start & fifo_full_1         ),
	.rd_en(fifo_empty_1 & start_sigmoid),
	.din  (in_fp                       ),
	//output
	.dout (pxl_out_fifo_2              ),
	.full (fifo_full_2                 ),
	.empty(fifo_empty_2                )
);

fifo_generator_0 inst_fifo3 (
	//input
	.clk  (clk                         ),
	.srst (~rst_n                      ),
	.wr_en(start & fifo_full_2         ),
	.rd_en(fifo_empty_2 & start_sigmoid),
	.din  (in_fp                       ),
	//output
	.dout (pxl_out_fifo_3              ),
	.full (fifo_full_3                 ),
	.empty(fifo_empty_3                )
);

fifo_generator_1 inst_fifo4 (
	//input
	.clk  (clk                         ),
	.srst (~rst_n                      ),
	.wr_en(start & fifo_full_3         ),
	.rd_en(fifo_empty_3 & start_sigmoid),
	.din  (in_fp                       ),
	//output
	.dout (pxl_out_fifo_4              ),
	.full (fifo_full_4                 ),
	.empty(fifo_empty_4                )
);

reg fifo_full_4_next ;
reg fifo_empty_1_next;
reg fifo_empty_2_next;
reg fifo_empty_3_next;

always @(posedge clk) begin
    if(~rst_n) begin
        fifo_full_4_next  <= 1'b0;
        fifo_empty_1_next <= 1'b0;
        fifo_empty_2_next <= 1'b0;
        fifo_empty_3_next <= 1'b0;
    end
    else begin
        fifo_full_4_next  <= fifo_full_4;
        fifo_empty_1_next <= fifo_empty_1;
        fifo_empty_2_next <= fifo_empty_2;
        fifo_empty_3_next <= fifo_empty_3;
    end
end

always @(posedge clk) begin
	if(~rst_n) begin
		out_pre_sigmoid <= 32'd0;
	end
	else begin
		casex ({fifo_empty_3_next,fifo_empty_2_next,fifo_empty_1_next,fifo_full_4})
			4'b0001  : out_pre_sigmoid <= pxl_out_fifo_1;
			4'b0011  : out_pre_sigmoid <= pxl_out_fifo_2;
			4'b0111  : out_pre_sigmoid <= pxl_out_fifo_3;
			4'b1110  : out_pre_sigmoid <= pxl_out_fifo_4;
			default : out_pre_sigmoid <= out_pre_sigmoid;
		endcase
	end
end

reg valid_out_tmp;

always @(posedge clk) begin
    if(~rst_n) begin
        valid_out_tmp <= 1'b0;
    end
    else begin
        valid_out_tmp <= (start_sigmoid & fifo_empty_3 & !fifo_empty_4) | (start_sigmoid & fifo_empty_2 & !fifo_empty_3) | (start_sigmoid & fifo_empty_1 & !fifo_empty_2) | (start_sigmoid & fifo_full_4 & !fifo_empty_1);
    end
end

always @(posedge clk) begin
    if(~rst_n) begin
        valid_out_pre_sigmoid <= 1'b0;
    end
    else begin
        valid_out_pre_sigmoid <= valid_out_tmp;
    end
end

reg [2:0] counter;

reg start_01;
reg start_02;

always @(posedge clk) begin
    if(~rst_n) begin
        counter <= 3'd0;
    end 
    else if (fifo_full_4 && (counter < 2)) begin
       counter <= counter + 1'b1;
    end
end

always @(posedge clk) begin
	if(~rst_n) begin
		start_01 <= 1'b0;
	end
	else if (!(|counter[2:1]) && counter[0]) begin
		start_01 <= 1'b1;
	end
	else begin
		start_01 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(~rst_n) begin
		start_02 <= 1'b0;
	end
	else  begin
		start_02 <= done;
	end
end

always @(posedge clk) begin
	if(~rst_n) begin
		start_sigmoid <= 1'b0;
	end
	else  begin
		start_sigmoid <= start_01 | start_02;
	end
end

// Sigmoid
cnn_sigmoid_synth sigmoid (
	.in_fp        (out_pre_sigmoid      ),
	.out_fp       (out_fp               ),
	.clk          (clk                  ),
	.rst_n        (rst_n                ),
	.start        (valid_out_pre_sigmoid),
	.done         (done                 ),
	.rom_val      (rom_val              ),
	.addr         (addr                 ),
	.read_en      (read_en              ),
	.top_overflow (top_overflow         ),
	.top_underflow(top_underflow        )
);

endmodule