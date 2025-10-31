下面给出一份“CMake 常用语法速查表”，按使用频率排序，左侧一句“能做什么”，右侧给出“最少且现代”的写法，复制即可用。

> 约定：  
> • 所有示例均要求 CMake ≥ 3.20  
> • 统一使用 **target-centric** 风格（不再出现 `include_directories()` 等老命令）  
> • `${}` 变量、`<>` 生成器表达式均可直接粘贴

---

### 1. 项目/语言声明

| 任务        | 一行就够                                   |
| :-------- | :------------------------------------- |
| 声明最低版本    | `cmake_minimum_required(VERSION 3.20)` |
| 声明项目及语言   | `project(MyApp LANGUAGES CXX CUDA)`    |
| 设置 C++ 标准 | `set(CMAKE_CXX_STANDARD 20)`（全局默认）     |

---

### 2. 目标（可执行文件 & 库）

|任务|一行就够|
|:--|:--|
|生成可执行文件|`add_executable(app src/main.cpp)`|
|生成静态库|`add_static_lib(Math STATIC src/math.cpp)`|
|生成共享库|`add_library(Math SHARED src/math.cpp)`|
|头文件-only 库|`add_library(Math INTERFACE)`|
|设置输出名|`set_target_properties(app PROPERTIES OUTPUT_NAME "mycli")`|
|设置调试后缀|`set_target_properties(Math PROPERTIES DEBUG_POSTFIX "d")`|

---

### 3. 给目标“挂”信息（现代 CMake 核心）

表格

复制

|任务|命令|
|:--|:--|
|添加 include 路径|`target_include_directories(app PUBLIC include/)`|
|链接库|`target_link_libraries(app PRIVATE Math Threads::Threads)`|
|添加编译定义|`target_compile_definitions(app PRIVATE USE_OPENCV)`|
|开启警告|`target_compile_options(app PRIVATE $<$<CXX_COMPILER_ID:GNU,Clang>:-Wall -Wextra>)`|
|要求编译特性|`target_compile_features(app PUBLIC cxx_std_20)`|

---

### 4. 变量 & 缓存

表格

复制

|任务|命令|
|:--|:--|
|普通变量|`set(SRC_FILES a.cpp b.cpp)`|
|缓存条目（可在 ccmake 中改）|`set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type")`|
|选项开关|`option(BUILD_TESTS "Build unit tests" ON)`|

---

### 5. 条件 / 循环

表格

复制

|任务|命令|
|:--|:--|
|平台判断|`if(WIN32)` … `endif()`|
|生成器表达式|`$<$<CONFIG:Debug>:--coverage>`|
|遍历列表|`foreach(f IN LISTS SRC_FILES)` … `endforeach()`|

---

### 6. 查找/使用外部依赖

表格

复制

|任务|命令|
|:--|:--|
|系统已安装|`find_package(Boost 1.82 REQUIRED COMPONENTS system)`|
|拉取源码（CMake 3.24+）|`FetchContent_Declare(fmt GIT_REPOSITORY https://github.com/fmtlib/fmt GIT_TAG 10.1.0)`|
|链接结果|`target_link_libraries(app PRIVATE fmt::fmt)`|

---

### 7. 安装 & 导出

表格

复制

|任务|命令|
|:--|:--|
|安装目标|`install(TARGETS app Math EXPORT MathTargets)`|
|安装头文件|`install(DIRECTORY include/ DESTINATION include)`|
|生成 *Config.cmake|`install(EXPORT MathTargets FILE MathTargets.cmake NAMESPACE Math:: DESTINATION lib/cmake/Math)`|
|快速打包|`include(CPack)`（然后 `cpack -G ZIP`）|

---

### 8. 测试

表格

复制

|任务|命令|
|:--|:--|
|开启测试|`enable_testing()`|
|添加可执行测试|`add_executable(unit_test test.cpp)`|
|注册测试|`add_test(NAME ut COMMAND unit_test)`|
|GoogleTest 自动发现|`gtest_discover_tests(unit_test)`|

---

### 9. 常用生成器表达式（延迟求值）

表格

复制

|表达式|含义|
|:--|:--|
|`$<CONFIG:Debug>`|仅 Debug 配置为真|
|`$<PLATFORM_ID:Windows>`|仅 Windows 为真|
|`$<STREQUAL:${CMAKE_BUILD_TYPE},Release>`|字符串相等|
|`$<TARGET_FILE:app>`|取目标的完整路径|

---

### 10. 一句话技巧

表格

复制

|需求|命令|
|:--|:--|
|统一输出目录|`set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)`|
|预编译头|`target_precompile_headers(app PRIVATE <vector> <map>)`|
|Unity 构建加速|`set(CMAKE_UNITY_BUILD ON)`|
|调用 clang-tidy|`set(CMAKE_CXX_CLANG_TIDY clang-tidy;-checks=*)`|
|地址消毒器|`target_compile_options(app PRIVATE -fsanitize=address)`|

---

### 11. 速查记忆口诀

**“一项目二目标，三挂信息四查包；五测试六安装，生成器表达式别忘了。”**

把这张表贴在桌前，80% 的 CMake 需求都能 10 秒内写出。