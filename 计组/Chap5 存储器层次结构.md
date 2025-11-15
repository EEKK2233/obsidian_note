# 存储器的层次结构
![存储器的层次结构](存储器的层次结构.png)
# Memory Technologies
## 基本术语
- 记忆单元（存储基元/ 存储元/ 位元）（Cell）
	- 具有两种稳态的能够表示二进制数码0和1的物理器件
- 存储单元/ 编址单位（Addressing Unit）
	- 具有相同地址的位构成一个存储单元，也称为一个编址单位
- 存储体/ 存储矩阵/ 存储阵列（Bank）
	- 所有存储单元构成一个存储阵列
- 编址方式（Addressing Mode）
	- 按字节编址、按字编址
- 存储器地址寄存器（Memory Address Register -MAR）
	- 用于存放主存单元地址的寄存器
- 存储器数据寄存器（Memory Data Register-MDR (或MBR) ）
	- 用于存放主存单元中的数据的寄存器
## 存储器分类
### （1）按工作性质/存取方式分类
- 随机存取存储器RandomAccessMemory(RAM)
	- 每个单元读写时间一样，且与各单元所在位置无关。如：内存。
	（注：原意主要强调地址译码时间相同。现在的DRAM芯片采用行缓冲，因而可能因为位置不同而使访问时间有所差别。）
- 顺序存取存储器SequentialAccessMemory(SAM)
	- 数据按顺序从存储载体的始端读出或写入，因而存取时间的长短与信息所在位置有关。例如：磁带。
- 直接存取存储器DirectAccessMemory(DAM)
	- 直接定位到读写数据块，在读写数据块时按顺序进行。如磁盘。
- 相联存储器AssociateMemory（AM）
		   ContentAddressedMemory(CAM)
	 - 按内容检索到存储位置进行读写。例如：快表。
### （2）按存储介质分类
**半导体存储器**：双极型，静态MOS型，动态MOS型
**磁表面存储器**：磁盘（Disk）、磁带（Tape）
**光存储器**：CD，CD-ROM，DVD
### （3）按信息的可更改性分类
**读写存储器（Read / Write Memory)**：可读可写
**只读存储器（Read Only Memory)**：只能读不能写
### （4）按断电后信息的可保存性分类
**非易失**（不挥发）性存储器(Nonvolatile Memory)
信息可一直保留，不需电源维持。
（如：ROM、磁表面存储器、光存储器等）
**易失（挥发**性存储器(Volatile Memory)
电源关闭时信息自动丢失。（如：RAM、Cache等）
### （5）按功能/容量/速度/所在位置分类
- 寄存器(Register)
	- 封装在CPU内，用于存放当前正在执行的指令和使用的数据
	- 用触发器实现，速度快，容量小（几~几十个）
- 高速缓存(Cache)
	- 位于CPU内部或附近，用来存放当前要执行的局部程序段和数据
	- 用SRAM实现，速度可与CPU匹配，容量小（几MB）
- 主存储器MM（Main(Primary)Memory）
	- 位于CPU之外，用来存放已被启动的程序及所用的数据
	- 用DRAM实现，速度较快，容量较大（几GB）
- 外存储器AM(辅助存储器Auxiliary/SecondaryStorage)
	- 位于主机之外，用来存放暂不运行的程序、数据或存档文件
	- 用磁表面或光存储器实现，容量大而速度慢

## 主存的主要性能指标
- 按字节连续编址，每个存储单元为1个字节（8个二进位）
- 存储容量：所包含的存储单元的总数（单位：MB或GB）
- 存取时间TA：从CPU送出内存单元的地址码开始，到主存读出数据并送到CPU（或者是把CPU数据写入主存）所需要的时间（单位：ns，1ns=10-9s），分读取时间和写入时间
- 存储周期TMC：连读两次访问存储器所需的最小时间间隔，它应等于存取时间加上下一次存取开始前所要求的附加时间，因此，TMC比TA大（因为存储器由于读出放大器、驱动电路等都有一段稳定恢复时间，所以读出后不能立即进行下一次访问。）
（就像一趟火车运行时间和发车周期是两个不同概念一样。）
## 内部存储器的分类
![内部存储器的分类](内部存储器的分类.excalidraw)
## 半导体RAM的组织
> 记忆单元(Cell) -> 存储器芯片(Chip) -> 内存条（存储器模块）

