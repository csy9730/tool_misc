[杭州.Mark](https://www.cnblogs.com/hzmark/)

- [博客园](https://www.cnblogs.com/)
- [首页](https://www.cnblogs.com/hzmark/)
- 
- [联系](https://msg.cnblogs.com/send/%E6%9D%AD%E5%B7%9E.Mark)
- [订阅](javascript:void(0))
- [管理](https://i.cnblogs.com/)

随笔 - 79  文章 - 2  评论 - 249  阅读 - 48万

# [Push or Pull?](https://www.cnblogs.com/hzmark/p/mq_push_pull.html)



采用Pull模型还是Push模型是很多中间件都会面临的一个问题。消息中间件、配置管理中心等都会需要考虑Client和Server之间的交互采用哪种模型：

- 服务端主动推送数据给客户端？
- 客户端主动从服务端拉取数据？

本篇文章对比Pull和Push，结合消息中间件的场景进一步探讨有没有其他更合适的模型。

### Push VS Pull

**1. Push**

Push即服务端主动发送数据给客户端。在服务端收到消息之后立即推送给客户端。

Push模型最大的好处就是实时性。因为服务端可以做到只要有消息就立即推送，所以消息的消费没有“额外”的延迟。

但是Push模式在消息中间件的场景中会面临以下一些问题：

- 在Broker端需要维护Consumer的状态，不利于Broker去支持大量的Consumer的场景
- Consumer的消费速度是不一致的，由Broker进行推送难以处理不同的Consumer的状况
- Broker难以处理Consumer无法消费消息的情况（Broker无法确定Consumer的故障是短暂的还是永久的）
- 大量的推送消息会加重Consumer的负载或者冲垮Consumer

Pull模式可以很好的应对以上的这些场景。

**2.Pull**

Pull模式由Consumer主动从Broker获取消息。

这样带来了一些好处：

- Broker不再需要维护Consumer的状态（每一次pull都包含了其实偏移量等必要的信息）
- 状态维护在Consumer，所以Consumer可以很容易的根据自身的负载等状态来决定从Broker获取消息的频率

> Pull模式还有一个好处是可以聚合消息。
>
> 因为Broker无法预测写一条消息产生的时间，所以在收到消息之后只能立即推送给Consumer，所以无法对消息聚合后再推送给Consumer。 而Pull模式由Consumer主动来获取消息，每一次Pull时都尽可能多的获取已近在Broker上的消息。

但是，和Push模式正好相反，Pull就面临了实时性的问题。

因为由Consumer主动来Pull消息，所以实时性和Pull的周期相关，这里就产生了“额外”延迟。如果为了降低延迟来提升Pull的执行频率，可能在没有消息的时候产生大量的Pull请求（消息中间件是完全解耦的，Broker和Consumer无法预测下一条消息在什么时候产生）；如果频率低了，那延迟自然就大了。

另外，Pull模式状态维护在Consumer，所以多个Consumer之间需要相互协调，这里就需要引入ZK或者自己实现NameServer之类的服务来完成Consumer之间的协调。

有没有一种方式，能结合Push和Pull的优势，同时变各自的缺陷呢？答案是肯定的。

### Long-Polling

使用long-polling模式，Consumer主动发起请求到Broker，正常情况下Broker响应消息给Consumer；在没有消息或者其他一些特殊场景下，可以将请求阻塞在服务端延迟返回。

long-polling不是一种Push模式，而是Pull的一个变种。

那么：

- 在Broker一直有可读消息的情况下，long-polling就等价于执行间隔为0的pull模式（每次收到Pull结果就发起下一次Pull请求）。
- 在Broker没有可读消息的情况下，请求阻塞在了Broker，在产生下一条消息或者请求“超时之前”响应请求给Consumer。

以上两点避免了多余的Pull请求，同时也解决Pull请求的执行频率导致的“额外”的延迟。

注意上面有一个概念：“超时之前”。每一个请求都有超时时间，Pull请求也是。“超时之前”的含义是在Consumer的“Pull”请求超时之前。

基于long-polling的模型，Broker需要保证在请求超时之前返回一个结果给Consumer，无论这个结果是读取到了消息或者没有可读消息。

因为Consumer和Broker之间的时间是有偏差的，且请求从Consumer发送到Broker也是需要时间的，所以如果一个请求的超时时间是5秒，而这个请求在Broker端阻塞了5秒才返回，那么Consumer在收到Broker响应之前就会判定请求超时。所以Broker需要保证在Consumer判定请求超时之前返回一个结果。

通常的做法时在Broker端可以阻塞请求的时间总是小于long-polling请求的超时时间。比如long-polling请求的超时时间为30秒，那么Broker在收到请求后最迟在25s之后一定会返回一个结果。中间5s的差值来应对Broker和Consumer的始终存在偏差和网络存在延迟的情况。 （可见Long-Polling模式的前提是Broker和Consumer之间的时间偏差没有“很大”）

**Long-Polling还存在什么问题吗，还能改进吗？**

### Dynamic Push/Pull

“在Broker一直有可读消息的情况下，long-polling就等价于执行间隔为0的pull模式（每次收到Pull结果就发起下一次Pull请求）。”

这是上面long-polling在服务端一直有可消费消息的处理情况。在这个情况下，一条消息如果在long-polling请求返回时到达服务端，那么它被Consumer消费到的延迟是：

```powershell
假设Broker和Consumer之间的一次网络开销时间为R毫秒，
那么这条消息需要经历3R才能到达Consumer

第一个R：消息已经到达Broker，但是long-polling请求已经读完数据准备返回Consumer，从Broker到Consumer消耗了R
第二个R：Consumer收到了Broker的响应，发起下一次long-polling，这个请求到达Broker需要一个R
的时间
第三个R：Broker收到请求读取了这条数据，那么返回到Consumer需要一个R的时间

所以总共需要3R（不考虑读取的开销，只考虑网络开销）
```

另外，在这种情况下Broker和Consumer之间一直在进行请求和响应（long-polling变成了间隔为0的pull）。

![img](https://mmbiz.qpic.cn/mmbiz_png/G6xepZmzIMdbdkI92K0hmiaaBFXumG5VwITDeia9xZwlPFUIDdPNK8BBz3RQbAibedy9Y0ialynmiaiasxJyyURyENOg/0?wx_fmt=png)

考虑这样一种方式，**它有long-polling的优势，同时能减少在有消息可读的情况下由Broker主动push消息给Consumer，减少不必要的请求。**

**消息中间件的Consumer实现**

在消息中间件的Consumer中会有一个Buffer来缓存从Broker获取的消息，而用户的消费线程从这个Buffer中获取消费来消息，获取消息的线程和消费线程通过这个Buffer进行数据传递。

![img](https://mmbiz.qpic.cn/mmbiz_png/G6xepZmzIMdbdkI92K0hmiaaBFXumG5Vwz6JSrcTxIyvGvDzvdORqWrdvicG9OibeIWvUuFU8K7M93YbCoqpc28uw/0?wx_fmt=png)

- pull线程从服务端获取数据，然后写入到Buffer
- consume线程从Buffer获取消息进行消费

有这个Buffer的存在，是否可以在long-polling请求时将Buffer剩余空间告知给Broker，由Broker负责推送数据。此时Broker知道最多可以推送多少条数据，那么就可以控制推送行为，不至于冲垮Consumer。

![img](https://mmbiz.qpic.cn/mmbiz_png/G6xepZmzIMdbdkI92K0hmiaaBFXumG5VwmIu1FcR2qXs4RjTapeWuBQwf3SHjXTldZzkwzAw4AjgqPWDd4MoByg/0?wx_fmt=png)

上面这幅图是akka的Dynamic Push/Pull示意图，思路就是每次请求会带上本地当前可以接收的数据的容量，这样在一段时间内可以由Server端主动推送消息给请求方，避免过多的请求。

akka的Dynamic Push/Pull模型非常适合应用到Consumer获取消息的场景。

Broker端对Dynamic Push/Pull的处理流程大致如下：

```cpp
收到long-polling请求
while(有数据可以消费&请求没超时&Buffer还有容量) {
    读取一批消息
    Push到Consumer
    Buffer-PushedAmount 即减少Buffer容量
}

response long-polling请求
结束（等待下一个long-polling再次开始这个流程）
```

Consumer端对Dynamic Push/Pull的处理流程大致如下：

```cpp
收到Broker的响应：

if (long-polling的response) {
    将获取的消息写入Buffer
    获取Buffer的剩余容量和其他状态
    发起新的long-polling请求
} else {
    // Dynamic Push/Pull的推送结果
    将获取的消息写入到Buffer（不发起新的请求）
}
```

举个例子：

Consumer发起请求时Buffer剩余容量为100，Broker每次最多返回32条消息，那么Consumer的这次long-polling请求Broker将在执行3次push(共push96条消息)之后返回response给Consumer（response包含4条消息）。

如果采用long-polling模型，Consumer每发送一次请求Broker执行一次响应，这个例子需要进行4次long-polling交互（共4个request和4个response，8次网络操作；Dynamic Push/Pull中是1个request，三次push和一个response，共5次网络操作）。

总结：

Dynamic Push/Pull的模型利用了Consumer本地Buffer的容量作为一次long-polling最多可以返回的数据量，相对于long-polling模型减少了Consumer发起请求的次数，同时减少了不必要的延迟（连续的Push之间没有延迟，一批消息到Consumer的延迟就是一个网络开销；long-polling最大会是3个网络开销）。

Dynamic Push/Pull还有一些需要考虑的问题，比如连续推送的顺序性保证，如果丢包了怎么处理之类的问题，有兴趣可以自己考虑一下（也可以私下交流）。

### 结语

本篇内容比较了Push、Poll、Long-Polling、Dynamic Push/Pull模型。

- Push模型实时性好，但是因为状态维护等问题，难以应用到消息中间件的实践中。
- Pull模式实现起来会相对简单一些，但是实时性取决于轮训的频率，在对实时性要求高的场景不适合使用。
- Long-Polling结合了Push和Pull各自的优势，在Pull的基础上保证了实时性，实现也不会非常复杂，是比较常用的一种实现方案。
- Dynamic Push/Pull在Long-Polling的基础上，进一步优化，减少更多不必要的请求。但是先对实现起来会复杂一些，需要处理更多的异常情况。

 

参考内容：Google->Reactive Stream Processing with Akka Streams

 

往期文章：

[消息中间件核心实体(1)](http://mp.weixin.qq.com/s?__biz=MzU0NTEyNDcwOA==&mid=2247483706&idx=1&sn=7740f4a0c96d40fd008c3b36fe09b64d&chksm=fb70f931cc077027d08a6d610a2b6717413ef5e93113d790d545f681c4afcdce0bfa3b855180&scene=21#wechat_redirect)

[消息中间件核心实体（0）](http://mp.weixin.qq.com/s?__biz=MzU0NTEyNDcwOA==&mid=2247483699&idx=1&sn=6f86400f35f30f50788bbb6f42784347&chksm=fb70f938cc07702eec4aa18cc4dbf8fd61c4bb9614c1557c61518748c32c3804802c5d5aa026&scene=21#wechat_redirect)

[消息的写入和读取流程](http://mp.weixin.qq.com/s?__biz=MzU0NTEyNDcwOA==&mid=2247483694&idx=1&sn=1349d8460e80614ae64667d7afe9bfe2&chksm=fb70f925cc077033c4a2b360cace8edfb53033041f5a5ad5e4d8997919786f571ac69f70167b&scene=21#wechat_redirect)

[NameServer模块划分](http://mp.weixin.qq.com/s?__biz=MzU0NTEyNDcwOA==&mid=2247483687&idx=1&sn=4c8351cb0fc033280fabf96c5e135594&chksm=fb70f92ccc07703a4e032b3e5bef820a1e09b6959426bebc2e736f71269eaa19ef479aeb47db&scene=21#wechat_redirect)

[Client模块划分](http://mp.weixin.qq.com/s?__biz=MzU0NTEyNDcwOA==&mid=2247483683&idx=1&sn=495c63688baa53ed60b4be5dbb8698cd&chksm=fb70f928cc07703ebe5925199c119d882f9f8508fcca97e9fcab6f4f6a76ba0a4efc0349b180&scene=21#wechat_redirect)

[Broker模块划分](http://mp.weixin.qq.com/s?__biz=MzU0NTEyNDcwOA==&mid=2247483679&idx=1&sn=a07d3e450d52c0ec4f85991968d1463e&chksm=fb70f914cc07700263dd3232328ce503ce050aa991980618221c098bf6729cf39b837f1e3e5e&scene=21#wechat_redirect)

[消息中间件架构讨论](http://mp.weixin.qq.com/s?__biz=MzU0NTEyNDcwOA==&mid=2247483674&idx=1&sn=b98cc7058e8e0c390749a71c497835d5&chksm=fb70f911cc077007303bee89ed019b94c2483c84c07557fc0e9c9b148f1001b265ea1bf205c8&scene=21#wechat_redirect)

[业务方对消息中间件的需求](http://mp.weixin.qq.com/s?__biz=MzU0NTEyNDcwOA==&mid=2247483665&idx=1&sn=ee9a95303887402950ad9b59ccf738c3&chksm=fb70f91acc07700cbbfa34d077af6bca924320262121fe15135a4472527042a54479331a7c06&scene=21#wechat_redirect)

[消息中间件中的一些概念](http://mp.weixin.qq.com/s?__biz=MzU0NTEyNDcwOA==&mid=2247483662&idx=1&sn=2927329d60abf5a2c560e5cb542c63d3&chksm=fb70f905cc077013305771ccac33340bbe00bb5dfd7e7ae3cbb8d69a23bc91706e2de486424e&scene=21#wechat_redirect)

[什么是分布式消息中间件？](http://mp.weixin.qq.com/s?__biz=MzU0NTEyNDcwOA==&mid=2247483653&idx=1&sn=0109d653531c0134c06c611a5edf593c&chksm=fb70f90ecc077018325d4094f269a5f58ff59f1734d0e755ef6612fd9001c9f4c9dc364f6ef7&scene=21#wechat_redirect)

 

![img](https://mmbiz.qpic.cn/mmbiz_png/G6xepZmzIMfbQkyzB0JGRazMQGwZRBE1fC4ElOzUUzTd2y3rN0RF051qZKrG3icWJMwTlRWMMZdDZicPxdnqNlrg/0?wx_fmt=png)

 

如果本文对您有帮助，点一下右下角的“推荐”



分类: [MQ](https://www.cnblogs.com/hzmark/category/1025980.html)