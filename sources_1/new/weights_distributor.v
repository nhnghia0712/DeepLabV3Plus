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

module weights_distributor (
    clk
    ,reset
    
    ,valid_weight_in
    ,weight_in

    ,valid_weight_in1 // 7x7
    ,weight_in1

    ,valid_weight_in2 // 3x3_11 layer1
    ,weight_in2

    ,valid_weight_in3 // 3x3_12 layer1
    ,weight_in3

    ,valid_weight_in4 // 3x3_21 layer1
    ,weight_in4

    ,valid_weight_in5 // 3x3_22 layer1
    ,weight_in5

    ,valid_weight_in6 // 3x3_11 layer2
    ,weight_in6

    ,valid_weight_in7 // 3x3_12 layer2
    ,weight_in7

    // ,valid_weight_in8 // 1x1_13 layer2
    // ,weight_in8

    ,valid_weight_in9 // 3x3_21 layer2
    ,weight_in9

    ,valid_weight_in10 // 3x3_22 layer2
    ,weight_in10

    ,valid_weight_in11 // 3x3_11 layer3
    ,weight_in11

    ,valid_weight_in12 // 3x3_12 layer3
    ,weight_in12

    // ,valid_weight_in13 // 1x1_13 layer3
    // ,weight_in13

    ,valid_weight_in14 // 3x3_21 layer3
    ,weight_in14

    ,valid_weight_in15 // 3x3_22 layer3
    ,weight_in15

    ,valid_weight_in16 // 3x3_11 layer4
    ,weight_in16

    ,valid_weight_in17 // 3x3_12 layer4
    ,weight_in17

    // ,valid_weight_in18 // 1x1_13 layer4
    // ,weight_in18

    ,valid_weight_in19 // 3x3_21 layer4
    ,weight_in19

    ,valid_weight_in20 // 3x3_22 layer4
    ,weight_in20

    // ,valid_weight_in21 // ASPP_1
    // ,weight_in21

    // ,valid_weight_in22 // ASPP_21
    // ,weight_in22

    // ,valid_weight_in23 // ASPP_22
    // ,weight_in23

    // ,valid_weight_in24 // ASPP_31
    // ,weight_in24

    // ,valid_weight_in25 // ASPP_32
    // ,weight_in25

    // ,valid_weight_in26 // ASPP_41
    // ,weight_in26

    // ,valid_weight_in27 // ASPP_42
    // ,weight_in27

    // ,valid_weight_in28 // ASPP_5
    // ,weight_in28

    ,valid_weight_in29 // 1x1_1280
    ,weight_in29

    ,valid_weight_in30 // 3x3_256
    ,weight_in30

    ,valid_weight_in31 // 1x1_256
    ,weight_in31

    // ,valid_weight_in32 // Out_layer1_1x1_48
    // ,weight_in32

    ,valid_weight_in33 // 3x3_304
    ,weight_in33

    ,valid_weight_in34 // 1x1_304
    ,weight_in34

    ,valid_weight_in35 // 1x1_7
    ,weight_in35
);

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

parameter WEIGHTS_NUM = 11472752;
parameter CNT_WIDTH   = 24      ; // $clog2(WEIGHTS_NUM) + 1

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk            ;
input                  reset          ;
input                  valid_weight_in;
input [DATA_WIDTH-1:0] weight_in      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output                  valid_weight_in1;
output [DATA_WIDTH-1:0] weight_in1      ;

output                  valid_weight_in2;
output [DATA_WIDTH-1:0] weight_in2      ;

output                  valid_weight_in3;
output [DATA_WIDTH-1:0] weight_in3      ;

output                  valid_weight_in4;
output [DATA_WIDTH-1:0] weight_in4      ;

output                  valid_weight_in5;
output [DATA_WIDTH-1:0] weight_in5      ;

output                  valid_weight_in6;
output [DATA_WIDTH-1:0] weight_in6      ;

output                  valid_weight_in7;
output [DATA_WIDTH-1:0] weight_in7      ;

// output                  valid_weight_in8;
// output [DATA_WIDTH-1:0] weight_in8      ;

output                  valid_weight_in9;
output [DATA_WIDTH-1:0] weight_in9      ;

output                  valid_weight_in10;
output [DATA_WIDTH-1:0] weight_in10      ;

output                  valid_weight_in11;
output [DATA_WIDTH-1:0] weight_in11      ;

output                  valid_weight_in12;
output [DATA_WIDTH-1:0] weight_in12      ;

// output                  valid_weight_in13;
// output [DATA_WIDTH-1:0] weight_in13      ;

output                  valid_weight_in14;
output [DATA_WIDTH-1:0] weight_in14      ;

