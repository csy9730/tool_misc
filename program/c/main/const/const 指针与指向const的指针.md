# [const 指针与指向const的指针](https://www.cnblogs.com/lihuidashen/p/4378884.html)

 

　　最近在复习Ｃ＋＋，指针这块真的是重难点，很久了也没有去理会，今晚好好总结一下const指针，好久没有写过博客了，记录一下

- const 内置变量

- const + 对象

  - const + 成员函数

- const + 指针

  - 类型
    - `int* p`; 指针
    - `const int*p`; 常量指针
    - `int * const p`; 指针常量
    - `const int * const p`; 常量指针常量

- const + 函数

  - const + 函数参数
  - const + 函数返回值
  - const + 函数主体

#### Constant Pointers (指针常量)
**1) Constant Pointers :** These type of pointers are the one which cannot change address they are pointing to. This means that suppose there is a pointer which points to a variable (or stores the address of that variable). Now if we try to point the pointer to some other variable (or try to make the pointer store address of some other variable), then constant pointers are incapable of this.

A constant pointer is declared as : `int *const ptr` ( the location of 'const' make the pointer 'ptr' as constant pointer)

#### Pointer to Constant (常量指针)
**2) Pointer to Constant :** These type of pointers are the one which cannot change the value they are pointing to. This means they cannot change the value of the variable whose address they are holding.

