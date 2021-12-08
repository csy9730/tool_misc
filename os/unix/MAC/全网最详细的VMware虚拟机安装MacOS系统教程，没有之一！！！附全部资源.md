# 全网最详细的VMware虚拟机安装MacOS系统教程，没有之一！！！附全部资源

[![xuan yang](https://pic2.zhimg.com/e9628690c_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/xuan-yang-12)

[xuan yang](https://www.zhihu.com/people/xuan-yang-12)





325 人赞同了该文章

一、准备工作

1.安装环境：

2.所需工具：

3.资源下载：

二、安装教程

三、优化

昨天给大家分享了VMware的安装教程，今天就给大家分享使用VMware安装MacOS系统的详细教程。

大部分Windows用户都想体验一下简洁易用的MacOS系统，但是如果Windows+MacOS双系统UEFI引导，安装黑苹果，如果没有好用的EFI，安装非常花费时间，那么可以使用VMware体验一把MacOS系统，当让也可以进行办公娱乐等等，只不过稍微有点卡，没有[固态双系统](https://www.zhihu.com/search?q=固态双系统&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A337036027})体验那么好。

OK！开始干！

## **一、准备工作**

因为VMware默认是不支持安装MacOS的，因此我们需要使用解锁工具解锁VMware。

### **1.安装环境：**

宿主机Windows 10 20H2 + 虚拟机VMware15.5（小e的安装环境）

Windows和VMware版本可以和小e不同，VMware安装教程小e已经分享过，若没有安装VMware，[见VMware安装教程！](https://link.zhihu.com/?target=https%3A//mp.weixin.qq.com/s%3F__biz%3DMzU4NDcxNjQ2Ng%3D%3D%26mid%3D2247489315%26idx%3D1%26sn%3D222d90fa2805b01fa408e2fea8844671%26chksm%3Dfd94cefecae347e8093dd537d564c00316abef92d2bdf2c7a47125d07ff404c7866607d09641%26token%3D956469501%26lang%3Dzh_CN%23rd)

### **2.所需工具：**

VMware解锁工具MK-Unlocker 或 Unlocker_v3.0.3 + MacOS Mojave 10.14懒人包

### **3.资源下载：**

**全部资源：**

```text
资源包括：
    1.解锁工具（MK-Unlocker + Unlocker_v3.0.3）
    2.MacOS镜像懒人包（MacOS Mojave 10.14.6懒人包 + MacOS Catalina10.15.5懒人包 ）
    3.优化卡顿工具（beamoff）

链接：https://pan.baidu.com/s/1UYK4e--BA8512pSD5Xl4qA 

提取码：zqrr 
```

如果不想下载全部，仅想下载部分资源。

**部分资源：**

**1.解锁工具（MK-Unlocker + Unlocker_v3.0.3）**

```text
链接：https://pan.baidu.com/s/1lXzyW2YRui_OJzVGtOWPJA 
提取码：txgp 
```

**2.MacOS镜像懒人包（MacOS Mojave 10.14.6懒人包 + MacOS Catalina10.15.5懒人包 ）**

```text
链接：https://pan.baidu.com/s/1tp-1DIRssL9WMOTmGyDQRw 
提取码：9e60 
```

**3.优化卡顿工具（beamoff）**

```text
链接：https://pan.baidu.com/s/1ceag0nXeBgv-OT_CkriXaQ 
提取码：y7vh 
```

## **二、安装教程**

首先安装VMware，VMware的安装小e在此就不赘述了，见之前VMware安装教程！

**注意：**

**安装完虚拟机后记得要在BIOS中开启intel VT（虚拟化），否则安装过程中会出错，提示“Intel VT-x处于禁用状态”。**

默认的VMware不支持识别和安装MacOS镜像，需要解锁，解锁前记得关闭杀毒软件以及windefender。

关闭虚拟机，解压解锁工具MK-Unlocker，以管理员身份运行[win-install.cmd]。

运行后会弹出dos命令窗口，等待运行完成，运行完成后会自动关闭窗口。

注：MK-Unlocker文件路径不能出现中文，否则会出现`Can't load frozen modules`的错误。

![img](https://pic2.zhimg.com/80/v2-dfba640e579d534d9ec54db816a32b29_1440w.jpg)

解锁后打开VMware15.5虚拟机，创建一个新的虚拟机。

![img](https://pic4.zhimg.com/80/v2-6c467796df43a96efa08e131b3aae197_1440w.jpg)

勾选[自定义（高级）]，下一步。

![img](https://pic4.zhimg.com/80/v2-c92875d9fd5b07eeabe33ba5e7cf3723_1440w.jpg)

硬件兼容性选择[Workstation 15.x]，下一步。

![img](https://pic1.zhimg.com/80/v2-c2c35c928cee189edf9a0d9bd8dd0ce8_1440w.jpg)

如果你下载小e打包的MacOS懒人包，那么下载的10.14的懒人包后缀为`.iso`，需要把`.iso`后缀改为`.cdr`，懒人包都是用原版镜像制作的。（也可以在网上自行找`.cdr`懒人包，那么忽略此步骤）

重命名，直接把iso后缀改为cdr即可。

![img](https://pic4.zhimg.com/80/v2-2cb4feae04b77d901a7fafabf177724b_1440w.jpg)

点击[浏览]，选择后缀为`.cdr`的懒人包，注意把右下角选择[所有文件]，选中后[打开]。

![img](https://pic4.zhimg.com/80/v2-e9dc8348baeba456c7e45ca6378997bb_1440w.jpg)

操作系统选择[Apple Mac OS X]，版本选择[macOS 10.14]，此为Vmware虚拟机解锁后的效果，如果前面没有解锁或者解锁失败，此处是没有[Apple Mac OS X]选择项的。

![img](https://pic3.zhimg.com/80/v2-f83e671a791410958b1a49bbd85f0cfa_1440w.jpg)

修改MacOS的安装位置，建议新建一个专门的文件夹，路径中不要出现中文。

![img](https://pic2.zhimg.com/80/v2-36c2b4d35167bf921334c7ad848fdd4d_1440w.jpg)

由于[小e笔记本](https://www.zhihu.com/search?q=小e笔记本&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A337036027})硬件为1个处理器，总共4核，因此给虚拟机设置1处理器和2个核的配置，大家按照自己的电脑实际配置自行设置。（宿主机处理器核配置可以在设备管理器中都能看到）

![img](https://pic4.zhimg.com/80/v2-459af6e96851ef6915624f56f02e84b7_1440w.jpg)

[小e宿主机](https://www.zhihu.com/search?q=小e宿主机&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A337036027})内存大小为16G，给虚拟机设置4G左右内存大小，按照自己电脑配置自行设置。（内存大小可以直接在任务管理器中查看）

![img](https://pic1.zhimg.com/80/v2-53105db40f364f098af6ba6c42e08ab4_1440w.jpg)

网络连接选择[使用[网络地址转换](https://www.zhihu.com/search?q=网络地址转换&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A337036027})]。

![img](https://pic2.zhimg.com/80/v2-e291240d63c69ccfed63bd37c7c6c52d_1440w.jpg)

使用默认推荐设置[LSI Logic]。

![img](https://pic2.zhimg.com/80/v2-ea4c764a010de873396275a00e1f5c7d_1440w.jpg)

硬盘类型选择推荐设置[SATA]。

![img](https://pic4.zhimg.com/80/v2-37a758ab0ca292bfa96c6d5d4405e377_1440w.jpg)

在虚拟机中安装系统需要创建[虚拟磁盘](https://www.zhihu.com/search?q=虚拟磁盘&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A337036027})用来安装操作系统，勾选[创建新虚拟磁盘]。

![img](https://pic1.zhimg.com/80/v2-0b3814465043f9b2383d95b3b19c0438_1440w.jpg)

虚拟磁盘大小自行设置，小e这里设置100G大小，其他默认。

![img](https://pic2.zhimg.com/80/v2-33b8c512a9d373c6ca60588dff978579_1440w.jpg)

配置完成，点击[完成]，配置好后先不要启动MacOS系统。

![img](https://pic2.zhimg.com/80/v2-7b2122b9eb2359aa58e2e826a458ca05_1440w.jpg)

找到MacOS的安装位置（上面步骤中已自行设置），使用记事本打开后缀为`.vmx`的[macOS [10.14.vmx](https://www.zhihu.com/search?q=10.14.vmx&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A337036027})]的文件。

![img](https://pic4.zhimg.com/80/v2-3ebd18c6001ab069a8f3696b5c198037_1440w.jpg)

在最后添加以下代码

```text
smc.version = 0
```

保存退出。

![img](https://pic4.zhimg.com/80/v2-9a95cea9702193596b456360f70190ff_1440w.jpg)

这时候[开启虚拟机]，启动MacOS系统。

![img](https://pic4.zhimg.com/80/v2-dd9e734a4b30bb6d6de39da799079153_1440w.jpg)

启动MacOS界面。

![img](https://pic3.zhimg.com/80/v2-f8b408655b4c8762cf8fe3b48a810f3e_1440w.jpg)

选择语言[简体中文]。

![img](https://pic1.zhimg.com/80/v2-f58634513965a6c3a4698cb5ef587790_1440w.jpg)

点击[[磁盘工具](https://www.zhihu.com/search?q=磁盘工具&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A337036027})]，如果没有此界面，可以在[实用工具]下找到。

![img](https://pic3.zhimg.com/80/v2-d290320fe4f732e7ee199b2594d8bd0e_1440w.jpg)

选择刚才新建的虚拟磁盘，因为MacOS和Windows磁盘大小的计算方式不一样，所以刚才设置的100G大小的虚拟磁盘在Mac中显示并不是100G，但是相差不大，选择近似的即可。

虚拟磁盘还好，不会对宿主机本地磁盘有影响，但是在黑苹果双系统安装中一定要仔细分辨出哪个是Windows的安装分区，哪个是MacOS安装分区，否则一旦抹掉，数据就会全部丢失，具体小e在双系统安装黑苹果教程中再谈！

选择正确磁盘后点击[抹掉]，相当于格式化磁盘。

![img](https://pic4.zhimg.com/80/v2-4e62caaffe93f6bc5e547af15f67329f_1440w.jpg)

名称自行设置，[格式]设置为[Mac OS扩展（日志式）]，方案为[GUID分区图]，点击[抹掉]。

![img](https://pic2.zhimg.com/80/v2-f2e71e9868860571e45271c0cf673949_1440w.jpg)

如果想对这块虚拟磁盘分区的话也可以点击分区，进行分区，小e在此使用一个分区为例，不再分区了。

![img](https://pic2.zhimg.com/80/v2-ee12dd0ec6702fb772b93741477866f5_1440w.jpg)

磁盘抹掉后关闭磁盘工具，点击[安装mac OS]。

![img](https://pic3.zhimg.com/80/v2-2475bab3b77205b0f51305d85692027a_1440w.jpg)

点击继续。

![img](https://pic1.zhimg.com/80/v2-190fe2d304321a83ef66b5023b6ac938_1440w.jpg)

同意。

![img](https://pic1.zhimg.com/80/v2-0fdcda30e978c6d26362132b7734d35c_1440w.jpg)

选择刚才抹掉的磁盘来安装系统，磁盘名称即为刚才抹盘时设置的。

![img](https://pic2.zhimg.com/80/v2-9f6ef862de4f87fd51d1bc686886ccad_1440w.jpg)

耐心等待。

![img](https://pic4.zhimg.com/80/v2-4bbfec9352d41c45e930c457e01c0c83_1440w.jpg)

耐心等待！

![img](https://pic2.zhimg.com/80/v2-2a916e03a928d34693caa0a3ec62de19_1440w.jpg)

设置区域[中国大陆]。

![img](https://pic3.zhimg.com/80/v2-6a4f8829daaaddb853ea740e84cb286a_1440w.jpg)

键盘选择[ABC]，至于简体中文后面进入系统后可以自己添加。

![img](https://pic1.zhimg.com/80/v2-9927d06147190a3c42eb08aae781ee6c_1440w.jpg)

继续。

![img](https://pic4.zhimg.com/80/v2-4998267834763db0aa5163edbce965cb_1440w.jpg)

勾选[现在不传输任何信息]，没有进系统前能不设置就不设置。

![img](https://pic2.zhimg.com/80/v2-bb939b2af883a31da63034a9d0876195_1440w.jpg)

稍后设置，跳过。

![img](https://pic2.zhimg.com/80/v2-3012019d05e802b702454f0a585c7399_1440w.jpg)

同意。

![img](https://pic1.zhimg.com/80/v2-86b30105fc0d0b0d0ab5b6954c4a528c_1440w.jpg)

创建账户和设置密码，自行设置。

![img](https://pic4.zhimg.com/80/v2-59dc98ef81f71e108e5c9faecb3ed4c7_1440w.jpg)

继续。

![img](https://pic3.zhimg.com/80/v2-096fa2f5f07ddf6b61bb7ed19fc08f2a_1440w.jpg)

选择外观，自行选择。

![img](https://pic1.zhimg.com/80/v2-fea281e4bdcd9043c4e84cfa7ea79244_1440w.jpg)

进入系统，可以看到系统界面很小，VMware虚拟机需要安装`VMware Tools`才能全屏。

![img](https://pic2.zhimg.com/80/v2-f289c4e99018536be85982eb5e3497b1_1440w.jpg)

安装`VMware Tools`前右键先推出安装程序`install macOS Mojave`。

![img](https://pic3.zhimg.com/80/v2-a9a6a22a58ac31ca5cc0c9d0ac06714a_1440w.jpg)

点击VMware上方选项卡[虚拟机]->[安装VMware Tools]，出现如下界面，双击安装VMware Tools。

![img](https://pic2.zhimg.com/80/v2-c833a146d378e4e3a538bb62830b809d_1440w.jpg)

Mac上安装软件不需要像Windows那样麻烦，因为Mac的程序管理非常方便，直接安装即可，安装成功后重新启动。

![img](https://pic3.zhimg.com/80/v2-b5ded6eda66b7ec3a307e9b142bf5b7a_1440w.jpg)

重新启动后就可以看到铺满了，如果想要全屏的话在VMware选项卡[查看]中全屏即可。

OK！MacOS在虚拟机上的安装就到此结束了。

![img](https://pic1.zhimg.com/80/v2-b24946724dc222f57356b4df796bb588_1440w.jpg)

## **三、优化**

安装成功后重启Mac系统，你会发现启动后很卡，重启后完全加载出桌面可能好久，而且在日常使用Mac虚拟机时，可能你会感到有点卡，比如你已经右键鼠标了，但是过了一两秒，Mac才弹出右键菜单。

这是因为VMware不支持给MacOS图形加速，像Windows和MacOS这种大型GUI桌面系统，没有3D图形加速要想流畅确实不太可能。

再者看到虚拟机给MacOS的图形显存只有128M，实在是太小了。综上，虚拟机对MacOS的优化支持实在有点差。

根本原因还是macOS系统只被允许在苹果的硬件设备上运行，在非苹果设备上公开支持macOS肯定是违规的，也就没有厂商愿意冒着风险开发显卡优化程序。

![img](https://pic3.zhimg.com/80/v2-2f4316cb1ae73ae080ed9b73d7ee8352_1440w.jpg)

不过小的优化还是有的，有一款MacOS虚拟机优化软件`beamoff`，GitHub项目地址：`https://github.com/JasF/beamoff`。

`beamoff`是VM上Mac虚拟机的优化神器，下载链接小e都打包了，见`资源下载`。

下载后在宿主机解压，因为已经安装了VM Tools，因此直接从宿主机拖动到Mac虚拟机桌面。（如果拖动中mac出现隐私安全弹窗，按照提示设置即可）

然后从桌面拖动到应用程序（打开访达即可看到）即可安装。

![img](https://pic3.zhimg.com/80/v2-7b0338c407f8e5f3bd004eb2054d3202_1440w.jpg)

安装后要设置为每次开机自启动，在设置->用户与群组，点击你的账户，点击右侧登录项，点击+号添加`beamoff`[应用程序](https://www.zhihu.com/search?q=应用程序&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A337036027})即可。

然后重启你就会感到开机加载桌面没有以前那么慢了，很明显。在日常使用时延迟也没有之前那么大了。

OK！长篇大文，两千多字，码字好几个小时，终于完成了，以后小e有时间还会分享Mac系统的新手配置教程，敬请期待！

分享不易，希望大家多多支持[小e](https://www.zhihu.com/search?q=小e&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A337036027})！

![img](https://pic4.zhimg.com/80/v2-c5b4940155ce7e1e880e3a9f7f29a043_1440w.jpg)

![img](https://pic2.zhimg.com/80/v2-c049045bf4083333e3cbf10df8f3bfa1_1440w.jpg)

![img](https://pic2.zhimg.com/80/v2-03ff42b114691df7af1f4ffac0dce681_1440w.jpg)



发布于 2020-12-15 11:45

黑苹果（Hackintosh）

VMware（威睿）

macOS