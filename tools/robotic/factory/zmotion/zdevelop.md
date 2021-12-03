# ZDevelop
产品名称：ZDevelop

规 格：ZDevelop开发软件

ZDevelop是Zmoiton系列运动控制器的PC端程序开发调试软件，通过它用户能够很容易的对控制器进行配置，快速开发应用程序以及对运动控制器正在运行的程序进行实时调试。

[正运动技术-《ZDevelop使用手册V2.72》.pdf](http://www.zmotion.com.cn/upload/%E6%AD%A3%E8%BF%90%E5%8A%A8%E6%8A%80%E6%9C%AF-%E3%80%8AZDevelop%E4%BD%BF%E7%94%A8%E6%89%8B%E5%86%8CV2.72%E3%80%8B.pdf)



## install
分为上位机pc和下位机设备。

### pc环境

| **参数/说明** | **最小要求**                    | **推荐使用**                              |
| ------------- | ------------------------------- | ----------------------------------------- |
| CPU           | Pentium 级别处理器, 主频 450MHz | Pentium级别处理器, 主频1GHz               |
| 内存大小      | 64 MB                           | 256MB                                     |
| 硬盘剩余空间  | 20MB                            | 100MB                                     |
| 操作系统      | Windows 98, Windows xp          | Windows xp or win7.                       |
| 显示器        | 800 x 600 / 256 彩色            | 1024 x 768 / 24位真彩色                   |
| 通讯接口      | RS232 串行口                    | RS232串行口/USB/以太网口(可以通过HUB转接) |

### device

ZMC控制器。
## overview
### feature

ZBASIC+PLC+HMI的一体化开发环境
- 支持ZMC ZSimu脱机仿真, 随时随地开发调试
- 支持相关参数示波器波形诊断分析
- 支持手动运行、寄存器、IO、AIO等在线调试
- 支持断点设置、逐语句、逐过程等单步程序调试
- 在线命令与输出、状态查询等
- 简单易上手、快速开发应用


### arch

软件平台包括：
- 脚本IDE(ZDevelop.exe)
- 设备链接器/烧录器
- 仿真器 (zsimu.exe)

### file arch

- exe
  - ZDevelop.exe
  - zsimu.exe
- dll
  - ZLexer.dll
  - zmotion.dll
  - ZmotionCad.dll
  - ZMotionPlc.dll
  - zsyntax.dll

#### IDE


![1589172391154432.png](http://www.zmotion.com.cn/upload/20200511/1589172391154432.png)



#### 设备链接器
ZDevelop支持串口和以太网连接到控制器，“自动连接”会自动检查本计算机的串口，并链接到第一个可以连接的串口。

USB链接会自动生成虚拟串口，选择串口号来连接即可。

当串口列表下拉选择时，会自动列出本计算机上可用的串口号； IP地址列表下拉选择时，会自动查找当前局域网可用的控制器IP地址。

控制器串口默认参数：波特率38400，数据位8，停止位1，校验位无。
![图片2.png](http://www.zmotion.com.cn/upload/20200511/1589172441554860.png)


#### 仿真器ZSimulator

支持离线仿真，在无控制器情况下可以用。

通过 “控制器”-“连接到仿真器”菜单可以自动启动仿真器，当仿真器启动后可以通过IP地址“127.0.0.1”来连接。

当程序为hmi工程时，点击“显示”来实现hmi界面仿真。

![图片4.png](http://www.zmotion.com.cn/upload/20200511/1589172620731335.png)

### doc


| 名称                                         | 版本号   | 格式 | 大小   | 下载                                                         |
| :------------------------------------------- | :------- | :--- | :----- | :----------------------------------------------------------- |
| ZDevelop编程软件V3.00.02                     | V3.00.02 | ZIP  | 28.12M | [Download](http://www.zmotion.com.cn/upload/ZDevelop3.00.02.zip) |
| 正运动技术-《ZDevelop使用手册V2.72》         | V2.72    | PDF  | 2.36M  | [Download](http://www.zmotion.com.cn/upload/正运动技术-《ZDevelop使用手册V2.72》.pdf) |
| 正运动技术-《ZDevelop使用手册V3.00.01》      | V3.00.01 | PDF  | 4.80M  | [Download](http://www.zmotion.com.cn/upload/正运动技术-《ZDevelop使用手册V3.00.01》.pdf) |
| 正运动技术-《ZBasic编程手册V3.2.5》          | V3.2.5   | PDF  | 14.9M  | [Download](http://www.zmotion.com.cn/upload/正运动技术-《ZBasic编程手册V3.2.5》.pdf) |
| 正运动技术-《ZMotion PLC编程手册V2.0.0》     | V2.0.0   | PDF  | 9.57M  | [Download](http://www.zmotion.com.cn/upload/正运动技术-《ZMotion%20PLC编程手册V2.0.0》.pdf) |
| 正运动技术-《ZHMI编程手册V2.0.0》            | V2.0.0   | PDF  | 5.17M  | [Download](http://www.zmotion.com.cn/upload/正运动技术-《ZHMI编程手册V2.0.0》.pdf) |
| 正运动技术-《ZMotion PC函数库编程手册 V2.1》 | V2.1     | PDF  | 9.96M  | [Download](http://www.zmotion.com.cn/upload/正运动技术-《ZMotion%20PC函数库编程手册%20V2.1》.pdf) |
| 正运动技术-《机械手指令说明v2.6》            | V2.6     | PDF  | 3.59MB | [Download](http://www.zmotion.com.cn/upload/正运动技术-《机械手指令说明v2.6》.pdf) |

