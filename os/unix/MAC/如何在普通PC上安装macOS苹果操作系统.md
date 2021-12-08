# 如何在普通PC上安装macOS苹果操作系统

[![臧大为](https://pic3.zhimg.com/v2-5ee9b7524d43ff2ec59b089862d5173b_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/davidtsang)

[臧大为](https://www.zhihu.com/people/davidtsang)

小白计划：http://51xbx.com



1,026 人赞同了该文章

**问题1**：macOS在普通电脑上运行稳定吗？

相当稳定。我的已经运行7~8年了。只是要小心升级，最好关闭自动更新，小版本可以升级，比如10.12.1升级10.12.2，大版本不要直接升级，很可能会导致无法启动。升级大版本先确保硬件兼容性，然后要用Unibeast制作好安装U盘，直接安装升级。

**问题2**：macOS普通电脑上安装困难吗？

如果你的硬件合适，那么可能最快30分钟就能安装完毕。如果你硬件恰好出现[兼容性](https://www.zhihu.com/search?q=兼容性&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A136662874})问题，可能捣鼓几天都捣鼓不好，所以这主要看人品。

**问题3：**什么样的电脑能安装macOS？

intel i3以上CPU，支持UEFI引导的主板（技嘉、华硕最佳），Intel HD4000以上或Nvida GT640/750/650/960以上显卡（macos 10.13及之前版本）或ATI RX560以上独立显卡（macos 10.14及之后版本)

首先检查你的显卡是否支持：

[臧大为：黑苹果macOS支持的显卡列表152 赞同 · 56 评论文章](https://zhuanlan.zhihu.com/p/139963444)

## 如何安装？

下面以在普通PC电脑上安装macOS 10.12为例（本文也提供了10.13及10.14的下载链接，安装方法基本相同）。

1、准备一个容量大于8GB的U盘

2、将安装镜像文件复制到U盘。
在苹果macOS上用Unibeast制作基于Clover的安装U盘，由于需要苹果macOS，所以我将制作好的系统盘做成了镜像文件，直接下载镜像到U盘即可。

2.1 下载[HDDRawCopy1.10Portable](https://www.zhihu.com/search?q=HDDRawCopy1.10Portable&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A136662874}).exe 链接: [https://pan.baidu.com/s/1CICKXlg_D9IvbPrfYKaSrw](https://link.zhihu.com/?target=https%3A//pan.baidu.com/s/1CICKXlg_D9IvbPrfYKaSrw) 提取码: 8dyh

2.2 下载macOS 10.12系统镜像文件，链接: [https://pan.baidu.com/s/1_e4_tgQGMGEbYUSFQcJaYA](https://link.zhihu.com/?target=https%3A//pan.baidu.com/s/1_e4_tgQGMGEbYUSFQcJaYA) 提取码: huj2

**补充1：** macOS 10.14 Mojave 系统镜像文件：链接: [https://pan.baidu.com/s/19OfY2ya09Sr_BYYO2nudLg](https://link.zhihu.com/?target=https%3A//pan.baidu.com/s/19OfY2ya09Sr_BYYO2nudLg) 提取码: tffz （基于Unibeast和原版macOS 10.14制作，10.14开始，苹果已经停止对nVidia显卡支持，必须配ATI RX560以上显卡或Intel显卡）

**补充2：**Z370等芯片主板可能用上个映像没问题，但是B360芯片等主板USB芯片不一样，会出现安装时鼠标键盘无法识别问题，请下载这个[映像macO](https://www.zhihu.com/search?q=映像macO&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A136662874})S 10.14 Mojave [usb fix](https://www.zhihu.com/search?q=usb+fix&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A136662874})：链接：[https://pan.baidu.com/s/15uBrlZdv_9c_BAqWGiD6PA](https://link.zhihu.com/?target=https%3A//pan.baidu.com/s/15uBrlZdv_9c_BAqWGiD6PA) 提取码：x4ki

**补充3:** macOS10.13 镜像 链接：[https://pan.baidu.com/s/100cEoc0Jd2RPTJ470aePgw](https://link.zhihu.com/?target=https%3A//pan.baidu.com/s/100cEoc0Jd2RPTJ470aePgw) 提取码：e0zr

2.3 解压下载的macOS 10.12镜像文件

2.4 运行HDDRawCopy1.10Portable.exe， 在选择sources界面，选择最下面的File列双击，打开文件打开对话框，然后选中下载解压好mac OS 10.12 imgc镜像文件，然后点击右下角的继续，在目标target界面，选择的你的U盘，然后点击继续，确认Sources是你下载的镜像和targer是你的U盘无误后，然后点击start，将文件复制进U盘。

搞不懂如何用这个软件？看视频教程：

<iframe title="video" src="https://video.zhihu.com/video/1243654251953668096?player=%7B%22autoplay%22%3Afalse%2C%22shouldShowPageFullScreenButton%22%3Atrue%7D" allowfullscreen="" frameborder="0" class="css-uwwqev" style="width: 688px; height: 387px;"></iframe>

HDDRawCopy视频教程



复制完毕后，U盘已经转换为[苹果磁盘](https://www.zhihu.com/search?q=苹果磁盘&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A136662874})格式，Windows或许会告诉你U盘无法识别，这是正常的。

2.5 主板BIOS设置

1. 磁盘模式设置为AHCI
2. 关闭快速启动
3. 关闭Intel VT-D技术
4. 关闭虚拟化技术(如[主板BIO](https://www.zhihu.com/search?q=主板BIO&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A136662874})S有这个选项）
5. USB的XHCI Hand-off更改为Enabled

2.6 将复制完毕的U盘，插入你需要安装系统的电脑，启动，按F12（[技嘉主板](https://www.zhihu.com/search?q=技嘉主板&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A136662874})，华硕主板F8，其他主板请查阅说明书或留意屏幕启动信息）选择引导选项，选择UEFI “你的U盘名字” 这个选择，回车。进入安装程序。

***提示：**如果你的硬盘是ntfs等win下面的格式，需要备份好数据，然后在安装界面菜单里的磁盘工具，将磁盘分成一个区，分区格式为GPT，磁盘格式为苹果HFS Plus格式。不要像Win下面那样分几个区。如果你要装双引导，请分区成两个区，但是只格式化其中一个为macOS安装位置，另外一个区在windows安装程序下再格式化安装。*

*如果你是从现有WIN下面安装，你需要为macOS找个一个空闲磁盘作为安装位置，容量应>100GB较为实用，你可以用Win自带的磁盘工具来压缩卷，腾出空间，新建一个简单卷。同时请确保安装盘存在>200mb的EFI磁盘分区。如果没有，请用磁盘精灵创建一个。*

2.7 安装完毕后不要拔掉U盘，安装程序会重启电脑，自动进入黑苹果引导界面，选择你安装的硬盘图标进入系统。

2.8 进入系统后，打开安装U盘查看内容：

![img](https://pic3.zhimg.com/80/v2-b47a9925397299e04ede4e8cf071d8e6_1440w.jpg)选择MultiBeast文件夹，运行MultiBeast程序

![img](https://pic3.zhimg.com/80/v2-8107715720dff9ca75e79dddb32c156a_1440w.jpg)选择Quick Start标签，然后点击UEFI Boot Mode图标

![img](https://pic2.zhimg.com/80/v2-2b25b145580b9aaa69907a07f1f5aec9_1440w.jpg)选择Drivers标签，对照你的主板配置，选择对应的声卡、网卡驱动，其他一般不用选，最后选择Build进行安装

2.9 等待MultiBeast安装完毕，拔掉安装U盘，重启电脑，现在应该可以正常启动及运行了。

祝你一切顺利！

如有技术疑问可以加群交流：1045026133

实践装机参考：

[臧大为：实战WIN10安装macOS 10.13到普通电脑55 赞同 · 47 评论文章![img](https://pic1.zhimg.com/v2-c7c111b3d2ac16f256b5fcdaeeff14d0_180x120.jpg)](https://zhuanlan.zhihu.com/p/139473184)

[臧大为：实战华硕B360主板RX580显卡安装苹果macOS 10.14 Mojave9 赞同 · 0 评论文章](https://zhuanlan.zhihu.com/p/138517930)



编辑于 2020-05-13 20:21

操作系统

macOS

黑苹果（Hackintosh）

赞同 1026

165 条评论

分享