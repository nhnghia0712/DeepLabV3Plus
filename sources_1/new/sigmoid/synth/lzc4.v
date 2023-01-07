`timescale 1ns/10ps
module lzc4 (
	input  [3:0] x_in ,
	output [1:0] q_out,
	output       a_out
);
	assign q_out[1] = !(x_in[3]||x_in[2]);
	assign q_out[0] = (!x_in[3] && x_in[2]) || (!x_in[3] && !x_in[1]);
	assign a_out    = !(|x_in);
endmodule
