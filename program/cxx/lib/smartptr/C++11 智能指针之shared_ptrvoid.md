# C++11 智能指针之shared_ptr<void>

[轻口味](https://juejin.cn/user/1134351728250568/posts)

2022-04-042,395阅读5分钟

专栏： 

写个Android开发者的C++课程

一起养成写作习惯！这是我参与「掘金日新计划 · 4 月更文挑战」的第3天，[点击查看活动详情](https://juejin.cn/post/7080800226365145118)。

## 1. 背景

基于Alexa的全链路智能语音SDK基于C++实现了跨平台特性，跑通了Android、Mac、Linux等设备，在兼容iOS时发现iOS未提供音频采集和播放的C++接口，所以需要改造SDK，允许SDK初始化时注入外部的采集器和播放器实现类，同时SDK中的Android播放器是基于ffmpeg解码 + opensl实现，但是考虑到包体积的问题，准备也基于这个接口在外部实现基于Android硬件解码的播放器。

## 2. 实现思路

在SDK内部定义了ExternalMediaPlayerInterface和ExternalMicrophoneInterface两个接口，初始化SDK时传入这两个对象：

```cpp
int create_and_run_home_speech_core_engine(std::string& configFiles, \
                                           std::string& configJsonData, \
                                           std::shared_ptr<HomeSpeech::engine_result_t> engineResult, \
                                           const std::string pathToKWDInputFolder = "",     \
                                           const std::string& logLevel = "",
										   std::shared_ptr<HomeSpeech::ExternalMicrophoneInterface> externalMicWrapper = nullptr,
										   std::function<std::shared_ptr<HomeSpeech::ExternalMediaPlayerInterface>(std::shared_ptr<alexaClientSDK::avsCommon::sdkInterfaces::HTTPContentFetcherInterfaceFactoryInterface> contentFetcherFactory,
																												   bool enableEqualizer,
																												   const std::string& name)> createExternalMediaPlayerCallback = nullptr);
```

由于两个接口依赖SDK内部的AudioInputStream数据结构，所以我们这里面使用了一个回调函数，在SDK内部中调用该方法，SDK外部实现方法来创建具体的播放器。

## 3. Android和iOS接口实现差异问题

本来这样实现已经够了，但是Android的采集和播放要使用同一个opensl对象，而该对象在SDK内部创建好了，复用的话需要SDK内部调用一个方法把opensl对象设置到播放器中，但是这个对象iOS并不需要，怎么办呢？

按照纯C指针的思路，接口定义成设置一个`void *`,C++中是允许裸指针，因此裸指针之间转换方法同C语言指针强转，但是整个工程都是基于C++ 11的智能指针，智能指针怎么转呢？先回顾一下C++ 11智能指针。

### 3.1 std::shared_ptr类型强转std::dynamic_pointer_cast

C++11中引入了智能指针`std::shared_ptr`等，智能指针转换不能通过C方式进行强转，必须通过库提供转换函数进行转换。 C++11的方法是：`std::dynamic_pointer_cast`，如下代码所示：

```cpp
#include <memory>
#include <iostream>

class A {
    public:
   AA(){}
    virtual ~A() {}
};

class B : public A {
    public:
    B(){}
    virtual ~B() {}
};

int main()
{
    // derived class to A class
    B* d1 = new B();
    A* b1 = d1;
    //
    std::shared_ptr<B> d2 = std::make_shared<B>();
    std::shared_ptr<A> b2 = d2;
    /*
     * dynamic cast maybe failed. and return null;
     * 
     */
    B* d11 = dynamic_cast<B*>(b1); //succ
    B* d12 = static_cast<B*>(b1);  //succ
    
    typedef std::shared_ptr<B> d_ptr;
    // std::shared_ptr<B> d21 = dynamic_cast<d_ptr>(b2); //compile error
    std::shared_ptr<B> d22 = std::dynamic_pointer_cast<B>(b2);
    return 0;
}
```

我们看看dynamic_pointer_cast与dynamic_cast的区别

**dynamic_cast**

将一个基类对象指针（或引用）cast到继承类指针，dynamic_cast会根据基类指针是否真正指向继承类指针来做相应处理。

主要用途：将基类的指针或引用安全地转换成派生类的指针或引用，并用派生类的指针或引用调用非虚函数。如果是基类指针或引用调用的是虚函数无需转换就能在运行时调用派生类的虚函数。

转换方式：

- dynamic_cast< type* >(e) type必须是一个类类型且必须是一个有效的指针
- dynamic_cast< type& >(e) type必须是一个类类型且必须是一个左值
- dynamic_cast< type&& >(e) type必须是一个类类型且必须是一个右值

e的类型必须符合以下三个条件中的任何一个：

1. e的类型是目标类型type的公有派生类
2. e的类型是目标type的共有基类
3. e的类型就是目标type的类型。

如果一条dynamic_cast语句的转换目标是指针类型并且转换失败了，会返回一个空指针，则判断条件为0，即为false；如果转换成功，指针为非空，则判断条件为非零，即true。

dynamic_pointer_cast与dynamic_cast用法类似，当指针是智能指针时候，向下转换，用dynamic_Cast 则编译不能通过，此时需要使用dynamic_pointer_cast。

### 3.2 `std::shared_ptr`

类似于`void *`想到了std::shared_ptr，了解了一下还真有。先看看直接使用`void*`有哪些弊端：

1. `void*`不能保证类型安全，可以将一个`void *` 赋给 People*，无论它指向的对象是否实际上是People类的；
2. `void *`不能像智能指针那样管理生命周期，因此必须手动管理关联数据的生命周期，容易导致内存泄漏；
3. 库无法复制`void *`指向的对象，因为它不知道对象的类型

使用`shared_ptr`代替`void*`可以解决声明周期管理的问题。shared_ptr有足够的类型信息以了解如何正确销毁它指向的对象。但是std::shared_ptr和void*一样不能解决类型安全的问题。

最后在使用了`shared_ptr`在SDK内部进行类型强转时报错：

```rust
/Library/android-ndk-r17c/sources/cxx-stl/llvm-libc++/include/memory:4851:16: error: 'void' is not a class
    Tp* __p = dynamic_cast<Tp*>(r.get());
               ^                  ~ (~)~
/xxx/src/main/cpp/AndroidMediaPlayer.cpp:494:19: note: in instantiation of function template specialization 'std::ndk1::dynamic_pointer_cast<alexaClientSDK::applicationUtilities::androidUtilities::AndroidSLESEngine, void>' requested here
  m_engine = std::dynamic_pointer_castalexaClientSDK::applicationUtilities::androidUtilities::AndroidSLESEngine(engine);
                  ^
1 error generated.
```

### 3.3 std::any

又了解了一下找到std::any这么一个类型，但是得c++17才可以使用。

定义在any头文件中：`#include `，是一个可用于任何类型单个值的`类型安全`的容器. std: any是一种值类型，它能够更改其类型，同时仍然具有类型安全性。也就是说，**对象可以保存任意类型的值，但是它们知道当前保存的值是哪种类型。在声明此类型的对象时，不需要指定可能的类型**。可以使用any_cast<该值的类型>获取值。

最后还是在SDK内部实现了AndoridExternalMediaplayerInterface来适配Android平台。

## 4. 总结

本文基于项目实战介绍了C++11智能指针的类型转换std::dynamic_pointer_cast，以及特殊的智能指针std::shared_ptr、C++17提供的std::any类型。