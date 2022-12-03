///////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Nguyen Hoang Nghia
//
// Create Date: Mon, May 13, 2022
// Design Name:
// Module Name: 
// Project Name: 
// Target Device:
// Tool Versions: 
// Description: 
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
/////////////////////////////////////////////////////////////////////////
module loop_data_in_mem(
    //input
    clk,
    reset,
    write, 
    read, 
    wr_ptr, 
    rd_ptr,
    data_in,
    //output
    data_out,
    valid_out
);
/////////////////////////////////////////////////////////////////////////
// Parameter
parameter DATA_WIDTH           = 2;
parameter CHANNEL_NUM_IN_PIXEL = 2;
parameter POINTER_WIDTH_LOOP   = 7;

/////////////////////////////////////////////////////////////////////////
// Input
input                          clk    ;
input                          reset  ;
input                          write  ;
input                          read   ;
input [POINTER_WIDTH_LOOP-1:0] wr_ptr ;
input [POINTER_WIDTH_LOOP-1:0] rd_ptr ;
input [        DATA_WIDTH-1:0] data_in;

/////////////////////////////////////////////////////////////////////////
// Output
output [DATA_WIDTH-1:0] data_out ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Logic
wire                          clk    ;
wire                          reset  ;
wire                          write  ;
wire                          read   ;
wire [POINTER_WIDTH_LOOP-1:0] wr_ptr ;
wire [POINTER_WIDTH_LOOP-1:0] rd_ptr ;
wire [        DATA_WIDTH-1:0] data_in;

reg [DATA_WIDTH-1:0] data_out ;
reg                  valid_out;

// (* ram_style = "ultra" *)
reg [DATA_WIDTH-1:0] mem[CHANNEL_NUM_IN_PIXEL-1:0];

always @(posedge clk) begin
    if(write)begin
        mem[wr_ptr] <= data_in;
    end
end

always @(posedge clk) begin
    if(reset)begin
        data_out  <= {DATA_WIDTH{1'b0}};
        valid_out <= 1'b0;
    end
    else if(read)begin
        data_out  <= mem[rd_ptr];
        valid_out <= 1'b1;
    end
    else begin
        valid_out <= 1'b0;
    end
end

endmodule