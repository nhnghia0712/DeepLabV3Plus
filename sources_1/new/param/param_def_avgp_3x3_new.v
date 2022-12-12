/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// General
parameter IMAGE_WIDTH  = 1224; //Width
parameter IMAGE_HEIGHT = 1224; //Height
parameter KERNEL       = 3   ; //3*3 Kernel
parameter RATE         = 1   ;

// Localparam general
parameter IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT;

// Parameter for submodule
parameter CNT_WIDTH_BUFFER = $clog2(IMAGE_WIDTH); // $clog2(IMAGE_WIDTH_PADDING) + 1 // For Buffer = log2(IMAGE_WIDTH_PADDING)
