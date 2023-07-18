# [【原创】C++之自定义高效的swap（1）](https://www.cnblogs.com/cposture/p/4939971.html)

## 1 问题背景

  当交换两个包含了指针成员的类，我们最想看到的是直接交换其指针。但是当我们调用std::swap标准库这个模板函数时，通常它都会复制3个指针指向的对象作为交换所用，缺乏效率。如下：



```cpp
namespace std{
    template<typename T>
    void swap(T& a, T& b) //std::swap的典型实现
    {
        T temp(a);    //一次拷贝,两次赋值
        a = b;
        b = temp;
    }
}
```



  上面的代码，5行的调用了类的拷贝构造函数将a拷贝给temp，6、7行调用了拷贝赋值函数交换a、b对象。

  那么我们能不能自定义一个较高效率的属于我们自己类的swap函数呢？

## 2 自定义高效的swap函数

  我们可以为自己写的新类T提供一个高效的swap方法。一般来说，提供swap方法有两种。

## 2.1 swap成员函数

### 2.1.1 方法

（1）在我们写的类T中添加一个swap成员函数，这样方便我们交换类中的私有成员，并且设置swap函数不会抛出异常，为什么？见《C++ Primer 第五版中文版》474页。

```
void T::swap(T& t) noexcept;
```

（2）在类T的同一命名空间里添加一个非成员函数swap，用于调用类中的成员函数swap

``` cpp
void swap(T& a, T& b) noexcept
{
    a.swap(b);
}
```

### 2.1.2 典型实现



```cpp
 #include <iostream>
 #include <string>
 class ClassTest{
 public:
     friend std::ostream& operator<<(std::ostream &os, const ClassTest& s);
     friend void swap(ClassTest &a, ClassTest &b) noexcept;
     ClassTest(std::string s = "abc") :str(new std::string(s)){} //默认构造函数
     ClassTest(const ClassTest &ct) :str(new std::string(*ct.str)){} //拷贝构造函数
     ClassTest &operator=(const ClassTest &ct) //拷贝赋值函数
     {
         str = new std::string(*ct.str);
         return *this;
     }
     ~ClassTest() //析构函数
     {
         delete str;
     }
     void swap(ClassTest &t) noexcept
     {
         using std::swap;
         swap(str,t.str); //交换指针，而不是string数据
     }
 private:
     std::string *str;  //一个指针资源
 };
 std::ostream& operator<<(std::ostream &os,const ClassTest& s)
 {
     os << *s.str;
     return os;
 }
 void swap(ClassTest &a, ClassTest &b) noexcept
 {
     a.swap(b);
 }
 int main(int argc, char const *argv[])
 {
     ClassTest ct1("ct1");
     ClassTest ct2("ct2");
     std::cout << ct1 << std::endl;
     std::cout << ct2 << std::endl;
     swap(ct1, ct2);
     std::cout << ct1 << std::endl;
     std::cout << ct2 << std::endl;
     return 0;
 }
```



注意：

1. （2）中的swap函数需要和类T位于同一的命名空间里，否则外部调用swap函数可能会解析不到
2. swap函数最好使它不要抛出异常，就像移动构造函数和移动赋值函数一样。
3. （2）中的函数可以声明为类T的友元函数，并且设置为内联函数
4. 做真实交换的swap函数，需要使用using std::swap;

### 2.1.2 关于using std::swap

```cpp
void swap(ClassTest &t) noexcept
{
    using std::swap;
    swap(str, t.str); //交换指针，而不是string数据
}
```

  在这里为什么要使用using std::swap呢？也就是using std::swap的作用是什么？

  在C++里存在多种名字查找规则：

