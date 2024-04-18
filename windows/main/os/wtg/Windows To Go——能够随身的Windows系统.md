# Windows To Go——能够随身的Windows系统

[![MaxYuan](https://pic1.zhimg.com/v2-0bb7795a927f6bdcb8a4e79c774da934_l.jpg?source=172ae18b)](https://www.zhihu.com/people/yzx-19-44)

[MaxYuan](https://www.zhihu.com/people/yzx-19-44)![img](https://picx.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a.jpg?source=88ceefae)

Guess it！

41 人赞同了该文章



Windows To Go，简称WTG。在广义上，所有装载在可移动介质中的Windows系统都可称作WTG。WTG十分实用，在遇到小容量电脑/在他人电脑工作时，都可以使用。

## 1 WTG的硬件要求

微软官方对存储WTG的可移动介质提出的最低硬件要求是接口为USB2.0及以上，硬盘容量大于等于32G。但这只是一个理论硬件要求，即如果你使用USB2.0+32GB的U盘装WTG，可以启动，但速度等问题....emmmmm，一言难尽。为了使WTG用户在选择可移动设备时有方向可循，微软官方认证了一些第三方USB存储器。如：

![img](https://pic3.zhimg.com/80/v2-239390aff6a73c68e13f217499ef5bbe_720w.webp)

同样是金士顿，USB3.2+64GB售价926元

价格难绷，所以我们在此并不一定需要完全遵照微软的指示操作，而是可以使用自己的固态硬盘/机械硬盘进行安装。比如说我做WTG的这款PSSD，售价478元，USB3.2-Gen2（转接）+500GB。这，不比上面那款性价比高吗？

![img](https://pic1.zhimg.com/80/v2-592f31954ec156ec900f14bb5d9d2e5c_720w.webp)

实际上，笔者认为，选择装载WTG的可移动磁盘的标准，应该是AS SSD这类老牌跑分软件的跑分得分情况。还是以我的磁盘为例，AS-SSD跑分结果如下：

![img](https://pic4.zhimg.com/80/v2-d74ce57efcbf3609266453ea0c53b89b_720w.webp)

这种分数下，WTG十分流畅，几乎和装在本机SSD中无差别。一个硬指标，是4K一行两个数据最好都大于2MB/s。

## 2 安装过程和安装注意事项

**不要使用Bitlocker加密，否则可能会进不去系统。**

**不要在运行WTG的时候贸然拔掉WTG的U盘，否则可能会造成蓝屏/文件损坏/U盘损坏。**

接下来我们通过实操，过一遍WTG的安装流程。

![img](https://pic1.zhimg.com/80/v2-7bde6c96f06017ed25db8e0f769034f8_720w.webp)

打开Diskgenius，右键你将要做WTG的磁盘，选择删除所有分区。然后选择“是”，点击窗口左上角的“保存更改”。

![img](https://pic3.zhimg.com/80/v2-45e4feda8292582ee8b5c19a8497d83e_720w.webp)

然后点击“快速分区”，在分区数目一栏选择自定，输入分区数量为1。当然，你也可以选择多个分区，这无伤大雅。然后**取消**勾选创建MSR分区一项，勾选“对齐分区到此扇区的整数倍“项，即4K对齐。

完成后，自动格式化，你将会得到一个卷标为Windows的新NTFS空磁盘。接下来有不少于3种方法安装WTG，我将分3节对常用的3种方法分别进行介绍。

### 2.1 官方WTG工具安装法

该方法仅适用于Win8、Win8.1、Win10-1607～2004教育版和专业版非精简系统的用户。

Windows+S打开索引，输入Windows To Go，选择索引出的程序。

![img](https://pic1.zhimg.com/80/v2-f365cd95f5dfe9440ef8bb82b7fbf528_720w.webp)

在该界面选择好自己的WTG设备，无脑下一步即可。底下的警告不用管，各位读者自己买的硬盘不仅性价比比微软认证的高，性能也比它们强。

直接双击挂载你的iso镜像文件，然后在下面窗口中选择“添加搜索位置”，选择自己挂载的iso镜像盘符，然后可以选择版本。注意一定要是企业版镜像，否则会提示“只能使用Windows10企业版创建WTG工作区”。

![img](https://pic3.zhimg.com/80/v2-53420a01fab9e69e216f9adf0d45740a_1440w.webp)

刚刚强调过，不需要选择bitlocker，所以直接下一步。

![img](https://pic1.zhimg.com/80/v2-f146fbd5f746e30ed115b3227611a3fc_1440w.webp)

在最后一步点击“创建”等待创建完成，然后重启电脑U盘启动进入WTG。

可以发现，官方 WTG 工具在安装 WTG 时会有三个条件：

- 对 Windows 镜像要求非常严格，**必须为企业版**，否则无法安装。
- 对外置存储要求较高，不过这一点的话只要你使用的是高性能固态硬盘或者是 U 盘的话基本上可以无视，它们的性能不比认证的驱动器差。

### 2.2 Dism++释放镜像法

打开Dism++，选择文件，选择释放镜像。

![img](https://pic2.zhimg.com/80/v2-58baebaa2c38c562a113bd03b15997d9_1440w.webp)

然后在目标映像的下面一栏选择自己的iso镜像，在再下面一栏选择自己WTG的盘符路径。勾选WindowsToGo、添加引导、格式化。

![img](https://pic1.zhimg.com/80/v2-4e229c9ffca84c64fa58858f601c0144_1440w.webp)

然后点击确定，等待完成，完成后重启U盘启动进入WTG。

![img](https://pic2.zhimg.com/80/v2-f5f9c5b5d36ecbddaeb5a96a3ecd9989_1440w.webp)

### 2.3 第三方工具安装法

此处使用WTGA进行安装，下载地址：[https://dl.luobotou.org/wtga5610.zip](https://link.zhihu.com/?target=https%3A//dl.luobotou.org/wtga5610.zip)

打开工具，在镜像地址栏选择自己的iso镜像，工具会自动对其进行挂载。在第二栏选择自己的可移动磁盘。第三栏选择自己要安装的Windows 10版本（家庭版、专业版等）。右侧高级功能处，勾选UEFI+GPT和跳过OOBE两项，其他默认。使用这种方式部署的WTG**可以正常升级**。点击部署，等待安装完成，重启U盘启动进入WTG。

![img](https://pic3.zhimg.com/80/v2-0a27c186eafa190a57301caa4e8a0c1e_1440w.webp)

## 3 安装系统后需做的设置

如果你安装的是Win10的部分老系统（如Win10-LTSB2016），在第一次进入系统时你可以听到开机音效，没错，就是Win7的那种。如果没有听到，可以作为判定系统声卡未驱动的现象之一。进入系统之后先静置几分钟，不要睡眠，不要关闭显示器，笔记本不要合盖。此处静置不是为了沉淀不可溶杂质（doge），而是为了让系统自动安装一些没有安装的设备驱动。十分钟后重启一次，再静置十分钟，驱动安装基本完成。除苹果设备外，其他设备几乎不存在缺失驱动的现象，所以驱动精灵等都不需要，盲目安装驱动还有可能造成系统崩溃。

Win+X选择Windows Powershell（管理员）/命令提示符（管理员），输入powercfg -h off。该命令是用于关闭磁盘休眠功能的，这步操作主要是为了使WTG能够随意移动。

## 4 结语

咕咕咕~还有一点进阶没写完，但是6月我实在比较忙，本人自己也是比较懒的人，所以先这样，等到7月继续。（不想看到烂尾的我干脆删掉了没写完的章节）

WTG是比较简单但非常实用的一种技术。由于有用，所以分享整理在此；但是确实比较简单，所以文章很短。

以上。

编辑于 2023-06-03 10:01・IP 属地江苏

[Microsoft Windows](https://www.zhihu.com/topic/19552612)

[Windows 10](https://www.zhihu.com/topic/20007813)

[WTG系统](https://www.zhihu.com/topic/21670828)