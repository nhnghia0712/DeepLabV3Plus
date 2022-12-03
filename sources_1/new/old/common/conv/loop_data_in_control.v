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
module loop_data_in_control(
    // Input
    reset, 
    clk, 
    write,
    read,
    // Output
    wr_ptr, 
    rd_ptr
);

/////////////////////////////////////////////////////////////////////////
// Parameter
parameter CHANNEL_NUM_IN_PIXEL = 72;
parameter POINTER_WIDTH_LOOP   = 7 ;

/////////////////////////////////////////////////////////////////////////
// Input
input reset;
input clk  ;
input write;
input read ;

/////////////////////////////////////////////////////////////////////////
// Output
output [POINTER_WIDTH_LOOP-1:0] wr_ptr;
output [POINTER_WIDTH_LOOP-1:0] rd_ptr;

/////////////////////////////////////////////////////////////////////////
// Logic
wire reset;
wire clk  ;
wire write;
wire read ;

wire [POINTER_WIDTH_LOOP-1:0] wr_ptr;
wire [POINTER_WIDTH_LOOP-1:0] rd_ptr;

reg [POINTER_WIDTH_LOOP:0] wr_ptr_next;
reg [POINTER_WIDTH_LOOP:0] rd_ptr_next;

// reg read_next;

///////////////////////////////////////////////////
// Count pointer
always @(posedge clk ) begin
    if(reset)begin
        wr_ptr_next <= {POINTER_WIDTH_LOOP+1{1'b0}};
    end
    else if(wr_ptr == CHANNEL_NUM_IN_PIXEL - 1) begin
        wr_ptr_next <= {1'b1,{POINTER_WIDTH_LOOP{1'b0}}};
    end
    else if (write) begin
        wr_ptr_next <= wr_ptr_next + 1'b1;
    end
end

always @(posedge clk ) begin
    if(reset)begin
        rd_ptr_next <= {POINTER_WIDTH_LOOP+1{1'b0}};
    end
    else if(rd_ptr == CHANNEL_NUM_IN_PIXEL - 1) begin
        rd_ptr_next <= {1'b1,{POINTER_WIDTH_LOOP{1'b0}}};
    end
    else if (read) begin
        rd_ptr_next <= rd_ptr_next + 1'b1;
    end
end

assign wr_ptr = wr_ptr_next[POINTER_WIDTH_LOOP-1:0];
assign rd_ptr = rd_ptr_next[POINTER_WIDTH_LOOP-1:0];

///////////////////////////////////////////////////
// Read loop data
// reg [CNT_WIDTH_LOOP-1:0] cnt_channel_out;

// always @(posedge clk) begin
//     if(reset) begin
//         cnt_channel_out <= {CNT_WIDTH_LOOP{1'b0}};
//     end 
//     else if(rd_ptr == (CHANNEL_NUM_IN_PIXEL - 1) && read) begin
//         cnt_channel_out <= cnt_channel_out + 1'b1;
//     end
// end

// always @(posedge clk) begin
//     if(reset) begin
//         read_next <= 1'b0;
//     end 
//     else if(cnt_channel_out < CHANNEL_NUM_OUT) begin
//         read_next <= 1'b1;
//     end
//     else begin
//         read_next <= 1'b0;
//     end
// end

// always @(posedge clk) begin
//     if(reset) begin
//         read <= 1'b0;
//     end 
//     else begin
//         read <= read_next;
//     end
// end

endmodule