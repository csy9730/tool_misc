# [SWIG 快速入门](https://www.cnblogs.com/fnlingnzb-learner/p/7307265.html)



## SWIG 安装

本文使用了 SWIG 版本 2.0.4（参见 [参考资料](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#resources) 获取下载站点的链接）。要构建和安装 SWIG，可按照典型的开源安装流程，在命令提示符下输入以下命令：

请注意，为前缀提供的路径必须是绝对路径。

`C` 和 `C++` 被公认为（理当如此）创建高性能代码的首选平台。对开发人员的一个常见要求是向脚本语言接口公开 `C/C++` 代码，这正是 Simplified Wrapper and Interface Generator (SWIG) 的用武之地。SWIG 允许您向广泛的脚本语言公开 `C/C++` 代码，包括 Ruby、Perl、Tcl 和 Python。本文使用 Ruby 作为公开 `C/C++` 功能的首选脚本接口。要理解本文，您必须具备 `C/C++` 与 Ruby 方面的相应知识。

SWIG 是一款不错的工具，可适合多种场景，其中包括：

- 向 `C/C++` 代码提供一个脚本接口，使用户更容易使用
- 向您的 Ruby 代码添加扩展或将现有的模块替换为高性能的替代模块
- 提供使用脚本环境对代码执行单元和集成测试的能力
- 使用 TK 开发一个图形用户接口并将它与 `C/C++` 后端集成

此外，与 GNU Debugger 每次都需触发相比，SWIG 要容易调试得多。

## Ruby 环境变量

SWIG 生成包装器 `C/C++` 代码时需要 ruby.h 来保证进行正确的编译。在您的 Ruby 安装中检查 ruby.h：一种建议的做法是将环境变量 RUBY_INCLUDE 指向包含 ruby.h 的文件夹，将 RUBY_LIB 指向包含 Ruby 库的路径。

## 使用 SWIG 编写 Hello World

作为输入，SWIG 需要一个包含 ANSI `C/C++` 声明和 SWIG 指令的文件。我将此输入文件称为*SWIG 接口文件。*一定要记住，SWIG 仅需要足够生成包装器代码的信息。该接口文件通常具有 **.i* 或 **.swg* 扩展名。以下是第一个扩展文件 test.i：

```
%module test
%constant char* Text = "Hello World with SWIG"
```

使用 SWIG 运行此代码：

```
swig –ruby test.i
```

第二个代码段中的命令行在当前文件夹中生成一个名为 *test_wrap.c* 的文件。现在，您需要在此 `C` 文件中创建一个共享库。以下是该命令行：

```
bash$ gcc –fPIC –c test_wrap.c –I$RUBY_INCLUDE
bash$ gcc –shared test_wrap.o –o test_wrap.so –lruby –L$RUBY_LIB
```

就这么简单。您已准备就绪，那就触发交互式 Ruby shell (IRB)，输入 `require 'test_wrap'`来检查 Ruby `Test` 模块和它的内容。以下是扩展的 Ruby 端：

```
irb(main):001:0> require 'test_wrap'
=> true
irb(main):002:0> Test.constants
=> ["Text"]
irb(main):003:0> Test:: Text
=> "Hello World with SWIG"
```

SWIG 可用于生成各种语言扩展，只需运行 `swig –help` 检查所有的可用选项。对于 Ruby，可以输入 `swig –ruby <interface file>`；对于 Perl，可以使用 `swig –perl <interface file>`。

也可以使用 SWIG 生成 `C++` 代码：只需在命令行使用 `–c++` 即可。在前面的示例中，运行 `swig –c++ –ruby test.i` 会在当前文件夹中生成一个名为 *test_wrap.cxx* 的文件。

------

[回页首](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#ibm-pcon)

## SWIG 基础知识

SWIG 接口文件语法是 `C` 的一个超集。SWIG 通过一个定制 `C` 预处理器处理它的输入文件。此外，接口文件中的 SWIG 操作通过一个百分比符号 (`%`) 后跟的特殊的指令（`%module`、`%constant` 等）来控制。SWIG 接口还允许您定义以 `%{` 开头和以 `%}` 结束的信息块。`%{` 和 `%}` 之间的所有内容会原封不动地复制到生成的包装器文件中。

## 模块名称的更多信息

可通过指定 `%module "rubytest::test34::example`，定义一个深度嵌套模块 `rubytest::test34::example`。另一个选项是将 `%module example` 放在接口代码中，在命令行添加 `rubytest::test34` 作为它的前缀，如下所示：

SWIG 接口文件必须以 `%module` 声明开头，例如 `%module *module-name*`，其中 *module-name*是目标语言扩展模块的名称。如果目标语言是 Ruby，这类似于创建一个 Ruby 模块。可以提供命令行选项 `–module *module-name-modified*` 来改写模块名称：在本例中，目标语言模块名称为（或许您已猜到）*module-name-modified*。现在，让我们看看常量。

### 模块初始化功能

SWIG 拥有一个特殊指令 `%init`，用于定义模块初始化功能。`%{ … %}` 代码块中 `%init` 之后定义的代码会在模块加载时调用。以下是代码：

```
%module test
%constant char* Text = “Hello World with SWIG”
%init %{ 
printf(“Initialization etc. gets done here\n”);
%}
```

现在重新启动 IRB。以下是在加载模块后得到的代码：

```
irb(main):001:0> require 'test'
Initialization etc. gets done here 
=> true
```

------

[回页首](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#ibm-pcon)

## SWIG 常量

`C/C++` 常量可在接口文件中以多种方式定义。要验证是否向 Ruby 模块公开了相同的常量，只需在加载共享库时在 IRB 提示符下键入 `<module-name>.constants`。可以以下任何方式定义常量：

- 在一个接口文件中使用 `#define`
- 使用 `enum`
- 使用 `%constant` 指令

请注意，Ruby 常量必需以一个大写字母开头。所以，如果接口文件有诸如 `#define pi 3.1415` 的声明，SWIG 会自动将它更正为 `#define Pi 3.1415` 并在此流程中生成一条警告消息：

```
bash$ swig –c++ –ruby test.i
test.i(3) : Warning 801: Wrong constant name (corrected to 'Pi')
```

下面的示例包含大量常量。作为 `swig –ruby test.i` 运行它：

```
%module test
#define S_Hello "Hello World"
%constant double PI = 3.1415
enum days {Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday};
```

[清单 1](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list1) 显示了 SWIG 的输出。

##### 清单 1. 向 Ruby 公开 C 枚举：哪里出错了？

```
test_wrap.c: In function `Init_test':
test_wrap.c:2147: error: `Sunday' undeclared (first use in this function)
test_wrap.c:2147: error: (Each undeclared identifier is reported only once
test_wrap.c:2147: error: for each function it appears in.)
test_wrap.c:2148: error: `Monday' undeclared (first use in this function)
test_wrap.c:2149: error: `Tuesday' undeclared (first use in this function)
test_wrap.c:2150: error: `Wednesday' undeclared (first use in this function)
test_wrap.c:2151: error: `Thursday' undeclared (first use in this function)
test_wrap.c:2152: error: `Friday' undeclared (first use in this function)
test_wrap.c:2153: error: `Saturday' undeclared (first use in this function)
```

哎哟：发生什么事了？如果打开 test_wrap.c（[清单 2](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list2)），就可以看到问题。

##### 清单 2. 使用 SWIG 生成的枚举代码

```
  rb_define_const(mTest, "Sunday", SWIG_From_int((int)(Sunday)));
  rb_define_const(mTest, "Monday", SWIG_From_int((int)(Monday)));
  rb_define_const(mTest, "Tuesday", SWIG_From_int((int)(Tuesday)));
  rb_define_const(mTest, "Wednesday", SWIG_From_int((int)(Wednesday)));
  rb_define_const(mTest, "Thursday", SWIG_From_int((int)(Thursday)));
  rb_define_const(mTest, "Friday", SWIG_From_int((int)(Friday)));
  rb_define_const(mTest, "Saturday", SWIG_From_int((int)(Saturday)));
```

SWIG 从 Sunday、Monday 等变量中创建 Ruby 常量，但生成的文件中缺少 `day` 原始的 `enum` 声明。解决此问题的最简单方式是将 `enum` 代码放在 `%{ … %}` 信息块内，使生成的文件知道枚举常量，如 [清单 3](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list3) 所示。

##### 清单 3. 以正确的方式向 Ruby 公开 C 枚举

```
%module test
#define S_Hello "Hello World"
%constant double PI = 3.1415
enum days {Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday}; 
%{
enum days {Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday}; 
%}
```

请注意，只有 `enum` 声明不会使枚举常量可用于脚本环境：您同时需要 `%{ … %}` 中的 `C` 代码和接口文件中的 `enum` 声明。

### %inline 特殊指令简介

[清单 3](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list3) 有点奇怪 — 存在没有必要的 `enum` 代码副本。要删除副本，需要使用 `%inline` SWIG 指令。`%inline` 指令将 `%{ … %}` 信息块中的所有代码插入接口文件中，以同时满足 SWIG 预处理器和 `C` 编译器的需求。[清单 4](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list4) 显示了修订的代码，`enum` 现在使用了 `%inline`。

##### 清单 4. 使用 %inline 指令减少代码副本

```
%module test
#define S_Hello "Hello World"
%constant double PI = 3.1415
%inline %{
enum days {Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday}; 
%}
```

### %include 是一种均衡的清除方法

在复杂的企业环境中，可能有一些 `C/C++` 头文件定义了您希望向脚本框架公开的全局变量和常量。在接口文件中使用 `%include <header.h>` 和 `%{ #include <header.h> %}`，可解决在头文件中重复所有元素的声明的问题。[清单 5](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list5) 显示了该代码。

##### 清单 5. 使用 %include 指令

```
%module test
%include "header.h"

%{
#include "header.h"
%}
```

`%include` 指令还适用于 `C/C++` 源文件。当与源文件一起使用时，SWIG 自动会将所有函数声明为 `extern`。

------

[回页首](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#ibm-pcon)

## 常量足够多了：让我们公开一些函数

开始学习 SWIG 的最简单方式是在接口文件中声明某个 `C` 函数，在某个源文件中定义它，在创建共享库时链接相应的目标文件。第一个示例展示了计算一个数的阶乘的函数：

```
%module test
unsigned long factorial(unsigned long);
```

以下是我编译为 factorial.o 并在创建 test.so 时链接的 `C` 代码：

```
unsigned long factorial(unsigned long n) {
   return n == 1 ? 1 : n * factorial(n - 1);
}
```

[清单 6](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list6) 显示了 Ruby 接口。

##### 清单 6. 从 Ruby 测试代码

```
irb(main):001:0> require 'test'
=> true
irb(main):002:0> Test.factorial(11)
=> 39916800
irb(main):003:0> Test.factorial(34)
=> 0
```

Factorial 34 失败了，因为 unsigned 类型的 `long` 没有足够的大小来存放结果。

### Ruby 到 C/C++ 的变量映射

让我们从简单的全局变量开始。请注意，`C/C++` 全局变量对 Ruby 而言不是真正全局的：只能以模块属性的形式访问它们。将以下全局变量添加到一个 `C` 文件中，像链接函数一样链接源文件。SWIG 自动为您生成这些变量的 setter 和 getter 方法。以下是 `C` 代码：

```
int global_int1;
long global_long1;
float global_float1; 
double global_double1;
```

[清单 7](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list7) 显示了相同的接口。

##### 清单 7. 向 Ruby 公开 C 接口

```
%module test
%inline %{
extern int global_int1;
extern long global_long1;
extern float global_float1; 
extern double global_double1; 
%}
```

现在，加载相应的 Ruby 模块以验证添加的 setter 和 getter 方法：

```
irb(main):003:0> Test.methods
[…"global_float1", "global_float1=", "global_int1", "global_int1=", "global_long1", 
   "global_long1=", "global_double1", "global_double1=", …]
```

现在访问变量就非常简单了：

```
irb(main):004:0> Test.global_long1 = 4327911
=> 4327911
irb(main):005:0> puts Test.global_long1
=> 4327911
```

特别有趣的是 Ruby 转换 `int`、`long`、`float` 和 `double` 后的结果。请参见 [清单 8](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list8)。

##### 清单 8. 在 Ruby 和 C/C++ 之间的类型映射

```
irb(main):009:0> Test::global_long1.class
=> Fixnum
irb(main):010:0> Test::global_int1.class
=> Fixnum
irb(main):011:0> Test::global_double1.class
=> Float
irb(main):012:0> Test::global_float1.class
=> Float
```

### 将结构和类从 C++ 映射到 Ruby

向 Ruby 公开结构和类与 `C/C++` 中的传统数据类型完全相同。在接口文件中声明结构和相关的方法。[清单 9](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list9) 声明一个简单的 `Point` 结构和一个函数来计算它们之间的距离。在 Ruby 端，您将一个新 `Point` 创建为 `Test::Point.new`，以 `Test.distance_between` 的形式调用计算距离。`distance_between` 函数在一个独立的 `C++` 源文件中定义，该文件链接到模块共享库。以下是 SWIG 接口代码：

##### 清单 9. 向 Ruby 公开结构和相关接口

```
%module test

%inline %{
typedef struct Point {
  int x;
  int y;
};
extern float distance_between(Point& p1, Point& p2);
%}
```

[清单 10](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list10) 展示了 Ruby 的用法。

##### 清单 10. 从 Ruby 验证 C/C++ 功能

```
irb(main):002:0> a = Test::Point.new
=> #<Test::Point:0x2d04260>
irb(main):003:0> a.x = 10
=> 10
irb(main):004:0> a.y = 20
=> 20
irb(main):005:0> b = Test::Point.new
=> #<Test::Point:0x2cce668>
irb(main):006:0> b.x = 20
=> 20
irb(main):007:0> b.y = 10
=> 10
irb(main):008:0> Test.distance_between(a, b)
=> 14.1421356201172
```

这个使用模型应该很清楚地说明了，为什么 SWIG 是在设置基本代码的单元或集成测试框架时的一个优秀、方便的工具。

### %defaultctor 和其他属性

如果查看一个点的 *x* 和 *y* 坐标的默认值，可以看到它们显示为 0。这不是巧合。SWIG 为您的结构生成了默认的构造函数。可以通过在接口文件中指定 `%nodefaultctor Point;` 来关闭此行为。[清单 11](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list11) 显示了如何做。

##### 清单 11. 没有针对 C++ 结构的默认构造函数

```
%module test
%nodefaultctor Point;
%inline %{
typedef struct Point {
  int x;
  int y;
};
%}
```

现在还需要为 `Point` 结构提供一个显式的构造函数。否则，您将看到以下代码：

```
irb(main):005:0> a = Test::Point.new
TypeError: allocator undefined for Test::Point
        from (irb):5:in `new'
        from (irb):5
```

可通过在接口文件中指定 `%nodefaultctor;`，让每个结构显式定义自己的构造函数。SWIG 也为析构函数中的类似功能定义了 `%nodefaultdtor` 指令。

------

[回页首](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#ibm-pcon)

## C++ 继承和 Ruby 接口

为简单起见，假设接口函数中有两个 `C++` 类 —`Base` 和 `Derived`。SWIG 充分意识到 `Derived`派生自 `Base`。从 Ruby 角度讲，您只需使用 `Derived.new`，就可以放心地期待创建的对象知道它派生自 `Base`。[清单 12](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list12) 展示了 Ruby 测试代码；在 `C++` 或 SWIG 接口端没有特定的操作需要执行。

##### 清单 12. SWIG 接口处理 C++ 继承

```
irb(main):003:0> a = Test::Derived.new
=> #<Test::Derived:0x2d06270>
irb(main):004:0> a.instance_of? Test::Derived
=> true
irb(main):005:0> a.instance_of? Test::Base
=> false
irb(main):006:0> Test::Derived < Test::Base
=> true
irb(main):007:0> Test::Derived > Test::Base
=> false
irb(main):008:0> a.is_a? Test::Derived
=> true
irb(main):009:0> a.is_a? Test::Base
=> true
```

该处理过程没有使用 `C++` 多个继承那么流畅。如果 `Derived` 继承自 `Base1` 和 `Base2`，那么默认的 SWIG 行为只需忽略 `Base2`。以下是您将从 SWIG 获得的消息：

```
Warning 802: Warning for Derived d: base Base2 ignored. 
   Multiple inheritance is not supported in Ruby.
```

坦诚地讲，SWIG 不能出错，因为 Ruby 不支持多个继承。SWIG 要正常工作，您需要在命令行中传递 `–minherit` 选项：

```
bash$ swig -ruby -minherit -c++ test.i
```

一定要了解 SWIG 如何处理多重继承。`C++` 中的派生类对应于 Ruby 中的一个类，这个类既不是派生自 `Base1`，也不是派生自 `Base2`。相反，`Base1` 和 `Base2` 代码重构为模块并包含在 `Derived` 中。这就是 Ruby 术语中所称的 *mixin*。[清单 13](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list13) 展示了所发生事件的伪代码。

##### 清单 13. 使用 Ruby 模拟多个继承

```
class Base1
  module Impl
  # Define Base1 methods here
  end
  include Impl
end

class Base2
  module Impl
  # Define Base2 methods here
  end
  include Impl
end

class Derived
  module Impl
  include Base1::Impl
  include Base2::Impl
  # Define Derived methods here
  end
  include Impl
end
```

让我们验证一下来自 Ruby 接口的声明。`included_modules` 模块为您完成了此任务，如 [清单 14](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#list14) 中所示。

##### 清单 14. Ruby 类中包含的多个模块

```
irb> Test::Derived.included_modules
=> [Test::Derived::Impl, Test::Base::Impl, Test::Base2::Impl, Kernel]

irb> Test::Derived < Test::Base
=> nil

irb> Test::Derived < Test::Base2
=> nil
```

请注意，类层次结构测试失败了（理应如此），但对于应用程序开发人员来说，`Base` 和 `Base2` 的功能仍可通过 `Derived` 类使用。

------

[回页首](http://www.ibm.com/developerworks/cn/aix/library/au-swig/#ibm-pcon)

## 指针和 Ruby 接口

Ruby 没有与指针类似的东西，那么接受或返回指针的 `C/C++` 方法怎么办？这为我们带来了 SWIG 这样的系统的一个最重要的挑战，这一系统的主要任务是在源和目标语言之间转换（或俗称*编组*）数据类型。仔细考虑下面的 `C` 函数：

```
void addition(const int* n1, const int* n2, int* result) { 
  *result = *n1 + *n2;
}
```

为解决这个问题，SWIG 引入了*类型映射* 的概念。您能够灵活地将您想要的 Ruby 类型映射到 `int*`、`float*` 等类型。幸运的是，SWIG 已为您完成了大部分样板工作。以下是您可能需要添加的最简单的接口：

```
%module Test
%include typemaps.i
void addition (int* INPUT, int* INPUT, int* OUTPUT);

%{ extern void addition(int*, int*, int*); %}
```

现在，从 Ruby 试用代码 `Test::addition(1, 2)`。您应该能够看到结果。要更详细地了解此处生的事情，可以查看 lib/ruby 文件夹。SWIG 使用 `int* INPUT` 语法将底层指针转换为对象。将一个类型从 Ruby 映射到 `C/C++` 的 SWIG 语法为：

```
%typemap(in) int* {
  … type conversion code from Ruby to C/C++
}
```

同样地，从 `C/C++` 到 Ruby 的类型转换代码为：

```
%typemap(out) int* {
  … type convesion code from C/C++ to Ruby
}
```

类型映射不只是为指针带来了方便：可将它们用于 Ruby 与 `C/C++` 之间的任何数据类型转换。

 

 

转自：<http://www.360doc.com/content/14/1020/18/6828497_418466026.shtml>



分类: [工具](https://www.cnblogs.com/fnlingnzb-learner/category/876430.html)

标签: [工具](https://www.cnblogs.com/fnlingnzb-learner/tag/工具/)