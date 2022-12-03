`timescale 1ns / 100ps
module tb_cnn_sigmoid1 ();

/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
   parameter DATA_WIDTH = 32;

// General
parameter IMAGE_WIDTH  = 2448; //Width
parameter IMAGE_HEIGHT = 2448; //Height
parameter CHANNEL_NUM  = 1   ; //The number of channel

localparam IMAGE_SIZE        = IMAGE_WIDTH * IMAGE_HEIGHT;
localparam CHANNEL_NUM_PIXEL = CHANNEL_NUM * IMAGE_SIZE  ;

localparam IMAGE_INPUT_FILE = "D:/GitHub/CNNs/Text_file/Input/R.txt";
localparam IMAGE_OUTPUT_FILE = "D:/GitHub/CNNs/Text_file/Output/Output_cnn_sigmoid1.txt";


parameter ENDTIME          = 12000000          ;
parameter SIMULATION_CLOCK = SIMULATION_CYCLE/2;
parameter SIMULATION_CYCLE = 10                ;

reg                  clk                               ;
reg                  rst_n                             ;
reg                  start                             ;
reg [DATA_WIDTH-1:0] in_fp                             ;
reg [DATA_WIDTH-1:0] rom_val                           ;
reg [           4:0] addr_reg                          ;
reg                  read_en_reg                       ;
reg [DATA_WIDTH-1:0] test_data  [0:CHANNEL_NUM_PIXEL-1];

   reg [DATA_WIDTH-1:0] result_data;

   wire [DATA_WIDTH-1:0] data         ;
   wire [           4:0] addr         ;
   wire                  read_en      ;
   wire [DATA_WIDTH-1:0] out_fp       ;
   wire                  top_overflow ;
   wire                  top_underflow;
   wire                  done         ;

   integer i;


   cnn_sigmoid1 u_top (
      .in_fp        (in_fp        ),
      .out_fp       (out_fp       ),
      .clk          (clk          ),
      .rst_n        (rst_n        ),
      .start        (start        ),
      .done         (done         ),
      .rom_val      (rom_val      ),
      .addr         (addr         ),
      .read_en      (read_en      ),
      .top_overflow (top_overflow ),
      .top_underflow(top_underflow)
   );

   always@(*)begin
      rom_val     = data;
      read_en_reg = read_en;
      addr_reg    = addr;
   end

   rom u_rom (
      .clk    (clk        ),
      .rst_n  (rst_n      ),
      .addr   (addr_reg   ),
      .read_en(read_en_reg),
      .data   (data       )
   );


initial begin
   clk = 1'b0;
   $readmemb(IMAGE_INPUT_FILE, test_data);
   result_data = $fopen(IMAGE_OUTPUT_FILE);
end

always #(SIMULATION_CLOCK) clk = ~ clk;

initial begin
   rst_n = 1'b0;
   start = 1'b0;
   #15;
   rst_n = 1'b1;
   for (i=0; i<IMAGE_SIZE;i=i+1) begin
      start = 1'b1;
      while (!done) begin
         in_fp = test_data[i];
         #SIMULATION_CYCLE;
         start = 1'b0;
      end
      if (done) begin
         result_data = out_fp;
      end
      #SIMULATION_CYCLE;
   end
   #ENDTIME;
   $finish;
end


endmodule


