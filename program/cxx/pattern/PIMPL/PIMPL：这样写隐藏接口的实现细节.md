# PIMPL：这样写隐藏接口的实现细节

[![守望](https://pic4.zhimg.com/v2-89f8f7ba849108889de4a633becdd172_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/huyanbing)

[守望](https://www.zhihu.com/people/huyanbing)





10 人赞同了该文章



## **前言**

有时候我们需要提供对外的API，通常会以头文件的形式提供。举个简单的例子：

提供一个从某个指定数开始打印的接口，头文件内容如下：

```cpp
//来源：公众号编程珠玑
//作者：守望先生
#ifndef _TEST_API_H
#define _TEST_API_H
//test_api.h
class TestApi{
  public:
    TestApi(int s):start(s){}
    void TestPrint(int num);
  private:
    int start_ = 0;
};
#endif //_TEST_API_H
```

实现文件如下：

```cpp
//来源：公众号编程珠玑
//作者：守望先生
#include "test_api.h"
#include <iostream>
//test_api.cc
TestApi::TestPrint(int num){
  for(int i = start_; i < num; i++){
    std::cout<< i <<std::endl;
  }
}
```

类TestApi中有一个私有变量start_，头文件中是可以看到的。

```cpp
#include "test_api.h"
int main(){
  TestApi test_api{10};
  test_api.TestPrint(15);
  return 0;
}
```

## **常规实现缺点**

从前面的内容来看， 一切都还正常，但是有什么问题呢？

- 头文件暴露了私有成员
- 实现与接口耦合
- 编译耦合

第一点可以很明显的看出来，其中的私有变量star_能否在头文件中看到，如果实现越来越复杂，这里可能也会出现更多的私有变量。有人可能会问，私有变量外部也不能访问，暴露又何妨？不过你只是提供几个接口，给别人看到这么多信息干啥呢？这样就会导致实现和接口耦合在了一起。另外一方面，如果有另外一个库使用了这个库，而你的这个库实现变了，头文件就会变，而头文件一旦变动，就需要所有使用了这个库的程序都要重新编译！这个代价是巨大的。所以，我们应该尽可能地保证头文件不变动，或者说，尽可能隐藏实现，隐藏私有变量。

## **PIMPL**

Pointer to implementation，由指针指向实现，而不过多暴露细节。废话不多说，上代码：

```cpp
//来源：公众号编程珠玑
//作者：守望先生
#ifndef _TEST_API_H
#define _TEST_API_H
#include <memory>
//test_api.h
class TestApi{
  public:
    TestApi(int s);
    ~TestApi();
    void TestPrint(int num);
  private:
    class TestImpl;
    std::unique_ptr<TestImpl> test_impl_;
};
#endif //_TEST_API_H
```

从这个头文件中，我们可以看到：

- 实现都在TestImpl中，因为只有一个私有的TestImpl变量，可以预见到，实现变化时，这个头文件是基本不需要动的
- test_impl_是一个unique_ptr，因为我们使用的是现代C++，这里需要注意的一点是，它的构造函数和析构函数必须存在，否则会有编译问题。

我们再来看下具体的实现：

```cpp
//来源：公众号编程珠玑
//作者：守望先生
#include "test_api.h"
#include <iostream>
//test_api.cc
class TestApi::TestImpl{
  public:
    void TestPrint(int num);
    TestImpl(int s):start_(s){}
    TestImpl() = default;
    ~TestImpl() = default;
  private:
    int start_;
};

void TestApi::TestImpl::TestPrint(int num){
  for(int i = start_; i < num; i++){
    std::cout<< i <<std::endl;
  }
}

TestApi::TestApi(int s){
    test_impl_.reset(new TestImpl(s));
}

void TestApi::TestPrint(int num){
  test_impl_->TestPrint(num);
}
//注意，析构函数需要
TestApi::~TestApi() = default;
```

从实现中看到，TestApi中的TestPrint调用了TestImpl中的TestPrint实现，而所有的具体实现细节和私有变量都在TestImpl中，即便实现变更了，其他库不需要重新编译，而仅仅是在生成可执行文件时重新链接。

## **总结**

从例子中，我们可以看到PIMPL模式中有以下优点：

- 降低耦合，头文件稳定，类具体实现改变不影响其他模块的编译，只影响可执行程序的链接
- 接口和实现分离，提高稳定性

当然了，由于实现在另外一个类中，所以会多一次调用，会有性能的损耗，但是这点几乎可以忽略。



[为何优先选用unique_ptr而不是裸指针？](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2OTA3NTk3Ng%3D%3D%26mid%3D2649285268%26idx%3D1%26sn%3D1832bbcf0f1c6a363efb31695d88da63%26chksm%3Df2f991f3c58e18e5b002f48a99eb6b3d395507f889534661cd5a20478ddaeeb93690fe5bad5a%26scene%3D21%23wechat_redirect)

[认真理一理C++的构造函数](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2OTA3NTk3Ng%3D%3D%26mid%3D2649284869%26idx%3D1%26sn%3D3b30d611fa06331d33d54cf8b8dec62f%26chksm%3Df2f99262c58e1b74975efadbda8e72b0b13ef89ab8eb3d00c69e17467d672a59511fe822dd72%26scene%3D21%23wechat_redirect)

[这才是现代C++单例模式简单又安全的实现](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI2OTA3NTk3Ng%3D%3D%26mid%3D2649286074%26idx%3D1%26sn%3D97b75de630161500bddb574f92e27aa6%26chksm%3Df2f996ddc58e1fcbf4c305e15d3dd2a0bfa18916df74752684e49fa284c87d1dee3858cbf886%26scene%3D21%23wechat_redirect)



关注【编程珠玑】，获取更多Linux/C/C++/数据结构与算法/计算机基础/工具等原创技术文章。后台免费获取经典电子书和视频资源

发布于 2020-10-11 15:21

C++

C / C++

编程