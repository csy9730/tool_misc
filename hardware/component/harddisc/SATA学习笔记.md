# SATA学习笔记

[![Kevin Z](https://picx.zhimg.com/4ab207b0307653181082515d9d265639_l.jpg?source=172ae18b)](https://www.zhihu.com/people/zhao-kai-fei-9)

[Kevin Z](https://www.zhihu.com/people/zhao-kai-fei-9)

硬件工程师

3 人赞同了该文章

## **SATA学习笔记**





- [历史](https://zhuanlan.zhihu.com/p/354218886/edit)

- - [PATA](https://zhuanlan.zhihu.com/p/354218886/edit)
  - [SATA](https://zhuanlan.zhihu.com/p/354218886/edit)



- [速度](https://zhuanlan.zhihu.com/p/354218886/edit)

- [简介](https://zhuanlan.zhihu.com/p/354218886/edit)

- - [拓扑](https://zhuanlan.zhihu.com/p/354218886/edit)
  - [接口结构](https://zhuanlan.zhihu.com/p/354218886/edit)
  - [协议模型](https://zhuanlan.zhihu.com/p/354218886/edit)



- [SATA接口](https://zhuanlan.zhihu.com/p/354218886/edit)

- [mSATA接口](https://zhuanlan.zhihu.com/p/354218886/edit)

- [M.2接口](https://zhuanlan.zhihu.com/p/354218886/edit)

- - [M.2接口(SATA)](https://zhuanlan.zhihu.com/p/354218886/edit)
  - [M.2接口（NVMe）](https://zhuanlan.zhihu.com/p/354218886/edit)







## **历史**

### **PATA**

PATA，全称Parallel Advanced Technology Attachment，顾名思义，这是一个附件，属于CPU，作为它的存储单元。
这一串行协议早已成为时代的眼泪，因为其速度、噪声、电平都落后于SATA。

### **SATA**

SATA，全称Serial Advanced Technology Attchment，跟PATA一样，这也是CPU的存储单元，但SATA属于串行通信。
和PATA相比，SATA的优点主要是：

1. 采用差分信号系统，该系统能有效将噪声滤除，因此SATA就不需要使用高电压传输去抑制噪声，只需要使用低电压操作即可。
2. SATA的速度比PATA更加快捷，并支持热插拔。另一方面，SATA总线使用了嵌入式时钟频率信号，具备了比以往更强的纠错能力，能对传输指令（不仅是数据）进行检查，如果发现错误会自动矫正，提高了数据传输的可靠性。

## **速度**

![img](https://pic3.zhimg.com/80/v2-a3d555d10daec72aa1125ea935fc147a_1440w.webp)

| 代数 | 数据传输速度 | 带宽 |
| ---- | ------------ | ---- |
|      |              |      |

## **简介**

### **拓扑**



![img](https://pic1.zhimg.com/80/v2-5765bf10c9db3c04f1eebf448af1be00_1440w.webp)

SATA的拓扑结构是点对点式的，主机可以通过多个链接支持多个设备，每个设备百分百占用总线带宽，并且一个设备的链接出错不会影响其他设备的链接。

### **接口结构**

SATA接口使用4根电缆传输数据，其结构图如下图所示。Tx+、Tx-表示输出差分数据线，对应的，Rx+、Rx-表示输入差分数据线。

![img](https://pic4.zhimg.com/80/v2-b27b7c513aa1b7a62407695fb93135ff_1440w.webp)

### **协议模型**

SATA接口协议借鉴TCP/IP模型，将SATA接口划分为四个层次来实现，包括物理层、链路层、传输层、应用层，其体系结构如下图所示。

![img](https://pic1.zhimg.com/80/v2-4fa2887cfc7cf18b9cc39401eb6e11d0_1440w.webp)

------

## **接口**

以上所说的SATA，都特指一种协议，是属于信号方面的内容，但SATA另外也指一种连接器标准，相对应的又有其他的协议，因此下文再进行详细分析。

## **SATA接口**

作为目前应用最多的硬盘接口，SATA 3.0接口最大的优势就是成熟。普通2.5英寸SSD以及HDD硬盘都使用这种接口，理论传输带宽6Gbps，虽然比起新接口的10Gbps甚至32Gbps带宽差多了，但普通2.5英寸SSD也没这么高的需求，500MB/s多的读写速度也够用。

![img](https://pic1.zhimg.com/80/v2-edec2d5b6fe46717a9dcea657b994a44_1440w.webp)

## **mSATA接口**

mSATA接口，全称迷你版SATA接口（mini-SATA）。是早期为了更适应于超级本这类超薄设备的使用环境，针对便携设备开发的mSATA接口应运而生。可以把它看作标准SATA接口的mini版，而在物理接口上（也就是接口类型）是跟mini PCI-E接口是一样的。

![img](https://pic1.zhimg.com/80/v2-c38c4e008c928944875f2719f06b9d74_1440w.webp)

## **M.2接口**

M.2接口是Intel推出的一种替代mSATA的新的接口规范，也就是我们以前经常提到的NGFF，即Next Generation Form Factor。 M.2接口的固态硬盘宽度22mm，单面厚度2.75mm，双面闪存布局也不过3.85mm厚，但M.2具有丰富的可扩展性，最长可以做到110mm，可以提高SSD容量。M.2 SSD与mSATA类似,也是不带金属外壳的，常见的规格有主要有**2242、2260、2280三种，宽度都为22mm，长度则各不相同**。

![img](https://pic2.zhimg.com/80/v2-e9aa79bf006fcfd279eb9445176cef11_1440w.webp)

![img](https://pic2.zhimg.com/80/v2-d1ce2e63f7d9edb5a80a6193b71a1f0d_1440w.webp)

不仅仅是长度，M.2的接口也有两种不同的规格，分别是“socket2”和”socket3”。



![img](https://pic3.zhimg.com/80/v2-cee33ff22d855fa67d6ee15640df2b76_1440w.webp)

看似都是M.2接口，但其支持的协议不同，对其速度的影响可以说是千差万别，**M.2接口目前支持两种通道总线，一个是SATA总线，一个是PCI-E总线。**
当然，SATA通道由于理论带宽的限制（6Gb/s）,极限传输速度也只能到600MB/s，但PCI-E通道就不一样了，带宽可以达到10Gb/s，所以看似都为M.2接口，但走的“道儿”不一样，速度自然也就有了差别。

### **M.2接口(SATA)**

这就是上面说的SATA协议，不展开讲了。

### **M.2接口（NVMe）**

NVMe，全称Non-Volatile Memory express，是一种逻辑设备接口规范，他相当于SATA中的AHCI规范，相当于通信协议中的应用层，NVMe是用于访问通过PCIe总线附加的内存介质，但理论上不一定要求PCIe总线协议。
NVMe的目的是充分利用PCIe通道的低延时性和并行性，降低由于AHCI接口带来的高延时，彻底解放SATA时代固态硬盘的极致性能。
简单的数据对比，SATA 3.0的带宽为6Gbps，PCIe 3.0的带宽则为8Gbps，并且NVMe无需厂家提供相应的驱动就可以正常工作，这无疑方便了向后兼容的设计。
具体来说，NVMe的具体优势包括：

1. 性能有数倍的提升；
2. 可大幅降低延迟；
3. NVMe可以把最大队列深度从32提升到64000，SSD的IOPS能力也会得到大幅提升；
4. 自动功耗状态切换和动态能耗管理功能大大降低功耗；
5. NVMe标准的出现解决了不同PCIe SSD之间的驱动适用性问题。 详细解释参考参考链接2。

参考链接：

1. **[SATA协议简介](https://link.zhihu.com/?target=https%3A//blog.csdn.net/yinfuyou/article/details/83304313)**
2. **[SATA、mSATA、M.2、M.2（NVMe）、PCIE固态硬盘接口详解](https://link.zhihu.com/?target=https%3A//blog.csdn.net/shuai0845/article/details/98330290)**
3. **[固态硬盘的PCIE，SATA，M2，NVMe，AHCI](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/yi-mu-xi/p/10469458.html)**

发布于 2021-03-03 10:54

[mSATA](https://www.zhihu.com/topic/20014774)

[nvme](https://www.zhihu.com/topic/20105066)

[固态硬盘](https://www.zhihu.com/topic/19562697)