**存储体(Memory Bank)**：由记忆单元(位元)构成的存储阵列
## 半导体存储芯片的基本结构
### SRAM存储芯片的引脚
### 存储芯片片选线的作用
## DRAM Technology
- Data stored as a charge in a capacitor
	- Single transistor used to access the charge
	- Must periodically be refreshed
		- Read contents and write back
		- Performed on a DRAM “row”
### Advanced DRAM Organization
- Bits in a DRAM are organized as a rectangular array
	- DRAM accesses an entire row
	- Burst mode: supply successive words from a row with reduced latency
- Double data rate (DDR) DRAM
	- Transfer on rising and falling clock edges
- Quad data rate (QDR) DRAM
	- Separate DDR inputs and outputs
### DRAM Performance Factors
- Row buffer
	- Allows several words to be read and refreshed in parallel
- Synchronous DRAM
	- Allows for consecutive accesses in bursts without needing to send each address
	- Improves bandwidth
- DRAM banking
	- Allows simultaneous access to multiple DRAMs
	- Improves bandwidth
### DRAM存储芯片
- 因为集成度提高，片内存储单元的数量增加，需要的地址线也相应增加，为了控制成本，封装芯片的尺寸没有增大，芯片引脚数目也就没有增加，所以DRAM芯片地址引脚的数目只是地址宽度的一半。
- 为此，访存地址被分为行地址和列地址依次发送。相应地，在芯片内部就要设置行地址锁存器和列地址锁存器。为了区分地址总线上的行地址和列地址，特地增加两个控制线：RAS和CAS ，分别控制行地址和列地址的接收。
- 另外，DRAM不再设置CS引脚，其功能用RAS代替。
#### 典型的16M位DRAM（4M\*4）
16M位= 4Mb\*4 = 2048\*2048\*4 = 211\*211\*4
(1) 地址线：11根线分时复用，由RAS和CAS提供控制时序。
(2) 需4个位平面，对相同行、列交叉点的4位一起读/写
问题：
为什么每出现新一代DRAM芯片，容量至少提高到4倍？
	行地址和列地址分时复用, 每出现新一代DRAM芯片，至少要增加一根地址线。每加一根地址线，则行地址和列地址各增加一位，所以行数和列数各增加一倍。因而容量至少提高到4倍。
	![](Pasted%20image%2020251105094838.png)
	![](Pasted%20image%2020251105094846.png)
#### DRAM 时序
#### DRAM芯片的刷新
- 在DRAM芯片工作过程中，如果某些存储单元未被选中，电容被隔离，由于漏电流的存在，电容上的电荷会缓慢丢失。因此，每隔一段时间给电容补充电荷，这个过程称为刷新。典型的刷新间隔为2ms。
- 刷新是通过读操作实现的。只不过这个“读”并不输出数据，是“假读”。
- 刷新是逐行进行的，行地址由芯片内部的“刷新计数器”提供。刷新一行所花时间称为刷新周期。
- “刷新”方式有：
  - 集中式刷新
  - 分散式刷新
  - 异步式刷新
##### 集中式刷新
-  在一个刷新间隔（2ms）内，集中一段时间，对全部存储单元进行逐行刷新。
- 在此期间正常的读/写操作将被停止，所以这段时间称为死时间。
- 例如，对读/写周期为0.5s的128128的存储矩阵进行刷新，需要128个读周期。由于在刷新间隔2ms内共有4000个读/写周期，所以规定前3872个周期用于读/写或维持，后128个周期（64s）用于刷新。
##### 分散式刷新
- 为了消除死时间，人们提出：分散式刷新。
- 对每行存储单元的刷新分散到每个读/写周期中进行。具体来说，就是延长原先的读/写周期，将新的读/写周期分成前/后两段，前半段用来读/写或维持，后半段用来刷新。假如存储单元的读/写周期为0.5s，则存储器的读/写周期为1.0s。
- 虽然不存在死时间，但分散式刷新导致存取周期延长，系统的性能下降
##### 异步式刷新
- 异步式刷新是将前两种方法结合起来，在一个刷新间隔内，均匀地进行逐行刷新。
- 例如在2ms内，均匀地把128行刷新一遍，即每隔2ms/128=15.5625s刷新一行。这样，原来大块的死时间被分散开，达到了缩短死时间的效果。
- 每行每隔2 ms刷新一次
- “死区”为0.5 s
- 如果进一步将刷新安排在指令译码阶段，还可以掩盖死时间。
- 刷新操作的优先级被安排成高于读/写操作。
##### 刷新周期
```
从上次对整个存储器刷新结束到下次对整个存储器全部刷新一遍为止的时间间隔，也就是相邻两次对某个特定行进行刷新
的时间间隔。
```
为电容数据有效保存期的上限10ms～100ms，典型值是64ms。
- 多采用异步刷新方式：
	将一个刷新周期分配给所有行，使得在一个刷新周期内每行至少
	刷新一次，且仅刷新一次。
