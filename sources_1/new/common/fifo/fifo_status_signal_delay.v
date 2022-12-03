///////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Nguyen Hoang Nghia
//
// Create Date: Mon, May 13, 2022
// Design Name: Status Signal
// Module Name: status_signal.v
// Project Name: FIFO
// Target Device: 
// Tool Versions: 2019.2
// Description: Synchronous, Depth=8, Synthesizable, freq= 350MHz, RAM-based, not register-based
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
/////////////////////////////////////////////////////////////////////////
module fifo_status_signal_delay(
    // Input
    reset, 
    clk, 
    write,
    read,
    wr_ptr, 
    rd_ptr,
    // Output
    full, 
    empty
);

/////////////////////////////////////////////////////////////////////////
// Parameter
parameter POINTER_WIDTH = 4 ;
parameter DATA_DEPTH    = 13;

/////////////////////////////////////////////////////////////////////////
// Input
input reset;
input clk  ;
input write;
input read ;

/////////////////////////////////////////////////////////////////////////
// Output
output [POINTER_WIDTH-1:0] wr_ptr;
output [POINTER_WIDTH-1:0] rd_ptr;
output                     full  ;
output                     empty ;

/////////////////////////////////////////////////////////////////////////
// Logic
wire reset;
wire clk  ;
wire write;
wire read ;

wire  [POINTER_WIDTH-1:0] wr_ptr;
wire [POINTER_WIDTH-1:0] rd_ptr;
wire                     full  ;
wire                     empty ;

reg  [POINTER_WIDTH:0] wr_ptr_next;
reg  [POINTER_WIDTH:0] rd_ptr_next;

wire enable_write;
wire enable_read ;

wire ptr_equal_signal;

assign ptr_equal_signal = (wr_ptr_next[POINTER_WIDTH-1:0] == rd_ptr_next[POINTER_WIDTH-1:0]);

assign full  = (wr_ptr_next[POINTER_WIDTH] ^ rd_ptr_next[POINTER_WIDTH]) & ptr_equal_signal;
assign empty = (wr_ptr_next[POINTER_WIDTH] ~^ rd_ptr_next[POINTER_WIDTH]) & ptr_equal_signal;

assign enable_write = write & !full;
assign enable_read  = read & !empty;

always @(posedge clk ) begin
    if(reset)begin
        wr_ptr_next <= {POINTER_WIDTH+1{1'b0}};
    end
    else if(wr_ptr == DATA_DEPTH) begin
        wr_ptr_next <= {1'b1,{POINTER_WIDTH{1'b0}}};
    end
    else if (enable_write) begin
        wr_ptr_next <= wr_ptr_next + 1'b1;
    end
end

always @(posedge clk ) begin
    if(reset)begin
        rd_ptr_next <= {POINTER_WIDTH+1{1'b0}};
    end
    else if(rd_ptr == DATA_DEPTH) begin
        rd_ptr_next <= {1'b1,{POINTER_WIDTH{1'b0}}};
    end
    else if (enable_read) begin

        rd_ptr_next <= rd_ptr_next + 1'b1;
    end
end

assign wr_ptr = wr_ptr_next[POINTER_WIDTH-1:0];
assign rd_ptr = rd_ptr_next[POINTER_WIDTH-1:0];

endmodule