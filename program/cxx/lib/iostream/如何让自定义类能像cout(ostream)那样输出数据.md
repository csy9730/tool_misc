# 如何让自定义类能像cout(ostream)那样输出数据

NXGG

于 2019-11-09 19:19:22 发布

1754
 收藏 1
分类专栏： C/C++
版权

C/C++
专栏收录该内容
7 篇文章2 订阅
订阅专栏
相信不少C++程序员初次看到下面的写法时，一定留下了深刻印象：



```cpp
#include<iostream>
using namespace std;

int main() {
cout << "Hello World!" << endl;
}
```

至少，对于当时从C语言转向学习C++的我是深感震惊，如此形象直观的输出方式，简直是黑科技。

那么如何在自定义类上来仿照ostream的这种输出特性呢？

直接上代码：


CMyStream.h:

```cpp
class CMyStream
{
public:
    typedef void (CMyStream::*PFunc)();
    CMyStream& operator<<(PFunc pFunc);
    template<typename T>
    CMyStream& operator<<(T Val)
    {
        std::stringstream ss;
        ss<<Val;
        m_str+=ss.str();
        return *this;
    }

    void MyEndl();
    private:
        std::string m_str;
}

extern CMyStream::PFunc Endl;


```

CMyStream.cpp:

``` cpp
CMyStream::PFunc Endl = &CMyStream::Endl;

CMyStream& operator<<(PFunc pFunc)
{
    (this->*pFunc)();
    return *this;
}

void CMyStream::Endl(void)
{
    std::cout<<m_str<<std::endl;
    m_str = "";
}

```





operator<<的重载不难，关键在于对endl的理解和实现。