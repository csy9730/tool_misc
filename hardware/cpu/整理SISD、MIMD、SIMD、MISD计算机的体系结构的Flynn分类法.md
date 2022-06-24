# 整理SISD、MIMD、SIMD、MISD计算机的体系结构的Flynn分类法



[conowen](https://blog.csdn.net/conowen)![img](https://csdnimg.cn/release/blogv2/dist/pc/img/newCurrentTime2.png)于 2012-02-13 21:35:59 发布![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes2.png)53041![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect2.png) 收藏 54

分类专栏： [计算机相关](https://blog.csdn.net/conowen/category_1077068.html) 文章标签： [多线程](https://so.csdn.net/so/search/s.do?q=%E5%A4%9A%E7%BA%BF%E7%A8%8B&t=blog&o=vip&s=&l=&f=&viparticle=) [编程](https://so.csdn.net/so/search/s.do?q=%E7%BC%96%E7%A8%8B&t=blog&o=vip&s=&l=&f=&viparticle=) [平台](https://so.csdn.net/so/search/s.do?q=%E5%B9%B3%E5%8F%B0&t=blog&o=vip&s=&l=&f=&viparticle=) [存储](https://so.csdn.net/so/search/s.do?q=%E5%AD%98%E5%82%A8&t=blog&o=vip&s=&l=&f=&viparticle=) [cache](https://so.csdn.net/so/search/s.do?q=cache&t=blog&o=vip&s=&l=&f=&viparticle=) [图像处理](https://so.csdn.net/so/search/s.do?q=%E5%9B%BE%E5%83%8F%E5%A4%84%E7%90%86&t=blog&o=vip&s=&l=&f=&viparticle=)



[![img](https://img-blog.csdnimg.cn/20201014180756923.png?x-oss-process=image/resize,m_fixed,h_64,w_64)计算机相关专栏收录该内容](https://blog.csdn.net/conowen/category_1077068.html)

2 篇文章1 订阅

订阅专栏

## **1. 计算平台介绍**

Flynn于1972年提出了计算平台的Flynn分类法，主要根据指令流和数据流来分类，共分为四种类型的计算平台，如下图所示：

![img](http://hi.csdn.net/attachment/201202/13/0_13291404283356.gif)



#### 单指令流单数据流机器（SISD）

SISD机器是一种传统的串行计算机，它的硬件不支持任何形式的并行计算，所有的指令都是串行执行。并且在某个时钟周期内，CPU只能处理一个数据流。因此这种机器被称作单指令流单数据流机器。早期的计算机都是SISD机器，如冯诺.依曼架构，如IBM PC机，早期的巨型机和许多8位的家用机等。

#### 单指令流多数据流机器（[SIMD](https://so.csdn.net/so/search?q=SIMD&spm=1001.2101.3001.7020)）

SIMD是采用一个指令流处理多个数据流。这类机器在数字信号处理、图像处理、以及多媒体信息处理等领域非常有效。

Intel处理器实现的MMXTM、SSE（Streaming SIMD Extensions）、SSE2及SSE3扩展指令集，都能在单个时钟周期内处理多个数据单元。也就是说我们现在用的单核计算机基本上都属于SIMD机器。

#### 多指令流单数据流机器（MISD）

MISD是采用多个指令流来处理单个数据流。由于实际情况中，采用多指令流处理多数据流才是更有效的方法，因此MISD只是作为理论模型出现，没有投入到实际应用之中。

#### 多指令流多数据流机器（MIMD）

MIMD机器可以同时执行多个指令流，这些指令流分别对不同数据流进行操作。最新的多核计算平台就属于MIMD的范畴，例如Intel和AMD的双核处理器等都属于MIMD。

本书所讲述的主要内容就是围绕多核计算平台而来的，下面就来介绍一下多核的硬件结构。

## **2. 多核CPU硬件结构**

多核CPU是将多个CPU核集成到单个芯片中，每个CPU核都是一个单独的处理器。每个CPU核可以有自己单独的Cache，也可以多个CPU核共享同一Cache。下图便是一个不共享Cache的双核CPU[体系结构](https://so.csdn.net/so/search?q=%E4%BD%93%E7%B3%BB%E7%BB%93%E6%9E%84&spm=1001.2101.3001.7020)。







在现代的多核硬件结构中，内存对多个CPU核是共享的，CPU核一般都是对称的，因此多核属于共享存储的对称多处理器（Symmetric Multi-processor，SMP）。

在多核硬件结构中，如果要充分发挥硬件的性能，必须要采用多线程（或多进程）执行，使得每个CPU核在同一时刻都有线程在执行。

和单核上的多线程不同，多核上的多个线程是在物理上并行执行的，是一种真正意义上的并行执行，在同一时刻有多个线程在并行执行。而单核上的多线程是一种多线程交错执行，实际上在同一时刻只有一个线程在执行。

## **3. 多核编程模型**

前面谈到过多核属于共享存储的SMP，但实际上SMP系统出现在多核之前，服务器硬件中就广泛采用多个CPU构成的SMP系统，如双CPU、四CPU的服务器很早就出现了。多核CPU系统中的编程和多CPU的SMP系统的编程模型是一致的，都属于共享存储的编程模型，在本书中把它叫做多核编程，实际上并不限于在多核CPU系统中的编程，而是可以应用于共享存储的SMP系统中的编程。



原文来自

http://book.51cto.com/art/201004/197196.htm

来自《多核计算与程序设计》周伟明