- 例如:
		以4096行为例，在64ms时间内必须轮流对每一行刷新一次，即
		每隔64ms/4096=15.625μs刷新一行。
## 主存模块的连接和读写操作
## CPU与存储器之间的通信方式
CPU和主存之间有同步和异步两种通信方式
### **异步方式** 
- **读操作**过程（需握手信号）
	- CPU送地址到地址线，主存进行地址译码
    - CPU发读命令，然后等待存储器发回“完成”信号
	- 主存收到读命令后开始读数，完成后发“完成”信号给CPU
	- CPU接收到“完成”信号，从数据线取数
- **写操作**过程类似
### - **同步方式**的特点
- CPU和主存由统一时钟信号控制，无需应答信号（如“完成”）
- 主存总是在确定的时间内准备好数据
- CPU送出地址和读命令后，总是在确定的时间取数据
- 存储器芯片必须支持同步方式
## 计算机系统互连
### 举例：SPARCstation 20’s Memory Module
## PC机主存储器的物理结构
### 举例：SPARCstation 20’s内存条(模块)
![SPARCstation20's内存条(模块)](SPARCstation20's内存条(模块).png)
### 举例：128MB的DRAM存储器

## 只读存储器
### 特点：
1. 信息只能读不能（在线）写。
2. 非破坏性读出，无需再生。
3. 也以随机存取方式工作。
4. 信息用特殊方式写入，一经写入，就可长久保存，不受断电影响。故是非易失性存储器。
### 用途：
1. 用来存放一些固定程序。如监控程序、启动程序等。只要一接通电源，这些程序就能自动地运行；
2. 可作为控制存储器，存放微程序。
3. 还可作为函数发生器和代码转换器。
4. 在输入/出设备中，被用作字符发生器，汉字库等。
5. 在嵌入式设备中用来存放固化的程序。
### 例子
- MROM（Mask ROM）：掩膜只读存储器
- PROM（Programmable ROM）：可编程只读存储器  //只能编程一次
- EPROM （Erasable PROM ） ：可擦除可编程只读存储器
- EEPROM （E2PROM ，Electrically EPROM） ：电可擦除可编程只读存储器
- flash memory：闪存（快擦存储器）：快擦型电可擦除重编程ROM
### Flash Storage(闪存存储)
 -  Nonvolatile semiconductor storage(非易失性半导体存储)
 -  100× – 1000× faster than disk
 -  Smaller, lower power, more robust(耐用性更强)
 -  But more $/GB (between disk and DRAM)
#### Flash Types
 1.  **NOR flash**: bit cell like a NOR gate
	 -  Random read/write access
	 -  Used for instruction memory in embedded systems
 -  **NAND flash**: bit cell like a NAND gate
	 -  Denser (bits/area)(存储密度更高), but block-at-a-time access(但需按块进行访问)
	 -  Cheaper per GB
	 -  Used for USB keys, media storage, …
 -  Flash bits **wears out** after 1000’s of accesses(会磨损)
	 -  Not suitable for direct RAM or disk replacement
	 -  Wear leveling: remap data to less used blocks
- 不适合直接替代动态随机存取存储器（RAM）或磁盘（Not suitable for direct RAM or disk replacement）
- 磨损均衡技术（Wear leveling）：将数据重新映射到使用频率较低的块，以延长闪存寿命（remap data to less used blocks）

### 存储器芯片的扩展
-  **位扩展**（字数不变，位数扩展）
	用4096×1位芯片构成4K×8位存储器需几个芯片？地址范围各是多少？
		位方向扩展8倍，字方向无需扩展。即8个芯片，地址范围都一样：000-FFFH， 地址共12位，全部作为片内地址
	-  芯片的地址线及读/写控制线对应相接，而数据线单独引出
-  字扩展（位数不变、字数扩展）
	用16K×8位芯片扩成64K×8位存储器需几个芯片？地址范围各为什么？
		字方向扩展4倍，即4个芯片。0000-3FFFH， 4000-7FFFH， 8000-BFFFH，C000- FFFFH， 地址共16位，高两位由外部译码器译码生成4个输出，分别连到4个片选信号，片内地址有14位
	- 地址线、读/写控制线等对应相接，片选信号连译码输出
