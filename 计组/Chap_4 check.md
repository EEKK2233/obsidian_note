**1.1**
For each code sequence below, state whether it must stall, can avoid stalls using only forwarding, or can execute without stalling or forwarding.

| Seauence 1                                          | Sequence 2                                                                    | Sequence 3                                                                                                                |
| :-------------------------------------------------- | :---------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| lw  &#36t0, 0(&#36t0)<br>add &#36t1, &#36t0, &#36t0 | add  &#36t1,&#36t0,&#36t0<br>addi &#36t2,&#36t0,#5<br>addi &#36t4, &#36t1, #5 | addi &#36t1, &#36t0, 1<br>addi &#36t2, &#36t0, 2<br>addi &#36t3,&#36t0,2<br>addi &#36t3,&#36t0,4 <br>addi &#36t5,&#36t0,5 |
   
   >Sequence 1: Stall on the lw result.
   >Sequence 2: Bypass the first add result written into $t1.
   >Sequence 3: No stall or bypass required.

**4.13.1** If there is no forwarding or hazard detection, insert nopsto ensure correct execution.
![](4_check_4_13_1.png)

**4.9**
In this exercise,we examineh ow data dependences affect execution in the basic 5-stage pipeline described in Section4.5.Problems in this exercise refer to the following sequence of instructions:
> orr1,r2,r3<br>orr2,r1,r4<br>orr1,r1,r2

Also,assumethefollowingcycletimesforeachoftheoptionsrelatedtoforwarding:

| WithoutForwarding | With FullForwarding | With ALU-ALU ForwardingOnly |
| ----------------- | ------------------- | --------------------------- |
| 250ps             | 300ps               | 290ps                       |
1. Indicate dependences and their type.

|Instructionsequence|Dependences|
|---|---|
|I1:ORR1,R2,R3<br>I2:ORR2,R1,R4<br>I3:ORR1,R1,R2|RAW on R1 from I1 to I2 and I3 <br>RAW on R2 from 2 to I3<br>WAR on R2 from I1 to I2<br>WAR on R1 from I2 to I3 <br>WAW on R1 from I1 to I3|
2. Assume there is no forwarding in this pipelined processor. Indicate hazards and add nopinstructions to eliminate them.
> In the basic five-stage pipeline WAR and WAW dependences do not cause any hazards. The code that eliminates these hazards by inserting NOP instructions is:

|   Instructionsequence  |   Delay  |
| --- | --- |
|   ORR1,R2,R3<br>NOP<br>NOP<br>ORR2,R1,R4<br>NOP<br>NOP<br>ORR1,R1,R2|  Delay I2 to avoid RAW hazard on R1 fromI1<br>Delay I3 to avoid RAW hazard on R2 fromI2   |
3. Assume there is full forwarding. Indicate hazards and add NOP instructions to eliminate them.
4. What is the total execution time of this instruction sequence without forwarding and with full forwarding? What is the speedup achieved by adding full forwarding to a pipeline that had no forwarding?
5. Add nopinstructions to this code to eliminate hazards if there is ALU-ALU forwarding only (no forwarding from the MEM to the EX stage).
 >With ALU-ALU-only forwarding, an ALU instruction can forward to the next instruction, but not to the second-next instruction (because that would be forwarding from MEM to EX). A load cannot forward at all, because it determines the data value in MEM stage, when it is too late for ALU-ALU forwarding. We have:

|Instructionsequence|forward|
|:---|---|
|ORR1,R2,R3<br>ORR2,R1,R4<br>nop<br>nop//to load R1 from reg<br>ORR1,R1,R2|ALU-ALU forwarding of R1 from I1<br>ALU-ALU forwarding of R2 from I2|
6. What is the total execution time of this instruction sequence with only ALU-ALU forwarding? What is the speedup over a no-forwarding pipeline?