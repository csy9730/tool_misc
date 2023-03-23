# USB协议看这一篇就够了

[![Kevin Z](https://pic1.zhimg.com/4ab207b0307653181082515d9d265639_l.jpg?source=172ae18b)](https://www.zhihu.com/people/zhao-kai-fei-9)

[Kevin Z](https://www.zhihu.com/people/zhao-kai-fei-9)

硬件工程师

46 人赞同了该文章

## **USB协议看这一篇就够了**





- [USB协议简析](https://zhuanlan.zhihu.com/write)

- [历史演变](https://zhuanlan.zhihu.com/write)

- - [特点](https://zhuanlan.zhihu.com/write)



- [技术细节](https://zhuanlan.zhihu.com/write)

- - [USB 3.2](https://zhuanlan.zhihu.com/write)
  - [USB 4.0](https://zhuanlan.zhihu.com/write)
  - [结束语](https://zhuanlan.zhihu.com/write)







## **USB协议简析**

有一篇文章在我的草稿箱里躺了很久，叫做《行业技术思考-接口篇》，是因为看到现在的处理器出来的通信协议有那么多，但它们本质上还是在传输码流，有一些历史的原因就全都保留了下来，有些甚至越走越远，因为各自的需求发展出了不同的特性，例如支持纠错或者传输电能等。但我想这些东西是不是可以归一化，让CPU专注在自己的部分，对外只输出PCIe或者别的某种高速协议，外设再根据各自的需求来翻译或者提取数据呢？

在业界有看到两种殊途同归的趋势，第一个时间长了给忘了（很尴尬，只记得是Intel提出的一个标准），第二个就是这几天研究的USB 4了。USB 4将我的这种想法给部分实现，通过一种隧道技术的方式，将DP/USB3/PCIe信号集成到通信隧道里面去，接收端再通过数据包头来区分数据（这就有点像交换机里的数据分发，通过MAC地址或者报文帧头确定数据包目的地）。

![img](https://pic2.zhimg.com/80/v2-9bdea2bc84a77bd4efdb424c283a3875_720w.webp)

这里先写下我认为的USB4.0的缺陷：因为硬件的局限性和可能的分发芯片性能功能问题，每个分发数据的协议速率是有各自的上限的，不能够动态调整每个接口的最大速度。不过相信在后面的技术中这一点应该可以动态调整。

## **历史演变**

![img](https://pic3.zhimg.com/80/v2-a1d5fc4dd1ad893ee09289c02e50edd2_720w.webp)

USB与I2C/SPI/UART类似，都是一种传输数据的协议规范，但USB主要设计是用于计算机与外接设备的数据交互和文件传输，这一点也正是它现在演变为相对高速的对外接口的原因，最高速的当然是PCIe。

历史就不展开讲了，基本上就是一些行业巨头联合开发的一种协议，技术角度我们先聊聊特点。

### **特点**

USB的速度一直是跟着时代在飞速发展，并且得益于摩尔定律，最近几年USB速度也在不断翻倍提升。

USB 1.0就不提了，早已化作时代的眼泪。年轻的我都没接触过这个96年的老朋友。

USB 2.0 可能是目前最经典的接口，480Mbps的速度已经可以满足一般人的日常文件传输需求，所以这个千禧年的接口协议仍然活跃在市场上，而且并将继续活跃，服务器交换机目前还是使用USB 2.0居多。

USB 3，这里只谈USB 3.2 Gen2，因为这个是最新的。从USB 3x开始，这一协议开始展现出统治力，3x开始和type C结合，将曾经的文件传输接口增加为文件加视频传输接口，并且视频一上来就是最新的DP接口。

USB 4，这兄弟更猛，除了USB、DP，还额外增加了PCIe的功能，1 LANE支持到10Gbps，通过隧道技术来最大限度发挥物理带宽性能，这个还没有开始投向商用，应该还要一两年。

## **技术细节**

### **USB 3.2**

> 2013年USB 3.0改名为USB 3.1 Gen 1，同时推出了10Gbps带宽的USB 3.1 Gen 2，两者统称为USB 3.1。到了2017年，**USB 3.1 Gen 1和USB 3.1 Gen 2分别改名为USB 3.2 Gen 1和USB 3.2 Gen 2** 。同时加入了带宽为10Gbps的USB 3.2 Gen 1x2和带宽为20Gbps的USB 3.2 Gen 2x2，这4个统称USB 3.2。至此进入了USB 3.2时代，而USB 3.0的名字已经成为历史。**总之，USB 2.0还保留着，而USB 3.0现在已经被USB-IF协会改名为USB 3.2 Gen 1了，而且还多了USB 3.2 Gen 2、USB 3.2 Gen 1x2和USB 3.2 Gen 2x2。其中USB 3.2 Gen 1x2和USB 3.2 Gen 2x2表示USB 3.2 Gen 1和USB 3.2 Gen 2的** 双通道模式，而USB 3.2 Gen 1和USB 3.2 Gen 2是**单通道模式** 。

接口上看，USB 3.2之前大致上有两到三种插件类型，A/B/C，但从USB3.2开始，就只有type-C了，原因就是之前都是单通道模式，两组差分一发一收就可以了，但USB 3.2为了有更高的带宽，就将type-C的本来不用的另一组差分也用上了。具体来说，下图中的蓝色两个通道在USB 3.2之前正插反插都是只用到一组的，从USB 3.2开始，正差反差就都是两组全用了。

![img](https://pic3.zhimg.com/80/v2-60d4319b9610c36752c61925423c3a06_720w.webp)

看到这里，让我们来分析下type C接口上的这些信号，在USB条件下：

| Pin Location | Pin Name | Function |
| ------------ | -------- | -------- |
|              |          |          |

在这其中，USB 2.0数据信号4个，其实是两个，为了满足正反插需求所以正反都有；USB 3.2数据信号8个，包含两通道的差分收发信号；VBUS信号4个，GND信号4个，一共8个信号处理电源；CC信号两个；SBU信号两个。

现在来展开讲讲CC信号和SBU。

### **CC信号**

全称Configuration　Channel，分为CC1和CC2，在type C接口被引用，主要是为了解决正反插的信号交错问题和侦测插入的接口类型。

目前主要是在source端设计上拉电阻，sink端设计下拉电阻，通过不同电阻的配比来表示当前的设备类型和插入方式。具体方式比较复杂，参考type C spec里的两个截图，两个CC信号用来侦测正反插情况和设备信息。以后有机会调试CC信号再深入了解。

![img](https://pic2.zhimg.com/80/v2-7207c7371e3c523267e2ce6f41182815_720w.webp)

![img](https://pic2.zhimg.com/80/v2-8a05964f6261815c8728bb92921fa821_720w.webp)

### **SBU信号**

SBU信号是为USB 4.0 预留的，3.2里没有用到这个信号，不过这两个信号又在Alternate Mode（主要是DP）和Audio Adapter Accessory Mode里有使用，后面讲到这两个模式再具体分析。

### **信号完整性**

从USB 3.1开始，码流速度就到达了5Gbps，这种速度下的信号要开始处理信号完整性的问题了，主要是插损和传输损耗，协议中对此也有规定。

此时开始引入redriver来解决信号完整性的问题。

Repeater分为两种，redriver和retimer。

Retimer，指的是这种器件包含有CDR（clock-data recovery）电路，可以重新编码信号。好处是不会为信号引入一些高频抖动。

Redriver，指的是器件使用模拟电路的方式来增强信号，不会对码流进行操作。中间会有均衡放大和发送的部分。

一个链路中能够使用的repeater个数是没有限制的，只要总体的时延和抖动能够满足要求，但一般是sink和source端各自处理自己接口上的信号质量，能满足协议规范就可以了，如果是cable厂商，可能也需要在cable中集成一到两个repeater。

### **USB 4.0**

对于USB 4，它的Gen 2和USB 3在每个lane的速度上是暂时一样的，Gen 3 则在USB 3.2的基础上再翻倍，但数据传输的内容和方式就有很大的差别。USB 3 是在传递USB的信号，但USB 4 使用了隧道技术，类似于将USB、DP、PCIe封装到一起的技术，不过这里面三个通道各自有其带宽上限。

### **隧道技术**

![img](https://pic2.zhimg.com/80/v2-837ec4b892169cb9771514a8be22ff05_720w.webp)

对于USB 4 来说，规定了一种可以同时传输三种通信协议的方式，但这是在芯片内部或者协议端实现的，物理层和逻辑层与所谓的通道互相独立，传输层和配置层需要针对通道方式做出改变。

作为对比，USB 3x则没有这种说法。下图是USB 3x的协议分层。

![img](https://pic3.zhimg.com/80/v2-10ab8f77941d361af8081af38c3352c6_720w.webp)

隧道技术采用了Distributed Time Management Units(TMUs)来处理每一个交换功能，网上并不能看到太多有关这个技术的细节，但从上面的分析，有理由得出一下的猜测：

1. TMUs位于芯片内部或者就是纯软件，与USB 4 协议是配套使用，在物理层和传输层没有体现
2. 由第一点，如果device端是USB 4，则也需要集成TMU，如果只是三种协议中的一种，就要看host端是否有向下兼容的能力（USB3和DP是必须的，PCIe目前是可选）。

再来看下图就会对USB 4的整个拓扑有更多的了解。

简单来说，USB 4 host可以直接支持USB 3x，DP，PCIe的device；也可以通过USB Hub的方式去fan out直接输出USB 4隧道信号，让Hub来分发；更可以直接插入支持USB 4 的device来一根cable传输这三个协议的信号。

![img](https://pic2.zhimg.com/80/v2-0abef165a5cc2a9f851b97cfc3e22005_720w.webp)

看完隧道技术，再来看一下USB 4 是如何支持三种device的。

第一张图里有看到，不同的协议影响的是红圈中的设计，也即Adapter的选择；在USB 4的整个通信过程中，这些具体的协议是已经在比较上层的地方，所以对于不同协议的支持，需要做的有两点：

1. 在USB 4 的block内有对应支持的协议种类的Adapter
2. 在USB 4 与CPU更上层的连接中有对应的通信路径，例如PCIe需要有PCIe Switch或者链接到Root Port的Root Complex

当满足以上两点，从芯片对外提供的USB 4 interface上来看，它就可以支持所有的四种协议：USB 4，USB 3，DP，PCIe（目前只到Gen 1）,根据插入的设备类型做到向下兼容。

![img](https://pic3.zhimg.com/80/v2-7ad9c952d88536c36ff2f3fc43f06dfa_720w.webp)

### **SBU信号**

SBU在USB 4开始被引入，速度为1Mbps，有三个功能：

1. 配置USB 4通道，进行初始化操作
2. 和retimer进行交互，完成USB 4 Link TxFFE的握手
3. 确保USB 4 通道的发送和retimer的上电或者wake up sequence的正确完成

### **与TMT3的兼容**

Thunderbolt™ 3是Intel发布的Light Peak技术。Thunderbolt连接技术融合了PCI **[Express](https://link.zhihu.com/?target=https%3A//so.csdn.net/so/search%3Ffrom%3Dpc_blog_highlight%26q%3DExpress)**（PCI-E）数据传输技术和Display Port（DP）显示技术，可以同时对数据和视频信号进行传输。

具体细节不展开了，有一个点需要注意，当以兼容TMT3模式运行时，adapter需要在TBT3兼容的速度下运行，也即Gen 2 是10.3125Gbps，Gen 3 是20.625Gbps。

### **结束语**

这篇有关USB 3和USB 4 的技术分析文章到此可以画一个顿号了，因为这两个协议内容实在复杂，这篇只是站在硬件和拓扑的角度初探了一下，为以后的使用打一个底子。

但几天看下来，深感USB协议本身的交错和兼容性问题，比如说USB 3 和USB 4 不同代数的命名问题，再比如USB 4 开始使用type C后与type C本身支持的一些特性的兼容问题。

USB，全称Universal Serial Bus，是一个很伟大并且巧妙统一的协议，但各个厂商在应用的时候加了很多自己的创意想法，因此就有了目前这么错综复杂的情况。

USB系列应该还有一篇，现在是站在USB通信协议的角度在看，下一篇将会站在type C这一连接器和USB power delivery的角度来再分析。

发布于 2021-11-09 13:05



[USB 开发者论坛（USB-IF）](https://www.zhihu.com/topic/20066418)

[USB](https://www.zhihu.com/topic/19559049)

[USB线](https://www.zhihu.com/topic/19636456)