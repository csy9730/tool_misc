# C++中指针与引用的区别

[算法集市](https://www.zhihu.com/people/zhimakaimencsd)

算法工程师



25 人赞同了该文章

初学C++时，很容易把指针和引用的用法混在一起，下面通过一些示例来说明指针和引用两者之间的差别。

## 1、两者的定义和性质不同

指针是一个变量，存储的是一个地址，指向内存的一个存储单元；

引用是原变量的一个别名，跟原来的变量实质上是同一个东西。

```cpp
int a = 996;
int *p = &a; // p是指针, &在此是求地址运算
int &r = a; // r是引用, &在此起标识作用
```

上面定义了一个整型变量 a，p 是一个指针变量，p 的值是变量 a 的地址；

而引用 r，是 a 的一个别名，在内存中 r 和 a 占有同一个存储单元。

![img](https://pic2.zhimg.com/80/v2-ffa5582dfe8d6d1116c55c7b8db47a21_720w.jpg)

## 2、指针可以有多级，引用只能是一级

```cpp
int **p; // 合法
int &&a; // 不合法
```

## 3、指针可以在定义的时候不初始化，引用必须在定义的时候初始化

```cpp
int *p; // 合法
int &r; // 不合法
int a = 996;
int &r = a; // 合法
```

## 4、指针可以指向NULL，引用不可以为NULL

```cpp
int *p = NULL; // 合法
int &r = NULL; // 不合法
```

## 5、指针初始化之后可以再改变，引用不可以

```cpp
int a = 996;
int *p = &a; // 初始化, p 是 a 的地址
int &r = a; // 初始化, r 是 a 的引用

int b = 885;
p = &b;	// 合法, p 更改为 b 的地址
r = b; 	// 不合法, r 不可以再变
```

## 6、sizeof 的运算结果不同

```cpp
int a = 996;
int *p = &a;
int &r = a;

cout << sizeof(p); // 返回 int* 类型的大小
cout << sizeof(r); // 返回 int 类型的大小
```

在64位机器上，int* 类型的大小为8个字节，int类型的大小为4个字节。

> sizeof 是C/C++ 中的一个操作符（operator），其作用就是返回一个对象或者类型所占的内存字节数。
> The sizeof keyword gives the amount of storage, in bytes, associated with a variable or a type(including aggregate types). This keyword returns a value of type size_t.

## 7、自增运算意义不同

如下图所示，p++之后指向a后面的内存，r++相当于a++。

```cpp
int a = 996;
int *p = &a;
int &r = a;

p++;
r++;
```

![img](https://pic2.zhimg.com/80/v2-f0b7762e624b96e7beb3ba8ea513cbc9_720w.jpg)

## 8、指针和引用作为函数参数时，指针需要检查是否为空，引用不需要

```cpp
void fun_p(int *p)
{
    // 需要检查P是否为空
    if (p == NULL) 
    {
        // do something
    }
}

void fun_r(int &r)
{
    // 不需要检查r
    // do something
}
```

PS：指针和引用都可以作为函数参数，改变实参的值。



编辑于 2020-05-15

C++

指针（C / C++）

C++引用

赞同 25