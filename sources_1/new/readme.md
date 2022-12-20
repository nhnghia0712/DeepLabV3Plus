# Timing Calculation:
## Conv 3x3:
+ Delay   = (2 x RATE x IMAGE_WIDTH) + 43 + ((IMAGE_SIZE + (IMAGE_WIDTH x RATE) + RATE) x (CHANNEL_NUM_IN - 1)) + 1 + (2^(CHANNEL_NUM_IN))
+ Latency = (2 x RATE x IMAGE_WIDTH) + 43 + ((((IMAGE_SIZE + (IMAGE_WIDTH x RATE) + RATE) x CHANNEL_NUM_IN) + 1 + (2^(CHANNEL_NUM_IN))) x CHANNEL_NUM_OUT)

## Conv 1x1:
+ Delay   = 8 + ((IMAGE_SIZE + (IMAGE_WIDTH x RATE) + RATE) x (CHANNEL_NUM_IN - 1)) + 1 + (2^(CHANNEL_NUM_IN))
+ Latency = 8 + ((((IMAGE_SIZE + (IMAGE_WIDTH x RATE) + RATE) x CHANNEL_NUM_IN) + 1 + (2^(CHANNEL_NUM_IN))) x CHANNEL_NUM_OUT)

## Avgp 3x3:
+ Delay   = (2 x RATE x IMAGE_WIDTH) + 43
+ Latency = (2 x RATE x IMAGE_WIDTH) + 43 + ((IMAGE_SIZE + (IMAGE_WIDTH x RATE) + RATE) x CHANNEL_NUM_IN)

## Concat:
+ Delay   = 1
+ Latency = Previous Latency

## ReLU:
+ Delay   = 1
+ Latency = Previous Latency

## Upsampling:
+ Delay   = 1
+ Latency = Previous Latency
