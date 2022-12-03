/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// General
parameter IMAGE_WIDTH     = 306; //Width
parameter IMAGE_HEIGHT    = 306; //Height
parameter CHANNEL_NUM_IN  = 1  ; //The number of channel in
parameter CHANNEL_NUM_OUT = 1  ; //The number of channel out
parameter KERNEL          = 1  ; //Kernel width

// Localparam general
parameter IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT;

parameter KERNEL_SIZE          = KERNEL * KERNEL                 ; // 1x1
parameter CHANNEL_NUM          = CHANNEL_NUM_IN * CHANNEL_NUM_OUT; // 2x2
parameter CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE     ; // 2x6x6
parameter WEIGHT_NUM           = CHANNEL_NUM + 1                 ; // 2x2x1x1

// conv_loop_data_in
parameter POINTER_WIDTH_LOOP = $clog2(CHANNEL_NUM_IN_PIXEL); //$clog2(CHANNEL_NUM_IN_PIXEL) + 1
parameter CNT_WIDTH_LOOP     = $clog2(CHANNEL_NUM_OUT) + 1 ; //$clog2(CHANNEL_NUM_OUT)

// conv_1x1_top
parameter CNT_WIDTH_BUFFER = $clog2(IMAGE_SIZE); // $clog2(IMAGE_SIZE)  // For Buffer = log2(IMAGE_SIZE)

parameter POINTER_WIDTH_BUFFER_WEIGHTS = $clog2(WEIGHT_NUM); // $clog2(WEIGHT_NUM) + 1 // For Buffer Weights = log2(WEIGHT_NUM)