-   字位同时扩展（字和位同时扩展）
	用16K×4位芯片构成64K×8位存储器需几个芯片，地址范围各是多少？
		字向4倍、位向2倍，8个芯片。0000-3FFFH， 4000-7FFFH， 8000-BFFFH，C000- FFFFH
	- 地址线、读/写控制线等对应相接，片选信号则分别与外部译码器各个译码输出端相连
	有两种编址方式：交叉编址和连续编址。
#### 位扩展法
![位扩展法](位扩展法.png)
#### 字扩展法
![字扩展法](字扩展法.png)
#### 字位同时扩展法
![字位同时扩展法](字位同时扩展法.png)
#### 例题
1. 某计算机主存容量为256K×16位，由若干个64K×8位的芯片组成。
	1. 需要多少个64K×8位的存储器芯片？
		(256k\*16)/(64k\*8)=*16*
	2. 画出CPU与译码器和存储器芯片的连接图。要求：图上需标明与存储器芯片片内地址连接的CPU地址线序号（形如Aj~Ai），与译码器连接的CPU地址线序号；清晰地画出译码器的输出连接到存储器芯片的引脚名称，CPU数据线与存储器芯片数据线的连接关系。
	3. 地址译码器的每个输出所对应的地址范围是多少（用十六进制表示）？
![例图](例题1.png)
![例题1_3](例题1_3.png)
### CPU和主存的连接
1. CPU地址线A15～A0，数据线D7～D0，WR为读/写信号，MREQ为访存请求信号。0000H～3FFFH为BIOS区，4000H～FFFFH为用户程序区。用8K×4位ROM芯片和16K×8位RAM芯片构成该存储器，要求说明地址译码方案，并将ROM芯片、RAM芯片与CPU连接。
	*解*：*因为0000H～3FFFH为BIOS*，故ROM区高两位总是00，低14位为全译码。
		ROM区大小为：214×8位=16K×8位=16KB，
		ROM芯片数为：16K×8位/ 8K×4位= 2×2 = 4，
		字方向扩展2倍，位方向扩展2倍。
		ROM芯片内地址位数为13位，连到CPU低13位地址线A12～A0。
		*因为4000H～FFFFH为用户程序区*，故RAM区高两位是01、10、11，低14位为全译码。
		RAM区大小为：3×214×8位=3×16K×8位= 48KB。
		RAM芯片数为：48K×8位/ 16K×8位= 3×1 = 3，
		字方向上扩展3倍，位方向上不扩展。
		RAM芯片内地址位数为14位，连到CPU低14位地址线A13～A0。
![CPU和主存的连接](CPU和主存的连接.png)
#### 假设需要连续访问4个WORD
![](假设需要连续访问4个WORD.png)
 - a. 1-word wide memory：(1+15+1)\*4=68 bus cycles,性能差成本低
 - b. 4-word wide memory：性能好但成本高
	 -  Miss penalty = 1 + 15 + 1 = 17 bus cycles
	 -  Bandwidth = 16 bytes / 17 cycles = 0.94 B/cycle
 - c. 4-bank interleaved memory：折中(一次性把地址发出, 依次读取)
	 -  Miss penalty = 1 + 15 + 4×1 = 20 bus cycles
	 -  Bandwidth = 16 bytes / 20 cycles = 0.8 B/cycle

### Disk Storage
- Nonvolatile, rotating magnetic storage
#### Disk Sectors and Access
 - Each sector records
	-  **Sector ID**:用于唯一标识磁盘上的每个扇区，帮助控制器准确定位数据位置。
	-  **Data (512 bytes, 4096 bytes proposed)**：是现代硬盘的主流标准（称为 “高级格式”），相比传统 512 字节扇区，能提升存储效率与数据完整性。
	-  **Error correcting code (ECC, 纠错码)**：硬盘硬件级的数据保护技术，可自动检测并修复部分数据错误，减少因磁盘物理缺陷导致的数据丢失风险。
		-  Used to hide defects and recording errors
	-   Synchronization fields and gaps(同步字段与间隙)
 -  Access to a sector involves //访问扇区的步骤
	-  Queuing delay if other accesses are pending //如果有其他请求, 则延迟
	-  Seek: move the heads //查找, 移动磁头
	-  Rotational latency //旋转延迟
	-  Data transfer //数据传输
	-  Controller overhead //控制开销
