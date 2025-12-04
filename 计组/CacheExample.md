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
-  **Given**
	-  I-cache miss rate = 2%
	-  D-cache miss rate = 4%
	-  Miss penalty = 100 cycles
	-  Base CPI (ideal cache) = 2
	-  Load & stores are 36% of instructions
-  **Miss cycles per instruction**
	-  I-cache: 0.02 × 100 = 2
	-  D-cache: 0.36 × 0.04 × 100 = 1.44
-  Actual CPI = 2 + 2 + 1.44 = 5.44
-  Ideal CPU is 5.44/2 =2.72 times faster

## MultilevelCacheExample
-  **Given**
	-  CPU base CPI = 1, clock rate = 4GHz
	-  Miss rate/instruction = 2%
	-  Main memory access time = 100ns
-  **With just primary cache**
	-  Miss penalty = 100ns/0.25ns = 400 cycles
	-  Effective CPI = 1 + 0.02 × 400 = 9

*解*: Now add L-2 cache
 Access time = 5ns
 Global miss rate to main memory = 0.5%
 Primary miss with L-2 hit
 Penalty = 5ns/0.25ns = 20 cycles
 Primary miss with L-2 miss
 Extra penalty = 500 cycles
 CPI = 1 + 0.02 × 20 + 0.005 × 400 = 3.4
 Performance ratio = 9/3.4 = 2.6


## ExampleProblem
 Assume a 500 MHz machine with
 base CPI 1.0
 main memory access time 200 ns.
 miss rate 5%
 How much faster will the machine be if we add a second-level
cache with 20ns access time that decreases the miss rate to 2%?

*Solution*

 Miss penalty to main = 200 ns / (2 ns / clock cycle) = 100 clock cycles
 Effective CPI with one level of cache
= Base CPI + Memory-stall cycles per instruction
= 1.0 + 5%  100 = 6.0
 With two levels of cache, miss penalty to second-level cache
= 20 ns / (2 ns / clock cycle) = 10 clock cycles
 Effective CPI with two levels of cache
= Base CPI + Primary stalls per instruction
+ Secondary stall per instruction
= 1 + 5%  10 + 2%  100 = 3.5
 Therefore, machine with secondary cache is faster by a factor of
6.0 / 3.5 = 1.71

## CacheHitAndMiss
F or the following repeating sequence of l w addresses (given in hexadecimal),determine the effective miss rate if the sequence is input to the following caches,ignoring startup effects (i.e., compulsory misses). Assuming least recently used(LRU) replacement for associative caches. The cache capacity is 16 words.
			*74 A0 78 38C A C 84 88 8C 7C 34 38 13C 388 18C*
(a) direct mapped cache, b = 1 word
(b) fully associative cache, b = 2 words

(a) direct mapped cache, b = 1 word
*Solution*:
1st loop: all missed
2nd loop: Hit: A0, AC, 84
Miss Rate = 11 /14 = 79%
![](CacheDirect.png)

