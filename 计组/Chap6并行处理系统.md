# 概述
## Introduction
-  Goal: connecting multiple computers to get higher performance
	-  Multiprocessors
	-  Scalability, availability, power efficiency
-  Task-level (process-level) parallelism
	-  High throughput for independent jobs
-  Parallel processing program
	-  Single program run on multiple processors
-  Multicore microprocessors
	-  Chips with multiple processors (cores)

## 并行处理的主要技术问题
*互连*
-  并行处理：将多个计算模块和存储模块互连，通过控制这些它们的并行工
作来提高处理速度。
*数据一致性*
-  在不同的计算模块中会设置共享高速缓存和主存，因此，在并行处理系统
中存在复杂的数据一致性问题。
*同步控制*
-  共享存储时，多个计算模块访问同一块数据需解决数据的互斥访问。
-  分布计算和存储时，需要对各个模块进行同步控制。
*任务划分*
-  大任务分解成子任务并行执行，包含算法分解和数据划分两个方面。
并行程序设计
-  对系统中运行的程序进行并行化处理描述，以说明哪些处理逻辑段可并行
执行、哪些有先后顺序关系，以及处理的数据可以怎样划分等。
*资源调度和管理*
-  计算资源的调度和存储资源的管理，比在串行处理系统中复杂得多。
*容错性和安全性*
-  预防由于单个节点失效可能带来的数据丢失、程序出错或系统崩溃等。
-  要求系统必须考虑良好的可靠性设计、失效检测和恢复机制。
*性能分析与评估*
-  并行处理性能通常用加速比来度量
	- 串行系统与并行系统中执行时间比值
	- 并行系统与串行系统的作业吞吐量比值
-  评价并行系统的指标包括可用性、可扩展性、负载均衡、可靠性等

## Amdahl’s Law
Sequential part：串行
parallelizable ：并行
并行处理技术*仅仅*可以加速*并行任务*

$$Time = n_{Sequential part}* T+\frac{n_{parallelizable part}}{n_{processors}}* T$$

## 计算机分类
Flynn’s 分类：基于*指令流*和*数据流数量*的计算机结构分类
- *Single* instruction stream, *single* data stream (SISD)
- *Single* instruction stream, *multiple* data streams (SIMD)
	- Multimedia extensions
	- Graphics processor units
- *Multiple* instruction streams, *single* data stream (MISD)//市面少
	- No commercial implementation
- *Multiple* instruction streams, *multiple* data streams (MIMD)

### 串行计算机
- Single instruction:在任一时钟周期只有单个指令流在CPU执行
- Single data:在任一时钟周期只有单个数据流用作输入

### 并行计算机
- 一种并行计算机：处理数据级并行
- Single instruction: 在任一时钟周期，所有处理单元执行相同指令
- Multiple data: 每个处理单元能对不同数据元素进行操作

- 适用于处理高度规整操作的问题，如图像处理

## MISD

## MIMD
-  并行计算机：线程级或任务级并行。
-  Multiple Instruction: 每个处理器可以执行不同的指令流
-  Multiple Data: 每个处理器可以对不同数据流进行操作

>[!danger]
>现代的不少并行处理器是SISD、SIMD和MIMD的混合类型。


## 按处理单元的位置及其互连方式划分

• 多核：一个CPU芯片中含多个（2、4、8等）核，共享LLC和主存
• 对称多处理器（Symmetric MultiProcessor, SMP）：相同类型CPU通过总
线互连，并等同地位共享所有存储资源。即多个CPU对称工作。可见SMP就是
一种UMA结构多处理器。PC、工作站和服务器等多采用SMP结构。
• 大规模并行处理机（MPP）：以专用内联网络连接数量众多处理单元而构成的
并行计算系统。例如，可通过专用互连网络（如Mesh、交叉开关）将数量达几
百甚至几千个的SMP服务器连接成MPP，SMP服务器之间协同工作，以完成同
一个任务。
• 集群（Cluster）：以高速网卡将若干PC或SMP服务器或工作站连接而成的并
行计算系统，其中每个节点有各自的独立编址的内存和磁盘，属于紧耦合同构多
计算机系统（消息传递机制）。
• 网格（Grid）：以因特网等广域网将远距离分布的一组异构计算机系统连接而
成的分布式并行处理系统，属于松耦合异构多计算机系统。
• 众核：一个GPU芯片中含几百个简单核，众多并行线程同时执行
• APU：CPU+GPU融合
>[!danger]
>PPT

# 多处理器系统
## Multithreading（多线程）
-  Performing multiple threads of execution inparallel
	-  Replicate registers, PC, etc.
	-  Fast switching between threads
-  Fine-grain multithreading
	-  Switch threads after each cycle
	-  Interleave instruction execution
	-  If one thread stalls, others are executed
-  Coarse-grain multithreading
	-  Only switch on long stall (e.g., L2-cache miss)
	-  Simplifies hardware, but doesn’t hide short stalls(eg, data hazards)

## 例题
[如果想用100个处理器达到80的加速比，求原计算程序中串行部分所占比例](并行处理#题1)
[没有远程访问的状态下与有0.2%的指令需要远程访问的状态下，前者比后者快多少](并行处理题2)


# 多计算机系统

## 集群（Cluster）
• 互连方式：局域网连接普通PC、通过消息传递进行通信，比多处理器系统中的互连
网络慢，集群中信息访问为微秒级，多处理器中为纳秒级
• 体积：集群在一个或多个房间甚至更大空间中，而多处理器通常在一个机箱中
• 应用广泛：数据库系统、文件服务器、Web服务器等
![](集群.png)

## 网格
• 互连方式：利用互联网把分散在不同地理位置的多个异构计算机组成一台逻辑上的“虚拟超级计算机”
• 体积：物理上可能位于世界各地
• 构建思路：不同的管理系统上运行相应的中间件，以使用户和程序可以通过方便的、一致的方式访问所有资源
• 基本原理：在网格中的每个计算机中运行一个特殊的程序，这个程序可以用来管理计算机并使计算机加入到网格中。因此，这个程序通常需要处理用户认证及远程登录、资源发布与发现、作业调度与分配等。当网格中的某个用户需要计算机
完成某个任务时，网格软件决定何处有空闲的硬件、软件和数据资源，然后将作业迁移到有资源的计算机处，安排执行并收集处理结果返回给用户。
• 预期目标：实现可靠的、具有较高容错和容灾性的系统，并且可以节省资源，实现资源共享

# 向量处理机和SIMD技术
>[!note]
>向量机：具有向量数据表示和相应向量指令的流水线处理机称为向量流水线处理机，也称向量处理机。与之对应的是标量处理机，不支持向量数据表示，没有提供向量指令。

## 向量处理机的基本思想
- 向量型数据并行计算
- 主要用于求解大型问题
- 需要设计对应的寄存器