output                  valid_weight_in15;
output [DATA_WIDTH-1:0] weight_in15      ;

output                  valid_weight_in16;
output [DATA_WIDTH-1:0] weight_in16      ;

output                  valid_weight_in17;
output [DATA_WIDTH-1:0] weight_in17      ;

// output                  valid_weight_in18;
// output [DATA_WIDTH-1:0] weight_in18      ;

output                  valid_weight_in19;
output [DATA_WIDTH-1:0] weight_in19      ;

output                  valid_weight_in20;
output [DATA_WIDTH-1:0] weight_in20      ;

// output                  valid_weight_in21;
// output [DATA_WIDTH-1:0] weight_in21      ;

// output                  valid_weight_in22;
// output [DATA_WIDTH-1:0] weight_in22      ;

// output                  valid_weight_in23;
// output [DATA_WIDTH-1:0] weight_in23      ;

// output                  valid_weight_in24;
// output [DATA_WIDTH-1:0] weight_in24      ;

// output                  valid_weight_in25;
// output [DATA_WIDTH-1:0] weight_in25      ;

// output                  valid_weight_in26;
// output [DATA_WIDTH-1:0] weight_in26      ;

// output                  valid_weight_in27;
// output [DATA_WIDTH-1:0] weight_in27      ;

// output                  valid_weight_in28;
// output [DATA_WIDTH-1:0] weight_in28      ;

output                  valid_weight_in29;
output [DATA_WIDTH-1:0] weight_in29      ;

output                  valid_weight_in30;
output [DATA_WIDTH-1:0] weight_in30      ;

output                  valid_weight_in31;
output [DATA_WIDTH-1:0] weight_in31      ;

// output                  valid_weight_in32;
// output [DATA_WIDTH-1:0] weight_in32      ;

output                  valid_weight_in33;
output [DATA_WIDTH-1:0] weight_in33      ;

output                  valid_weight_in34;
output [DATA_WIDTH-1:0] weight_in34      ;

output                  valid_weight_in35;
output [DATA_WIDTH-1:0] weight_in35      ;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk            ;
wire                  reset          ;
wire                  valid_weight_in;
wire [DATA_WIDTH-1:0] weight_in      ;

reg                  valid_weight_in1;
reg [DATA_WIDTH-1:0] weight_in1      ;

reg                  valid_weight_in2;
reg [DATA_WIDTH-1:0] weight_in2      ;

reg                  valid_weight_in3;
reg [DATA_WIDTH-1:0] weight_in3      ;

reg                  valid_weight_in4;
reg [DATA_WIDTH-1:0] weight_in4      ;

reg                  valid_weight_in5;
reg [DATA_WIDTH-1:0] weight_in5      ;

reg                  valid_weight_in6;
reg [DATA_WIDTH-1:0] weight_in6      ;

reg                  valid_weight_in7;
reg [DATA_WIDTH-1:0] weight_in7      ;

// reg                  valid_weight_in8;
// reg [DATA_WIDTH-1:0] weight_in8      ;

reg                  valid_weight_in9;
reg [DATA_WIDTH-1:0] weight_in9      ;

reg                  valid_weight_in10;
reg [DATA_WIDTH-1:0] weight_in10      ;

reg                  valid_weight_in11;
reg [DATA_WIDTH-1:0] weight_in11      ;

reg                  valid_weight_in12;
reg [DATA_WIDTH-1:0] weight_in12      ;

// reg                  valid_weight_in13;
// reg [DATA_WIDTH-1:0] weight_in13      ;

reg                  valid_weight_in14;
reg [DATA_WIDTH-1:0] weight_in14      ;

reg                  valid_weight_in15;
reg [DATA_WIDTH-1:0] weight_in15      ;

reg                  valid_weight_in16;
reg [DATA_WIDTH-1:0] weight_in16      ;

reg                  valid_weight_in17;
reg [DATA_WIDTH-1:0] weight_in17      ;

// reg                  valid_weight_in18;
// reg [DATA_WIDTH-1:0] weight_in18      ;

reg                  valid_weight_in19;
reg [DATA_WIDTH-1:0] weight_in19      ;

reg                  valid_weight_in20;
reg [DATA_WIDTH-1:0] weight_in20      ;

// reg                  valid_weight_in21;
// reg [DATA_WIDTH-1:0] weight_in21      ;

// reg                  valid_weight_in22;
// reg [DATA_WIDTH-1:0] weight_in22      ;

// reg                  valid_weight_in23;
// reg [DATA_WIDTH-1:0] weight_in23      ;

// reg                  valid_weight_in24;
// reg [DATA_WIDTH-1:0] weight_in24      ;

