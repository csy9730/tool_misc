# pc装机

[TOC]

主要配件分为：主机机箱和其他外设，外设包括显示器，键盘，鼠标，音箱。

主机包括：主板，cpu，显卡，内存，硬盘，机箱，电源，风冷装置。



### 主板


主板 B365 CPU 
主板上之前有北桥芯片和南桥芯片，后来北桥芯片合并进了CPU内部，
南桥部分，和CPU使用DMI通道，南桥芯片组IO速度只有PCI-E X4的带宽 ，限制主板的速度。


Z390 
H270 芯片组产品有B365

### CPU

CPU是英文“Central Processing Unit”的缩写，中文名叫中央处理器，是一块超大规模的集成电路，是一台计算机的运算核心和控制核心。

cpu领域主要分为intel和amd两大厂商

#### intel



##### Core™ 

intel产品标号分为Brand，Brand modifier，Gen Indicator ，SKU Numeric Digits Product Line Suffix



![第十代智能英特尔® 酷睿™ i7-10310Y 处理器 SKU 编号显卡](https://www.intel.cn/content/dam/www/public/us/en/images/illustrations/RWD/10th-gen-i7-10310-y-sku-graphic-rwd.png.rendition.intel.web.480.270.png)

**第十代智能英特尔® 酷睿™ 处理器家族**

此类第十代智能英特尔® 酷睿™ 处理器家族的处理器编号采用字母数字的排列形式，即以品牌及其标识符开头，随后是代编号和产品系列详细信息。五位序列号的前两位表示处理器的代次（第十代），后三位是 SKU 编号，末尾是 U 或 Y，表示处理器适用移动系统类别。



Intel 笔记本 CPU 有 i3 ，i5 ，i7 几个类型。可以理解为低端cpu，中端cpu，高端cpu，上面还有个i9，可以理解为发烧级cpu 。一般来说，在同代 CPU 的情况下，i5 要好过 i3，i7 要好过i5。

后缀包括：

| 字母后缀 |   描述   | **范例** |
| ------------ | ---- | ---- |
|    无          |台式机      |      |
|      K        |  未锁频    | 英特尔® 酷睿™ i9-9900K 处理器     |
|      T        | 台式机 低功耗 |      |
|     S         |   特别版   |      |
| X | 极致性能(extreme) |  |
|       Φ       |  需要独立显卡    |      |
|       M       |   移动式   |      |
| H | 高性能显卡 |  |
| U | 超低功耗 | 第八代智能英特尔® 酷睿™ i7-8650U 处理器 |
| G | 封装包中包含独立显卡 | 第八代智能英特尔® 酷睿™ i7-8705G 处理器 |





CPU 性能的一个重要指标是频率,这要同时结合 CPU 的其他参数来比较：是第几代，有几核等。

影响 CPU 性能的另一项关键指标是核心数，当然，核心数越多越好。不过要注意，这里的核心数是指物理核心数。比如，双核四线程是物理双核而不是物理四核。

一般说来， i3 不带超线程技术，而 i5 i7 不仅带有超线程技术，还具备睿频加速技术，因而性能会更胜一筹。

##### 其他

Xeon 适用于工作站，Atom适用于边缘设备。 PENTIUM， Celeron，Itanium，Quark是过时的系列。



- 至强® 处理器  Xeon
- 英特尔凌动® 处理器 Atom
- 奔腾处理器 PENTIUM
- 英特尔® 赛扬® 处理器 Celeron
- Itanium
- Quark



[intel官网](https://www.intel.cn/content/www/cn/zh/homepage.html)

#### AMD

AMD 产品可以大致分为[桌面级](https://www.baidu.com/s?wd=%E6%A1%8C%E9%9D%A2%E7%BA%A7&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao)和服务器级处理器。

![img](..\img\v2-bc43716167ec0d31ec957022d2442f29_hd.jpg)

其中[桌面级](https://www.baidu.com/s?wd=%E6%A1%8C%E9%9D%A2%E7%BA%A7&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao)处理器有锐龙(Ryzen)、AMD FX、APU、速龙（Athlon）和闪龙（sempron）系列，他们的性能依次为：锐龙>AMD FX>APU>速龙>闪龙。它们将AMD桌面处理器划分为高中低端。

羿龙（[phenom](https://www.baidu.com/s?wd=phenom&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao)）钻龙(Duron)已经淘汰停产.



X后缀— —AMD Ryzen X系列跟Intel的K系列类似，都是强化了超频特性。

K后缀— —K代表解锁倍频，可以超频，如AMD Athlon X4 860K和AMD A10-7870K。

E后缀— —指FX系列CPU的节能版，如FX 8370E的频率降低到3.3-4.3GHz，功耗降低到95W（FX8370的规格为4.0-4.3GHz，125W）。

B后缀— —指APU的低功耗商务版本，比如A10 PRO-7850B，下限能耗少10W，GPU频率降低。

M后缀— —M系列特指APU的移动版。

### 显卡

显卡分为两大厂商，NVIDIA和amd，此外还有intel的集成显卡。

NVIDIA有GeForce，Tesla，Quant等多个品牌。

民用级主要是GeForce品牌

前缀：GTX＞GTS＞GT

但是后缀就多了，但是大致分为四类，一般是super?>Ti＞无后缀＞笔记本版＞MQ。
后缀M是笔记本？
MQ一般用于超薄的笔记本。
GTX 1080Ti>GTX 1080

GeForce GTX 1660Super
GeForce GTX 1080TI
GeForce RTX 2080TI ~ GeForce RTX 2080 2060



显卡天梯图



