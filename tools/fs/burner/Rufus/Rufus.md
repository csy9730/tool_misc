# [Rufus](https://github.com/pbatard/rufus)

​		轻松创建USB启动盘	

![[rufus screenshot]](/pics/rufus_zh_CN.png)

Rufus 是一个可以帮助格式化和创建可引导USB闪存盘的工具，比如 USB 随身碟，记忆棒等等。

在如下场景中会非常有用：			

- 你需要把一些可引导的ISO格式的镜像（Windows，Linux，UEFI等）创建成USB安装盘的时候
- 你需要使用一个还没有安装操作系统的设备的时候
- 你需要从DOS系统刷写BIOS或者其他固件的时候
- 你需要运行一个非常底层的工具的时候



Rufus 麻雀虽小，五脏俱全，体积虽小，功能全面。

哦，对了，Rufus 还 **非常快**，比如，在从ISO镜像创建 Windows 7 USB安装盘的时候，他比 [UNetbootin](http://unetbootin.sourceforge.net/)，[Universal USB Installer](http://www.pendrivelinux.com/universal-usb-installer-easy-as-1-2-3) 或者 [Windows 7 USB download tool](https://www.microsoft.com/en-us/download/windows-usb-dvd-download-tool) 大约快2倍。当然，在创建 Linux 可引导USB设备的时候也比较快。 [(1)](#ref1)
		页面底部也粗略列举了一些 Rufus 支持的ISO镜像。 [(2)](#ref2)



## 下载

**最后更新于 2021.08.03：**



- **[Rufus 3.15](https://github.com/pbatard/rufus/releases/download/v3.15/rufus-3.15.exe)** (1.1 MB)
- [Rufus 3.15 便携版](https://github.com/pbatard/rufus/releases/download/v3.15/rufus-3.15p.exe) (1.1 MB)
- [其他版本 (GitHub)]()
- [其他版本 (FossHub)](https://www.fosshub.com/Rufus.html)



#### 支持的语言：



| *Bahasa Indonesia* | ,    | *Bahasa Malaysia* | ,    | *Български* | ,    | *Čeština* | ,    | *Dansk* | ,    | *Deutsch* | ,    | *Ελληνικά* | ,    |
| ------------------ | ---- | ----------------- | ---- | ----------- | ---- | --------- | ---- | ------- | ---- | --------- | ---- | ---------- | ---- |
|                    |      |                   |      |             |      |           |      |         |      |           |      |            |      |

| *English* | ,    | *Español* | ,    | *Français* | ,    | *Hrvatski* | ,    | *Italiano* | ,    | *Latviešu* | ,    | *Lietuvių* | ,    | *Magyar* | ,    | *Nederlands* | ,    | *Norsk* | ,    |
| --------- | ---- | --------- | ---- | ---------- | ---- | ---------- | ---- | ---------- | ---- | ---------- | ---- | ---------- | ---- | -------- | ---- | ------------ | ---- | ------- | ---- |
|           |      |           |      |            |      |            |      |            |      |            |      |            |      |          |      |              |      |         |      |

| *Polski* | ,    | *Português* | ,    | *Português do Brasil* | ,    | *Русский* | ,    | *Română* | ,    | *Slovensky* | ,    | *Slovenščina* | ,    | *Srpski* | ,    |
| -------- | ---- | ----------- | ---- | --------------------- | ---- | --------- | ---- | -------- | ---- | ----------- | ---- | ------------- | ---- | -------- | ---- |
|          |      |             |      |                       |      |           |      |          |      |             |      |               |      |          |      |

| *Suomi* | ,    | *Svenska* | ,    | *Tiếng Việt* | ,    | *Türkçe* | ,    | *Українська* | ,    | 简体中文 | ,    | 正體中文 | ,    | 日本語 | ,    | 한국어 | ,    | ไทย  | ,    |
| ------- | ---- | --------- | ---- | ------------ | ---- | -------- | ---- | ------------ | ---- | -------- | ---- | -------- | ---- | ------ | ---- | ------ | ---- | ---- | ---- |
|         |      |           |      |              |      |          |      |              |      |          |      |          |      |        |      |        |      |      |      |

| עברית | ,    | العربية | ,    | پارسی | .    |
| ----- | ---- | ------- | ---- | ----- | ---- |
|       |      |         |      |       |      |



#### 系统需求：

需要Windows 7以上的操作系统，无所谓32位还是64位，下载后开箱即用。

在这里我要借这个机会表达对那些把 Rufus 和这个网页翻译成各种语言的翻译者们的谢意。如果你发现 Rufus 可以支持你们使用的语言，你也应该感谢他们。

## 用法

下载可执行文件后直接运行 – 无需安装，绿色环保。

可执行文件已经进行数字签名，详情如下：			

- *"Akeo Consulting"* (v1.3.0 或者更新的版本)
- *"Pete Batard - Open Source Developer"* (v1.2.0 或者更老的版本)



#### 对DOS支持的说明：

如果你创建了一个DOS启动盘，但是没有使用美式键盘，Rufus 会尝试根据设备选择一个键盘布局，在那种情况下推荐使用 [FreeDOS](http://www.freedos.org)（默认选项）而不是 MS-DOS，因为前者支持更多的键盘布局。

#### 对ISO支持的说明：

Rufus v1.10 及其以后的所有版本都支持从 [ISO 镜像](http://en.wikipedia.org/wiki/ISO_image) (.iso) 创建可引导USB。

通过使用类似 [InfraRecorder](http://infrarecorder.org/) 或者 [CDBurnerXP](http://cdburnerxp.se/) 之类的免费CD镜像烧录程序，可以非常方便的从实体光盘或者一系列文件中创建 ISO 镜像。



## 常见问题（FAQ）

Rufus 的常见问题（FAQ）**[在此](https://github.com/pbatard/rufus/wiki/FAQ)**。

您可以使用 github 的 [issue tracker](https://github.com/pbatard/rufus/issues) 来提供反馈，报告 BUG，或者提交功能需求。当然也可以直接发 [电子邮件](mailto:pete@akeo.ie?subject=Rufus)。



## 许可证

[GNU General Public License (GPL) version 3](http://www.gnu.org/licenses/gpl.html) 或更新版本
在尊重 GPLv3 许可证的前提下，你可以随意分发，修改或者出售此软件。

Rufus 项目使用 100% 透明的方式进行开发，对公众开放 [源代码](https://github.com/pbatard/rufus)，使用 [MinGW32](http://mingw-w64.org) 环境。



## 更新日志（英文）

- 版本 3.15

   (2021.08.03)				

  - Update [GRUB](https://www.gnu.org/software/grub/) to version 2.06
  - Add support for `.vtsi` files ([Ventoy](https://www.ventoy.net) Sparse Image, courtesy of ***longpanda\***/***ventoy\***)
  - Add workaround for openSUSE Live ISOs
  - Move default app directory to `%LocalAppData%\Rufus\` and always save a log there on exit
  - Fix AppStore version of Rufus not being able to store downloaded files
  - Fix failure to open Syslinux/GRUB files when Rufus is located at the root of a drive
  - Prevent the creation of `System Volume Information` on [ESP](https://en.wikipedia.org/wiki/EFI_system_partition)s written in DD mode
  - Prevent drive letter assignation to the [UEFI:NTFS](https://github.com/pbatard/uefi-ntfs) partition
  - Prevent persistent partition creation errors due to size
  - Wnhance safety checks before running the [Fido ISO download script](https://github.com/pbatard/Fido)
  - Other internal fixes and improvements

- **[其他版本](https://github.com/pbatard/rufus/blob/master/ChangeLog.txt)**

## 源代码



- [Rufus 3.15](https://github.com/pbatard/rufus/archive/v3.15.zip) (3.5 MB)

- 当然，你也可以使用如下方式克隆 

  git

   源代码库：			

  ```
  $ git clone git://github.com/pbatard/rufus
  ```

- 更多详情请查看 [github 项目主页](https://github.com/pbatard/rufus) 。

​			非常欢迎开发者来折腾 Rufus 和提交补丁。





## 捐助

这个问题老是有人问我，不过这个页面上真的 **没有** 捐助按钮。

主要原因是我认为捐助模式不能真正帮助软件发展，相反的，会对没有捐助的用户产生一种无意的诱导性的愧疚歧视感。

当然，如果你非要坚持，你可以捐给 [Free Software Foundation（自由软件基金会）](http://www.fsf.org/)，他们才是无数类似 Rufus 的软件得以存在的原因。

不管如何，我都要在此对你们说  *谢谢你们* 对这个小程序持续的支持和热情：非常非常感谢。

但是无论怎样也请你随意使用 Rufus ，无需介怀对此项目没有付出任何经济上的贡献 –  因为你本来就不需要嘛。

 

## (1) Rufus 与其他同类软件的速度对比

如下测试在一台安装了64位Windows7操作系统的配备了酷睿2双核，4GB内存的平台上进行，主板USB支持 USB 3.0 ，使用了 [ 16GB的 USB 3.0 ADATA S102 闪存盘](http://www.adata-group.com/index.php?action=product_feature&cid=1&piid=145&lan=en).



| •    | Windows 7 x64 | :    | *en_windows_7_ultimate_with_sp1_x64_dvd_618240.iso* |
| ---- | ------------- | ---- | --------------------------------------------------- |
|      |               |      |                                                     |



| Windows 7 USB/DVD Download Tool v1.0.30 | 00:08:10     |
| --------------------------------------- | ------------ |
| Universal USB Installer v1.8.7.5        | 00:07:10     |
| UNetbootin v1.1.1.1                     | 00:06:20     |
| RMPrepUSB v2.1.638                      | 00:04:10     |
| WiNToBootic v1.2                        | 00:03:35     |
| **Rufus v1.1.1**                        | **00:03:25** |





| •    | Ubuntu 11.10 x86 | :    | *ubuntu-11.10-desktop-i386.iso* |
| ---- | ---------------- | ---- | ------------------------------- |
|      |                  |      |                                 |



| UNetbootin v1.1.1.1              | 00:01:45     |
| -------------------------------- | ------------ |
| RMPrepUSB v2.1.638               | 00:01:35     |
| Universal USB Installer v1.8.7.5 | 00:01:20     |
| **Rufus v1.1.1**                 | **00:01:15** |





| •    | Slackware 13.37 x86 | :    | *slackware-13.37-install-dvd.iso* |
| ---- | ------------------- | ---- | --------------------------------- |
|      |                     |      |                                   |



| UNetbootin v1.1.1.1              | 01:00:00+    |
| -------------------------------- | ------------ |
| Universal USB Installer v1.8.7.5 | 00:24:35     |
| RMPrepUSB v2.1.638               | 00:22:45     |
| **Rufus v1.1.1**                 | **00:20:15** |



 

## (2) Rufus  目前已知（但不限于）的支持的ISO镜像如下

| [Arch Linux](http://www.archlinux.org/) | ,    | [Archbang](http://archbang.org/) | ,    | [BartPE/pebuilder](http://www.nu2.nu/pebuilder/) | ,    | [CentOS](http://centos.org) | ,    | [Damn Small Linux](http://www.damnsmalllinux.org/) | ,    | [Debian](https://www.debian.org/) | ,    | [Fedora](http://fedoraproject.org/) | ,    | [FreeDOS](http://www.freedos.org/) | ,    |
| --------------------------------------- | ---- | -------------------------------- | ---- | ------------------------------------------------ | ---- | --------------------------- | ---- | -------------------------------------------------- | ---- | --------------------------------- | ---- | ----------------------------------- | ---- | ---------------------------------- | ---- |
|                                         |      |                                  |      |                                                  |      |                             |      |                                                    |      |                                   |      |                                     |      |                                    |      |

| [FreeNAS](http://www.freenas.org/) | ,    | [Gentoo](http://www.gentoo.org/) | ,    | [GParted](http://gparted.org/) | ,    | [gNewSense](http://www.gnewsense.org/) | ,    | [Hiren's Boot CD](http://www.hirensbootcd.org/) | ,    | [LiveXP](http://reboot.pro/forum/52/) | ,    | [Knoppix](http://knoppix.net/) | ,    | [KolibriOS](http://kolibrios.org) | ,    | [Kubuntu](http://www.kubuntu.org/) | ,    |
| ---------------------------------- | ---- | -------------------------------- | ---- | ------------------------------ | ---- | -------------------------------------- | ---- | ----------------------------------------------- | ---- | ------------------------------------- | ---- | ------------------------------ | ---- | --------------------------------- | ---- | ---------------------------------- | ---- |
|                                    |      |                                  |      |                                |      |                                        |      |                                                 |      |                                       |      |                                |      |                                   |      |                                    |      |

| [Linux Mint](http://linuxmint.com/) | ,    | [NT Password Registry Editor](http://pogostick.net/~pnh/ntpasswd/) | ,    | [Parted Magic](http://partedmagic.com/) | ,    | [Partition Wizard](http://www.partitionwizard.com/partition-wizard-bootable-cd.html) | ,    | [Raspbian](http://www.raspbian.org/) | ,    |
| ----------------------------------- | ---- | ------------------------------------------------------------ | ---- | --------------------------------------- | ---- | ------------------------------------------------------------ | ---- | ------------------------------------ | ---- |
|                                     |      |                                                              |      |                                         |      |                                                              |      |                                      |      |

| [ReactOS](http://reactos.org/) | ,    | [Red Hat](http://www.redhat.com/) | ,    | [rEFInd](http://www.rodsbooks.com/refind/) | ,    | [Slackware](http://www.slackware.com/) | ,    | [Super Grub2 Disk](http://www.supergrubdisk.org/category/download/supergrub2diskdownload/super-grub2-disk-stable/) | ,    | [Tails](https://tails.boum.org/) | ,    | [Trinity Rescue Kit](http://trinityhome.org/) | ,    | [Ubuntu](http://www.ubuntu.com/) | ,    |
| ------------------------------ | ---- | --------------------------------- | ---- | ------------------------------------------ | ---- | -------------------------------------- | ---- | ------------------------------------------------------------ | ---- | -------------------------------- | ---- | --------------------------------------------- | ---- | -------------------------------- | ---- |
|                                |      |                                   |      |                                            |      |                                        |      |                                                              |      |                                  |      |                                               |      |                                  |      |

| [Ultimate Boot CD](http://www.ultimatebootcd.com/) | ,    | [Windows XP (SP2+)](https://msdn.microsoft.com/en-us/subscriptions/downloads/default.aspx#searchTerm=&ProductFamilyId=140&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0) | ,    | [Windows Vista](https://msdn.microsoft.com/en-us/subscriptions/downloads/default.aspx#searchTerm=&ProductFamilyId=146&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0) | ,    | [Windows Server 2008](https://msdn.microsoft.com/en-us/subscriptions/downloads/default.aspx#searchTerm=&ProductFamilyId=351&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0) | ,    | [Windows 7](https://msdn.microsoft.com/en-us/subscriptions/downloads/default.aspx#searchTerm=&ProductFamilyId=350&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0) | ,    |
| -------------------------------------------------- | ---- | ------------------------------------------------------------ | ---- | ------------------------------------------------------------ | ---- | ------------------------------------------------------------ | ---- | ------------------------------------------------------------ | ---- |
|                                                    |      |                                                              |      |                                                              |      |                                                              |      |                                                              |      |

| [Windows 8](https://msdn.microsoft.com/en-us/subscriptions/downloads/default.aspx#searchTerm=&ProductFamilyId=481&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0) | ,    | [Windows 8.1](https://msdn.microsoft.com/en-us/subscriptions/downloads/default.aspx#searchTerm=&ProductFamilyId=524&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0) | ,    | [Windows Server 2012](https://msdn.microsoft.com/en-us/subscriptions/downloads/default.aspx#searchTerm=&ProductFamilyId=483&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0) | ,    | [Windows 10](https://www.microsoft.com/en-us/software-download/windows10ISO/) | ,    | [Windows Server 2016](https://msdn.microsoft.com/en-us/subscriptions/downloads/default.aspx#searchTerm=&ProductFamilyId=665&Languages=en&FileExtensions=.iso&PageSize=10&PageIndex=0&FileId=0) | ,    | …    |
| ------------------------------------------------------------ | ---- | ------------------------------------------------------------ | ---- | ------------------------------------------------------------ | ---- | ------------------------------------------------------------ | ---- | ------------------------------------------------------------ | ---- | ---- |
|                                                              |      |                                                              |      |                                                              |      |                                                              |      |                                                              |      |      |



| Copyright | ©    | 2011-2021 | [Pete Batard](https://pete.akeo.ie) |
| --------- | ---- | --------- | ----------------------------------- |
|           |      |           |                                     |

​			简体中文 由  [ihipop](https://twitter.com/ihipop) 翻译
​			USB 图标设计： PC Unleashed
​			主机提供： [GitHub](https://pages.github.com/)