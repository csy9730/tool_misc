# jlink仿真器

本词条缺少**概述图**，补充相关内容使词条更完整，还能快速升级，赶紧来编辑吧！

J-Link是SEGGER公司为支持仿真ARM内核[芯片](https://baike.baidu.com/item/%E8%8A%AF%E7%89%87/32249)推出的[JTAG仿真器](https://baike.baidu.com/item/JTAG%E4%BB%BF%E7%9C%9F%E5%99%A8/10107172)。配合IAR EWAR，ADS，KEIL，WINARM，RealView等集成开发环境支持所有ARM7/ARM9/ARM11,Cortex M0/M1/M3/M4, Cortex A5/A8/A9等内核芯片的仿真，与IAR,Keil等编译环境无缝连接，操作方便、连接方便、简单易学，是学习开发ARM最好最实用的开发工具。产品规格：电源USB供电，整机电流 <50mA 支持的目标板电压 1.2 ～ 3.3V，5V兼容 目标板供电电压 4.5 ～ 5V (由USB提供5V) 目标板供电电流 最大300mA，具有过流保护功能 工作环境温度 +5℃～ +60℃ 存储温度 -20℃ ～ +65℃ 湿度 <90%尺寸（不含电缆） 100mm x 53mm x 27mm 重量（不含电缆）70g 电磁兼容 EN 55022, EN 5502 。



- 中文名

  jlink仿真器

- 外文名

  jlink simulator

- 公    司

  SEGGER

- 整机电流

  <50mA

- 电    源

  USB供电

## 目录

1. 1 [仿真器简介](https://baike.baidu.com/item/jlink%E4%BB%BF%E7%9C%9F%E5%99%A8/10410763#1)
2. 2 [主要特点](https://baike.baidu.com/item/jlink%E4%BB%BF%E7%9C%9F%E5%99%A8/10410763#2)
3. 3 [J-Link版本](https://baike.baidu.com/item/jlink%E4%BB%BF%E7%9C%9F%E5%99%A8/10410763#3)



## 仿真器简介

编辑

 语音

J-LINK仿真器目前已经升级到V9.50[版本](https://baike.baidu.com/item/%E7%89%88%E6%9C%AC/505574)，其[仿真速度](https://baike.baidu.com/item/%E4%BB%BF%E7%9C%9F%E9%80%9F%E5%BA%A6/53324988)和功能远非简易的并口WIGGLER调试器可比。J-LINK支持[ARM7](https://baike.baidu.com/item/ARM7/8475039)/[ARM9](https://baike.baidu.com/item/ARM9/2220517)/ARM11,Cortex M0/M1/M3/M4, Cortex A4/A8/A9等内核芯片，支持ADS、IAR、KEIL[开发环境](https://baike.baidu.com/item/%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83/10119007)。V9.3版本较V8.0版本进一步提升了下载速度，最大下载速度提升到1 MByte/s。



## 主要特点

编辑

 语音

\* IAR EWARM集成开发环境无缝连接的[JTAG仿真器](https://baike.baidu.com/item/JTAG%E4%BB%BF%E7%9C%9F%E5%99%A8/10107172)。

*支持CPUs: Any ARM7/9/11, Cortex-A5/A8/A9, Cortex-M0/M1/M3/M4, Cortex-R4, RX610, RX621, RX62N, RX62T, RX630, RX631, RX63N。

*下载速度高达1 MByte/s。

*最高JTAG速度15 MHz。

*目标板电压范围1.2V –3.3V,5V兼容。

*自动速度识别功能。

*监测所有JTAG信号和目标板电压。

*完全即插即用。

*使用USB电源（但不对目标板供电）

*带USB连接线和20芯扁平电缆。

*支持多JTAG器件串行连接。

*标准20芯JTAG仿真插头。

*选配14芯JTAG仿真插头。

*选配用于5V目标板的适配器。

*带J-Link TCP/IP server，允许通过TCP/ IP网络使用J-Link。

产品规格

电源： USB供电，整机电流< 50mA 。

[USB接口](https://baike.baidu.com/item/USB%E6%8E%A5%E5%8F%A3/493294)： USB 2.0全速12Mbps。

目标板接口： JTAG (20P)

支持的目标板电压： 1.2 – 3.3V，5V兼容。

目标板供电电压： 4.5 – 5V (由USB提供5V)

目标板供电电流： 最大300mA，具有过流保护功能。

工作环境温度： +5°C ... +60°C。

存储温度： -20°C ... +65 °C。

湿度： <90%

尺寸（不含电缆）： 100mm x 53mm x 27mm。

重量（不含电缆）： 80g。

电磁兼容： EN 55022, EN 55024。

| upported OS | Microsoft Windows 2000Microsoft Windows XPMicrosoft Windows XP x64Microsoft Windows 2003Microsoft Windows 2003 x64Microsoft Windows VistaMicrosoft Windows Vista x64Windows 7Windows 7 x64Windows 8Windows 8 x64LinuxMac OSX 10.5 and higher |
| ----------- | ------------------------------------------------------------ |
|             |                                                              |

| JTAG/SWD Interface, Timing   |              |
| ---------------------------- | ------------ |
| JTAG speed                   | Max. 15MHz   |
| SWO sampling frequency       | Max. 7.5MHz  |
| Data input rise time (Trdi)  | Trdi <= 20ns |
| Data input fall time (Tfdi)  | Tfdi <= 20ns |
| Data output rise time (Trdo) | Trdo <= 10ns |
| Data output fall time (Tfdo) | Tfdo <= 10ns |
| Clock rise time (Trc)        | Trc <= 3ns   |
| Clock fall time (Tfc)        | Tfc <= 3ns   |

**J-Link标准接口**

[![img](https://bkimg.cdn.bcebos.com/pic/e61190ef76c6a7ef04c82724f5faaf51f2de66c2?x-bce-process=image/resize,m_lfit,w_440,limit_1/format,f_auto)](https://baike.baidu.com/pic/jlink%E4%BB%BF%E7%9C%9F%E5%99%A8/10410763/0/e61190ef76c6a7ef04c82724f5faaf51f2de66c2?fr=lemma&ct=single)



## J-Link版本

编辑

 语音

J-Link Plus，J-Link Ultra， J-Link Ultra+, J-Link Pro，J-Link EDU， J-Trace等多个版本， 可以根据不同的需求来选择不同的产品。

J-Link为德国SEGGER公司原厂产品，目前在中国仅设有代理商，没有国产版本，购买J-Link后可以通过SEGGER官方网站或者SEGGER公司中国区代理商广州市风标电子联系认证是否为正版产品，以保障您的权益。