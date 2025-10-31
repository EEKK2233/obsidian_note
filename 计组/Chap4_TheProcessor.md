# Introduction
![[QQ20251013-200406.png|**Components of a Computer**]]
# Logic Design Conventions
# 数据冒险(DATA Hazards)
## structure hazards(一个需要的结构被占用)
> **Solution**
> 1.  RegFileaccess is VERYfast: takes less than half the time of ALU stage
>    - Writeto Registers during first halfof each clock cycle
>    - Readfrom Registers during second halfof each clock cycle
> 2. Build RegFilewith independentread and write ports
>    
> **Result**:can perform Read and Write during same clock cycle
## Data hazard(需要等之前的指令完成数据读写)
> **Solution**
> 1. waiting stall but *impacts CPI*, 加空指令(NOP)
> 2. forwarding results as soon as they are available to where they are needed(*forwarding unit*)
>    (*if value not computed when needed, can't forward backward in time*)**!!!**
> 3. **Reorder** code to avoid use of load result in the next instruction
> ![[forwarding_unit.png|**forwarding_unit**]]
>  >forward A, B:EX hazard *(三种数据来源:reg, mem, EX/MEM(超前查看))*
   > if (EX/MEM.RegWrite and (EX/MEM.RegisterRd ≠ 0)and (EX/MEM.RegisterRd =ID/EX.RegisterRs))
   > **ForwardA = 10**
   > if (EX/MEM.RegWrite and (EX/MEM.RegisterRd ≠ 0)and (EX/MEM.RegisterRd = ID/EX.RegisterRt))
   > **ForwardB = 10**
   > MEM hazard
   > if (MEM/WB.RegWrite and (MEM/WB.RegisterRd ≠ 0)and (MEM/WB.RegisterRd = ID/EX.RegisterRs))
   > **ForwardA = 01**
   > if (MEM/WB.RegWrite and (MEM/WB.RegisterRd ≠ 0)and (MEM/WB.RegisterRd = ID/EX.RegisterRt))
   > **ForwardB = 01**
   > ![**datapath_with_forward**](datapath_with_forward.png)
## Control hazard(根据之前的指令决定控制行为)
>Solution
>1. waiting **stall** but *affects CPI*
>   ![Branch_Hazards](Branch_Hazards.png)

### 分支预测方法
#### 简单（静态）分支预测方法
>**基本做法**
> - 总预测条件不满足(not taken)，即：继续执行分支指令的后续指令
可加启发式规则：
在特定情况下总是预测满足(taken)，其他情况总是预测不满足
> -  预测失败时，需把流水线中三条错误预测指令丢弃掉
> - 将被丢弃指令的控制信号值或指令设置为0
（注：涉及到当时在IF、ID和EX三个阶段的指令）

缩短分支延迟，减少错误预测代价
- 可以将“转移地址计算”和“分支条件判断”操作调整到ID阶段来缩短延迟
- 将转移地址生成从MEM阶段移到ID阶段，可以吗？为什么？
（是可能的：IF/ID流水段寄存器中已经有PC的值和立即数）
- 将“判0”操作从EX阶段移到ID阶段，可以吗？为什么？
（用逻辑运算(如，先按位异或，再结果各位相或)来直接比较Rs和Rt的值）
（简单判断用逻辑运算，复杂判断可以用专门指令生成条件码）
（许多条件判断都很简单）
预测错误的检测和处理（称为“冲刷、冲洗”--Flush）
- 当Branch=1并且Zero=1时，发生转移（taken）
- 增加控制信号：IF.Flush=Branch and Zero，取值为1时，说明预测失败
- 预测失败(条件满足) 时，完成以下两件事（延迟损失时间片C=1时）：
> 1. 将转移目标地址->PC
> 2. 清除IF段中取出的指令，即：将IF/ID中的指令字清0，转变为nop指令
原来要清除三条指令，调整后只需要清除一条指令，因而只延迟一个时钟周期，每次预测错误减少了两个周期的代价！(C=1)[^17]

#### 动态分支预测方法
>动态预测**基本思想**：
- 利用最近转移发生的情况，来预测下一次可能转移还是不转移
- 根据实际情况来调整预测
- 转移发生的历史情况记录在BHT中（有多个不同的名称）
	- 分支历史记录表BHT（Branch History Table）
	- 分支预测缓冲BPB（Branch Prediction Buffer）
	- 分支目标缓冲BTB（Branch TargetBuffer）
- 每个表项由分支指令地址低位作索引，故在IF阶段就可以取到预测位
	- 低位地址相同的分支指令共享一个表项，所以，可能取的是其他分支指令的预测位。会不会有问题
	- 由于仅用于预测，所以不影响执行结果

现在几乎所有的处理器都采用动态预测（dynamic predictor）

**2 位预测器（2-Bit Predictor）**：一种经典的分支预测器，通过 2 位状态寄存器记录分支指令的历史执行情况（如 “强跳转”“弱跳转”“弱不跳转”“强不跳转”），根据历史状态预测下一次分支是否跳转，准确率通常高于 “始终预测跳转 / 不跳转” 的简单策略。


# Exceptions(中断)
> exception arises within the CPU, 有=由CPU导致的

## 系统控制协处理器(CP0)
- 在 MIPS 架构中，异常由系统控制协处理器（System Control Coprocessor，简称 CP0[^1]）管理。
- 保存出错（或被中断）指令的程序计数器（PC）
    - 在 MIPS 中：该值存储在异常程序计数器（Exception Program Counter，简称 EPC[^2]）中。
- 保存问题指示信息
    - 在 MIPS 中：该信息存储在 Cause 寄存器[^3]中。
    - 此处假设使用 1 位（来表示问题类型）：
        - 0 表示未定义操作码（的异常）
        - 1 表示溢出（异常）
- 跳转到地址为 8000 0018₁₆（注：原文本 “8000 00180” 为十六进制表示，末尾多写一个 “0”，修正为常见的 MIPS 异常处理程序入口地址格式，下标 “16” 表示十六进制）的处理程序（执行）
### 向量中断（Vectored Interrupts)[^4]

- 处理程序地址由中断原因决定
- 示例：
    - 未定义操作码（异常对应的中断）：C000 0000（十六进制地址）
    - 溢出（异常对应的中断）：C000 0020（十六进制地址）
    - ……（其他中断类型）：C000 0040（十六进制地址，此处为示例地址，不同中断类型对应不同地址偏移）
- （中断触发后执行的）指令功能二选一：
    - 直接处理该中断
    - 跳转到实际的（中断）处理程序
### 读取原因（寄存器），并转移至相关处理程序

- 确定所需执行的操作
- 若（异常 / 中断）可重启：
    - 执行纠正操作
    - 使用异常程序计数器（EPC）返回到原程序
- 若不可重启：
    - 终止程序
    - 利用异常程序计数器（EPC）、原因（寄存器）等信息报告错误
### 另一种控制冒险形式

- 考虑执行（EX）阶段加法运算发生溢出的情况
    - 示例指令：add $1, $2, $1（将寄存器$2 和$1中的值相加，结果写入寄存器$1)
