///////////////////////////////////////////////////////////////////////////
// Company: VB Tech
// Engineer: Nguyen Hoang Nghia
//
// Create Date: Mon, May 13, 2022
// Design Name: Test Bench
// Module Name: testbench.v
// Project Name: FIFO
// Target Device: KU5P
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
// 1. The timescale directive
`timescale     10 ps/ 1 ps
`define          DELAY 1.429
// 3. Include Statements
module tb_fifo ();
  // 4. Parameter definitions
  parameter ENDTIME       = 620;
  parameter DATA_WIDTH    = 8  ;
  parameter DATA_DEPTH    = 13 ;
  parameter POINTER_WIDTH = 4  ;
  parameter N             = DATA_DEPTH + 3 ;
  parameter T             = DATA_DEPTH / 3  ;
  parameter TIME          = DATA_DEPTH * 9  ;
  // 5. DUT Input regs
  reg                  clk    ;
  reg                  reset  ;
  reg                  write  ;
  reg                  read   ;
  reg [DATA_WIDTH-1:0] data_in;
  // 6. DUT Output wires
  wire [DATA_WIDTH-1:0] data_out;
  wire                  empty   ;
  wire                  full    ;

  integer i;

		cnn_fifo #(DATA_WIDTH,DATA_DEPTH,POINTER_WIDTH) tb (
			.reset   (reset   ),
			.clk     (clk     ),
			.write   (write   ),
			.read    (read    ),
			.data_in (data_in ),
			.data_out(data_out),
			.full    (full    ),
			.empty   (empty   )
		);
  // 8. Initial Conditions
  initial
    begin
      clk     = 1'b0;
      reset     = 1'b0;
      write     = 1'b0;
      read     = 1'b0;
      data_in     = 8'd0;
    end
  // 9. Generating Test Vectors
  initial
    begin
      main;
    end
  task main;
    fork
      clock_generator;
      reset_generator;
      operation_process;
      debug_fifo;
      endsimulation;
    join
  endtask
  task clock_generator;
    begin
      forever #`DELAY clk = !clk;
    end
  endtask
  task reset_generator;
    begin
      #(`DELAY*2)
        reset = 1'b0;
      # 4
        reset = 1'b1;
      # 4
        reset = 1'b0;
      #(`DELAY*(TIME+2))
        reset = 1'b1;
      # 4
        reset = 1'b0;
      #(`DELAY*(TIME/3))
        reset = 1'b1;
      # 4
        reset = 1'b0;
    end
  endtask
  task operation_process;
    begin
      //TEST CASE 1:
       #(`DELAY*4)
      for (i = 0; i < N; i = i + 1) begin
        #(`DELAY*($urandom_range(1,5)))
          write = 1'b1;
        read = 1'b0;
        data_in = $random;
      end
      #(`DELAY)
        for (i = 0; i < T; i = i + 1) begin
          #(`DELAY*($urandom_range(1,5)))
            read = 1'b1;
          write = 1'b0;
        end
      #(`DELAY)
        for (i = 0; i < T; i = i + 1) begin
          #(`DELAY*($urandom_range(1,5)))
            write = 1'b1;
          read = 1'b0;
          data_in = $random;
        end
      #(`DELAY)
        for (i = 0; i < N; i = i + 1) begin
          #(`DELAY*($urandom_range(1,5)))
            read = 1'b1;
          write = 1'b0;
        end
      //TEST CASE 2:
      read = 1'b0;
      #(`DELAY*5)
        for (i = 0; i < T; i = i + 1) begin
          #(`DELAY*($urandom_range(1,5)))
            write = 1'b1;
          read = 1'b0;
          data_in = $random;
        end
      #(`DELAY)
        for (i = 0; i < T; i = i + 1) begin
          #(`DELAY*($urandom_range(1,5)))
            read = 1'b1;
          write = 1'b0;
        end

      //TEST CASE 3:
      #(`DELAY*10)
        read = 1'b0;
      for (i = 0; i < N; i = i + 1) begin
        #(`DELAY*($urandom_range(1,3)))
          write = 1'b1;
        #(`DELAY*($urandom_range(1,3)))
          write = 1'b0;
        #(`DELAY*($urandom_range(1,3)))
          read = 1'b0;
        #(`DELAY*($urandom_range(1,3)))
          data_in = $random;
      end
      #(`DELAY*($urandom_range(1,5)))
        for (i = 0; i < N; i = i + 1) begin
          #(`DELAY*($urandom_range(1,3)))
            read = 1'b1;
          #(`DELAY*($urandom_range(1,3)))
            read = 1'b0;
          #(`DELAY*($urandom_range(1,3)))
            write = 1'b0;
        end
    end
  endtask
  // 10. Debug fifo
  task debug_fifo;
    begin
      $display("----------------------------------------------");
      $display("------------------   -----------------------");
      $display("----------- SIMULATION RESULT ----------------");
      $display("--------------       -------------------");
      $display("----------------     ---------------------");
      $display("----------------------------------------------");
      $monitor("TIME = %d, Read = %b, Write = %b, In = %h",$time, read, write, data_in);
    end
  endtask

  //11. Determines the simulation limit
  task endsimulation;
    begin
        #ENDTIME
        $display("-------------- THE SIMUALTION FINISHED ------------");
      $finish;
    end
  endtask
endmodule  