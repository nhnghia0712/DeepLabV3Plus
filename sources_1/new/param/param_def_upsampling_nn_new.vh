/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// General
parameter IMAGE_WIDTH  = 612; //Width
parameter IMAGE_HEIGHT = 612; //Height
parameter CHANNEL_NUM  = 7;    //The number of channel

// Localparam general
parameter IMAGE_SIZE        = IMAGE_WIDTH * IMAGE_HEIGHT;
parameter CHANNEL_NUM_PIXEL = IMAGE_SIZE * CHANNEL_NUM;  

parameter ADDR_WIDTH        = $clog2(CHANNEL_NUM_PIXEL);
parameter CNT_HEIGHT_WIDTH  = $clog2(IMAGE_HEIGHT)     ;
parameter CNT_CHANNEL_WIDTH = $clog2(CHANNEL_NUM) + 2  ;