1. 普通的名字查找：先在当前的作用域里查找，查找不到再到外层作用域中查找，即局部相同名字的变量或函数会隐藏外层的变量或作用域
2. [实参相关的名字查找（ADL）](https://en.wikipedia.org/wiki/Argument-dependent_name_lookup)[（链接2）](http://en.cppreference.com/w/cpp/language/adl)
3. 涉及函数模板匹配规则：一个调用的候选函数（关于候选函数请参考C++ Primer第五版中关于函数的一章）包括所有模板实参推断成功的函数模板实例；候选的函数模板总是可行的，因为模板实参推断会排除任何不可行的模板；如果恰好有一个函数（或模板）比其他函数更加匹配，则选择该函数；同样好的函数里对于有多个函数模板和只有一个非模板函数，会优先选择非模板函数；同样好的函数里对于没有非模板函数，那么选择更特例化的函数模板
4. 因为C++会优先在当前的作用域里查找，所以使用using std::swap将标准库的swap模板函数名字引入该局部作用域，重载当前作用域的同名函数，隐藏外层作用域的相关声明。为什么using std::swap不会隐藏外层的void swap(ClassTest &a, ClassTest &b) noexcept函数呢？参见：[这里](http://en.cppreference.com/w/cpp/language/adl)。其中说到，当经过普通的名字查找后（没有包括ADL），如果候选函数中有类成员、块作用域中的函数声明（不包括using声明引入的）、其他同名的函数对象或变量名，则不启动ADL查找了。如果没有，则进行ADL查找。因此在经过普通的查找后，发现并没有匹配的函数，最后再经过ADL找到了标准库中的swap和外层作用域的void swap(ClassTest &a, ClassTest &b) noexcept，由于后者较匹配，编译器优先选择后者。
5. 如果str类型有自定义的swap函数，那么第4行代码的swap调用将会调用str类型自定义的swap函数
6. 但是如果str类型并没有特定的swap函数，那么第4行代码的swap调用将会被解析到标准库的std::swap

## 2.2 swap友元函数

### 2.2.1 方法

（1）在T的同一命名空间中定义一非成员的swap函数，并且将函数声明为类T的友元函数，方便访问T的私有成员

``` cpp
void swap(ClassTest &a, ClassTest &b) noexcept
{
    using std::swap;
    //swap交换操作
}
```

### 2.2.2 典型实现



```cpp
 #include <iostream>
 #include <string>
 class ClassTest{
 public:
     friend std::ostream& operator<<(std::ostream &os, const ClassTest& s);
     friend void swap(ClassTest &a, ClassTest &b) noexcept;
     ClassTest(std::string s = "abc") :str(new std::string(s)){} //默认构造函数
     ClassTest(const ClassTest &ct) :str(new std::string(*ct.str)){} //拷贝构造函数
     ClassTest &operator=(const ClassTest &ct) //拷贝赋值函数
     {
         str = new std::string(*ct.str);
         return *this;
     }
     ~ClassTest() //析构函数
     {
         delete str;
     }
 private:
     std::string *str;  //一个指针资源
 };
 std::ostream& operator<<(std::ostream &os, const ClassTest& s)
 {
     os << *s.str;
     return os;
 }
 void swap(ClassTest &a, ClassTest &b) noexcept
 {
     using std::swap;
     swap(a.str,b.str); //交换指针，而不是string数据
 }
 int main(int argc, char const *argv[])
 {
     ClassTest ct1("ct1");
     ClassTest ct2("ct2");
     std::cout << ct1 << std::endl;
     std::cout << ct2 << std::endl;
     swap(ct1, ct2);
     std::cout << ct1 << std::endl;
     std::cout << ct2 << std::endl;
     return 0;
 }
```



注意：

1. （2）中的swap函数需要和类T位于同一的命名空间里，否则外部调用swap函数可能会解析不到
2. swap函数最好使它不要抛出异常，就像移动构造函数和移动赋值函数一样


本文链接：[【原创】C++之swap（1） ](http://www.cnblogs.com/cposture/p/4939971.html)http://www.cnblogs.com/cposture/p/4939971.html

分类: [C++](https://www.cnblogs.com/cposture/category/750501.html)