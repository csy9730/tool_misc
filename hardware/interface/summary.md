# summary

SATA 
USB
SPI

#### 集线器
“集线器组成的星型结构”，只是看起来他好像是星型的。他在逻辑上实际就是总线结构。集线器你就把他看成一根总线就完事了。

不要再纠结csma/cd了，这是上世纪的技术。如今从快速以太网开始，采用全双工模式，干掉了冲突域。有数据直接转发即可，无需侦听线路电压。

无线局域网是CSMA/CA。

#### 总线型结构 vs 星型
总线结构是指各工作站和服务器均挂在一条总线上，各工作站地位平等，无中心节点控制，公用总线上的信息多以基带形式串行传递，其传递方向总是从发送信息的节点开始向两端扩散，如同广播电台发射的信息一样，因此又称广播式计算机网络。各节点在接受信息时都进行地址检查，看是否与自己的工作站地址相符，相符则接收网上的信息。

总线型结构的网络特点如下：结构简单，可扩充性好。当需要增加节点时，只需要在总线上增加一个分支接口便可与分支节点相连，当总线负载不允许时还可以扩充总线；使用的电缆少，且安装容易；使用的设备相对简单，可靠性高；维护难，分支节点故障查找难。


个人理解： 总线型，无时无刻都是广播，所有结点对等；星型拓扑，中心结点比周围结点有更高的带宽能力，周围结点会有独享中心的结点的错觉。

#### 485总线冲突
485总线冲突如何避免？

差分电压在±0.2V范围内，大部分phy是不定态，没法用来做冲突检测

主要还是软件做啦，一般轮询从机地址进行分时通信吧

#### RS485多主的方法
RS485多主的方法？

多主机通信也可以，采用时间片轮转方法。每个设备单独的时间片

每一帧数据的字节数不要太多，因为485波特率不高，每帧字节数多的话，占用的总线时间就长，容易在多主系统中造成冲突。

#### USB 以太网
协议栈太大不是主要原因，以太网协议栈也不小，但在通信行业的应用远远多于USB具体原因有以下几点：1、USB通信距离太短（抗干扰能力太弱），只有5米，RS232通信距离是10米,RS232可以扩展到RS485通信距离是1000米。2、USB不是对等协议，USB协议要求所有请求必须由主机发起，设备只能被动接受控制，设备与设备之间无法直接通信（比如USB键盘和USB鼠标是无法互相通信的），而RS232则是一个对等协议，通信行业更多的时候要求的是对等通信（比如以太网也是对等协议）。3、USB协议栈太大了，当然大小只是一方面，以太网的协议栈规模并不小，所以有人说USB协议栈太大，这是一个因素，但不是最关键的地方，前两条原因才是。


#### SDIO

SDIO是SD型的扩展接口，除了可以接SD卡外，还可以接支持SDIO接口的设备，插口的用途不止是插存储卡。支持 SDIO接口的PDA，笔记本电脑等都可以连接象GPS接收器，Wi-Fi或蓝牙适配器，调制解调器，局域网适配器，条型码读取器，FM无线电，电视接收 器，射频身份认证读取器，或者数码相机等等采用SD标准接口的设备。

#### GPIO
GPIO (General Purpose Input Output 通用输入/输出)或总线扩展器，利用工业标准I2C、SMBus或SPI接口简化了I/O口的扩展。

当微控制器或芯片组没有足够的I/O端口，或当系统 需要采用远端串行通信或控制时，GPIO产品能够提供额外的控制和监视功能。每个GPIO端口可通过软件分别配置成输入或输出。Maxim的GPIO产品线包括8端口至28端口的GPIO，提供推挽式输出或漏极开路输出。提供微型3mm x 3mm QFN封装。
