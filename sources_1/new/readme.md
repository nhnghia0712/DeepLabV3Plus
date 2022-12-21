# Timing Calculation:
## Conv 3x3:
+ Delay   = (RATE * (IMAGE_WIDTH + 1)) + 45 + ((IMAGE_SIZE + (RATE * (IMAGE_WIDTH + 1))) * (CHANNEL_NUM_IN - 1)) + 1 + (9 * log2(CHANNEL_NUM_IN))
+ Latency = (RATE * (IMAGE_WIDTH + 1)) + 45 + ((((IMAGE_SIZE + (RATE * (IMAGE_WIDTH + 1))) * (CHANNEL_NUM_IN - 1)) + 1 + (9 * log2(CHANNEL_NUM_IN)) + IMAGE_SIZE) * CHANNEL_NUM_OUT)

## Conv 1x1:
+ Delay   = 8 + ((IMAGE_SIZE + (RATE * (IMAGE_WIDTH + 1))) * (CHANNEL_NUM_IN - 1)) + 1 + (9 * log2(CHANNEL_NUM_IN))
+ Latency = 8 + ((((IMAGE_SIZE + (RATE * (IMAGE_WIDTH + 1))) * (CHANNEL_NUM_IN - 1)) + 1 + (9 * log2(CHANNEL_NUM_IN)) + IMAGE_SIZE) * CHANNEL_NUM_OUT)

## Avgp 3x3:
+ Delay   = (RATE * (IMAGE_WIDTH + 1)) + 44
+ Latency = (RATE * (IMAGE_WIDTH + 1)) + 44 + ((IMAGE_SIZE + (RATE * (IMAGE_WIDTH + 1))) * CHANNEL_NUM_IN)

## Maxp 3x3:
+ Delay   = (RATE * (IMAGE_WIDTH + 1)) + 8
+ Latency = (RATE * (IMAGE_WIDTH + 1)) + 8 + ((IMAGE_SIZE + (RATE * (IMAGE_WIDTH + 1))) * CHANNEL_NUM_IN)

## Conv 7x7:
+ Delay   = (IMAGE_WIDTH * 3) + 63 + ((IMAGE_SZE + (3 * (IMAGE_WIDTH + 1))) * 2) + 19
+ Latency = (IMAGE_WIDTH * 3) + 63 + (((IMAGE_SIZE + (3 * (IMAGE_WIDTH + 1))) * 2) + 19 + IMAGE_SIZE) * CHANNEL_NUM_OUT

## Concat:
+ Delay   = 1
+ Latency = Previous Latency

## ReLU:
+ Delay   = 1
+ Latency = Previous Latency

## Upsampling:
+ Delay   = 1
+ Latency = Previous Latency
