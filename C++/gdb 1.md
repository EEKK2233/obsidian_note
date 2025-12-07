下面这份“速查表”按使用频率排序，90% 的调试场景只需记住前 20 条即可。  
（→ 表示可简写，括号内为常用缩写）

---

### 1. 启动 & 加载
```bash
gdb ./a.out              # 直接加载可执行文件
gdb ./a.out -tui         # 启动文本窗口（源码+命令分屏）
gdb -p <pid>             # attach 到正在运行的进程
```

---

### 2. 运行 & 中断
```
run  → r                 # 开始执行
run  arg1 arg2           # 带参数运行
Ctrl-C                   # 中断程序，回到 (gdb) 提示符
continue → c             # 继续运行到下一断点
kill                     # 终止被调试程序
quit  → q                # 退出 gdb
```

---

### 3. 断点（Breakpoints）
```
break  → b               # 通用断点
b main                   # 函数断点
b 12                     # 当前文件第 12 行
b Dijkstra.cpp:35        # 指定文件行号
b foo.cc:foo(int)        # 重载函数精确匹配
b 25 if i==5             # 条件断点
info breakpoints → i b   # 查看所有断点
disable 2                # 禁用编号 2 的断点
enable 2                 # 重新启用
delete 2                 # 删除编号 2
delete                   # 删除全部断点
```

---

### 4. 单步 & 堆栈
```
next  → n                # 单步**过**函数（不进入）
step  → s                # 单步**入**函数
finish                   # 执行到当前函数返回
until  → u               # 执行到当前行之后（跳出循环）
where → bt               # 打印调用栈（backtrace）
frame → f 2              # 切换到第 2 帧
up / down                # 向栈顶/栈底移动一帧
```

---

### 5. 查看变量 & 内存
```
print  → p  foo          # 打印变量值
p/x foo                  # 十六进制
p *array@10              # 打印数组前 10 个元素
p foo.bar                # 打印成员
display foo              # 每次停顿时自动打印
undisplay 1              # 取消编号 1 的 display
x/10wx 0x7fff1234        # 按十六进制查看 10 个字（word）
x/20bx buf               # 按字节查看 20 个字节
```

---

### 6. 线程 & 进程（多线程/多进程）
```
info threads             # 列出所有线程
thread 3                 # 切换到 3 号线程
thread apply all bt      # 所有线程打印栈
set follow-fork-mode child # fork 后追踪子进程
```

---

### 7. 反汇编 & 寄存器
```
disassemble main         # 反汇编函数
disassemble 0x4005a0,0x4005c0
info registers → i r     # 查看通用寄存器
p $rax                   # 打印单个寄存器
```

---

### 8. 信号 & 异常
```
handle SIGUSR1 noprint   # 屏蔽自定义信号输出
catch throw              # 捕获所有 C++ 异常
catch catch              # 捕获异常被 catch 的位置
```

---

### 9. 脚本化 & 重复
```
set pagination off       # 关闭分页提示，适合脚本
set logging on           # 把 gdb 输出写到 gdb.txt
source my.gdb            # 批量执行命令文件
define myback            # 自定义命令（宏）
> bt
> info registers
> end
```

---

### 10. TUI 模式专用（分屏）
Ctrl-X A                 # 进入/退出 TUI 分屏
Ctrl-X 2                 # 切换布局（源码+汇编+寄存器）
Ctrl-L                   # 刷新屏幕（防止花屏）

---

### 11. 快速实战流程（最简记忆）
1. `gdb ./a.out`
2. `b main`
3. `r`
4. `n / s` 单步
5. `p 变量`
6. `c` 继续
7. `bt` 看栈
8. `q` 退出

---

把这张表贴在工位，调试效率翻倍。  
需要针对多线程、core 文件、或者 VS Code + gdb 整合再深入，随时喊我。