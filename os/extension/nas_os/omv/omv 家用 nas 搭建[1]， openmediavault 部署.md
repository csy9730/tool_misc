# omv 家用 nas 搭建[1]， openmediavault 部署

[![geniusjoe](https://pic1.zhimg.com/v2-b98ac8eeefabc19793a0e25d17c82200_l.jpg?source=32738c0c)](https://www.zhihu.com/people/zhou-zhuo-han-3)

[geniusjoe](https://www.zhihu.com/people/zhou-zhuo-han-3)

25 人赞同了该文章

### 1. 部署背景

### 1.1 常见 nas 系统优缺点

市面上自托管的 nas 操作系统有很多，简单总结后常见系统如下表所示：

- FreeNAS 及其衍生 TrueNAS SCALE ，TrueNAS CORE

优点在于 FreeNAS 基于 BSD 内核，而在 BSD 上实现的 ZFS 文件系统具有例如硬盘快照，数据校验，数据恢复等实用功能，使用 ZFS 实现的硬盘阵列 RAID-Z2，RAID-Z3 性能十分优秀。同时 FreeNAS 经过多年发展，官方插件既丰富又全面，社区也很活跃。

缺点在于 ZFS 将内存作为数据缓存来优化性能，因此理论上 ZFS 需要 ecc 内存进行数据校验，而目前常用的 ecc 硬件平台大致有如下几种：X58，X79，X99，锐龙平台。这几款至强平台用的均为 recc ddr3/ddr4 内存，但年代久远，寿命比较成问题，而锐龙平台使用纯 ecc 内存，但锐龙集显驱动较难安装。除此之外，BSD 内核对于 linux 常见的软件版本管理器及 docker 支持也没有那么好。

- 成品 NAS 自带系统及其破解，群晖，威联通

优点在于白群晖和白威联通作为成品 NAS 的解决方案，基本上已经完善所有功能，遇到 bug 也有售后工程师帮忙解决，比较省心。而黑群晖即使不洗白也能够运行群辉绝大部分的功能，比较方便。威联通与群辉大同小异。

缺点在于基本上成品 NAS 属于买系统送硬件，低端 NAS 使用 arm 架构处理器，在使用群辉服务商店拓展功能时容易出问题，而高端 NAS 也用的是 J1900, J3455 等廉价硬件，通常直接 bga 封装在主板上，并且主板上只有 4 个 sata 接口，pcie 插槽也不多，不利于拓展。同时由于赛扬定位本身是低功耗 cpu ，性能也比酷睿差得多。

- Openmediavault，unraid

优点在于 omv 基于 debian 内核，而 debian 经过长期商业版本测试极其稳定，只要硬件没有问题基本不会出现死机的情况，同时 debian 内核也能使用常用的 apt 包管理器进行项目管理。同时由于是 linux 系统，能够使用 docker 进行环境隔离与迁移，便于快速拓展。除此之外，omv 所需硬件条件也较低，已经有在树莓派上成功运行的例子。

缺点在于本身 omv 较为小众，社区讨论度不太够，有很多问题需要自己摸索解决。除此之外， omv 实现硬盘阵列使用的是 linux raid 阵列，在极端情况下性能没有 ZFS 文件系统优越。

### 1.2 nas 需求

笔者主要使用 nas 进行家用资料同步，远程播放视频，远程访问文件的需求，因此需要 nas 有自动同步程序， pt 站做种和百度云下载功能。除此之外，由于日常任务需要，还需要创建不同隔离环境从而部署简单挂机脚本。

### 1.3 硬件配置

omv 占用硬件资源较小，如果没有大量播放解码转码的需求，建议直接使用集成显卡，或是 GT1030，GTX1050 等定位初级游戏，播放高清视频的显卡。

- 处理器 ： i3-9100
- 主板 ： b360m mortar
- 内存 ： 光威 奕 pro 16G * 2
- 硬盘 ： 光威 奕 pro 512G m2 固态，西数 SATA 蓝盘 4T * 2，希捷 3T * 4 SAS 拆机盘
- 阵列卡 ： LSI 9211-8i
- 显卡 ： UHD630

------

## 2. 部署过程

部署过程主要参考了油管 [Techno Dad Life](https://link.zhihu.com/?target=https%3A//www.youtube.com/watch%3Fv%3DM_oxzpvMPTE) 相关视频，以下部分图片也将参考视频进行截取。

### 2.1 u 盘烧录镜像

烧录过程需要以下三个步骤，下载 omv 镜像，下载烧录软件，使用烧录软件将镜像写入 u 盘中。

### 2.1.1 下载 omv 镜像

首先在 [omv 官方网站](https://link.zhihu.com/?target=https%3A//www.openmediavault.org/%3Fpage_id%3D77)下载最新版本镜像

![img](https://pic3.zhimg.com/80/v2-a67806269ab06e92636c8e330198bb16_1440w.webp)

点击之后会跳到 SourceForge 网站，点击下载 omv5 最新版本 iso 镜像

![img](https://pic3.zhimg.com/80/v2-87e76a6270fc7cbc6c64101fc7470d4e_1440w.webp)

### 2.1.2 下载烧录软件

烧录软件采用 [balenaEtcher](https://link.zhihu.com/?target=https%3A//www.balena.io/etcher/) ，直接选择 portable 版本进行下载。

![img](https://pic2.zhimg.com/80/v2-b75209b6fe4a6d03f6929872aa574a65_1440w.webp)

### 2.1.3 将镜像写入 u 盘

打开 etcher，依次选中 omv 镜像文件，刷入 u 盘，点击 "Flash“ 即可自动完成写入

![img](https://pic2.zhimg.com/80/v2-94c6972b3fa99596f5496bcc6d7dc199_1440w.webp)

### 2.2 u 盘引导安装系统

bios 设置启动项 u 盘后，会直接进入 omv 安装界面。

*在安装前建议只留下安装的系统盘及 u 盘，不然在系统创建 grub 文件时可能会报错。*

*安装 omv 系统建议避免选用一代锐龙，例如： r5 1400, r5 2400g 等，一代锐龙内置的 iommu 模块在 omv 上运行时还存在一些问题，可能会导致死机等异常情况。*

- 运行语言选择中文

![img](https://pic3.zhimg.com/80/v2-906f0f67bd7c4bb69fac020bd0e1576a_1440w.webp)

- 设置系统 root 密码

*注意这个密码和 web 登陆时密码不同，此处密码是 ssh 登陆 omv 时的密码*

![img](https://pic2.zhimg.com/80/v2-f30e146b0e6a0b0bbccb2d9dafe28865_1440w.webp)

- 设置系统安装位置

*注意此处需要仔细确认，之后 omv 并不会进行二次确认，安装系统的过程会将相应硬盘清空*

![img](https://pic2.zhimg.com/80/v2-c12594cbc4980a2b10d814ae9804cbcd_1440w.webp)

- 镜像选择

*此处镜像所在国家选择 china ，镜像源选择 [http://tuna.tsinghua.edu.com](https://link.zhihu.com/?target=http%3A//tuna.tsinghua.edu.com) 清华源*

![img](https://pic1.zhimg.com/80/v2-78bde9a1b0c9feeda0cd75ec8ccf9bbc_1440w.webp)

如果安装顺利，将会出现如下图的安装成功提示

这时候就可以将当前 u 盘拔出，重启时选择安装系统的硬盘启动，同时可以将除了安装系统之外其他的硬盘插回主板上了，包括阵列卡等设备。

![img](https://pic3.zhimg.com/80/v2-438e5f814d7d3de3665c2e4ff7b97bfe_1440w.webp)

至此安装基本告一段落，重启后会出现 omv 界面以及系统对应 ip。同时也能直接通过路由器管理界面查看 ip。如下图所示，此时 openmediavault 对应的 ip 为 192.168.1.165 。输入相应网址即可进入登录界面。

![img](https://pic2.zhimg.com/80/v2-aa5132c0e89976ea5eade6074614e84d_1440w.webp)

------

### 3. 设置系统

### 3.1 omv 常用设置

运行系统后，需要进行 omv 系统的常用设置。

### 3.1.1 设置 omv web 密码

![img](https://pic4.zhimg.com/80/v2-a35d3d4593b521ce280bb4179f0e9bbb_1440w.webp)

### 3.1.2 设置登入超时时间

![img](https://pic1.zhimg.com/80/v2-354cc7476f3f42e96f6f0a05380f6d64_1440w.webp)

### 3.1.3 设置当前时区

![img](https://pic2.zhimg.com/80/v2-507e3724a722a4c6387050619c55ebb9_1440w.webp)

### 3.1.4 设置启用局域网 ssh 登陆

![img](https://pic2.zhimg.com/80/v2-c21665bd0790be068ca91962a3e58b15_1440w.webp)

### 3.1.5 设置文件系统

首选如果需要使用 raid 的文件系统，则需要先创建 raid。如下图所示，勾选设备后设定级别，点击创建后 omv 会自动进行 raid 分区的创建。

![img](https://pic2.zhimg.com/80/v2-2f682daac322bfd488789c355e889b15_1440w.webp)

创建 raid 后，在文件系统中就能显示 raid 后的硬盘分区，勾选设备后，选择文件系统类别即可。

![img](https://pic4.zhimg.com/80/v2-62cb275a73a68600e1dccb7f99dead1f_1440w.webp)

### 3.2 omv-extras 设置

### 3.2.1 设置 omv-extras

omv-extras 不能直接从 web ui 上安装，根据[官方文档](https://link.zhihu.com/?target=https%3A//wiki.omv-extras.org/)所述，需要使用前文启用的 ssh 连接终端，并粘贴以下命令。

```
wget -O - https://github.com/OpenMediaVault-Plugin-Developers/packages/raw/master/install | bash
```

![img](https://pic3.zhimg.com/80/v2-ddb4c1e6783bdea870b2d44c686b9e0a_1440w.webp)

运行成功后，会在 web ui 侧边栏中多出 omv-extras 选项。

### 3.2.2 安装 portainer

portainer 是一款管理 docker 的 web 端工具，能够实现大部分终端的功能，例如使用 docker-compose 部署，与 container 交互等。

点击侧边栏 omv-extras 选项，依次安装 docker 和 portainer，如下图所示，完成后 portainer 默认在 9000 端口启用。

![img](https://pic2.zhimg.com/80/v2-aa13f88e4994bc3c9f644ff31999ce7d_1440w.webp)

![img](https://pic2.zhimg.com/80/v2-bfc04776b7d6b4176f929fb327d434e5_1440w.webp)

------

## 3. 部署总结

这次主要实现了直接部署 openmediavault 在物理机上，并且设置了常用功能以及安装 portainer，完成 docker 的平台搭建。



[geniusjoe：omv 家用 nas 搭建[1\]， openmediavault 部署25 赞同 · 0 评论文章![img](https://pic4.zhimg.com/v2-28073600eabb4c7601976756c474b8ff_180x120.jpg)](https://zhuanlan.zhihu.com/p/362998867)

[geniusjoe：omv 家用 nas 搭建[2\]， qbitttorrent 部署14 赞同 · 20 评论文章![img](https://pic2.zhimg.com/v2-40a5f62b0cf22c0dc11b118bff6284e5_180x120.jpg)](https://zhuanlan.zhihu.com/p/363378341)

[geniusjoe：omv 家用 nas 搭建[3\]， 百度云网盘部署13 赞同 · 1 评论文章![img](https://pic1.zhimg.com/v2-d96208869c34460432598fa86a920314_180x120.jpg)](https://zhuanlan.zhihu.com/p/363608459)

[geniusjoe：omv 家用 nas 搭建[4\]， jellyfin 部署15 赞同 · 5 评论文章![img](https://pic3.zhimg.com/v2-701ef8c211b06267075e80e1c6a32676_180x120.jpg)](https://zhuanlan.zhihu.com/p/363652899)

[geniusjoe：omv 家用 nas 搭建[5\]， urbackup 部署5 赞同 · 0 评论文章![img](https://pic4.zhimg.com/v2-62d4fa09d2378c5b1e41bc2f65e3cc4b_180x120.jpg)](https://zhuanlan.zhihu.com/p/363746660)



编辑于 2021-04-10 15:25

[家用 NAS](https://www.zhihu.com/topic/19736752)

[个人电脑](https://www.zhihu.com/topic/19550286)

[计算机](https://www.zhihu.com/topic/19555547)