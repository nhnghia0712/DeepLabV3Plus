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

module cnn_conv_relu (
  clk, 
  reset,
  valid_in,
  in, 

  out,
  valid_out
  );

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

/////////////////////////////////////////////////////////////////////////
// Port Declarations
input                  clk     ;
input                  reset   ;
input                  valid_in;
input [DATA_WIDTH-1:0] in      ;

/////////////////////////////////////////////////////////////////////////
// Output Declarations
output [DATA_WIDTH-1:0] out      ;
output                  valid_out;

/////////////////////////////////////////////////////////////////////////
// Local Logic and Instantiation
wire                  clk     ;
wire                  reset   ;
wire                  valid_in;
wire [DATA_WIDTH-1:0] in      ;

reg [DATA_WIDTH-1:0] out      ;
reg                  valid_out;

always @(posedge clk) begin
  if(reset) begin
    out       <= {DATA_WIDTH{1'b0}};
    valid_out <= 1'b0;
  end
  else if (valid_in) begin
    if (in[DATA_WIDTH-1]) begin
      out       <= {DATA_WIDTH{1'b0}};
      valid_out <= 1'b1;
    end
    else begin
      out       <= in;
      valid_out <= 1'b1;
    end
  end
  else begin
    valid_out <= 1'b0;
  end
end

endmodule


