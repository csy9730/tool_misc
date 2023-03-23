# [什么是STM32的ISP？](https://www.cnblogs.com/zhengnian/p/11538465.html)

上一篇笔记分享了STM32的串口IAP实例：[STM32串口IAP分享](https://zhengnianli.github.io/2019/09/16/stm32-chuan-kou-iap-fen-xiang/)。其中，下载IAP程序时用`ISP`的方式进行下载。这里的ISP又是什么呢？

# ISP方式下载程序原理

ISP：In System Programing，在系统中编程

在STM32F10xxx里有三种启动方式：

![img](https://img2018.cnblogs.com/blog/1331311/201909/1331311-20190918084338873-729733892.png)

以ISP方式下载程序时需要把STM32的`BOOT0`引脚置1、`BOOT1`引脚置0，即从系统存储区（System Memory）启动。为什么设置从System Memory启动就可以使用串口来下载我们的程序呢？那是因为在芯片出厂前ST官方已经把一段自举程序（BootLoader程序）固化到这一块存储区。对于STM32F103ZET6来说，System Memory的起始地址为0x1FFFF000，可在芯片手册的内存映射图里找到：

![img](https://img2018.cnblogs.com/blog/1331311/201909/1331311-20190918084346296-1285924884.png)

其通过串口来接收数据并烧写到`用户闪存存储器`的起始地址（0x08000000）。只能烧写到这个地址，若keil里设置的地址不是这个地址，则编译出来的文件将烧录不成功。

> 用户闪存，即User Flash，同时也称为Main Flash。

这一段`BootLoader`程序源码是没有开源出来的，用户是不可修改的。我们在上一篇笔记的IAP实验中，IAP程序通过`FlyMCU`软件进行烧录，烧录的地址就是`0x08000000`。

注意：不同系列不同型号的STM32固化的`BootLoader`是不同的，即使用的通讯接口是不同的。如STM32F1xxx系列只支持USART1：

![img](https://img2018.cnblogs.com/blog/1331311/201909/1331311-20190918084353347-942606800.png)

STM32F4xxx系列只支持USART1、USART3、CAN2等接口：

![img](https://img2018.cnblogs.com/blog/1331311/201909/1331311-20190918084401779-87464160.png)

其他型号的BootLoader支持的接口可查看`AN2606`文档，链接：

```c
https://www.st.com/content/ccc/resource/technical/document/application_note/b9/9b/16/3a/12/1e/40/0c/CD00167594.pdf/files/CD00167594.pdf/jcr:content/translations/en.CD00167594.pdf
```

这里，关于数据协议的内容不展开讨论，有兴趣的朋友可自行研究。

# IAP程序与ISP程序有什么不同？

从基本功能来看，IAP程序与ISP程序所做的事情好像是一样的，都是引导加载程序，所以网上有很多文章把IAP程序与ISP程序都称为BootLoader程序，要注意区分。但是，ISP与IAP还是有点区别的。

STM32内部Flash分为两部分，`System Flash`和`User Flash`。上电之后执行哪个Flash里的程序有boot脚来控制。

`System Flash`内存放的是ST官方编写的自举程序（ISP程序），我们是没有办法改变的。

`User Flash`是我们可以使用的Flash空间，我们编写的代码就是要烧录到`User Flash`中。我们可以把`User Flash`分为两部分，前面一部分空间用于烧写我们编写的IAP程序，后面一部分用于烧写我们编写的应用程序。其中，IAP程序用于更新我们的应用程序。

ISP程序用于把我们编写的程序更新到0x08000000地址上，如果我们的产品中的程序有`IAP程序+应用程序`，则此时0x08000000地址存放的程序就是IAP程序。ISP程序、IAP程序、应用程序的关系示意图如下：

![img](https://img2018.cnblogs.com/blog/1331311/201909/1331311-20190918084414543-1230220363.png)

如果我们的产品中的程序只有`应用程序`，则此时0x08000000地址存放的程序就是应用程序。ISP程序、应用程序的关系示意图如下：

![img](https://img2018.cnblogs.com/blog/1331311/201909/1331311-20190918084422376-1307700807.png)

## 以上就是今天的分享，如有错误，欢迎指出！

我的个人博客：https://zhengnianli.github.io/

我的微信公众号：嵌入式大杂烩