- （处理流程）：
    1. 防止寄存器 $1 的值被破坏（避免溢出的错误结果覆盖原寄存器值）
    2. 完成（该加法指令之前的）所有先前指令的执行
    3. 清空（流水线中该）加法指令及后续所有指令（使其无效，避免错误执行)
    4. 设置 Cause 寄存器（记录异常原因）和 EPC 寄存器（记录异常发生时的指令地址）的值
    5. 将控制权转移到（异常）处理程序
- （此处理机制）与预测错误的分支（处理机制）类似
    - （两者）共用大量相同的硬件资源
## 流水线（技术）的异常处理相关内容
### 精确异常（Precise exceptions)

- 流水线（技术）会将多条指令的执行过程重叠进行
    - 可能会同时出现多个异常
    - 简单处理方法：优先处理最早进入流水线的指令所引发的异常
        - 清空后续（进入流水线的）指令
        - （这种处理方式称为）“精确异常”（Precise exceptions）
- 在复杂流水线中
    - 每个周期可发射多条指令
    - （指令存在）乱序完成（的情况）
    - 维持精确异常的处理（机制）难度很大！
### 非精确异常（Imprecise Exceptions）

- 直接停止流水线并保存状态
    - 状态中需包含（一个或多个）异常原因
- 由处理程序自行判断以下内容
    - 哪些指令引发了异常
    - 哪些指令需要完成执行，哪些需要清空
