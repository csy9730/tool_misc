# 如何快速地学习一门编程语言

学习是从不知道到知道的过程。要想最快地加速这个过程，首先要先清楚知道的结果，例如，首先使用A语言实现a模型，然后对照的学习B语言如何实现a模型，这样就可以最大化的利用自己的A语言的经验，学习B语言，利用自己构造a模型的经验，学习使用B语言构造a模型的要点。

此外，还可以对语言进行进一步的抽象，抽取出常见的实体，通过比较A和B语言，猜测对应实现的原理。

大多数语言都是使用c语言编写的，实现是基于指令集之上，搞清楚了 实现原理，就能理解核心特性和高阶特性。

## lang

常见语言
- c-like
  - c
  - cpp
  - c#
  - java
  - golang
  - php
  - rust
- else
  - javascript/nodejs typescript
  - python
  - lua
  - asm


### 变量

变量包括： 域domain，变量名key， 变量值value，变量类型（type），子类型例如数组长度/指针或地址/可变性。

#### domain
变量一般划分成 global/local。

- global： 全局变量. 函数外定义的变量称为全局变量 
- static: 静态全局变量.
- local： 局部变量。函数内定义的变量称为局部变量


#### type

auto：通过自动推定变量的类型，可以省略类型名，但类型仍然是在编译时确定。

delctype: decltype与auto关键字一样，用于进行编译时类型推导


自定义类型定义 struct/class

反射特性。
##### type convert
类型转换：包括显式类型转换，隐式类型转换。
``` cpp
<static_cast>
const_cast
dynamic_cast
reinterpret_cast

```
#### array

array 一维数组
array of array 高维数组

c/cpp 支持一维数组，支持高维数组（实际上是一维数组）

##### container
容器container

动态数组 go 的slice ，
迭代器： go 的for range
动态字典（key-value-pair-collction）：Map

迭代器 iterator
可以实现访问接口和访问实现分离。

#### 可变

javascript var 变量定义
java final: 可修饰函数，指最终不再可变。
c/cpp const ：常量

enumeration
#### 指针
指针的作用特别强，对许多问题是必须的。同时，偶尔错用指针，会带来意想不到的错误，甚至是灾难性的后果。

- 野指针：使用未初始化的指针（uninitialized pointer）
- 野指针：使用指向被释放的区域的指针
- 内存泄露
- 重复释放指针


正确使用
```CPP
int *p = (int *)malloc(100);
···
free(p);
p = NULL;
```

野指针
``` cpp
char *p = (char *)malloc(100);
...
free(p); //没有置为NULL，成为野指针
p[0] = 'a';// 错误访问
```


#### 指针和引用

- 指针：指针是一个变量，只不过这个变量存储的是一个地址，指向内存的一个存储单元，即指针是一个实体；

- 引用跟原来的变量实质上是同一个东西，只不过是原变量的一个别名而已。

- 指针可以有多级，但是引用只能是一级
- 指针的值可以为空，但是引用的值不能为NULL，并且引用在定义的时候必须初始化；
- 指针的值在初始化后可以改变，即指向其它的存储单元，而引用在进行初始化后就不会再改变了，从一而终。
- ”sizeof引用”得到的是所指向的变量(对象)的大小，而”sizeof指针”得到的是指针本身的大小；

对一般应用而言，把引用理解为指针，不会犯严重语义错误。引用是操作受限了的指针（仅容许取内容操作）。

引用的主要功能是传递函数的参数和返回值。C++语言中，函数的参数和返回值的传递方式有三种：值传递、指针传递和引用传递。
“引用传递”的性质像“指针传递”，而书写方式像“值传递”。实际上“引用”可以做的任何事情“指针”也都能够做
指针能够毫无约束地操作内存中的如何东西，尽管指针功能强大，但是非常危险。
引用可以确保不会垂悬指针。


- c支持指针机制
- c++支持引用和指针机制
- go支持引用和指针机制

##### 值类型和引用
值类型 和 引用类型（指针）。


引用类型一般是 指针实现，使用成本低，但需要即时释放。
值类型，直接复制，使用成本高，管理成本低。
##### 移动
- c++ 支持右值，移动机制
- rust 默认支持移动机制
##### 智能指针
引用计数 

- 弱引用
- 唯一引用
- 强引用


#### struct/class/interface/union


##### struct
struct 是比较原始的结构

- c 提供了该机制


##### class
class 在struct之上添加 成员函数（method）。

类含有成员变量和成员函数，静态成员函数


访问限制符：public/private/protect 
##### 继承
类的继承


语言是否支持 继承？ 
#### 抽象类

通过虚函数表提供了多态机制

- c没有类和抽象类，可以使用函数指针模拟。
- C++ 支持抽象类


###### 多继承
语言是否支持多继承，如何处理菱形继承？

多继承：指一个子类同时继承多个父类，从而具备多个父类的特征
多继承会造成

1、若子类继承的父类中拥有相同的成员变量，子类在引用该变量时将无法判别使用哪个父类的成员变量

2、若一个子类继承的多个父类拥有相同方法，同时子类并未覆盖该方法（若覆盖，则直接使用子类中该方法），那么调用该方法时将无法确定调用哪个父类的方法。

Java为了简单，废弃了C++中非常容易混淆的多继承等特性。

- c++ 支持多继承
- java不支持多继承


##### interface 
interface 相当于轻量级的可继承类，不携带任何成员变量。 

和抽象类一样，接口不能实例化，接口是特殊的抽象类

