/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// Localparam general
parameter IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT;

parameter KERNEL_SIZE          = KERNEL * KERNEL                 ; // 3x3
parameter CHANNEL_NUM          = CHANNEL_NUM_IN * CHANNEL_NUM_OUT;
parameter CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE     ;
parameter WEIGHT_NUM           = CHANNEL_NUM + 1                 ; // 2x2x3x3 // >=1

// conv_3x3_dilation_top
parameter CNT_WIDTH_BUFFER = $clog2(IMAGE_WIDTH) + 1; // $clog2(IMAGE_WIDTH_PADDING) + 1 // For Buffer = log2(IMAGE_WIDTH_PADDING)

parameter POINTER_WIDTH_BUFFER_WEIGHTS = $clog2(WEIGHT_NUM) + 1 ; // $clog2(WEIGHT_NUM) + 1 // For Buffer Weights = log2(WEIGHT_NUM)
parameter CNT_WIDTH_BUFFER_WEIGHTS     = $clog2(KERNEL_SIZE) + 1; // $clog2(KERNEL_SIZE) // For Buffer Weights = log2(KERNEL_SIZE)