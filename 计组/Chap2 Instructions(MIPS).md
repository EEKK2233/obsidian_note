# MIPS 指令集的三种基本格式

| 类型  | 31 … 26 | 25 … 21          | 20 … 16 | 15 … 11            | 10 … 6 | 5 … 0 |
| --- | ------- | ---------------- | ------- | ------------------ | ------ | ----- |
| R   | opcode  | rs               | rt      | rd                 | shamt  | funct |
| I   | opcode  | rs               | rt      | immediate (16 bit) |        |       |
| J   | opcode  | address (26 bit) |         |                    |        |       |

# R型指令
*srl*: Shift Right Logical , 把寄存器 **rt** 的值**逻辑右移** **shamt** 位，结果写入 **rd**，空位补 0
*sll*: Shift Left Logical , 把寄存器 **rt** 的值**逻辑左移** **shamt** 位，结果写入 **rd**，空位补 0

# I型指令


# J型指令

