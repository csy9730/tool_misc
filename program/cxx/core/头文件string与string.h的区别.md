## [头文件string与string.h的区别](https://www.cnblogs.com/Cmpl/archive/2012/01/01/2309710.html)

在C++中，#include<iostream>与#include<iostream.h>的区别，前者要使用更新的编译器（其实大部分编译器多比较前卫了，出了有些搞嵌入式的用变态的编译器）。

喔，原来iostream是C++的头文件，iostream.h是C的头文件，即标准的C++头文件没有.h扩展名，将以前的C的头文件转化为C++的头文件后，有时加上c的前缀表示来自于c，例如cmath就是由math.h变来的。

``` cpp
using namespace std //使用名字空间（使用所有）
using namespace std::cout//只使用cout
```

如不用using，则在代码前可以用sdt::cout<<表示使用的是std中的cout。

``` cpp
#include<iostream.h>//必须要加上.h
void main()
{
cout<<"Right?"<<endl;
}

#include<string>
#include<iostream>//此处必须去掉.h
usingnamespace std ;
void main()
{
string s;
getline(cin,s);
cout<<"Right?"<<endl;
}    
```


相关解析：

iostream.h里面定义的所有类以及对象都是在全局空间里，所以你可以直接用cout   
但在iostream里面，它所定义的东西都在名字空间std里面，所以你必须加上   
using namespace std才能使用cout

一般一个C++的老的带“.h”扩展名的库文件，比如iostream.h，在新标准后的标准库中都有一个不带“.h”扩展名的相对应，区别除了后者的好多改进之外，还有一点就是后者的东东都塞进了“std”名字空间中。

但唯独string特别。
问题在于C++要兼容C的标准库，而C的标准库里碰巧也已经有一个名字叫做“string.h”的头文件，包含一些常用的C字符串处理函数，比如楼主提到的strcmp。
这个头文件跟C++的string类半点关系也没有，所以<string>并非<string.h>的“升级版本”，他们是毫无关系的两个头文件。
要达到楼主的目的，比如同时：
``` cpp
#include <string.h>
#include <string>
usingnamespace std;
```
或者
``` cpp
#include <cstring>
#include <string>
```
其中<cstring>是与C标准库的<string.h>相对应，但裹有std名字空间的版本。

最大的挑战是把字符串头文件理清
楚：<string.h>是旧的C 头文件，对应的是基于char*的字符串处理函数；<string>
是包装了std 的C++头文件，对应的是新的string 类（看下文）；<cstring>是对
应于旧C 头文件的std 版本。如果能掌握这些（我相信你能），其余的也就容易
了。

 

<string>是c++ 的头文件，其内包含了一个string类，string s1就是建立一个string类的对象 

<string.h> 的c语言的东西 并无类，所以不能 string s1 

<cstring>文件实际上只是在一个命名空间std中include了 <string.h>，…



分类: [C++](https://www.cnblogs.com/Cmpl/category/320313.html)