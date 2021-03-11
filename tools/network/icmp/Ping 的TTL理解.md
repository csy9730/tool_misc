# [Ping 的TTL理解](https://www.cnblogs.com/ptqueen/p/8457873.html)

http://www.webkaka.com/tutorial/zhanzhang/2017/061570/

根据自己的扩展重新整理了一下，虽然不是运维，想了解一点东西就希望了解清楚。

### 一.含义

“TTL”是生存时间（Time To Live）的意思

关于时间与跳的讨论，

https://www.zhihu.com/question/61007907

一开始理解为time to leap，wiki上是hop limit

顺便复习了个单词，hop是类似青蛙跳，兔子跳连续的，正符合。

leap是大步跳，并没有连续的意思。

这里把time理解成次数也可以。

首先我们了解一下“TTL”的意思，“TTL”是 Time To Live 的缩写，该字段指定IP包被路由器丢弃之前允许通过的最大网段数量。这样说可能比较抽象。下面我们看一下Ping命令的数据，如图：

![Ping百度服务器](http://www.webkaka.com/tutorial/zhanzhang/upload/2017/6/201706151006397477.gif)

Ping百度服务器

上图，我ping了百度的服务器（windows下默认ping 4次）。

字节代表数据包的大小，时间顾名思义就是返回时间，“TTL”的意思就是数据包的生存时间，当然你得到的这个就是剩余的生存时间。TTL用来计算数据包在路由器的消耗时间，因为现在绝大多数路由器的消耗时间都小于1s，而时间小于1s就当1s计算，所以数据包没经过一个路由器节点TTL都减一。

那么TTL的值一开始是什么呢？不同的操作系统默认下TTL是不同的。默认情况下，Linux系统的TTL值为64或255，Windows NT/2000/XP系统的TTL值为128，Windows 98系统的TTL值为32，UNIX主机的TTL值为255。

上图看到Ping百度服务器返回的数据包的TTL值为56（一般都是找2^n且离返回值最近的那个值），那么途中则经过了64-56=9个路由器。

再比如，我Ping自己的ip，结果如下图：

![Ping本地计算器](http://www.webkaka.com/tutorial/zhanzhang/upload/2017/6/201706151012405473.gif)

Ping本地计算器

可以看到我得到的时候TTL为128，那么途中则经过了128-128=0个路由器，也就是我自己给自己发送数据包不需要经过任何路由器，所以TTL值为128，即是说我的数据包生存时间为128。

### 二.路由器是什么？

通过路由表到达目的地，路由表每一条路由对应两个信息

（目的网络地址，下一跳地址）

详见《计算机网络第七版》4.2.6 

从 Tracert 命令了解

上面提到发送数据包要经过多少个路由器，那么路由器是什么意思？这就不得不说到 Tracert 命令了。

Tracert的写法如下：

tracert [目标]

意思是得到你的主机到目标主机经过路由器的ip。

如图：

 ![tracert百度服务器](http://www.webkaka.com/tutorial/zhanzhang/upload/2017/6/201706151035091468.gif)

tracert百度服务器

在这里我们可以看到达到目标我们经过了9个路由器（不算终点），跟上面Ping百度服务器返回的“TTL”值（56）是相关的，64-56=9。

注意一下有的值为“请求超时” ，原因是有的路由器是禁止Ping的（所以不会返回信息）。

### 三.TTL从哪来的

http://searchnetworking.techtarget.com/definition/time-to-live

An IP TTL is set initially by the system sending the packet. It can be set to any value between 1 and 255; different operating systems set different defaults. 

ttl是发送的时候便携带的，有空用wireshark抓包看看。

也就是说，如果你设置ttl为5，然后hop了5下还没到目标地址，那就扔掉。具体返回什么信息没试

如果设置ttl设置为100，返回跳了9下，到了目的地址，是linux服务器，获得ttl为64,64-9=55，返回ttl 55

### 四.linux和windows的ttl为什么不同

就算目标服务器windows换成linux，路由器hop的路线还是一样的，不明白为什么默认要设置两个不同的地址，让人判断服务器类型。

很想知道历史原因是什么。暂时没搜到，先放着吧。