// reg                  valid_weight_in25;
// reg [DATA_WIDTH-1:0] weight_in25      ;

// reg                  valid_weight_in26;
// reg [DATA_WIDTH-1:0] weight_in26      ;

// reg                  valid_weight_in27;
// reg [DATA_WIDTH-1:0] weight_in27      ;

// reg                  valid_weight_in28;
// reg [DATA_WIDTH-1:0] weight_in28      ;

reg                  valid_weight_in29;
reg [DATA_WIDTH-1:0] weight_in29      ;

reg                  valid_weight_in30;
reg [DATA_WIDTH-1:0] weight_in30      ;

reg                  valid_weight_in31;
reg [DATA_WIDTH-1:0] weight_in31      ;

// reg                  valid_weight_in32;
// reg [DATA_WIDTH-1:0] weight_in32      ;

reg                  valid_weight_in33;
reg [DATA_WIDTH-1:0] weight_in33      ;

reg                  valid_weight_in34;
reg [DATA_WIDTH-1:0] weight_in34      ;

reg                  valid_weight_in35;
reg [DATA_WIDTH-1:0] weight_in35      ;

/////////////////////////////////////////////////////////////////////////
reg [CNT_WIDTH-1:0] counter;

always @(posedge clk) begin
	if(reset) begin
		counter <= {CNT_WIDTH{1'b0}};
	end 
	else if (valid_weight_in && counter < WEIGHTS_NUM) begin
		counter <= counter + 1'b1;
	end
	else begin
		counter <= {CNT_WIDTH{1'b0}};
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in1       <= {DATA_WIDTH{1'b0}};
		valid_weight_in1 <= 1'b0;
	end
	else if ((counter >= 'd0) && (counter < 'd9408))begin
		weight_in1       <= weight_in;
		valid_weight_in1 <= valid_weight_in;
	end
	else begin
		valid_weight_in1 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in2       <= {DATA_WIDTH{1'b0}};
		valid_weight_in2 <= 1'b0;
	end
	else if ((counter >= 'd9408) && (counter < 'd46272))begin
		weight_in2       <= weight_in;
		valid_weight_in2 <= valid_weight_in;
	end
	else begin
		valid_weight_in2 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in3       <= {DATA_WIDTH{1'b0}};
		valid_weight_in3 <= 1'b0;
	end
	else if ((counter >= 'd46272) && (counter < 'd83136))begin
		weight_in3       <= weight_in;
		valid_weight_in3 <= valid_weight_in;
	end
	else begin
		valid_weight_in3 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in4       <= {DATA_WIDTH{1'b0}};
		valid_weight_in4 <= 1'b0;
	end
	else if ((counter >= 'd83136) && (counter < 'd120000))begin
		weight_in4       <= weight_in;
		valid_weight_in4 <= valid_weight_in;
	end
	else begin
		valid_weight_in4 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in5       <= {DATA_WIDTH{1'b0}};
		valid_weight_in5 <= 1'b0;
	end
	else if ((counter >= 'd120000) && (counter < 'd156864))begin
		weight_in5       <= weight_in;
		valid_weight_in5 <= valid_weight_in;
	end
	else begin
		valid_weight_in5 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in6       <= {DATA_WIDTH{1'b0}};
		valid_weight_in6 <= 1'b0;
	end
	else if ((counter >= 'd156864) && (counter < 'd230592))begin
		weight_in6       <= weight_in;
		valid_weight_in6 <= valid_weight_in;
	end
	else begin
		valid_weight_in6 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in7       <= {DATA_WIDTH{1'b0}};
		valid_weight_in7 <= 1'b0;
	end
	else if ((counter >= 'd230592) && (counter < 'd378048))begin
		weight_in7       <= weight_in;
		valid_weight_in7 <= valid_weight_in;
	end
	else begin
		valid_weight_in7 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in9       <= {DATA_WIDTH{1'b0}};
		valid_weight_in9 <= 1'b0;
	end
	else if ((counter >= 'd378048) && (counter < 'd525504))begin
		weight_in9       <= weight_in;
		valid_weight_in9 <= valid_weight_in;
	end
	else begin
		valid_weight_in9 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in10       <= {DATA_WIDTH{1'b0}};
		valid_weight_in10 <= 1'b0;
	end
	else if ((counter >= 'd525504) && (counter < 'd672960))begin
		weight_in10       <= weight_in;
		valid_weight_in10 <= valid_weight_in;
	end
	else begin
		valid_weight_in10 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in11       <= {DATA_WIDTH{1'b0}};
		valid_weight_in11 <= 1'b0;
	end
	else if ((counter >= 'd672960) && (counter < 'd967872))begin
		weight_in11       <= weight_in;
		valid_weight_in11 <= valid_weight_in;
	end
	else begin
		valid_weight_in11 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in12       <= {DATA_WIDTH{1'b0}};
		valid_weight_in12 <= 1'b0;
	end
	else if ((counter >= 'd967872) && (counter < 'd1557696))begin
		weight_in12       <= weight_in;
		valid_weight_in12 <= valid_weight_in;
	end
	else begin
		valid_weight_in12 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in14       <= {DATA_WIDTH{1'b0}};
		valid_weight_in14 <= 1'b0;
	end
	else if ((counter >= 'd1557696) && (counter < 'd2147520))begin
		weight_in14       <= weight_in;
		valid_weight_in14 <= valid_weight_in;
	end
	else begin
		valid_weight_in14 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in15       <= {DATA_WIDTH{1'b0}};
		valid_weight_in15 <= 1'b0;
	end
	else if ((counter >= 'd2147520) && (counter < 'd2737344))begin
		weight_in15       <= weight_in;
		valid_weight_in15 <= valid_weight_in;
	end
	else begin
		valid_weight_in15 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in16       <= {DATA_WIDTH{1'b0}};
		valid_weight_in16 <= 1'b0;
	end
	else if ((counter >= 'd2737344) && (counter < 'd3916992))begin
		weight_in16       <= weight_in;
		valid_weight_in16 <= valid_weight_in;
	end
	else begin
		valid_weight_in16 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in17       <= {DATA_WIDTH{1'b0}};
		valid_weight_in17 <= 1'b0;
	end
	else if ((counter >= 'd3916992) && (counter < 'd6276288))begin
		weight_in17       <= weight_in;
		valid_weight_in17 <= valid_weight_in;
	end
	else begin
		valid_weight_in17 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in19       <= {DATA_WIDTH{1'b0}};
		valid_weight_in19 <= 1'b0;
	end
	else if ((counter >= 'd6276288) && (counter < 'd8635584))begin
		weight_in19       <= weight_in;
		valid_weight_in19 <= valid_weight_in;
	end
	else begin
		valid_weight_in19 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in20       <= {DATA_WIDTH{1'b0}};
		valid_weight_in20 <= 1'b0;
	end
	else if ((counter >= 'd8635584) && (counter < 'd10994880))begin
		weight_in20       <= weight_in;
		valid_weight_in20 <= valid_weight_in;
	end
	else begin
		valid_weight_in20 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in29       <= {DATA_WIDTH{1'b0}};
		valid_weight_in29 <= 1'b0;
	end
	else if ((counter >= 'd10994880) && (counter < 'd11322560))begin
		weight_in29       <= weight_in;
		valid_weight_in29 <= valid_weight_in;
	end
	else begin
		valid_weight_in29 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in30       <= {DATA_WIDTH{1'b0}};
		valid_weight_in30 <= 1'b0;
	end
	else if ((counter >= 'd11322560) && (counter < 'd11324864))begin
		weight_in30       <= weight_in;
		valid_weight_in30 <= valid_weight_in;
	end
	else begin
		valid_weight_in30 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in31       <= {DATA_WIDTH{1'b0}};
		valid_weight_in31 <= 1'b0;
	end
	else if ((counter >= 'd11324864) && (counter < 'd11380992))begin
		weight_in31       <= weight_in;
		valid_weight_in31 <= valid_weight_in;
	end
	else begin
		valid_weight_in31 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in33       <= {DATA_WIDTH{1'b0}};
		valid_weight_in33 <= 1'b0;
	end
	else if ((counter >= 'd11380992) && (counter < 'd11383728))begin
		weight_in33       <= weight_in;
		valid_weight_in33 <= valid_weight_in;
	end
	else begin
		valid_weight_in33 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in34       <= {DATA_WIDTH{1'b0}};
		valid_weight_in34 <= 1'b0;
	end
	else if ((counter >= 'd11383728) && (counter < 'd11470960))begin
		weight_in34       <= weight_in;
		valid_weight_in34 <= valid_weight_in;
	end
	else begin
		valid_weight_in34 <= 1'b0;
	end
end

always @(posedge clk) begin
	if(reset) begin
		weight_in35       <= {DATA_WIDTH{1'b0}};
		valid_weight_in35 <= 1'b0;
	end
	else if ((counter >= 'd11470960) && (counter < 'd11472752))begin
		weight_in35       <= weight_in;
		valid_weight_in35 <= valid_weight_in;
	end
	else begin
		valid_weight_in35 <= 1'b0;
	end
end

endmodule
