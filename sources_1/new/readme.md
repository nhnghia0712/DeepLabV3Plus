# Timing Calculation:
## Conv 3x3:
+ Delay   = (9 * ($clog2(CHANNEL_NUM_IN))) + (CHANNEL_NUM_OUT * ((IMAGE_SIZE * (CHANNEL_NUM_IN - 1)) + ((CHANNEL_NUM_IN * RATE) * (IMAGE_WIDTH + 1)))) + 46
+ Latency = Delay + IMAGE_SIZE * CHANNEL_NUM_OUT

> Notice: if CHANNEL_NUM_IN = 304:
>
>> Delay   = (304 * ((303 * IMAGE_SIZE) + (304 * RATE * (IMAGE_WIDTH + 1)))) + 136
>>
>> Latency = Delay + (304 * IMAGE_SIZE)
>>

## Conv 1x1:
+ Delay   = 8 + ((IMAGE_SIZE + IMAGE_WIDTH + 1) * (CHANNEL_NUM_IN - 1)) + 1 + (9 * $clog2(CHANNEL_NUM_IN)) + (((((IMAGE_WIDTH * RATE ) + RATE + IMAGE_SIZE) * CHANNEL_NUM_IN) - IMAGE_SIZE)) * (CHANNEL_NUM_OUT - 1))
+ Latency = Delay + IMAGE_SIZE * CHANNEL_NUM_OUT

> Notice: if CHANNEL_NUM_IN = 1280:
>
>> Delay   = 108 + ((IMAGE_SIZE + IMAGE_WIDTH + 1) * 1279) + ((((IMAGE_WIDTH + 1 + IMAGE_SIZE) * 1280) - IMAGE_SIZE)) * 1279)
>>
>> Latency = Delay + IMAGE_SIZE * 1280
>>
> Notice: if CHANNEL_NUM_IN = 304:
>
>> Delay   = 99 + ((IMAGE_SIZE + IMAGE_WIDTH + 1) * 303) + ((((IMAGE_WIDTH + 1 + IMAGE_SIZE) * 304) - IMAGE_SIZE)) * 303)
>>
>> Latency = Delay + IMAGE_SIZE * 304
>>

## Avgp 3x3:
+ Delay   = IMAGE_WIDTH + 45
+ Latency = Delay + IMAGE_SIZE * CHANNEL_NUM_OUT

## Maxp 3x3:
+ Delay   = IMAGE_WIDTH + 9
+ Latency = Delay + IMAGE_SIZE * CHANNEL_NUM_OUT

## Conv 7x7:
+ Delay   = (IMAGE_WIDTH * 3) + 63 + ((IMAGE_SZE + (3 * (IMAGE_WIDTH + 1))) * 2) + 19 + (((((IMAGE_WIDTH * RATE ) + RATE + IMAGE_SIZE) * CHANNEL_NUM_IN) - IMAGE_SIZE)) * (CHANNEL_NUM_OUT - 1))
+ Latency = Delay + IMAGE_SIZE * CHANNEL_NUM_OUT

## Concat:
+ Delay   = 1
+ Latency = Previous Latency
+ SHIFT_WIDTH_01 = DELAY_02 - DELAY_01 - CHANNEL_NUM_PIXEL
+ SHIFT_WIDTH_02 = 0
+ SHIFT_WIDTH_01 = CHANNEL_NUM_PIXEL - (DELAY_03 - DELAY_02)
+ SHIFT_WIDTH_01 = DELAY_02 - DELAY_01 - CHANNEL_NUM_PIXEL
+ SHIFT_WIDTH_01 = DELAY_02 - DELAY_05 + (CHANNEL_NUM_PIXEL * 3)

## ReLU:
+ Delay   = 1
+ Latency = Previous Latency

## Upsampling:
+ Delay   = 1
+ Latency = Previous Latency

## Sigmoid:
+ Delay   = 5
+ Latency = Previous Latency