#### Disk Access Example
-  Given
	-  512B sector, 15,000rpm, 4ms average seektime, 100MB/s transfer rate, 0.2ms controlleroverhead, idle disk
	- Average read time
		-  4ms seek time //查找时间
			\+ ½ / (15,000/60) = 2ms rotational latency 
					//旋转延时磁头定位到目标磁道后，等待目标扇区旋转到磁头下方的平均时间，通常取转速周期的 1/2（因扇区随机分布，平均等待半圈）。
			\+ 512 / 100MB/s = 0.005ms transfer time //数据传输时间
			\+ 0.2ms controller delay /控制延迟时间
		= 6.2ms
-  If actual average seek time is 1ms
	-  Average read time = 3.2ms
##### 磁盘响应时间计算举例
###### 例1
1. 假定每个扇区512字节， 磁盘转速为5400 RPM，寻道时间（最大寻道时间的一半）为12 ms, 数据传输率为4 MB/s, 磁盘控制器开销为1 ms, 不考虑排队时间，则磁盘响应时间为多少？
*解*:Disk Response Time= Seek time + Rotational Latency + Transfer time
					\+ Controller Time + Queuing Delay
					= 12 ms + 0.5 / 5400 RPM + 0.5 KB / 4 MB/s + 1 ms + 0
					= 12 ms + 0.5 / 90 RPS + 0.125 / 1024 s + 1 ms + 0
					= 12 ms + 5.5 ms + 0.1 ms + 1 ms + 0 ms
					= 18.6 ms
如果实际的寻道时间只有1/3的话，则总时间变为10.6ms，这样旋转等待时间就占了近50%！
12/3+5.5+0.1+1=10.6ms
- 为什么实际的寻道时间可能只有1/3？
		访问局部性使得每次磁盘访问大多在局部几个磁道，实际寻道时间变少！
- 能否算出每道大约有多少扇区？
		4MB\*60 / (512B\*5400) ≈ 91个扇区
		每分钟传输的数据/每分钟转的圈数(道数)/每个扇区的大小=每道的扇区数
