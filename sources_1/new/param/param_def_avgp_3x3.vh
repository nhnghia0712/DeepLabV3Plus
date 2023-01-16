/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// Localparam general
parameter IMAGE_SIZE           = IMAGE_WIDTH * IMAGE_HEIGHT ;
parameter CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE;

// Parameter for submodule
parameter CNT_WIDTH_BUFFER = $clog2(IMAGE_WIDTH) + 1; // $clog2(IMAGE_WIDTH_PADDING) + 1 // For Buffer = log2(IMAGE_WIDTH_PADDING)
