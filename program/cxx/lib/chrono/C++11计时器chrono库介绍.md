# [C++11计时器:chrono库介绍](https://www.cnblogs.com/-citywall123/p/12623266.html)

C++11有了chrono库，可以在不同系统中很容易的实现定时功能。

 

要使用chrono库，需要#include<chrono>，其所有实现均在std::chrono namespace下。注意标准库里面的每个命名空间代表了一个独立的概念。

chrono是一个模版库，使用简单，功能强大，只需要理解三个概念：duration、time_point、clock

##  一 、时钟-CLOCK

**`chrono库定义了三种不同的时钟:`**

```
 std::chrono::system_clock:  依据系统的当前时间 (不稳定)
 std::chrono::steady_clock:  以统一的速率运行(不能被调整)
 std::chrono::high_resolution_clock: 提供最高精度的计时周期(可能是steady_clock或者system_clock的typedef)
```

**这三个时钟有什么区别呢？**

system_clock就类似Windows系统右下角那个时钟，是系统时间。明显那个时钟是可以乱设置的。明明是早上10点，却可以设置成下午3点。

steady_clock则针对system_clock可以随意设置这个缺陷而提出来的，他表示时钟是不能设置的。

high_resolution_clock则是一个高分辨率时钟。

 

这三个时钟类都提供了一个静态成员函数now()用于获取当前时间，该函数的返回值是一个time_point类型，


system_clock除了now()函数外，还提供了to_time_t()静态成员函数。用于将系统时间转换成熟悉的std::time_t类型，

 

得到了time_t类型的值，在使用ctime()函数将时间转换成字符串格式，就可以很方便地打印当前时间了。



```
#include<iostream>
#include<vector>
#include<string>
#include<ctime>//将时间格式的数据转换成字符串
#include<chrono>
using namespace std::chrono;
using namespace std;
int main()
{
    //获取系统的当前时间
    auto t = system_clock::now();
    //将获取的时间转换成time_t类型
    auto tNow = system_clock::to_time_t(t);

    //ctime()函数将time_t类型的时间转化成字符串格式,这个字符串自带换行符
    string str_time = std::ctime(&tNow);

    cout<<str_time;

    return 0;
}
```



 

 

```
时间精度其实也就是时间分辨率。抛开时间量纲单论分辨率，其实就是一个比率。如：1000/1、10/1、1/1 、1/10、1/1000。

这些比率加上距离量纲就变成距离分辨率，加上时间量纲就变成时间分辨率了。为此，C++11定义了一个新的模板类ratio，用于表示比率，定义如下：
```

 

**std::ratio<**intmax_t **N,** intmax_t **D** **>`表示时钟周期，是用秒表示的时间单位,`**

**`ratio是一个分数类型的值,其中N表示分子(秒),D表示分母(周期)`**

**常用的时间单位已经定义好了**

 

ratio<3600, 1>        hours       (3600秒为一个周期,表示一小时)

ratio<60, 1>          minutes

ratio<1, 1>           seconds

ratio<1, 1000>        millisecond

ratio<1, 1000000>     microseconds

ratio<1, 1000000000>  nanosecons

 

 

注意，我们自己可以定义Period，比如ratio<1, -2> r, 一个 r 表示单位时间是-0.5秒。

 

```

```

##  二、持续的时间 - duration

std::chrono::duration<int,ratio<60,1>> ,表示持续的一段时间,这段时间的单位是由ratio<60,1>决定的,int表示这段时间的值的类型,函数返回的类型还是一个时间段duration

std::chrono::duration<double,ratio<60,1>> 

 

由于各种时间段(duration)表示不同，chrono库提供了duration_cast类型转换函数。

duration_cast用于将duration进行转换成另一个类型的duration。

duration还有一个成员函数count(),用来表示这一段时间的长度



```
#include<iostream>
#include<string.h>
#include<chrono>
using namespace std::chrono;
using namespace std;
int main()
{
    auto start = steady_clock::now();
    for(int i=0;i<100;i++)
        cout<<"nice"<<endl;
    auto end = steady_clock::now();

    auto tt = duration_cast<microseconds>(end - start);

    cout<<"程序用时="<<tt.count()<<"微秒"<<endl;
    return 0;
}
```



 

##  三、时间点 - time_point

 

std::chrono::time_point 表示一个具体时间，如上个世纪80年代、你的生日、今天下午、火车出发时间等，只要它能用计算机时钟表示。鉴于我们使用时间的情景不同，这个time point具体到什么程度，由选用的单位决定。一个time point必须有一个clock计时

 

设置一个时间点:

time_point<clock类型> 时间点名字

```
//设置一个高精度时间点
    time_point<high_resolution_clock> high_resolution_clock::now();
```

 

 

 

 参考博客：https://blog.csdn.net/luotuo44/article/details/46854229

 

 

 

 

```


```

等风起的那一天，我已准备好一切

分类: [C++数据结构](https://www.cnblogs.com/-citywall123/category/1686729.html)