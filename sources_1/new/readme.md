# Timing Calculation:
## Conv 3x3:
+ Delay   = (RATE * (IMAGE_WIDTH + 1)) + 45 + ((IMAGE_SZE + RATE * (IMAGE_WIDTH + 1)) * (CHANNEL_NUM_IN - 1)) + 1 + (9 * log2(CHANNEL_NUM_IN))
+ Latency = (RATE * (IMAGE_WIDTH + 1)) + 45 + ((((IMAGE_SZE + RATE * (IMAGE_WIDTH + 1)) * (CHANNEL_NUM_IN - 1)) + 1 + (9 * log2(CHANNEL_NUM_IN)) + IMAGE_SIZE) * CHANNEL_NUM_OUT)

## Conv 1x1:
+ Delay   = 8 + ((IMAGE_SZE + RATE * (IMAGE_WIDTH + 1)) * (CHANNEL_NUM_IN - 1)) + 1 + (9 * log2(CHANNEL_NUM_IN))
+ Latency = 8 + ((((IMAGE_SZE + RATE * (IMAGE_WIDTH + 1)) * (CHANNEL_NUM_IN - 1)) + 1 + (9 * log2(CHANNEL_NUM_IN)) + IMAGE_SIZE) * CHANNEL_NUM_OUT)

## Avgp 3x3:
+ Delay   = (RATE * (IMAGE_WIDTH + 1)) + 45
+ Latency = (RATE * (IMAGE_WIDTH + 1)) + 45 + ((IMAGE_SIZE + (RATE * (IMAGE_WIDTH + 1))) * CHANNEL_NUM_IN)

## Concat:
+ Delay   = 1
+ Latency = Previous Latency

## ReLU:
+ Delay   = 1
+ Latency = Previous Latency

## Upsampling:
+ Delay   = 1
+ Latency = Previous Latency
