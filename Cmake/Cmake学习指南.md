# 🧭 CMake 学习指南（2025 精修版）

> 适用人群：C/C++ 开发者、跨平台构建工程师、开源贡献者  
> 学习目标：能独立为中型 C/C++ 项目设计可维护、可扩展、跨平台的 CMake 构建系统

---

## 1. 前置知识 30 min

表格

复制

| 主题        | 速览要点                                                     | 官方链接 |
| :-------- | :------------------------------------------------------- | :--- |
| 编译链四阶段    | 预处理 → 编译 → 汇编 → 链接                                       | —    |
| 静态 vs 共享库 | `.a` / `.lib` 与 `.so` / `.dll` 区别                        | —    |
| 交叉编译概念    | HOST / BUILD / TARGET 三元组                                | —    |
| 命令行基础     | `mkdir build && cd build && cmake .. && cmake --build .` | —    |

---

## 2. 起步 → 第一次构建 1 h

1. 安装 2025 稳定版（≥3.28）
    
    - Windows: `winget install Kitware.CMake`
        
    - macOS: `brew install cmake`
        
    - Linux: `apt install cmake` 或源码编译
        
2. 最小可运行示例
    
    cmake
    
    复制
    
    ```cmake
    cmake_minimum_required(VERSION 3.28)
    project(hello)
    add_executable(hello main.cpp)
    ```
    
3. 常用生成器
    
    - Ninja（最快）: `cmake -G Ninja -B build`
        
    - VS2022: `cmake -G "Visual Studio 17 2022" -A x64 -B build`
        
    - Xcode: `cmake -G Xcode -B build`
        

---

## 3. 核心语法速查 2 h

表格

复制

|指令|典型用法|备注|
|:--|:--|:--|
|`target_*`|`target_link_libraries`, `target_include_directories`, `target_compile_features`|现代 CMake 首选|
|变量与缓存|`set(VAR val CACHE TYPE "doc")`|缓存条目可在 `ccmake` 中改|
|属性|`set_target_properties`, `set_property`|细粒度控制|
|生成器表达式|`$<CONFIG:Debug>, $<PLATFORM_ID:Windows>`|延迟求值，减少 if-else|
|作用域|`function()` 新建作用域，`macro()` 文本展开|理解变量传递|

---

## 4. 现代 CMake 设计范式 3 h

1. **Target-centric**（以目标为中心）
    
    - 所有信息挂在 target 上，禁止全局 `include_directories()` / `add_definitions()`
        
2. **最小化变量**，最大化属性
    
3. **命名参数**封装函数（见下）
    
4. **目录树划分**
    
    复制
    
    ```
    root
    ├─ CMakeLists.txt          # 主配置
    ├─ src/                    # 可执行文件源码
    ├─ lib/                    # 内部库
    ├─ tests/                  # 单元测试
    ├─ cmake/                  # 自用模块 *.cmake
    └─ extern/                 # 第三方依赖（FetchContent）
    ```
    

---

## 5. 函数 & 宏：编写可复用模块 2 h

阅读

并实践“命名参数”模式：

cmake

复制

```cmake
include(CMakeParseArguments)
function(my_add_benchmark)
  cmake_parse_arguments(ARG "" "NAME;TIMEOUT" "SOURCES;LIBS" ${ARGN})
  add_executable(${ARG_NAME} ${ARG_SOURCES})
  target_link_libraries(${ARG_NAME} PRIVATE benchmark::benchmark ${ARG_LIBS})
  add_test(NAME ${ARG_NAME} COMMAND ${ARG_NAME})
  set_tests_properties(${ARG_NAME} PROPERTIES TIMEOUT ${ARG_TIMEOUT})
endfunction()
```

- 把常用功能抽象成 `*.cmake` 模块，放入 `cmake/Modules`
    
- 主 CMakeLists 用 `list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")`
    

---

## 6. 第三方依赖管理 2 h

表格

复制

