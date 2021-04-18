# 如何快速地学习一门编程语言

学习是从不知道到知道的过程。要想最快地加速这个过程，首先要先清楚知道的结果，例如，首先使用A语言实现a模型，然后对照的学习B语言如何实现a模型，这样就可以最大化的利用自己的A语言的经验，学习B语言，利用自己构造a模型的经验，学习使用B语言构造a模型的要点。

此外，还可以对语言进行进一步的抽象，抽取出常见的实体，通过比较A和B语言，猜测对应实现的原理。

大多数语言都是使用c语言编写的，实现是基于指令集之上，搞清楚了 实现原理，就能理解核心特性和高阶特性。

## lang
### 变量

变量包括： 域domain，变量名key， 变量值value，变量类型（type），子类型例如数组长度/指针或地址/可变性。


变量定义。
auto：通过自动推定变量的类型，可以省略类型名，但类型仍然是在编译时确定。

global： 全局变量. 函数内定义的变量称为局部变量
local： 局部变量。函数外定义的变量称为全局变量
变量一般划分成 global/local。

var 变量定义
final: 可修饰函数，指最终不再可变。
const ：常量

值类型 和 引用类型。
引用类型一般是 指针实现，使用成本低，但需要即时释放。
值类型，直接复制，使用成本高，管理成本低。

enumeration 

array 数组
array of array 高维数组

动态数组 go 的slice ，
迭代器： go 的for range
动态字典（key-value-pair-collction）：Map

类型转换：包括显式类型转换，隐式类型转换。

自定义类型定义，
反射特性。


#### struct/class/interface/union

struct 是比较原始的结构，class 在struct之上添加 成员函数（method）。

##### struct
类的继承

##### class
是否支持 继承
是否支持多继承，如何处理菱形继承？
public/private/protect

##### method
Rob Pike的话来说就是：
> "A method is a function with an implicit first argument, called a receiver."

成员函数 的 overload Override
overload 只 多个成员函数同名，函数参数不相同。
override，指 多个成员函数同名，函数参数和返回值必须相同。

##### interface 
java 和 go 支持 interface 
c和c++ 不支持 interface 

##### union

#### Exception

* c++ 使用 try throw catch
* python 是 try except finally 和 raise Exception
* go 使用  panic

### 函数

函数参数
函数参数是否支持变长参数？
函数参数是否支持缺省参数？

函数返回值
是否支持多重返回值？


函数是否支持 尾递归？

函数只是支持 作为变量传递？

函数体内定义函数？ c和c++ 都不支持。
匿名函数？ c不支持，c++11 支持。

### lang
包括

- token 
  - 操作符 +-×/
  - 关键字/保留字 
  - 分隔符 space (), [], {}
  - 标志符 （标准库/开发者定义）
  - type , int/char/long/str/class
- 表达式
- 语句
- 注释
- 语句块
- 上下文
- 文件域/包域/模块域/包/名字空间

包导入
* c/c++ 使用 include 和 link机制
* java 使用 import， 例如 `import java.io.*;`
* python 使用 import , 例如 `import os.path as osp`
* javascript 使用 require。
* go 使用 import。`import ("fmt")`


#### 运算符
运算符 包括
- 算术运算符： +-*/ %
- 位运算 & ^ | << >>
- 关系运算符（输出布尔类型） >  < ==
- 逻辑运算（布尔运算） && ||  !
- 赋值运算符 = +=
- 其他运算  & *

#### control

##### 分支结构
if then else endif
switch case default end

##### 循环结构
for loop
while do 

#### comment
#### 上下文

### 高阶特性

#### GC
内置类型如 int/char/str，语言可以实现释放管理，在退出域时释放即可。
平凡对象，如c语言的 不带指针的struct， java 的 POJO ，也可能实现支持。
而对于 可能包含 多层 引用的对象，不能在域退出时释放，可能会导致 NULL Pointer 或 memory leak，语言难以在编译时实现管理，需要通过框架在运行时管理。

GC （gabage collect）垃圾收集机制。
根据语言是否提供主动释放方式，划分出 有 GC 语言 和无 GC 语言。

#### 泛型/模板
c++ 支持模板

#### stream/buffer

golang的channel，相当于支持 协程中通信的 buffer。只支持 串行输入和输出，相当于 push/pop。

注意：如果通道不带缓冲，**发送方会阻塞**，直到接收方从通道中接收了值。
如果通道带缓冲，**发送方则会阻塞**直到发送的值被拷贝到缓冲区内；如果缓冲区已满，则意味着需要等待直到某个接收方获取到一个值。接收方在有值可以接收之前会一直**阻塞**。
总结，协程特性，支持 读写方轮流阻塞（这里应该理解成 yield？）。

#### coroutine
Go 语言支持并发，goroutine 是轻量级线程，goroutine 的调度是由 Golang 运行时进行管理的。


### 编译器/解释器

编译器/解释器及套件对应的就是环境。

c语言对应的是对应版本的 gcc/cl 程序
nodejs 对应的是对应版本的 node 解释器程序
python语言 对应的是 python解释器程序
java语言 对应的是javac/java 程序
go语言 对应的是 go 程序


### 包管理

* 包管理
    * 包命名
    * 包导入
* 包依赖
    * 安装

c 没有 包管理器
c++ 没有统一的包管理。
nodejs 使用 npm 管理包
python 使用 pip 管理包
go 使用 go 管理包
java 没有统一的包管理，可选 mvn/gradle


## 系统特性

### io

#### 文件IO
#### 网络IO

### concurrent

#### 多线程
#### 多进程
#### 携程