###### 例2
1. 某磁盘存储器转速为3000转/分，共有4个记录盘面，每毫米5道，每道记录信息12 288字节，最小磁道直径为230mm，共有275道，求：
	（1）磁盘存储器的存储容量；
	（2）最高位密度（最小磁道的位密度）和最低位密度；
	（3）磁盘数据传输率；
	（4）平均等待时间。
	*解*：
	（1）存储容量= 275道×12 288 /道×4面= 13 516 800字节
	（2）最高位密度= 12 288B/230$\pi$≈17B/mm≈136位/mm
		最大磁道直径	=230mm+275道/5道× 2
				   = 230mm + 110mm = 340mm
		最低位密度= 12 288B / 340
				   ≈11.5B/mm≈92位/ mm
	（3）磁盘数据传输率 = 12 288 × 3000转/分
					 =12 288 × 50转/秒
					 =614 400字节/S
	（4）平均等待时间= 1/50 / 2 = 10ms
	*讨论*
	1、本题给出的道容量单位为字节，因此算出的存储容量单位也是字节，而不是位；
	2、由此算出的位密度单位最终应转换成bpm(位/毫米）；
	3、平均等待时间是磁盘转半圈的时间，与容量无关。
###### 例3
下列存储器中，不采用随机存储方式的是*B*。
 A．EPROM B．CDROM
 C．DRAM D．SRAM
###### 例4
某磁盘的转速为10 000转/分，平均寻道时间是6ms，磁盘传输速率为20MB/s，磁
盘控制器延迟为0.2ms，读取一个4KB的扇区所需要的平均时间约为 *B*。
 A. 9ms B. 9.4ms C. 12ms D. 12.4ms
*答*：读取一个4KB的扇区所需要的平均时间
 = 磁盘控制器延迟+平均寻道时间+
 平均旋转延迟TR+传输一个扇区数据的时间TA。
 TR=(60/10000)/2=3ms，TA=4KB/20MB=0.2ms。
 则读取一个4KB的扇区所需要的平均时间
 =0.2ms+6ms+3ms+0.2ms=9.4ms。故选B。
### Disk Performance Issues
- Manufacturers quote average seek time
	-  Based on all possible seeks
	-  Locality and OS scheduling lead to smaller actualaverage seek times
-  Smart disk controller allocate physical sectors ondisk
	-  Present logical sector interface to host
	-  SCSI, ATA, SATA
-  Disk drives include caches
	-  Prefetch sectors in anticipation of access
	-  Avoid seek and rotational delay
#### 冗余磁盘阵列(RAID)(RAID0-RAID7)
 - 系统总体性能的提高不匹配
	- 处理器和主存性能改进快
	- 辅存性能性能改进慢可靠性(Reliability)
*所用措施*：RAID-Redundant Arrays of Inexpensive Disk （磁盘冗余阵列）
- RAID的基本思想：
	将多个独立操作的磁盘按某种方式组织成磁盘阵列(Disk Array)，以增加容量，利用类似于主存中的多体交叉技术，将数据存储在多个盘体上，通过使这些盘并行工作来提高数据传输速度，并用冗余(redundancy)磁盘技术来	进行错误恢复(error correction)以提高系统可靠性。
- RAID特性：
	（1）RAID是一组物理磁盘驱动器，在操作系统下被视为一个单逻辑驱动器。
	（2）数据分布在一组物理磁盘上。
	（3）冗余磁盘用于存储奇偶校验信息，保证磁盘万一损坏时能恢复数据。
- RAID级别
	- 目前已知的RAID方案分为8级（0-7级），以及RAID10（结合0和1级）和RAID30 （结合0和3级）和RAID50 （结合0和5级） 。但这些级别不是简单地表示层次关系，而是表示具有上述3个共同特性的不同设计结构。
##### 例题
1. 下列选项中，用于提高RAID可靠性的措施有*B*。
I. 磁盘镜像        II. 条带化
III. 奇偶校验      IV. 增加Cache机制
A. 仅I、II         B. 仅I、III
C. 仅I、III和IV    D. 仅II、III和IV
*答*：条带化是为了提高吞吐率，
   增加Cache机制是为了提高速度。
   用于提高RAID可靠性的措施有“磁盘镜像”和“奇偶校验”，
   故选B。
# The Basics of Caches
现在的存储器:
![](存储器.png)
## 层次化存储器结构（Memory Hierarchy）
![](层次化存储器结构.png)
- 数据总是在相邻两层之间复制传送
	- Upper Level: 上层更靠CPU
	- Lower Level: 下层更远离CPU
	- Block: 最小传送单位是定长块，互为副本
- *问题*：为什么这种层次化结构是有效的？
	- 时间局部性（Temporal Locality）
		含义：刚被访问过的单元很可能不久又被访问
		做法：让最近被访问过的信息保留在靠近CPU的存储器中
	- 空间局部性（Spatial Locality）
		含义：刚被访问过的单元的邻近单元很可能不久被访问
		做法：将刚被访问过的单元的邻近单元调到靠近CPU的存储器中
## 加快访存速度措施：引入Cache
- 大量典型程序的运行情况分析结果表明
	-  在较短时间间隔内，程序产生的地址往往集中在一个很小范围内这种现象称为程序访问的局部性：空间局部性、时间局部性
- 程序具有访问局部性特征的原因
	-  指令：指令按序存放，地址连续，循环程序段或子程序段重复执行
	-  数据：连续存放，数组元素重复、按序访问
- 为什么引入Cache会加快访存速度？
	-  在CPU和主存之间设置一个快速小容量的存储器，其中总是存放最活跃（被频繁访问）的程序和数据，由于程序访问的局部性特征，大多数情况下，CPU能直接从这个高速缓存中取得指令和数据，而不必访问主存。这个高速缓存就是位于主存和CPU之间的**Cache**！
### 局部性原理举例
#### 程序的局部性原理举例1
#### 例2 程序的局部性原理
- 以下哪个对数组a引用的空间局部性更好？时间局部性呢？变量sum的空间局部性和时间局部性如何？对于指令来说，for循环体的空间局部性和时间局部性如何？
- ![](例2程序的局部性原理主存布局.png)
*程序段A*:
```
int sumarrayrows(int a\[M\]\[N\])
{
int i, j, sum=0;
for (i=0; i<M, i++)
for (j=0; j<N, j++) sum+=a\[i\]\[j\];
return sum;
}
```
*程序段B*:
```
int sumarraycols(int a\[M\]\[N\])
{
int i, j, sum=0;
for (j=0; j<N, j++)
for (i=0; i<M, i++) sum+=a\[i\]\[j\];
return sum;
}
```
#### 程序段A
程序段A的时间局部性和空间局部性分析
（1）数组a：访问顺序为a\[0\]\[0\], a\[0\]\[1\] ,……,a\[0\]\[2047\]; a\[1\]\[0\], a\[1\]\1\],…… ,a\[1\]\[2047\];
……，与存放顺序一致，故*空间局部性好*！
因为每个a\[i\]\[j\]只被访问一次，故*时间局部性差*！
（2）变量sum：单个变量不考虑空间局部性；每次循环都要访问sum，所以其*时间局部性较好*！
（3） for循环体：循环体内指令按序连续存放，所以*空间局部性好*！
		循环体被连续重复执行2048\*2048次，所以*时间局部性好*！
