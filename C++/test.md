## google test
```cpp
#include <gtest/gtest.h>  
#include <memory>

#include <tuple>  
#include "Executor.hpp"  
namespace adas

{

bool operator==(const Pose& lhs, const Pose& rhs)

{   // 为Pose定义==运算符重载，使得在测试中比较Pose对象变得简单明了， std::tie提高代码可读性

    return std::tie(lhs.x, lhs.y, lhs.heading) == std::tie(rhs.x, rhs.y, rhs.heading);

}

  
//       测试套            测试用例名，清晰地描述了预期行为和测试的条件，更容易理解测试在验证什么

TEST(ExecutorTest, should_return_init_pose_when_without_command)

{

    // given

    std::unique_ptr<Executor> executor(Executor::NewExecutor({0, 0, 'E'}));

  
    // when  测试遵循了 Arrange-Act-Assert (AAA) 模式，这是提高可读性和维护性的好习惯

  
    // then

    const Pose target({0, 0, 'E'});

    ASSERT_EQ(target, executor->Query());

}

}  // namespace adas
```

这段代码是一个典型的 **Google Test（gtest）** 单元测试示例，用来验证一个名为 `Executor` 的类在没有任何命令输入时是否返回初始姿态（Pose）。下面逐条解释其中涉及的 **C++ 测试相关知识点**：

---

### ✅ 1. 使用 `gtest` 框架

cpp

复制

```cpp
#include <gtest/gtest.h>
```

- **Google Test** 是 C++ 中最流行的单元测试框架之一。
    
- `TEST(TestSuiteName, TestName)` 是它的宏，用于定义一个测试用例。
    

---

### ✅ 2. 测试命名规范

cpp

复制

```cpp
TEST(ExecutorTest, should_return_init_pose_when_without_command)
```

- **测试套（Test Suite）**：`ExecutorTest`
    
- **测试用例名**：`should_return_init_pose_when_without_command`
    
- 命名清晰表达 **测试意图**，是gtest最佳实践之一。
    

---

### ✅ 3. AAA 模式（Arrange-Act-Assert）

cpp

复制

```cpp
// given（Arrange）
std::unique_ptr<Executor> executor(Executor::NewExecutor({0, 0, 'E'}));

// when（Act）——这里省略了显式调用，因为是初始化状态

// then（Assert）
const Pose target({0, 0, 'E'});
ASSERT_EQ(target, executor->Query());
```

- **Arrange**：准备测试数据和环境。
    
- **Act**：执行被测操作（此处是构造函数）。
    
- **Assert**：验证结果是否符合预期。
    

---

### ✅ 4. 使用 `ASSERT_EQ` 断言

cpp

复制

```cpp
ASSERT_EQ(target, executor->Query());
```

- `ASSERT_EQ` 是 gtest 提供的宏，用于判断两个值是否相等。
    
- 如果断言失败，测试会立即终止。
    

---

### ✅ 5. 为被测类型重载 `operator==`

cpp

复制

```cpp
bool operator==(const Pose& lhs, const Pose& rhs)
{
    return std::tie(lhs.x, lhs.y, lhs.heading) == std::tie(rhs.x, rhs.y, rhs.heading);
}
```

- 为了让 `ASSERT_EQ` 能比较两个 `Pose` 对象，必须提供 `operator==`。
    
- 使用 `std::tie` 可以简洁地比较多个成员变量，避免手写冗长的 `if` 链。
    

---

### ✅ 6. 使用智能指针管理资源

cpp

复制

```cpp
std::unique_ptr<Executor> executor(Executor::NewExecutor(...));
```

- 使用 `std::unique_ptr` 确保资源自动释放，符合 RAII 原则。
    
- 也避免测试中出现内存泄漏。
    

---

### ✅ 7. 测试封装在命名空间中

cpp

复制

```cpp
namespace adas { ... }
```

- 保持与被测代码一致的命名空间，避免符号冲突。
    
- 测试代码通常放在与被测代码相同的命名空间下，便于访问内部实现（如有需要）。
    

---

### ✅ 8. 测试可读性与可维护性

- 使用清晰的变量名：`target`, `executor`
    
- 使用 `std::tie` 提高比较逻辑可读性
    
- 注释标明 `given / when / then`，方便团队维护
    

---

### ✅ 总结一句话：

> 这段代码展示了如何用 **Google Test** 编写一个结构清晰、断言明确、可维护的 C++ 单元测试，并通过重载 `operator==` 和智能指针等现代 C++ 技术，使测试简洁、安全、易读。