- java 和 go 支持 interface 
- c和c++ 不支持 interface 


##### method
Rob Pike的话来说就是：
> "A method is a function with an implicit first argument, called a receiver."

c++ 提供了复杂的重载隐藏机制：成员函数 的 overload Override overwrite
- overload 只 多个成员函数同名，函数参数不相同。
- override，指 多个成员函数同名，函数参数和返回值必须相同。
- overwrite，提供了隐藏屏蔽机制。


##### 成员函数


成员函数调用涉及成员函数访问成员变量。

如何实现调用A类的成员函数访问B类的成员变量。
- c语言没有成员函数，只能通过普通函数和指针模拟实现。注意，基于相对偏移来访问变量。
- c++ 中可以通过转制类型转换，实现。要求A类B类是继承关系。注意，如果访问不存在的变量，会导致运行时错误。
- javascript 中，支持任意类函数和实例成员。如果访问不存在的变量，会提供一个默认值underfined。

##### union

和结构类似， 区别在于使复用地址空间。

- c提供了该机制
- c++ 沿用了该机制
- java 不支持



### 函数

#### 函数参数
函数参数是否支持变长参数？
函数参数是否支持缺省参数？

#### 函数返回值
是否支持多重返回值？
c++11的新特性提供tuple机制，模拟多返回值。

c++11的新特性提供了尾值优化

#### 其他
函数是否支持 尾递归？


嵌套函数：函数体内定义函数？ c和c++ 都不支持。
#### 匿名函数


匿名函数. 引入了闭包特性。 

- c不支持
- c++11 支持。
- java支持
- javascript支持
- python 支持


#### 函数式编程 


支持函数作为函数变量传递

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
##### if
``` cpp
// if then else endif
if (a>0){
  return a;
}else{
  return -a;
}
```

##### switch

``` cpp
// switch case default end
switch (a){
  case 0:
    b = 0;
    break;
  case 1:
    b = 0;
    break;
  default:
    break;
}

```


##### 循环结构
1
``` cpp
for (int i=0;i<10;i++)
{
  i;
}
```


``` cpp
while (1){

} 
```
2
``` cpp
do {

}while(1);

```
#### comment
注释机制
### 高阶特性


#### macro

宏 macro


#### Exception

* c++ 使用 try throw catch
* python 是 try except finally 和 raise Exception
* go 使用  panic


#### 内存管理
内置类型如 int/char/str，语言可以实现释放管理，在退出域时释放即可。
平凡对象，如c语言的 不带指针的struct， java 的 POJO ，也可能实现支持。
而对于 可能包含 多层 引用的对象，不能在域退出时释放，可能会导致 NULL Pointer 或 memory leak，语言难以在编译时实现管理，需要通过框架在运行时管理。

``` cpp
void *malloc(unsigned int size);

void *calloc(unsigned int num, unsigned int size);
void *realloc(void *p, unsigned int size);

void free(void *p);

```

##### stack/heap

#### GC
存储空间既有堆，也有栈。对象放在栈上，可以复制，也可以随着退栈而被自动销毁掉。
而以Java为代表的一类语言，默认都是在堆上分配对象，所以需要GC来实现堆上的管理。

GC （gabage collect）垃圾收集机制。
根据语言是否提供主动释放方式，划分出 有 GC 语言 和无 GC 语言。

- non-gc
  - c/cpp
  - rust
- gc
  - java
  - go
  - javascript
  - python

#### 反射
运行时类型识别
- c不支持反射
- java支持反射机制


#### 模板

### 包管理



* 包管理
    * 包命名
    * 包导入
* 包依赖
    * 安装

- c 没有 包管理器
- c++ 没有统一的包管理。
- nodejs 使用 npm 管理包
- python 使用 pip 管理包
- go 使用 go 管理包
- java 没有统一的包管理，可选 mvn/gradle

### import
包导入
* c/c++ 使用 include 和 link机制
* java 使用 import， 例如 `import java.io.*;`
* python 使用 import , 例如 `import os.path as osp`
* javascript 使用 require。
* go 使用 import。`import ("fmt")`
### 低阶特性

#### 上下文

### 编译器/解释器/虚拟机/运行时

编译器/解释器及套件对应的就是环境。

- c语言对应的是对应版本的 gcc/cl 程序
- nodejs 对应的是对应版本的 node 解释器程序
- python语言 对应的是 python解释器程序
- java语言 对应的是javac/java 程序
- go语言 对应的是 go 程序

编译器/解释器的区别：
- 编译器
  - c/cpp
  - java
  - go
  - rust
- 解释器
  - javascript
  - nodejs
  - python

## 系统特性

### io

#### 文件IO
#### 网络IO

### concurrent

#### 多线程

c++ 提供了 thread_local 

#### 多进程


#### coroutine
Go 语言支持并发，goroutine 是轻量级线程，goroutine 的调度是由 Golang 运行时进行管理的。

#### sync
##### stream/buffer

golang的channel，相当于支持 协程中通信的 buffer。只支持 串行输入和输出，相当于 push/pop。

注意：如果通道不带缓冲，**发送方会阻塞**，直到接收方从通道中接收了值。
如果通道带缓冲，**发送方则会阻塞**直到发送的值被拷贝到缓冲区内；如果缓冲区已满，则意味着需要等待直到某个接收方获取到一个值。接收方在有值可以接收之前会一直**阻塞**。
总结，协程特性，支持 读写方轮流阻塞（这里应该理解成 yield？）。