- 可能需要 “手动” 完成（部分指令的执行流程）
- （该方式）简化了硬件设计，但会使处理程序软件更为复杂
- 对于复杂的多发射乱序流水线而言，此方式不可行

# A Multicycle Implementation(多周期处理器设计)
>[!note] 主要内容
> 多周期数据通路实现思想
> 单周期数据通路和多周期数据通路的差别
> -  通过简要分析LOAD指令分阶段执行过程，以加深理解单周期和多周期数据通路的差别
> 多周期通路中存储单元的“竞争”问题及其解决思路
> 详细分析7条指令在多周期通路中的执行过程
> 在分析执行过程基础上，分析每个周期内控制信号的取值，生成相应的状态
> 综合生成所有指令的状态转换图
> 根据状态转换图，生成控制器输出的逻辑表达式
> 根据逻辑表达式，用PLA(硬布线)实现控制逻辑

## Drawback of Single Cycle Processor
单周期处理器的CPI为1，所有指令执行时间都以最长的load指令为准。
最长指令时间（load指令执行时间）为：
PC’s Clock -to-Q +
Instruction Memory Access Time +
Register File Access Time +
ALU Delay (address calculation) +
Data Memory Access Time +
Register File Setup Time +
Clock Skew
时钟周期远远大于其他指令实际所需的执行时间，效率极低。
•R-type指令、立即数运算指令不需要读内存
•Store指令不需要写寄存器（无需Setup时间）
•分支指令不需要访问内存和写寄存器
•Jump 不需要ALU运算，不需要读内存，也不需要读/写寄存器

![Load指令执行过程](Load指令执行过程.png)

## 多周期处理器的实现思想
- 单周期处理器的问题根源:
	- 时钟周期以最复杂指令所需时间为准，太长！
- 解决思路:
	1. 把指令的执行分成多个阶段，每个阶段在一个时钟周期内完成
		- 时钟周期以最复杂阶段所花时间为准
		- 尽量分成大致相等的若干阶段
		- 规定每个阶段最多只能完成1次访存或寄存器堆读/写或ALU
	2. 每步都设置存储元件，每部执行结果都在下个时钟开始保存到相应单元
- 多周期处理器的好处:
	1. 时钟周期短
	2. 不同指令所用周期数可以不同，如：
		- Load：five cycles
		- Jump：three cycles（前两个都一样）
	3. 允许功能部件在一条指令执行过程中被重复使用。如：
		- Adder + ALU（多周期时只用一个ALU，在不同周期可重复使用）
		- Inst./ Data mem（多周期时合用，不同周期中重复使用）

