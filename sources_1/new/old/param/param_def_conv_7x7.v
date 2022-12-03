/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// General
parameter IMAGE_WIDTH     = 2448; //Width
parameter IMAGE_HEIGHT    = 2448; //Height
parameter CHANNEL_NUM_IN  = 1   ; //The number of channel in
parameter CHANNEL_NUM_OUT = 1   ; //The number of channel out
parameter KERNEL          = 7   ; //Kernel width
parameter PADDING         = 3   ; //Padding

// Localparam general
parameter IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT;

parameter KERNEL_SIZE          = KERNEL * KERNEL                 ; // 7x7
parameter CHANNEL_NUM          = CHANNEL_NUM_IN * CHANNEL_NUM_OUT;
parameter CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE     ;
parameter CHANNEL_NUM_PIXEL    = IMAGE_SIZE * CHANNEL_NUM        ; // 6x6x2x2
parameter WEIGHT_NUM           = CHANNEL_NUM + 1                 ; // 2x2x7x7
parameter IMAGE_WIDTH_PADDING  = IMAGE_WIDTH + (PADDING * 2)     ; // 6+(3x2)
parameter PAD_H                = PADDING * ((PADDING * 2) + IMAGE_WIDTH); // Height of top/bot padding

// conv_loop_data_in
parameter POINTER_WIDTH_LOOP = $clog2(CHANNEL_NUM_IN_PIXEL); //$clog2(CHANNEL_NUM_IN_PIXEL) + 1

// conv_3x3_dilation_top
parameter CNT_WIDTH_BUFFER_COL = $clog2(IMAGE_WIDTH_PADDING * IMAGE_HEIGHT); // $clog2(IMAGE_HEIGHT_PADDING * (IMAGE_WIDTH_PADDING - (KERNEL - 1))) + 1 // For Buffer = log2(IMAGE_HEIGHT_PADDING * (IMAGE_WIDTH_PADDING - (KERNEL - 1)))
parameter CNT_WIDTH_BUFFER_ROW = $clog2(IMAGE_WIDTH); // $clog2(IMAGE_HEIGHT_PADDING - (KERNEL - 1)) + 1 // For Buffer = log2(IMAGE_HEIGHT_PADDING - (KERNEL - 1))

parameter POINTER_WIDTH_BUFFER_WEIGHTS = $clog2(WEIGHT_NUM); // $clog2(WEIGHT_NUM) + 1 // For Buffer Weights = log2(WEIGHT_NUM)
parameter CNT_WIDTH_BUFFER_WEIGHTS     = $clog2(KERNEL_SIZE); // $clog2(KERNEL_SIZE) // For Buffer Weights = log2(KERNEL_SIZE)

// Padding
parameter CNT_PAD_H_1_WIDTH     = $clog2(PAD_H)      ; //  $clog2(PAD_H) + 1 //Optimize the number of bit in data
parameter CNT_PAD_H_2_WIDTH     = $clog2(PAD_H)      ; // $clog2(PAD_H) + 1
parameter CNT_PAD_WIDTH         = $clog2(PADDING)    ; // $clog2(PADDING) + 2
parameter CNT_PAD_WH_WIDTH      = $clog2(IMAGE_WIDTH); // $clog2(IMAGE_WIDTH) + 1
parameter CNT_PAD_CHANNEL_WIDTH = $clog2(CHANNEL_NUM); // $clog2(CHANNEL_NUM) + 1

// /////////////////////////////////////////////////////////////////////////
// // Parameter Declarations
// parameter DATA_WIDTH  = 32;

// // General
// parameter IMAGE_WIDTH     = 2448; //Width
// parameter IMAGE_HEIGHT    = 2448; //Height
// parameter CHANNEL_NUM_IN  = 3   ; //The number of channel in
// parameter CHANNEL_NUM_OUT = 64  ; //The number of channel out
// parameter KERNEL          = 7   ; //Kernel width
// parameter PADDING         = 3   ; //Padding

// // conv_loop_data_in
// parameter POINTER_WIDTH_LOOP = 25; //$clog2(CHANNEL_NUM_IN_PIXEL) + 1
// parameter CNT_WIDTH_LOOP     = 7 ; //  $clog2(CHANNEL_NUM_OUT) + 1

// // conv_3x3_dilation_top
// parameter POINTER_WIDTH = 31; //$clog2(CHANNEL_NUM_PIXEL) // For FIFO and Core = log2(CHANNEL_NUM_PIXEL)

// parameter CNT_WIDTH_BUFFER_COL = 23; // $clog2(IMAGE_HEIGHT_PADDING * (IMAGE_WIDTH_PADDING - (KERNEL - 1))) + 1 // For Buffer = log2(IMAGE_HEIGHT_PADDING * (IMAGE_WIDTH_PADDING - (KERNEL - 1)))
// parameter CNT_WIDTH_BUFFER_ROW = 12; // $clog2(IMAGE_HEIGHT_PADDING - (KERNEL - 1)) + 1 // For Buffer = log2(IMAGE_HEIGHT_PADDING - (KERNEL - 1))

// parameter POINTER_WIDTH_BUFFER_WEIGHTS = 14; // $clog2(WEIGHT_NUM) + 1 // For Buffer Weights = log2(WEIGHT_NUM)
// parameter CNT_WIDTH_BUFFER_WEIGHTS     = 6; // $clog2(KERNEL_SIZE) // For Buffer Weights = log2(KERNEL_SIZE)

// parameter POINTER_WIDTH_CORE   = 29; //$clog2(CHANNEL_NUM_PIXEL_STRIDE2)

// // Padding
// parameter CNT_PAD_H_1_WIDTH     = 13 ; //  $clog2(PAD_H) + 1 //Optimize the number of bit in data
// parameter CNT_PAD_H_2_WIDTH     = 13 ; // $clog2(PAD_H) + 1
// parameter CNT_PAD_WIDTH         = 3 ; // $clog2(PADDING) + 2
// parameter CNT_PAD_WH_WIDTH      = 12; // $clog2(IMAGE_WIDTH) + 1
// parameter CNT_PAD_CHANNEL_WIDTH = 8 ; // $clog2(CHANNEL_NUM) + 1


// // Localparam general
// localparam IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT;

// // localparam KERNEL_SIZE          = KERNEL * KERNEL                 ; // 7x7
// // localparam CHANNEL_NUM          = CHANNEL_NUM_IN * CHANNEL_NUM_OUT;
// // localparam CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE;
// // localparam CHANNEL_NUM_PIXEL    = IMAGE_SIZE * CHANNEL_NUM        ; // 6x6x2x2
// // localparam WEIGHT_NUM           = CHANNEL_NUM * KERNEL_SIZE       ; // 2x2x7x7
// // localparam IMAGE_WIDTH_PADDING  = IMAGE_WIDTH + (PADDING * 2)     ; // 6+(3x2)