A pointer to a constant is declared as : `const int *ptr` (the location of 'const' makes the pointer 'ptr' as a pointer to constant.

### **const指针的定义：**

　　const指针是指针变量的值一经初始化，就不可以改变指向，初始化是必要的。其定义形式如下：

`type *const 指针名称;`

　　声明指针时，可以在类型前或后使用关键字const，也可在两个位置都使用。例如，下面都是合法的声明，但是含义大不同：

```cpp
const int * pOne;    // 指向整形常量的指针，它指向的值不能修改
int * const pTwo;    // 指向整形的常量指针 ，它不能在指向别的变量，但指向（变量）的值可以修改。 
const int *const pThree;  // 指向整形常量 的常量指针 。它既不能再指向别的常量，指向的值也不能修改。
```



理解这些声明的技巧在于，查看关键字const右边来确定什么被声明为常量 ，如果该关键字的右边是类型，则值是常量；如果关键字的右边是指针变量，则指针本身是常量。下面的代码有助于说明这一点：

```cpp
const int *p1;  //the int pointed to is constant
int * const p2; // p2 is constant, it can't point to anything else
```

 

### **const指针和const成员函数**

可以将关键字用于成员函数。例如：



```cpp
class Rectangle
{
     pubilc:
        .....
        void SetLength(int length){itslength = length;}
        int GetLength() const {return itslength;}  //成员函数声明为常量
        .....
     private:
        int itslength;
        int itswidth;
};
```



当成员函数被声明为const时，如果试图修改对象的数据，编译器将视为错误。

如果声明了一个指向const对象的指针，则通过该指针只能调用const方法（成员函数）。

示例声明三个不同的Rectangle对象：



```cpp
Rectangle* pRect = new Rectangle;

const Rectangle * pConstRect = new Rectangle;     //指向const对象

Rectangle* const pConstPtr = new Rectangle;

// pConstRect是指向const对象的指针，它只能使用声明为const的成员函数，如GetLength（）。
```

## 带有const的指针

当使用带有const的指针时其实有两种意思。一种指的是你不能修改指针本身的内容，另一种指的是你不能修改指针指向的内容。听起来有点混淆一会放个例子上来就明白了。

### 指向const的指针

​      先说指向const的指针，它的意思是指针指向的内容是不能被修改的。它有两种写法。

```cpp
const int* p; （推荐）
int const* p;
```

​      第一种可以理解为，p是一个指针，它指向的内容是const int 类型。p本身不用初始化它可以指向任何标示符，但它指向的内容是不能被改变的。

​      第二种很容易被理解成是p是一个指向int的const指针（指针本身不能被修改），但这样理解是错误的，它也是表示的是指向const的指针（指针指向的内容是不能被修改的），它跟第一种表达的是一个意思。为了避免混淆推荐大家用第一种。

### const指针

再说const指针，它的意思是指针本身的值是不能被修改的。它只有一种写法

```cpp
  int* const p=一个地址;// (因为指针本身的值是不能被修改的所以它必须被初始化）
```



这种形式可以被理解为，p是一个指针，这个指针是指向int 的const指针。它指向的值是可以被改变的如*p=3;

### 指向const的const指针

还有一种情况是这个指针本身和它指向的内容都是不能被改变的，请往下看。

```cpp
const int* const p=一个地址;

int const* const p=一个地址;
```



## 总结

看了上面的内容是不是有点晕，没关系，你不用去背它，用的多了就知道了，还有个技巧，通过上面的观察我们不难总结出一点规律，是什么呢？这个规律就是： 指向const的指针（指针指向的内容不能被修改）const关健字总是出现在*的左边而const指针（指针本身不能被修改）const关健字总是出现在*的右边，那不用说两个const中间加个*肯定是指针本身和它指向的内容都是不能被改变的。有了这个规则是不是就好记多了。



```cpp
#include <iostream>
using namespace std;
int main(int argc, char *argv[])
{
    int a=3;
    int b;
    
    /*定义指向const的指针（指针指向的内容不能被修改）*/ 
    const int* p1; 
    int const* p2; 
    
    /*定义const指针(由于指针本身的值不能改变所以必须得初始化）*/ 
    int* const p3=&a; 
    
    /*指针本身和它指向的内容都是不能被改变的所以也得初始化*/
    const int* const p4=&a;
    int const* const p5=&b; 
    
     p1=p2=&a; //正确
     *p1=*p2=8; //不正确（指针指向的内容不能被修改）
    
     *p3=5; //正确
     p3=p1; //不正确（指针本身的值不能改变） 
    
     p4=p5;//不正确 （指针本身和它指向的内容都是不能被改变） 
     *p4=*p5=4; //不正确（指针本身和它指向的内容都是不能被改变） 
     
    return 0; 
}
```



### **const用法小结：**
const最常用的就是定义常量，除此之外，它还可以修饰函数的参数、返回值和函数的定义体。
#### 1. const修饰函数的参数
如果参数作输出用，不论它是什么数据类型，也不论它采用“指针传递”还是“引用传递”，都不能加const 修饰，否则该参数将失去输出功能。
const 只能修饰输入参数：
如果输入参数采用“指针传递”，那么加const 修饰可以防止意外地改动该指针，起到保护作用。
将“const &”修饰输入参数的用法总结如下：
(1)对于非内部数据类型的输入参数，应该将“值传递”的方式改为“const 引用传递”，目的是提高效率。例如将`void Func(A a) `改为`void Func(const A &a)`。
(2)对于内部数据类型的输入参数，不要将“值传递”的方式改为“const 引用传递”。否则既达不到提高效率的目的，又降低了函数的可理解性。例如`void Func(int x)` 不应该改为`void Func(const int &x)`。

#### 2. const 修饰函数的返回值
如果给以“指针传递”方式的函数返回值加const 修饰，那么函数返回值（即指针）的内容不能被修改，该返回值只能被赋给加const 修饰的同类型指针。例如函数
`const char * GetString(void);`
如下语句将出现编译错误：
`char *str = GetString();`
正确的用法是
`const char *str = GetString();`

如果返回值不是内部数据类型，将函数`A GetA(void) `改写为`const A & GetA(void)`的确能提高效率。但此时千万千万要小心，一定要搞清楚函数究竟是想返回一个对象的“拷贝”还是仅返回“别名”就可以了，否则程序会出错。
函数返回值采用“引用传递”的场合并不多，这种方式一般只出现在类的赋值函数中，目的是为了实现链式表达。
例如：



```cpp
class A
{
	A & operate = (const A &other); // 赋值函数
};
A a, b, c; // a, b, c 为A 的对象
a = b = c; // 正常的链式赋值
(a = b) = c; // 不正常的链式赋值，但合法
```



如果将赋值函数的返回值加const 修饰，那么该返回值的内容不允许被改动。上例中，语句 a = b = c 仍然正确，但是语句 (a = b) = c 则是非法的。

#### 3. const修饰成员函数
关于Const函数的几点规则：
a. const对象只能访问const成员函数,而非const对象可以访问任意的成员函数,包括const成员函数.
b. const对象的成员是不可修改的,然而const对象通过指针维护的对象却是可以修改的.
c. const成员函数不可以修改对象的数据,不管对象是否具有const性质.它在编译时,以是否修改成员数据为依据,进行检查.
d. 然而加上mutable修饰符的数据成员,对于任何情况下通过任何手段都可修改,自然此时的const成员函数是可以修改它的

 

　　版权所有，转载请注明转载地址：<http://www.cnblogs.com/lihuidashen/p/4378884.html>

技术让梦想更伟大



分类: [C/C++](https://www.cnblogs.com/lihuidashen/category/529392.html)