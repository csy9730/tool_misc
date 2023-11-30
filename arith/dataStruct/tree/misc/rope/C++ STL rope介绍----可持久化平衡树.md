# [C++ STL rope介绍----可持久化平衡树](https://www.cnblogs.com/Mrsrz/p/7170738.html)



**大致介绍：**

rope这个东西，我刚刚知道这玩意，用的不是很多，做个简单的介绍。

官方说明：[我是刘邦](http://www.sgi.com/tech/stl/Rope.html)（我估计你是看不懂的）。

rope就是一个用可持久化平衡树实现的“重型”string（然而它也可以保存int或其他的类型），它不是标准STL里的东西，属于STL扩展。

crope即rope<char>，就是一个“重型”string，且可以用cin/cout直接输入输出。

速度么，我并不知道，应该还可以，不过应该没有手写的快。

比赛的话，我不大清楚，据我所知Cena是不支持的。然而如果你会写可持久化平衡树，还用这个干什么？

**具体操作：**

它的定义在#include<ext/rope>中，需要using namespace __gnu_cxx。

例如：

``` cpp
#include<ext/rope>
using namespace __gnu_cxx;
rope<int> f[10000];
int main(){}
```

如何让它“可持久化”呢？

``` cpp
f[i]= new rope<int>(*f[i-1]);
```

这样做可以用O(1)的时间得到它的历史版本，就做到了可持久化。

rope的基本操作有：
``` cpp
x.length()/x.size() // 返回x的大小

x.push_back(s) // 在末尾添加s
x.insert(pos,s) // 在pos位置插入s

x.erase(pos,x)  // 从pos位置开始删除x个

x.replace(pos,s) // 将位置为pos的元素换成s

x.substr(pos,x) // 从pos位置开始提取x个元素

x.copy(pos,x,s); // 将从pos位置开始x个元素提取到s中

x.at(x),x[x] // 访问第x个元素
```

如果需要翻转平衡树，就维护一正一反两个rope，翻转就把两个rope交换一下就行了。

然而我知道的只有这么点了，如果您觉得有什么不足，可以告诉我。



标签: [STL介绍](https://www.cnblogs.com/Mrsrz/tag/STL介绍/)