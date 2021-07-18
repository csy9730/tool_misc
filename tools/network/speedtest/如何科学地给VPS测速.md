# 如何科学地给VPS测速

2021年3月11日

[https://www.vpsbros.com/vps%E6%B5%8B%E9%80%9F/](https://www.vpsbros.com/vps%E6%B5%8B%E9%80%9F/)

## 你所知道的VPS测速方法可能并不可靠

我个人不喜欢用网上流传的各种“VPS测速脚本”，有3个原因：

- 可能不安全，这些脚本分布在各种乱七八糟的个人网站上，直接把shell代码curl/wget进bash是不明智的，即使脚本放在github，我也没有义务去100%信任，代码背后还是人
- 源脚本的更新频率比主流Linux包管理系统里的benchmark工具快不到哪里去，对我来说一个sysbench测CPU、磁盘IO、内存足够，依赖3方脚本画蛇添足
- 一些脚本里把简单数一数/proc/cpuinfo里的内核数叫“CPU测速”，可见脚本作者对服务器测速的理解根本是一知半解的，但这么低质的工具却反复出现在很多VPS博主的推荐清单里

我也不相信任何厂商提供的所谓测速（speedtest）节点，并不一定说厂商故意骗我（尽管这种可能性在小厂身上太常见），但并不是主要的。VPS厂商提供的测试节点不可靠，还因为测试节点的配置不透明也不开放，你测不到磁盘IO性能这样非常关键的方面，另外，因为IP长期暴露容易受到各种干扰，也还是有配置不透明，测出来的结果也缺乏代表性。所以笔者从不依赖测试节点的评测数据，我宁可自己买一台试用，先测再用，这是笨办法，但很可靠。

## 磁盘IO、CPU、内存

测这些东西sysbench一个工具足矣，用起来很简单，使用方法可以参考`sysbench --help`或参考[网上资料](https://www.howtoforge.com/how-to-benchmark-your-system-cpu-file-io-mysql-with-sysbench)。以磁盘IO测速为例，下面是一个例子，命令都是最简单的 `sysbench fileio prepare; sysbench fileio --file-test-mode=rndrw run;`

这是一台4核8G国内某云计算厂深圳节点的服务器的测速结果：

```
File operations:
    reads/s:                      718.79
    writes/s:                     479.19
    fsyncs/s:                     1522.55

Throughput:
    read, MiB/s:                  11.23
    written, MiB/s:               7.49

General statistics:
    total time:                          10.0003s
    total number of events:              27217

Latency (ms):
         min:                                  0.00
         avg:                                  0.37
         max:                                 25.48
         95th percentile:                      0.97
         sum:                               9978.72

Threads fairness:
    events (avg/stddev):           27217.0000/0.00
    execution time (avg/stddev):   9.9787/0.00
```

这是一台单核2G国外某知名VPS供应商硅谷节点的fileio测速结果：

```
File operations:
    reads/s:                      4249.99
    writes/s:                     2833.39
    fsyncs/s:                     9066.85

Throughput:
    read, MiB/s:                  66.41
    written, MiB/s:               44.27

General statistics:
    total time:                          10.0079s
    total number of events:              161523

Latency (ms):
         min:                                    0.00
         avg:                                    0.06
         max:                                    5.16
         95th percentile:                        0.16
         sum:                                 9923.94

Threads fairness:
    events (avg/stddev):           161523.0000/0.00
    execution time (avg/stddev):   9.9239/0.00
```

一个VPS厂商的磁盘IO速度我认为是很能说明问题的，因为磁盘IO直接决定绝大多数应用的基础性能，服务商的技术架构、销售模式、管理水平多少都体现在上面了。上面的结果虽然只是单次测速，但它是一个让VPS用户无法忽视的结果，这种情况也是很多时候做[VPS推荐](https://www.vpsbros.com/)容易翻车的原因，VPS分了多少个CPU核心，多少G内存，多少G硬盘是可见的，而其它很多东西对普通用户来说就不是这么一目了然了，这就是很多VPS老玩家挂在嘴边的“这行的水很深”。

## 网络测速

- 本机[Ping](https://www.runoob.com/linux/linux-comm-ping.html)：判断一台VPS服务器适不适合架设某些应用，最直接的方法是在24小时内取几个时间点从本机多次Ping一下（先确定服务器[ICMP协议](https://baike.baidu.com/item/ICMP)已打开），观察返回结果，观察延迟和Ping通率，延迟过高（>250ms）或Ping通率过低（<80%）的服务不必考虑
- 本机[SSH](https://www.cnblogs.com/ftl1012/p/ssh.html)：SSH连接质量决定你的VPS以后管理起来方不方便，不是Ping质量高的主机SSH质量都高，网络干扰是一个很大的变量，笔者用过Ping起来通畅但一连SSH就断线的主机，也用过几个月都难得掉线的VPS，为什么会这样到现在都是个迷
- [SCP](https://www.cnblogs.com/no7dw/archive/2012/07/07/2580307.html)/[SFTP](https://www.digitalocean.com/community/tutorials/how-to-use-sftp-to-securely-transfer-files-with-a-remote-server)下载：在VPS上[建一个大文件](https://blog.csdn.net/cywosp/article/details/9674757)，用SCP/SFTP下载，前面你已经确认过SSH连接质量，SCP/SFTP下载是基于SSH加密链路的，所以下载本身应该没问题，只需要观察下载速度，太慢的VPS不考虑，怎么才算太慢呢？观看720P在线流媒体所需最小带宽约为2.5Mbps（约合320KB/s），保守一点加一倍，也就是说你没有640KB/s的下载速度可能无法“流程”观看，仅做参考。用SCP/SFTP下载测速可能比任何其他途径都可靠，因为第一这是真正的实机实线测试，不是什么测试节点，第二SCP/SFTP（加密）下载和真实的网络传输很接近，通过http协议测出的下载速度并不能代表实际网络流量方式
- SCP/SFTP上传：如果你打算拿VPS当网盘，上传速度也无法忽略，仍然用SCP/SFTP测试，你可以在命令行操作，也可以用客户端如：[WinSCP](https://winscp.net/)

## 综合测速

上面的测试都通过以后，你不妨把应用装上。如果是网站，你可以用[WebPageTest](https://www.webpagetest.org/)，[GTMetrix](https://gtmetrix.com/)，[ChinaZ](https://tool.chinaz.com/speedtest)等工具，不过要注意，能影响网站综合速度的因素很多，服务器速度只是其中之一，确保你理解这一点；如果是非HTTP协议上的应用，你应该用对应的客户端在实际使用中观察速度。综合测速是最终知道你的VPS与所架设的应用间匹配度的最终办法。笔者一般会在多台待选VPS上装上相同应用，对比测试过后择优购买。