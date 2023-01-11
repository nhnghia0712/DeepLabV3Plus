/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// Localparam general
parameter IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT;

parameter KERNEL_SIZE          = KERNEL * KERNEL                 ; // 1x1
parameter CHANNEL_NUM          = CHANNEL_NUM_IN * CHANNEL_NUM_OUT; // 2x2
parameter CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE     ; // 2x6x6
parameter WEIGHT_NUM           = CHANNEL_NUM + 1                 ; // 2x2x1x1

// Loop
parameter LOOP_CHANNEL_IN_CNT = $clog2(CHANNEL_NUM_IN) + 1                      ;
parameter LOOP_COL_CNT        = $clog2(IMAGE_SIZE + ((IMAGE_WIDTH * 1) + 1)) + 1;

// conv_1x1_top
parameter CNT_WIDTH_BUFFER = $clog2(IMAGE_SIZE) + 1; // $clog2(IMAGE_SIZE)  // For Buffer = log2(IMAGE_SIZE)

parameter POINTER_WIDTH_BUFFER_WEIGHTS = $clog2(WEIGHT_NUM) + 1; // $clog2(WEIGHT_NUM) + 1 // For Buffer Weights = log2(WEIGHT_NUM)