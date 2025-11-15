## CacheExample
- 8-blocks, 1 word/block, direct mapped

- Initial state

|Index| V| Tag| Data|
|---|---|---|---|
|000 |N| | |
|001 |N| | |
|010 |N| | |
|011 |N| | |
|100 |N| | |
|101 |N| | |
|110 |N| | |
|111 |N| | |


add 
![](CacheExample_1.png)
![](CacheExample_2.png)
## 1_KB_Direct_Mapped_Cache_with_32_B_Blocks
![](1_KB_Direct_Mapped_Cache_with_32_B_Blocks.png)

## ex
1. How many total bits are required for a direct-mapped
cache with 128 KB of data and 1-word block size,
assuming a 32-bit address?
-  Cache data = 128 KB = 217 bytes = 215 words = 215 blocks
-  Cache entry size = block data bits + tag bits + valid bit
= 32 + (32 – 15 – 2) + 1 = 48 bits
-  Therefore, cache size = 215  48 bits = 215  (1.5  32) bits
= 1.5  220 bits = 1.5 Mbits
-  data bits in cache = 128 KB  8 = 1 Mbits
-  total cache size/actual cache data = 1.5

2. How many total bits are required for a direct-mapped
cache with 128 KB of data and 4-word block size,
assuming a 32-bit address?
-  Cache size = 128 KB = 217 bytes = 215 words = 213 blocks
-  Cache entry size = block data bits + tag bits + valid bit
= 128 + (32 – 13 – 2 – 2) + 1 = 144 bits
-  Therefore, cache size = 213  144 bits = 213  (1.25  128) bits
= 1.25  220 bits = 1.25 Mbits
-  data bits in cache = 128 KB  8 = 1 Mbits
-  total cache size/actual cache data = 1.25

## CachePerformanceExample 
 Given
 I-cache miss rate = 2%
 D-cache miss rate = 4%
 Miss penalty = 100 cycles
 Base CPI (ideal cache) = 2
 Load & stores are 36% of instructions
 Miss cycles per instruction
 I-cache: 0.02 × 100 = 2
 D-cache: 0.36 × 0.04 × 100 = 1.44
 Actual CPI = 2 + 2 + 1.44 = 5.44
 Ideal CPU is 5.44/2 =2.72 times faster