|方案|适用场景|示例|
|:--|:--|:--|
|FetchContent|源码级，CI 友好|`FetchContent_Declare(googletest GIT_TAG v1.15...)`|
|find_package|系统已安装|`find_package(Boost 1.82 REQUIRED COMPONENTS system)`|
|Conan / vcpkg|二进制缓存、多版本共存|`conan install . --build=missing`|
|submodule + add_subdirectory|离线、定制 fork|—|

> 2025 最佳组合：  
> 开发期用 vcpkg 提供常用二进制；CI 用 FetchContent 保证源码一致性。

---

## 7. 测试、静态分析与打包 3 h

- **GoogleTest 集成**
    
    cmake
    
    复制
    
    ```cmake
    enable_testing()
    add_subdirectory(extern/googletest)
    add_executable(unit_test test_main.cpp)
    target_link_libraries(unit_test GTest::gtest_main)
    gtest_discover_tests(unit_test)
    ```
    
- **CTest 定制**  
    `ctest --test-dir build --output-on-failure --parallel 8`
    
- **静态检查**
    
    - clang-tidy: `set(CMAKE_CXX_CLANG_TIDY clang-tidy)`
        
    - cppcheck: `find_program(CPPCHECK cppcheck)` + `add_custom_target`
        
- **Sanitizer**
    
    cmake
    
    复制
    
    ```cmake
    set(san "-fsanitize=address,undefined -fno-omit-frame-pointer")
    target_compile_options(app PRIVATE $<$<CONFIG:Debug>:${san}>)
    target_link_options(app PRIVATE $<$<CONFIG:Debug>:${san}>)
    ```
    
- **打包**  
    `include(CPack)` → `cpack -G ZIP/TGZ/NSIS`
    

---

## 8. 跨平台技巧 2 h

表格

复制

|平台|典型坑|解决方案|
|:--|:--|:--|
|Windows|缺 DLL、WinMain|`set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)` / `add_executable(... WIN32)`|
|macOS|框架路径、rpath|`set(CMAKE_INSTALL_RPATH "@loader_path")`|
|Linux|多架构、libc 差异|使用 dockcross / appimage|
|嵌入式|交叉文件|`cmake --toolchain arm-none-eabi.cmake`|

---

## 9. 性能加速 1 h

- Ninja + ccache：
    
    bash
    
    复制
    
    ```bash
    export CMAKE_CXX_COMPILER_LAUNCHER=ccache
    cmake -G Ninja -B build
    ```
    
- 统一链接：  
    `set(CMAKE_UNITY_BUILD ON)`（谨慎，可能破坏宏污染代码）
    
- 预编译头：  
    `target_precompile_headers(mylib PRIVATE <vector> <map>)`
    

---

## 10. 进阶阅读 & 社区

- 官方文档 → [https://cmake.org/cmake/help/latest/](https://cmake.org/cmake/help/latest/)
    
- 最佳实践 repo → [https://github.com/cpp-best-practices/cmake_template](https://github.com/cpp-best-practices/cmake_template)
    
- 实时问答 → CMake Discord / StackOverflow `#cmake`
    
- 会议视频 → CppCon “Effective CMake” 系列（Daniel Pfeifer）
    

---

## 🎯 实战里程碑

表格

复制

|里程碑|检验标准|预计耗时|
|:--|:--|:--|
|能写最小项目|单文件可执行 + 多文件库|1 h|
|引入第三方库|使用 FetchContent 引入 fmt 并链接|1 h|
|单元测试通过|用 GTest 编写 5 个用例，CI 绿灯|2 h|
|交叉编译成功|在 x86_64 Linux 上生成 armv7 可执行文件|2 h|
|输出安装包|`cpack` 生成 deb / zip，含正确 rpath|2 h|

完成以上五步，你已具备独立维护中型 C/C++ 项目构建系统的能力！

---

## 📦 一键学习仓库（示例）

[https://github.com/yourname/cmake-study-roadmap](https://github.com/yourname/cmake-study-roadmap)  
包含：

- 01-hello
    
- 02-library
    
- 03-fetchcontent
    
- 04-gtest
    
- 05-sanitizer
    
- 06-cross-toolchain
    
- 07-cpack
    

祝你学习顺利，构建快乐!