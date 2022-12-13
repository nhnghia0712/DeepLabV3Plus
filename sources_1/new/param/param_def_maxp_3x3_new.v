/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// General
parameter IMAGE_WIDTH    = 1224; //Width
parameter IMAGE_HEIGHT   = 1224; //Height
parameter KERNEL         = 3   ; //3*3 Kernel
parameter RATE           = 1   ;
parameter CHANNEL_NUM_IN = 64  ;

// Localparam general
parameter IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT;
parameter CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE;

// Loop
parameter LOOP_CHANNEL_IN_CNT = $clog2(CHANNEL_NUM_IN)                            ;
parameter LOOP_COL_CNT        = $clog2(IMAGE_SIZE + ((IMAGE_WIDTH * RATE) + RATE));

// Parameter for submodule
parameter CNT_WIDTH_BUFFER = $clog2(IMAGE_WIDTH); // $clog2(IMAGE_WIDTH_PADDING) + 1 // For Buffer = log2(IMAGE_WIDTH_PADDING)
