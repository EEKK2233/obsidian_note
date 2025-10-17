## using and typedef
using 模板:`using DWORD = unsigned long`
## lambda
> 定义并创建匿名的函数对象, 简化编程工作
通常与STL算法结合使用, 如制定查找条件, 排序条件.

> 语法如下: \[模板形参\](形参)mutable或exception声明->返回值类型 {函数体}

lambda对象默认不允许修改, 需要加上mutable
```cpp
int thresh = 10;
vector<int> v{0, 1, 3, 5};
auto it = find_if(v.begin(), v.end(), [thresh](int x){
				thresh++;//编译失败, thresh不能修改(虽然是形参);
				return x<thresh;
				});
```

``` cpp
vector<int> int a = 2, b = 1;  
for_each(iv.begin(), iv.end(), [b](int &x) { cout<<(x + b)<<endl;} );
for_each(iv.begin(), iv.end(), [=](int &x) ->int { return x * (a + b);} );
for_each(iv.begin(), iv.end(), [&](int &x) ->int { return x * (a + b);} );
```

[]内的参数指的是 Lambda 表达式可以取得的变量。
()内的参数是每次调用函数时传入的参数。
-> 后加上的是 Lambda 表达式返回值的类型

\[x, &y\]       // x 以传值方式传入，y以引用方式传入。

\[&\]            // 任何被使用到的外部变量皆引用方式传入。

\[=\]            // 任何被使用到的外部变量都是以传值方式传入。

\[&, x\]          // x 显示地以传值方式加以引用。其余变量已引用方式传入。

\[=, &z\]     // z 显示地以引用方式传入。其余变量以传值方式传入。

C++在使用函数对象的地方让编译器临时生成一个
> 该lambda函数对象无类名, 使用*decltype*获取类型, **任意两个lambda类型不同**

## bind
> bind可以视为一个通用的函数适配器, 接受一个可调用对象, 生成一个新的可调用对象来适应原对象的参数列表.
> 通常用于设定默认参数, 调整参数顺序

> 语法: `auto newCallable = bind(callable, arg_list)`

```Cpp
bool check_size(const string &s, string::size_type sz) { return s.size() >= sz; }

//check6 是一个可调用对象，接受一个 string 类型的参数

//并用此 string 和值 6 来调用 check size

auto check6 = bind(check size, _1，6);  // _1 为参数占位符, check6=check_size(s, 6)
```

## function类模板
```Cpp
int add(int i, int j){return i + j};  //函数类型

auto mod=[](int i,int j){return i % j};  //lambda对应一个未命名的函数对象类

struct divide{  //函数对象类
    int operator()(int i,int j){  return i / j;
    }
}
```

```cpp
std::map<std::string, std::function<int(int, int)>> binops;
binops.insert({"%", f2});

//调用
binops["%"](10, 5)//调用lambda函数对象
```

## override and final keyword
> 如果希望函数**不要再被派生类进一步重写**，可以把它标识为 final。可以在基类或任何派生类中使用 final。在派生类中，可以同时使用 override 和 final 标识.override表示当前函数是从上一个对象继承来的.

```cpp
struct Base1 final { };
struct Derived1 : Base1 { };   // 错误格式: class Base1 已标明为 final
struct Base2 {
    virtual void f() final;
};

struct Derived2 : Base2 {
    void f();                 // 错误格式: Base2::f 已标明为 final
};
```

tuple(元组)
> C++的元组（tuple）是由**固定数量**的多个**异构值**组成的**有序**集合。元组中的每一个元素都可以是不同的数据类型。

>语法：`tuple <type_1, type_2, ... , type_n> tuple_name`
>常用操作: . make_tuple()用于为元组赋值。传递的值应该与tuple中声明的值顺序一致。
>		 . get()用于访问和修改元组值，它接受索引和元组名称作为参数来访问特定的元组元素。
>		 . tuple_size()返回元组中存在的元素个数
>		 . swap()交换两个不同元组的元素
>		 . tuple_cat()连接两个元组并返回一个新的元组
>		 . tie()将元组值解包到单独的变量中。
>			 -ignore可带可不带, 忽略特定的元组元素并阻止它被解包.