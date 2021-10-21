# 玩转CODESYS 入门篇-- 认识CODESYS

勇哥2020/7/7注：



目前codesys + EtherCAT驱动 做运动控制很有优势。现在总线式运动控制基本都是这种配置。 

Codesys 号称PLC界的安卓，国内造PLC的 基本都用Codesys内核了。

如：汇川 ，合信，  和利时 ，英威腾，  台达。  

包括国外的： 倍福TC2  施耐德Somachine  力士乐 等等都是Codesys



直观的讲codesys是一个已经写好了运动控制和通讯的软件PLC。

例如：树苺派刷一个Codesys的Runtime应用就可以用Codesys编程当PLC跑程序了。



运动控制中PLCOpen协议是一种PLC的编程规范，博图的运动控制用的也是PLCOpenMotion，而Codesys支持PLCopen规范。

另外Codesys还有对高级语言的支持，例如在Codesys里可以调用C++函数程序。

再比如，Codesys还可以定义多任务，类似于高级语言的并行计算。 





以下为正文================================================



**认识CODESYS**

CODESYS 是什么？

CODESYS是一款工业自动化领域的一款开发编程系统，应用领域涉及工厂自动化、汽车自动化、嵌入式自动化、过程自动化和楼宇自动化等等。CODESYS软件可以分为两个部分，一部分是运行在各类硬件中的RTE（Runtime Environment），另一部分是运行在PC机上的IDE。因此CODESYS的用户既包括生产PLC、运动控制器的硬件厂商，也包括最终使用PLC、运动控制器的用户。



目前全球有近400家的控制系统生产制造商是CODESYS的用户：如ABB、施耐德电气SchneiderElectric、伊顿电气EATON、博世力士乐Rexroth、倍福BECKHOFF、科控KEBA、日立HITACHI、三菱自动化MITSUBISHI、欧姆龙OMRON、研华科技、凌华科技ADLINK、新汉电脑、和利时集团、SUPCON 中控集团、步科自动化KINCO、深圳雷赛、汇川技术、深圳合信、深圳英威腾、华中数控、固高科技等等。



**CODESYS 可以做什么？**

这里介绍的CODESYS主要指的是CODESYS上位开发程序，也就是下图中Engineering Level的部分。



![image.png](http://www.skcircle.com/zb_users/upload/2018/12/201812161544959720115330.png)

从图中可以看到，我们从CODESYS Store中下载的CODESYS程序，其中主要包含了IEC61131-3语言的编辑器、编译器、调试器、工程配置工具等。可以实现的功能有MOTION + CNC、可视化、总线、安全等。用户使用IEC语言编写程序，就可以实现运动控制、可视化等等功能。程序经过编译下载到控制器的Runtime中，就可以对设备进行控制。



**CODESYS有什么优势？**

**1.全部功能都集成在一个单一的用户界面**

包含全部IEC 61131-3的语言：SFC（顺序功能图）、LD（梯形图）、FBD（功能块）、ST（结构化文本）、IL（指令表)，支持从经典PLC编程到面向都对象编程。

全面的功能，方便工程和自动化应用的调试。

为系统化应用程序开发提供可选的附加模块。

可以对绝大多数工业现场总线系统或制造商特定的I / O系统进行组态和调试。

可选的附加组件可以无缝集成到工程中。

安装、维护和培训只需要一个用户界面。

**2.为今后的自动化任务提供开放的选择**

来自著名制造商的数百台自动化设备可通过CODESYS开发系统进行编程。

提供SoftPLC系统的标准平台。

在现有开发环境和过程中轻松连接。

**3.强大的实施复杂自动化项目的能力**

快速运行的机器代码，用于不同复杂的设备和应用程序。

用于计算3D CNC /机器人，以及3D可视化的强大工具。

丰富的可扩展功能

可重用程序代码的库的概念

**4.该系统已在工业领域被可靠和广泛的使用**

CODESYS同类产品

CODESYS是全球为数不多进行软件PLC开发的，类似的公司还有KW（已更名为菲尼克斯软件），infoteam等等。



结语

希望大家能通过本文简短的介绍，对CODESYS软件有一个基本的了解。更加详细的信息可以登录CODESYS的官方网站[www.codesys.com进行了解。](http://www.codesys.xn--com-3h9d345x28bs9p./)





**CODESYS下载方式**



CODESYS上位编程软件（也就是IDE）有两种获取的方式。第一种是在CODESYS官方商店下载安装程序，网址为 store.codesys.com 。因为该步骤比较繁琐，不想在商店下载的用户可以采取第二种方式“从百度网盘获取安装程序”



在CODESYS官方商店下载安装程序

CODESYS商店的网站：store.codesys.com 。

从百度网盘获取安装程序

我已经下载好了CODESYS的安装程序，现在通过百度网盘进行分享，感觉注册CODESYS账户有困难的用户可以使用百度网盘下载安装程序。



[CODESYS 3.5.9.20 下载地址](https://pan.baidu.com/s/1gfBM9Lx)



[CODESYS 3.5.9.30 下载地址](http://pan.baidu.com/s/1qY4ICAK)



[CODESYS 3.5.9.40 下载地址](https://pan.baidu.com/s/1slW0X21)



[CODESYS 3.5.9.50 下载地址](https://pan.baidu.com/s/1bpghfOV)



[CODESYS 3.5.10.0 下载地址](http://pan.baidu.com/s/1dES8E8D)



# 安装CODESYS

我们获取了CODESYS的安装程序，图标如下图所示：

![image.png](http://www.skcircle.com/zb_users/upload/2018/12/201812161544960225461339.png)

安装方式比较简单，一路往下NEXT即可。

此时在桌面上会出现CODESYS的图标，任务栏右侧会出现两个托盘，左侧的是Gateway，右侧的是PLC。

![image.png](http://www.skcircle.com/zb_users/upload/2018/12/201812161544960287256362.png)



\--------------------- 

作者：QueenB_is_Mine 

来源：CSDN 

原文：https://blog.csdn.net/weixin_36315396/article/details/53215335 

版权声明：本文为博主原创文章，转载请附上博文链接！


  