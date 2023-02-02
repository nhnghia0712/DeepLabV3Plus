///////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Nguyen Hoang Nghia
//
// Create Date: Mon, May 13, 2022
// Design Name: RAM
// Module Name: ram.v
// Project Name: FIFO
// Target Device:
// Tool Versions: 2019.2
// Description: Synchronous, Depth=8 Synthesizable, freq= 350MHz, RAM-based, not register-based
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
/////////////////////////////////////////////////////////////////////////
module fifo_ram(
    //input
    clk,
    reset,
    write, 
    read, 
    full, 
    empty,
    wr_ptr, 
    rd_ptr,
    data_in,
    //output
    data_out
);
/////////////////////////////////////////////////////////////////////////
// Parameter
parameter DATA_WIDTH    = 32;
parameter DATA_DEPTH    = 13;
parameter POINTER_WIDTH = 4;

/////////////////////////////////////////////////////////////////////////
// Input
input                     clk    ;
input                     reset  ;
input                     write  ;
input                     read   ;
input                     full   ;
input                     empty  ;
input [POINTER_WIDTH-1:0] wr_ptr ;
input [POINTER_WIDTH-1:0] rd_ptr ;
input [   DATA_WIDTH-1:0] data_in;

/////////////////////////////////////////////////////////////////////////
// Output
output [DATA_WIDTH-1:0] data_out ;

/////////////////////////////////////////////////////////////////////////
// Logic
wire                     clk    ;
wire                     reset  ;
wire                     write  ;
wire                     read   ;
wire                     full   ;
wire                     empty  ;
wire [POINTER_WIDTH-1:0] wr_ptr ;
wire [POINTER_WIDTH-1:0] rd_ptr ;
wire [   DATA_WIDTH-1:0] data_in;

reg [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] mem[DATA_DEPTH-1:0];

always @(posedge clk) begin
    if(write && !full)begin
        mem[wr_ptr] <= data_in;
    end
end

always @(posedge clk) begin
    if(reset)begin
        data_out <= {DATA_WIDTH{1'b0}};
    end
    else if(read && !empty)begin
        data_out <= mem[rd_ptr];
    end
end

// assign data_out = (read && !empty) ? mem[rd_ptr]:data_out;

endmodule