#### 程序段B
程序段B的时间局部性和空间局部性分析
（1）数组a：访问顺序为a\[0\]\[0\], a\[1\]\[0\] ,……,a\[2047\]\[0\]; a\[0\]\[1\],a\[1\]\[1\],…… ,a\[2047\]\[1\];……，与存放顺序不一致，每次跳过2048个单元，*若交换单位小于2KB，则没有空间局部性*！
（*时间局部性差*，同程序A）
（2）变量sum：（同程序A ）
（3） for循环体：（同程序A）

*实际运行结果*(2GHz Intel Pentium 4):
- 程序A：59,393,288 时钟周期
- 程序B：1,277,877,876 时钟周期
### Cache(高速缓存)是什么样的？
Cache是一种小容量高速缓冲存储器，它由**SRAM**组成。
Cache直接制作在**CPU芯片内**，**速度几乎与CPU一样快**。
程序运行时，CPU使用的一部分数据/指令会预先成批拷贝在Cache中，
Cache的内容是主存储器中部分内容的映象。
当CPU需要从内存读(写)数据或指令时，先检查Cache，若有，就直接从Cache中读取，而不用访问主存储器。
![Cache存储器数据访问过程](Cache存储器数据访问过程.png)
### Adding Cache to Computer
![Adding Cache to Computer](Adding_Cache_to_Computer.png)
### Memory Access 
- Load word instruction: lw $t0,0($t1)
- $t1 contains 0x12F0, Memory[0x12F0] =99
#### Memory Access without Cache
1. Processor issues address 0x12F0 to Memory
2. Memory reads word at address 0x12F0 (99)
3. Memory sends 99 to Processor
4. Processor loads 99 into register $t0
#### Memory Access with Cache
1. Cache checks to see if has copy of data at address 0x12F0
	a. If finds a match (Hit): cache reads 99, sends to processor
	b. No match (Miss): cache sends address 0x12F0 to Memory
		I. Memory reads 99 at address 0x12F0
		II. Memory sends 99 to Cache
		III. Cache replaces word which can store 0x12F0 with new 99
		IV. Cache sends 99 to processor
2. Processor loads 99 into register $t0
### Caches <-> Pipeline Relationship
![Caches <-> Pipeline Relationship](Caches-PipelineRelationship.png)
### Cache Memory
> The level of the memory hierarchy closest to the CPU

