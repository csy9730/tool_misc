# C++ 11 关键字：thread_local

[买房House](https://www.zhihu.com/people/li-yi-fan-4-46)

分享编程经验



27 人赞同了该文章

thread_local 是 C++ 11 新引入的一种存储类型，它会影响变量的存储周期。

C++ 中有 4 种存储周期：

```text
automatic
static
dynamic
thread
```

有且只有 thread_local 关键字修饰的变量具有线程（thread）周期，这些变量在线程开始的时候被生成，在线程结束的时候被销毁，并且每一个线程都拥有一个独立的变量实例。

thread_local 一般用于需要保证线程安全的函数中。

需要注意的一点是，如果类的成员函数内定义了 thread_local 变量，则对于同一个线程内的该类的多个对象都会共享一个变量实例，并且只会在第一次执行这个成员函数时初始化这个变量实例，这一点是跟类的静态成员变量类似的。

下面用一些测试样例说明：
case 1:

```cpp
class A {
 public:
  A() {}
  ~A() {}

  void test(const std::string &name) {
    thread_local int count = 0;
    ++count;
    std::cout << name << ": " <<  count << std::endl;
  }
};

void func(const std::string &name) {
  A a1;
  a1.test(name);
  a1.test(name);
  A a2;
  a2.test(name);
  a2.test(name);
}

int main(int argc, char* argv[]) {
  std::thread t1(func, "t1");
  t1.join();
  std::thread t2(func, "t2");
  t2.join();
  return 0;
}
```

输出：

```text
t1: 1
t1: 2
t1: 3
t1: 4
t2: 1
t2: 2
t2: 3
t2: 4
```

case 2:

```cpp
class A {
 public:
  A() {}
  ~A() {}

  void test(const std::string &name) {
    static int count = 0;
    ++count;
    std::cout << name << ": " <<  count << std::endl;
  }
};

void func(const std::string &name) {
  A a1;
  a1.test(name);
  a1.test(name);
  A a2;
  a2.test(name);
  a2.test(name);
}

int main(int argc, char* argv[]) {
  std::thread t1(func, "t1");
  t1.join();
  std::thread t2(func, "t2");
  t2.join();
  return 0;
}
```

输出：

```text
t1: 1
t1: 2
t1: 3
t1: 4
t2: 5
t2: 6
t2: 7
t2: 8
```



发布于 2019-08-11 12:11

C++11

线程安全

赞同 27

2 条评论

分享