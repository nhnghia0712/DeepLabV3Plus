/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// Localparam general
parameter IMAGE_SIZE        = IMAGE_WIDTH * IMAGE_HEIGHT;
parameter CHANNEL_NUM_PIXEL = IMAGE_SIZE * CHANNEL_NUM;  

parameter ADDR_WIDTH        = $clog2(CHANNEL_NUM_PIXEL) + 1;
parameter CNT_HEIGHT_WIDTH  = $clog2(IMAGE_HEIGHT) + 1     ;
parameter CNT_CHANNEL_WIDTH = $clog2(CHANNEL_NUM) + 2      ;
