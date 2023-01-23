# rpc框架实现原理

[![璃笙0974](https://pic2.zhimg.com/v2-063b0ea1d6674812af349f3a30c0a6ba_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/fylian-1)

[璃笙0974](https://www.zhihu.com/people/fylian-1)







**rpc框架是什么？**

RPC 的全称是 Remote Procedure Call 是一种进程间通信方式。它允许程序调用另一个地址空间(通常是共享网络的另一台机器上)的过程或函数，而不用程序员显式编码这个远程调用的细节。即无论是调用本地接口/服务的还是远程的接口/服务，本质上编写的调用代码基本相同。

RPC 会隐藏底层的通讯细节(不需要直接处理Socket通讯或Http通讯)

RPC 是一个请求响应模型。客户端发起请求，服务器返回响应(类似于Http的工作方式)

RPC 在使用形式上像调用本地函数(或方法)一样去调用远程的函数(或方法)。



**rpc框架有哪些?常用开源 RPC 框架有哪些？**

跟语言平台绑定的开源 RPC 框架主要有下面几种。

Dubbo：国内最早开源的 RPC 框架，由[阿里巴巴公司](https://www.zhihu.com/search?q=阿里巴巴公司&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A438924676})开发并于 2011 年末对外开源，仅支持 Java 语言。

Motan：微博内部使用的 RPC 框架，于 2016 年对外开源，仅支持 Java 语言。

Tars：腾讯内部使用的 RPC 框架，于 2017 年对外开源，仅支持 C++ 语言。

Spring Cloud：国外 Pivotal 公司 2014 年对外开源的 RPC 框架，仅支持 Java 语言

而跨语言平台的开源 RPC 框架主要有以下几种。

gRPC：Google 于 2015 年对外开源的跨语言 RPC 框架，支持多种语言。

Thrift：最初是由 Facebook 开发的内部系统跨语言的 RPC 框架，2007 年贡献给了 Apache 基金，成为 Apache 开源项目之一，支持多种语言。

hprose：一个MIT开源许可的新型轻量级跨语言跨平台的面向对象的高性能远程动态通讯中间件。它支持众多语言:nodeJs, C++, .NET, Java, Delphi, Objective-C, ActionScript, JavaScript, ASP, PHP, Python, Ruby, Perl, Golang 。

rpc框架的实现原理

在RPC框架中主要有三个角色：Provider、Consumer和Registry。

节点角色说明：

\* Server: 暴露服务的服务提供方。

\* Client: 调用远程服务的服务消费方。

\* Registry: 服务注册与发现的注册中心。

RPC调用流程

RPC基本流程图：

![img](https://pic2.zhimg.com/80/v2-e33e58a30e7ebbdbf43d51131cdc9f41_1440w.jpg)

一次完整的RPC调用流程(同步调用，异步另说)如下：

1)服务消费方(client)调用以本地调用方式调用服务;

2)client stub接收到调用后负责将方法、参数等组装成能够进行网络传输的消息体;

3)client stub找到服务地址，并将消息发送到服务端;

4)server stub收到消息后进行解码;

5)server stub根据解码结果调用本地的服务;

6)本地服务执行并将结果返回给server stub;

7)server stub将返回结果打包成消息并发送至消费方;

8)client stub接收到消息，并进行解码;

9)服务消费方得到最终结果。

**使用到的技术**

1、动态代理

生成 client stub和server stub需要用到 Java 动态代理技术 ，我们可以使用JDK原生的动态代理机制，可以使用一些开源字节码工具框架 如：CgLib、Javassist等。

2、[序列化](https://www.zhihu.com/search?q=序列化&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A438924676})

为了能在网络上传输和接收 Java对象，我们需要对它进行 序列化和反序列化操作。

\* 序列化：将Java对象转换成byte[]的过程，也就是编码的过程;

\* 反序列化：将byte[]转换成Java对象的过程;

可以使用Java原生的序列化机制，但是效率非常低，推荐使用一些开源的、成熟的序列化技术，例如：protobuf、Thrift、hessian、Kryo、Msgpack

关于序列化工具性能比较可以参考：jvm-serializers

3、NIO

当前很多RPC框架都直接基于netty这一IO通信框架，比如阿里巴巴的HSF、dubbo，Hadoop Avro，推荐使用Netty 作为底层通信框架。

4、服务注册中心

可选技术：

\* Redis

\* Zookeeper

\* Consul

\* Etcd

TG：li9047

发布于 2021-11-29 10:24

开发框架

远程过程调用协议RPC（Remote Procedure Call Protocol)

交互框架