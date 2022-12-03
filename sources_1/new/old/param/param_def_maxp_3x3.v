/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH = 32;

// General
parameter IMAGE_WIDTH  = 1224; //Width
parameter IMAGE_HEIGHT = 1224; //Height
parameter CHANNEL_NUM  = 1   ; //The number of channel
parameter KERNEL       = 3   ; //3*3 Kernel
parameter PADDING      = 1   ;

// Localparam general
parameter IMAGE_SIZE          = IMAGE_WIDTH * IMAGE_HEIGHT             ;
parameter CHANNEL_NUM_PIXEL   = IMAGE_SIZE * CHANNEL_NUM               ;
parameter IMAGE_WIDTH_PADDING = IMAGE_WIDTH + (PADDING * 2)            ;
parameter PAD_H               = PADDING * ((PADDING * 2) + IMAGE_WIDTH); // Height of top/bot padding

// Parameter for submodule
parameter POINTER_WIDTH_LOOP   = $clog2(CHANNEL_NUM_PIXEL); //$clog2(CHANNEL_NUM_PIXEL)

parameter CNT_WIDTH_BUFFER_COL = $clog2(IMAGE_WIDTH_PADDING * IMAGE_HEIGHT); // $clog2(IMAGE_HEIGHT * IMAGE_WIDTH_PADDING) + 1
parameter CNT_WIDTH_BUFFER_ROW = $clog2(IMAGE_WIDTH)                       ; // $clog2(IMAGE_HEIGHT) + 1

// Padding
parameter CNT_PAD_H_1_WIDTH     = $clog2(PAD_H) + 1      ; //  $clog2(PAD_H) + 1 //Optimize the number of bit in data
parameter CNT_PAD_H_2_WIDTH     = $clog2(PAD_H) + 1      ; // $clog2(PAD_H) + 1
parameter CNT_PAD_WIDTH         = $clog2(PADDING) + 2    ; // $clog2(PADDING) + 2
parameter CNT_PAD_WH_WIDTH      = $clog2(IMAGE_WIDTH)    ; // $clog2(IMAGE_WIDTH) + 1
parameter CNT_PAD_CHANNEL_WIDTH = $clog2(CHANNEL_NUM) + 2; // $clog2(CHANNEL_NUM) + 1
