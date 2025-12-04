`.clang-format` 是一个**纯文本配置文件**，放在**项目根目录**（或任何父目录）即可生效。  
它告诉 `clang-format` 到底怎么排版：缩进几格、大括号换不换行、指针靠左靠右……

---

### ✅ 最简写法：一行也行

```yaml
BasedOnStyle: Google
```
→ 整个项目直接沿用 Google C++ 风格，**零配置开箱即用**。

---

### ✅ 常用模板（可复制即用）

#### 1. Google 风格 + 2 空格缩进 + 指针靠左
```yaml
---
BasedOnStyle: Google
IndentWidth: 2
PointerAlignment: Left
AllowShortFunctionsOnASingleLine: Inline
...
```

#### 2. LLVM 风格 + 4 空格 + 大括号换行
```yaml
---
BasedOnStyle: LLVM
BreakBeforeBraces: Allman
IndentWidth: 4
PointerAlignment: Middle
...
```

#### 3. 自定义「国内大厂」风格（可读性优先）
```yaml
---
Language: Cpp
BasedOnStyle: Google
IndentWidth: 4
ColumnLimit: 100
PointerAlignment: Left
BreakBeforeBraces: Attach
AllowShortIfStatementsOnASingleLine: false
AllowShortFunctionsOnASingleLine: Empty
SortIncludes: true
...
```

---

### ✅ 如何生成完整模板

终端执行：
```bash
clang-format -style=llvm -dump-config > .clang-format
```
→ 立刻得到**百行官方默认配置**，按需删改即可。

---

### ✅ 必懂字段速查（10 个够用）

| 字段 | 作用 | 常用值 |
|------|------|--------|
| `BasedOnStyle` | 继承哪个大风格 | `Google` / `LLVM` / `Chromium` / `Mozilla` |
| `IndentWidth` | 缩进列数 | `2` / `4` |
| `ColumnLimit` | 一行最大字符 | `80` / `100` / `120` |
| `PointerAlignment` | `*` `&` 靠哪边 | `Left` (`int* p`) / `Right` (`int *p`) / `Middle` (`int * p`) |
| `BreakBeforeBraces` | 大括号换行策略 | `Attach` (Java) / `Allman` (独行) / `Linux` (函数不换行) |
| `AllowShortFunctionsOnASingleLine` | 短函数放一行 | `true` / `false` / `Inline` |
| `SortIncludes` | 自动排序头文件 | `true` / `false` |
| `IndentCaseLabels` | `case` 是否缩进 | `true` / `false` |
| `SpacesBeforeTrailingComments` | 注释前空格数 | `1` / `2` |
| `UseTab` | 是否用 Tab | `Never` / `ForIndentation` |

---

### ✅ 验证写没写对

终端在项目根目录执行：
```bash
clang-format -i src/main.cpp
```
→ 如果格式按你预期变化，说明 `.clang-format` 已生效。

---

### ✅ 一句话总结

> 先写 **一行 `BasedOnStyle: Google`** 就能用；  
> 想微调，把官方模板 `clang-format -dump-config` 拉下来改 5~10 行即可。