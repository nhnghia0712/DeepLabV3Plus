/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// General
parameter IMAGE_WIDTH     = 256; //Width
parameter IMAGE_HEIGHT    = 256; //Height
parameter CHANNEL_NUM_IN  = 3  ; //The number of channel in
parameter CHANNEL_NUM_OUT = 64 ; //The number of channel out
parameter KERNEL          = 7  ; //Kernel width

// Localparam general
parameter IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT;

parameter KERNEL_SIZE          = KERNEL * KERNEL                 ; // 7x7
parameter CHANNEL_NUM          = CHANNEL_NUM_IN * CHANNEL_NUM_OUT;
parameter CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE     ;
parameter CHANNEL_NUM_PIXEL    = IMAGE_SIZE * CHANNEL_NUM        ; // 6x6x2x2
parameter WEIGHT_NUM           = CHANNEL_NUM + 1                 ; // 2x2x7x7

// conv_loop_data_in
parameter LOOP_CHANNEL_IN_CNT = $clog2(CHANNEL_NUM_IN)                    ;
parameter LOOP_COL_CNT        = $clog2(IMAGE_SIZE + (IMAGE_WIDTH * 3) + 3);

// conv_3x3_dilation_top
parameter CNT_WIDTH_BUFFER = $clog2(IMAGE_WIDTH); // $clog2(IMAGE_HEIGHT_PADDING - (KERNEL - 1)) + 1 // For Buffer = log2(IMAGE_HEIGHT_PADDING - (KERNEL - 1))

parameter POINTER_WIDTH_BUFFER_WEIGHTS = $clog2(WEIGHT_NUM); // $clog2(WEIGHT_NUM) + 1 // For Buffer Weights = log2(WEIGHT_NUM)
parameter CNT_WIDTH_BUFFER_WEIGHTS     = $clog2(KERNEL_SIZE); // $clog2(KERNEL_SIZE) // For Buffer Weights = log2(KERNEL_SIZE)

// Adder
parameter ADD_CHANNEL_IN_CNT      = $clog2(CHANNEL_NUM) + 1;
parameter ADD_TEMP_CHANNEL_IN_CNT = $clog2(IMAGE_SIZE)     ;