![多周期数据通路](多周期数据通路.png)
# 术语补充说明（适配计算机体系结构语境）
[^1]: **System Control Coprocessor (CP0)**：MIPS 架构中专门负责处理系统级功能的协处理器，核心作用包括异常管理、中断控制、状态寄存器维护等，是操作系统与硬件交互的关键组件。
[^2]: **Exception Program Counter (EPC)**：CP0 中的专用寄存器，用于保存发生异常时正在执行（或即将执行）的指令的 PC 值，以便异常处理完成后能正确返回到原执行流程。
[^3]: **Cause 寄存器**：同样属于 CP0，用于记录异常或中断的原因类型，通过不同位的取值区分未定义 opcode、算术溢出、外部中断等不同事件，方便处理程序针对性响应。
[^4]: **向量中断（Vectored Interrupts）**：一种中断处理机制，与 “非向量中断” 相对。其核心特点是不同类型的中断（或异常）对应预设的、唯一的处理程序入口地址（即 “向量地址”），CPU 可根据中断原因直接定位到对应处理程序，无需先执行统一的 “中断识别” 流程，能显著减少中断响应延迟。
[^5]: **Handler address（处理程序地址）**：指中断发生后，CPU 需要跳转到的、用于处理该中断事件的程序代码的内存地址，向量中断中该地址与中断原因一一对应（如示例中 “未定义操作码” 对应地址 C000 0000）。
[^6]: **restartable**：指异常 / 中断处理完成后，原程序是否可恢复执行的属性。例如，部分因临时资源冲突导致的中断属于 “可重启” 类型，而程序逻辑错误引发的严重异常（如非法内存访问）可能 “不可重启”。
[^7]: **corrective action**：针对可重启的异常 / 中断所执行的修复操作，例如重新申请资源、修正数据格式等，目的是消除导致异常的因素，使原程序能从 EPC 记录的地址继续正常执行。
[^8]: **执行（EX）阶段**：MIPS 流水线的核心阶段之一，主要功能是对译码后的指令进行算术逻辑运算（如加法、减法）、地址计算等，加法指令的溢出判断即在此阶段完成。
[^9]: **clobbered**：在计算机体系结构中，指寄存器或内存单元的值被错误指令意外覆盖、破坏的情况，此处强调需保护寄存器 $1 的原始值不被加法溢出的错误结果篡改。
[^10]: **Flush**：流水线中的 “清空” 操作，当检测到异常（如加法溢出）或分支预测错误时，需将流水线中已取指、译码但尚未执行完成的指令标记为无效，避免错误结果产生，是流水线错误恢复的关键步骤。
[^11]: **Pipelining（流水线）**：CPU 核心技术之一，将一条指令的执行拆解为取指、译码、执行、访存、写回等多个阶段，让不同指令的不同阶段在流水线中并行重叠执行，从而提升指令吞吐量。
[^12]: **Precise exceptions（精确异常）**：一种异常处理标准，要求异常发生后，能准确定位到 “引发异常的指令”，且确保该指令之前的所有指令已正确执行，该指令及之后的所有指令均未对系统状态（如寄存器、内存）产生错误修改，是保障程序正确性的关键机制。
[^13]: **Out-of-order completion（乱序完成）**：复杂流水线（如超标量流水线）的特性，指由于不同指令的执行周期长短不同（如简单加法 vs 复杂乘法），后进入流水线的指令可能先于先进入的指令完成执行，这种乱序特性会给精确异常的判定和处理带来挑战。
[^14]: **Imprecise Exceptions（非精确异常）**：与 “精确异常” 相对的异常处理方式，不严格保证能准确定位引发异常的指令，也不确保异常发生前所有指令均已正确执行、后续指令均未产生影响。其核心特点是硬件实现简单，但需软件（处理程序）承担更多异常分析和状态恢复工作。
[^15]: **multiple-issue out-of-order pipelines（多发射乱序流水线）**：复杂的 CPU 流水线架构，“多发射” 指每个周期可同时发射多条指令进入流水线，“乱序” 指指令执行和完成的顺序可能与指令在程序中的原始顺序不一致。此类流水线因指令并行度高、执行顺序复杂，无法通过 “非精确异常” 的简单停止 + 保存状态方式保证程序正确性，故不适用该异常处理机制。
[^16]: Instruction Set Architecture（ISA，指令集架构）是**计算机硬件（主要是 CPU）与软件之间的接口规范**，它定义了软件可以向硬件发出的指令类型、操作方式及数据格式，决定了软件如何控制硬件工作
[^17]: **延迟损失时间片C**：发生转移时，给流水线带来的延迟损失