#### Direct Mapped Cache
- Location determined by address
	- Direct mapped: only one choice
	- (Block address) modulo (#Blocks in cache)// *计算公式*:(块地址）对（缓存中的块数）取余(类似于哈希)
//Blocks is a power of 2
//Use low-order address bits
#### Tags and Valid Bits
- **标记（Tag）**：缓存中用于唯一标识主存块的地址片段。由于直接映射缓存通过 “块地址取余” 确定缓存位置，不同主存块可能映射到同一缓存位置，因此需存储块地址的高阶位（即标记），用于区分当前缓存位置中实际存储的是哪一个主存块。
- **有效位（Valid Bit）**：缓存初始化时，所有位置均无有效数据，故有效位设为 0；当主存块被载入缓存后，对应位置的有效位更新为 1。通过有效位可避免访问缓存中未初始化或已失效的数据，确保数据正确性。
- How do we know which particular block isstored in a cache location?
	- Store block address as well as the data
	- Actually, only need the high-order bits
	- Called the tag
- What if there is no data in a location?
	- Valid bit: 1 = present, 0 = not present
	- Initially 0
#### Address Subdivision
![Address Subdivision](AddressSubdivision.png)
### Cache Example
#### CacheExample
[Cache Example](CacheExample.md#CacheExample)
#### Example 1
1 KB Direct Mapped Cache with 32 B Blocks
[Cache Example](CacheExample.md#1_KB_Direct_Mapped_Cache_with_32_B_Blocks)
#### Example2
[Cache Example](CacheExample.md#ex)
### Block Size Considerations
- Larger blocks should reduce miss rate
	-  Due to spatial locality
-  But in a fixed-sized cache
	-  Larger blocks -> fewer of them
		-  More competition -> increased miss rate
	-  Larger blocks -> pollution
-  Larger miss penalty
	-  Can override benefit of reduced miss rate
	-  Early restart and critical-word-first can help
#### Miss Rate Versus Block Size
![Miss Rate Versus Block Size](MissRateVersusBlockSize.png)

### Cache Misses
-  On cache hit, CPU proceeds normally
-  On cache miss
	-  Stall the CPU pipeline
	-  Fetch block from next level of hierarchy
	-  Instruction cache miss
		-  Restart instruction fetch
	-  Data cache miss
		-  Complete data access
#### Sources of Cache Misses(3'c)
- **Compulsory Miss** (cold start, first reference):**强制性失效（又称冷启动失效、首次访问失效）**
	-  *1st access to a block*, not a lot you can do about it.
		-  If running billions of instructions, compulsory misses are insignificant
-  **Capacity Miss**:
	-  Cache cannot contain all blocks accessed by theprogram
		-  Misses that would not occur with infinite cache
-  **Conflict Miss (collision)**:
	-  Multiple memory locations mapped to same cache set
		-  Misses that would not occur with ideal fully associative cache
### Handling Stores with Write

#### hit
- Store instructions write to memory,changing values
- Need to make sure cache and memory have same values on writes: 2 policies
1) Write-Through Policy //写Cache和主存, Cache和主存内容一致
2) Write-Back Policy //只写Cache, 增加dirty标记位
##### Write-Through Cache
- Write both values in cache and in memory
- Write buffer stops CPU from stalling if memory cannot keep up
- Write buffer may have multiple entries to absorb bursts of writes

###### Write-Through
 On data-write hit, could just update the block in
cache
 But then cache and memory would be inconsistent
 Write through: also update memory
 But makes writes take longer
 e.g., if base CPI = 1, 10% of instructions are stores,
write to memory takes 100 cycles
 Effective CPI = 1 + 0.1×100 = 11
 Solution: write buffer
 Holds data waiting to be written to memory
 CPU continues immediately
 Only stalls on write if write buffer is already full
##### Write-Back Cache
 Store/cache hit, write data
in cache only & set dirty bit
 Memory has stale value
 Store/cache miss, read
data from memory, then
update and set dirty bit
 “Write-allocate” policy
 On any miss, write back
evicted block, only if dirty.
Update cache with new
block and clear dirty bit.
###### Write-Back
 Alternative: On data-write hit, just update
the block in cache
 Keep track of whether each block is dirty
 When a dirty block is replaced
 Write it back to memory
 Can use a write buffer to allow replacing block
to be read first
#### Miss 
#### Write Policy Choices
 Cache hit:
 write through: writes both cache & memory on every access
 Generally higher memory traffic but simpler pipeline & cache design
 write back: writes cache only, memory `written only when dirty
entry evicted
 A dirty bit per line reduces write-back traffic
 Must handle 0, 1, or 2 accesses to memory for each load/store
 Cache miss:
 no write allocate: only write to main memory
 write allocate (aka fetch on write): fetch into cache
 Common combinations:
 write through and no write allocate
 write back with write allocate

# Large and Fast : Exploiting Memory Hierarchy
## Cache (Performance) Terms
 Hit rate: fraction of accesses that hit in the cache
 Miss rate: 1 – Hit rate
 Miss penalty: time to replace a block from lower level in memory hierarchy to cache
 Hit time: time to access cache memory (including tag comparison)

## Main Memory Supporting Caches
 Use DRAMs for main memory
 Fixed width (e.g., 1 word)
 Connected by fixed-width clocked bus
 Bus clock is typically slower than CPU clock
 Example cache block read
 1 bus cycle for address transfer
 15 bus cycles per DRAM access
 1 bus cycle per data transfer
 For 4-word block, 1-word-wide DRAM
 Miss penalty = 1 + 4×15 + 4×1 = 65 bus cycles
 Bandwidth = 16 bytes / 65 cycles = 0.25 B/cycle
## Measuring Cache Performance
 Components of CPU time
 Program execution cycles
 Includes cache hit time
 Memory stall cycles
 Mainly from cache misses
 With simplifying assumptions:
$$Memory stall cycles= \frac{Memory accesses}{Program} * Miss rate * Miss penalty$$
### [Cache Performance Example](CacheExample.md#CachePerformanceExample) 
