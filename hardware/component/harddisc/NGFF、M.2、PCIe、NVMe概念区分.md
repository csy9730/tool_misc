# NGFF、M.2、PCIe、NVMe概念区分


[JosephDHF](https://www.jianshu.com/u/ac0cbb4e8841)关注

0.7042017.10.10 14:33:33字数 231阅读 132,880

故障现象:
对于NGFF/M.2、PCIe、NVMe等概念的说明。解决方案:
NGFF (Next Generation Form Factor) ，顾名思义，是物理外形(Form Factor)的标准。与 NGFF 并列的是 2.5"，而不是 PCIe。（另外 NGFF 现在已经改名为M.2 了，大家最好与时俱进，改称为M.2。）
PCIe 是总线标准，与SATA 并列。
NVMe是硬盘新的传输标准，是取代现在的AHCI的。
为什么人们总是把 NGFF/M.2 与 PCIe/NVMe 联系/等同起来呢？这是因为在笔记本上，M.2 外形的 SSD 最先支持 PCIe 总线。但其实 M.2 有 SATA 和 PCIe 两种总线标准。2.5" 也有 SATA 和 PCIe 两种总线标准。下面列出了一些市面上的代表性产品，方便大家比较：

![img](https://upload-images.jianshu.io/upload_images/2320469-a144d133a3e55f8d.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/847/format/webp)

http://attach.51nb.com/forum/201604/04/071512ry0ob4ulblqlopbq.png.thumb.jpg


总线需要芯片级的支持，目前用六代平台(Skylake)的 ThinkPad，一些型号是支持 PCIe SSD 的。但不同的型号，有不同的支持组合。
我们可以通过Reference来查询，
如T460p，在Storage里面显示，2.5”的SSD硬盘支持SATA总线和PCIe总线，速度分别为6.0Gb/s和16Gb/s（没有支持M.2接口的SSD）

![img](https://upload-images.jianshu.io/upload_images/2320469-f0c198ca496d8b82.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/1020/format/webp)


如X1 carbon 4th，在Storage里面显示，M.2 SSD支持SATA和PCIe总线（没有支持2.5”硬盘）

![img](https://upload-images.jianshu.io/upload_images/2320469-b54a9df773a4e501.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/1016/format/webp)


[**Reference下载地址>>**](https://link.jianshu.com/?t=http://www.lenovo.com/psref/)
那么，我们该如何记忆ThinkPad各种型号支持什么样的硬盘呢？
1、区分物理外形标准，外形都不对肯定是用不了的。
2.5”硬盘（包括HDD和SSD）还得注意厚度，一般为9.5mm和7mm，如果机器支持9.5mm的，也能支持7mm，有螺丝固定，反过来则不行，塞不进去啊
M.2硬盘都是SSD，有4种长度，宽度都一样为22mm，所以有： 22x42mm、22x60mm、22x80mm和22x110mm，ThinkPad目前没有支持22x60mm和22x110mm的
（课外知识：目前WiFi/BT网卡为22x30mm、WWAN网卡为22x42mm，也是M.2接口，因为这只是物理外形接口，所以网卡和硬盘都可用，早期机器的WWAN的M.2接口同时也支持SATA总线，所以可以支持SSD，新款机器的不支持SATA总线，所以WWAN网卡不能使用SSD；据说是因为新机型可以支持4G，4G就不能和SATA总线共存，早期的是3G，可以与SATA共存）
2、区分总线标准和接口速度，不同的总线决定了不同的速度。
SATA有三代，SATAⅠ速度为1.5Gb/s，SATAⅡ速度为3.0Gb/s，SATAⅢ速度为6.0Gb/s；由于这三代都互相兼容，当用户咨询的时候，如果记不住主板支持情况，就建议买SATAⅢ就行，速度向下兼容（SATAⅢ普遍也不贵）
PCIe也分为PCIe3.0和2.0，以及有x4和x2的区别（总线数为4和2），PCIe 3.0 x4速度为32Gb/s，PCIe 3.0 x2速度为16Gb/s，PCIe 2.0 x4速度为20Gb/s，PCIe 2.0 x2速度为10Gb/s，也是向下兼容
3、快速记忆法！快速记忆法！快速记忆法！
2014-15机型（50系列）：

![img](https://upload-images.jianshu.io/upload_images/2320469-51415121b160122b.png?imageMogr2/auto-orient/strip|imageView2/2/w/730/format/webp)


2015-15机型（60系列）

![img](https://upload-images.jianshu.io/upload_images/2320469-a6b24750e95e2561.png?imageMogr2/auto-orient/strip|imageView2/2/w/648/format/webp)


另外，关于NVMe，记忆比较方便，50系列的都不支持，60系列的，支持PCIe的就支持；2.5”硬盘厚度没有规律，反正7mm肯定能用。



[http://iknow.lenovo.com/detail/dc_148269.html](https://link.jianshu.com/?t=http://iknow.lenovo.com/detail/dc_148269.html)