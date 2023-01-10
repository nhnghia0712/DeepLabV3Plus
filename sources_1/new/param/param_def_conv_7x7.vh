/////////////////////////////////////////////////////////////////////////
// Parameter Declarations
parameter DATA_WIDTH  = 32;

// Localparam general
parameter IMAGE_SIZE = IMAGE_WIDTH * IMAGE_HEIGHT;

parameter KERNEL_SIZE          = KERNEL * KERNEL                 ; // 7x7
parameter CHANNEL_NUM          = CHANNEL_NUM_IN * CHANNEL_NUM_OUT;
parameter CHANNEL_NUM_IN_PIXEL = CHANNEL_NUM_IN * IMAGE_SIZE     ;
parameter CHANNEL_NUM_PIXEL    = IMAGE_SIZE * CHANNEL_NUM        ; // 6x6x2x2

// conv_7x7_dilation_top
parameter CNT_WIDTH_BUFFER         = $clog2(IMAGE_WIDTH) + 1; // $clog2(IMAGE_HEIGHT_PADDING - (KERNEL - 1)) + 1 // For Buffer = log2(IMAGE_HEIGHT_PADDING - (KERNEL - 1))
parameter CNT_WIDTH_BUFFER_WEIGHTS = $clog2(KERNEL_SIZE) + 1; // $clog2(KERNEL_SIZE) // For Buffer Weights = log2(KERNEL_SIZE)