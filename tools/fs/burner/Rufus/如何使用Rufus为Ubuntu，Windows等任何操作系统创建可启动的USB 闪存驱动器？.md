# 如何使用Rufus为Ubuntu，Windows等任何操作系统创建可启动的USB /闪存驱动器？

![img](https://csdnimg.cn/release/blogv2/dist/pc/img/translate.png)

[cunjiu9486](https://blog.csdn.net/cunjiu9486) 2020-10-05 06:47:54 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 379 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏

文章标签： [java](https://www.csdn.net/tags/NtTaIg5sMzYyLWJsb2cO0O0O.html) [linux](https://www.csdn.net/tags/MtjaQg5sMDY0MC1ibG9n.html) [python](https://www.csdn.net/tags/MtjaQg4sNDk0LWJsb2cO0O0O.html) [ubuntu](https://www.csdn.net/tags/MtTaEg0sNTA1ODktYmxvZwO0O0OO0O0O.html) [mysql](https://www.csdn.net/tags/MtTaEg5sOTYwNC1ibG9n.html)

版权

In the old times, CD/DVD was popular for operating system installation. The operating system images were burned into CD or DVD then the installation was started via CD or DVD. Currently, USB or Flash Drives are popular to install new operating systems like Ubuntu, Windows, Mint, etc. `Rufus` is a simple tool that is used to burn the operating system images into the USB or Flash Drives.

在过去，CD / DVD在操作系统安装中很流行。 操作系统映像已刻录到CD或DVD中，然后通过CD或DVD开始安装。 当前，USB或闪存驱动器在安装新的操作系统(如Ubuntu，Windows，Mint等)方面很流行`Rufus`是一个简单的工具，用于将操作系统映像刻录到USB或闪存驱动器中。

## Rufus功能 **(**Rufus Features**)**

Rufus is a simple tool but provides a lot of useful features to create bootable USB/Flash Drive. Here are some of the popular features of Rufus.

Rufus是一个简单的工具，但提供了许多有用的功能来创建可启动的USB /闪存驱动器。 这是Rufus的一些流行功能。

- Twice faster then UNetbootin, Universal USB Installer or Windows 7 USB download tool.

  

  速度比UNetbootin，Universal USB Installer或Windows 7 USB下载工具快两倍。

- Supports a lot of different languages

  

  支持多种不同的语言

- Rufus is an open-source tool which source code can be downloaded from GitHub

  

  Rufus是一个开源工具，可以从GitHub下载源代码

- MBR, GPT partition scheme support

  

  MBR，GPT分区方案支持

- BIOS, UEFI target system support

  

  BIOS，UEFI目标系统支持

- FAT32, NTS file system support

  

  FAT32，NTS文件系统支持

- Adjustable cluster size

  

  集群大小可调

- Specify the volume name

  

  指定卷名

![Rufus Features](https://img-blog.csdnimg.cn/img_convert/5cf376ae2777c1d44e896505b48fed36.png)Rufus FeaturesRufus功能

## 下载Rufus**(**Download Rufus**)**

Rufus is provided for different platforms and operating system. Rufus mainly used for windows operating system. Rufus can be downloaded from the following link.

提供了针对不同平台和操作系统的Rufus。 Rufus主要用于Windows操作系统。 可以从以下链接下载Rufus。

https://rufus.ie/

https://rufus.ie/

![Download Rufus](https://img-blog.csdnimg.cn/img_convert/6150b31d0196ebb5e243d3d5fbcfe0d2.png)Download Rufus下载Rufus

If we want to download for ARM, Beta or different versions we can navigate to the `Other versions` where all download types are provided.

如果要下载ARM，Beta或其他版本，可以导航到提供所有下载类型的`Other versions` 。

![Download Rufus](https://img-blog.csdnimg.cn/img_convert/d80fd74767f418839399117ccc800b64.png)Download Rufus下载Rufus

## 启动Rufus **(**Start Rufus**)**

We will run the downloaded Rufus executable which will ask us Administrative rights. Because burning a USB/Flash disk requires some low-level functions which are only accessible with Administrative privileges. We will click `Yes` like below to provide.

我们将运行下载的Rufus可执行文件，这将询问我们管理权限。 因为刻录USB /闪存盘需要一些低级功能，这些功能只能通过“管理”权限访问。 我们将单击“ `Yes`如下所示。

![Start Rufus](https://img-blog.csdnimg.cn/img_convert/60c5e4033a0de57f4b5d9599b5635cf0.png)Start Rufus启动Rufus

For the first start, Rufus will ask us if we want to check updates from the internet. We will click to `Yes` in order to check updates regularly.

首先，Rufus将询问我们是否要检查来自互联网的更新。 我们将单击“ `Yes` ”以定期检查更新。

![Check Rufus Updates](https://img-blog.csdnimg.cn/img_convert/7339e6483d4fea2f1e6a871dcb3f6e88.png)Check Rufus Updates检查Rufus更新

## 鲁弗斯菜单**(**Rufus Menu**)**

Rufus is a simple tool with a single screen. All configuration and operation are done via following the single screen. Let’s explain the configuration.

Rufus是具有单个屏幕的简单工具。 所有配置和操作均通过以下单个屏幕完成。 让我们解释一下配置。

![Rufus Menu](https://img-blog.csdnimg.cn/img_convert/48cbb49c6d30f33392eee452a2696d2c.png)Rufus Menu鲁弗斯菜单

- `Drive Properties` is a section which contains source and destination drive related options

  `Drive Properties`是包含源和目标驱动器相关选项的部分

  - `Device` is the destination device which is a USB Flash Drive we will burn the iso

    `Device`是目标设备，它是USB闪存盘，我们将刻录iso

  - `Boot selection` is the type of boot style which should stay default

    `Boot selection`是引导样式的类型，应保留默认设置

  - `SELECT` is the button which is used to select ISO image

    `SELECT`是用于选择ISO映像的按钮

  - `Persistent partition size` is the size which will persistent during boots via USB

    `Persistent partition size`是在通过USB启动时将永久保留的大小

  - `Partition scheme` is the partition scheme which is MBR by default

    `Partition scheme`是默认情况下为MBR的分区方案

  - `Target system` is the type of BIOS

    `Target system`是BIOS的类型

  - `Show advanced drive properties` will provide some detailed option

    `Show advanced drive properties`将提供一些详细的选项

  `Drive Properties` is a section which contains source and destination drive related options

  `Drive Properties`是包含源和目标驱动器相关选项的部分

- `Format Options` is a section which contains the name, file system related options

  `Format Options`是包含名称，文件系统相关选项的部分

  - `Volume label` will be used to set the name for the created installation media

    `Volume label`将用于设置创建的安装媒体的名称

  - `File system` will be used to set the file system of the USB Flash Drive

    `File system`将用于设置USB闪存盘的文件系统

  - `Cluster size` will be used to set the size of the cluster of the USB Flash Drive

    `Cluster size`将用于设置USB闪存驱动器的群集大小

  `Format Options` is a section which contains the name, file system related options

  `Format Options`是包含名称，文件系统相关选项的部分

- `Status` will print the progress of USB Flash media creation

  `Status`将打印USB闪存介质创建的进度

[LEARN MORE Windows WMIC (Windows Management Interface Command) Tutorial with Examples](https://www.poftut.com/windows-wmic-windows-management-interface-command-tutorial-with-examples/)

了解更多Windows WMIC(Windows管理界面命令)教程和示例

## 下载Ubuntu ISO映像**(**Download Ubuntu ISO Image**)**

In this tutorial, we will create an Ubuntu Bootable Installation USB/Flash Disk. So we will download the Ubuntu ISO image. Ubuntu ISO images can be download in various ways. In this case, we will download from the Ubuntu web page as below. We will select the latest version `19.04`.

在本教程中，我们将创建一个Ubuntu可启动安装USB /闪存盘。 因此，我们将下载Ubuntu ISO映像。 Ubuntu ISO映像可以通过多种方式下载。 在这种情况下，我们将如下所示从Ubuntu页面下载。 我们将选择最新版本`19.04` 。

https://ubuntu.com/#download

https://ubuntu.com/#download

![Download Ubuntu ISO Image](https://img-blog.csdnimg.cn/img_convert/3d412ba5860e7b05ca698807adbad84c.png)Download Ubuntu ISO Image下载Ubuntu ISO映像

The downloaded Ubuntu ISO image has name `ubuntu-19.04-desktop-amd64.iso`.

下载的Ubuntu ISO映像的名称为`ubuntu-19.04-desktop-amd64.iso` 。

## 创建USB Ubuntu安装介质 **(**Create USB Ubuntu Installation Media**)**

Before starting the USB Ubuntu installation media we have to plug the USB Flash media drive to the system. It will be automatically recognized by the Rufus. Then we will provide the ISO file from the `SELECT` button of the Rufus like below.

在启动USB Ubuntu安装介质之前，我们必须将USB Flash介质驱动器插入系统。 Rufus将自动识别它。 然后，我们将通过Rufus的`SELECT`按钮提供ISO文件，如下所示。

![Create USB Ubuntu Installation Media](https://img-blog.csdnimg.cn/img_convert/c09be44de1e3f9ced6ab2aa6b6036ea0.png)Create USB Ubuntu Installation Media创建USB Ubuntu安装介质

We will see the following screen where we will select the Ubuntu ISO image file and then click to the `Open`.

我们将看到以下屏幕，我们将在其中选择Ubuntu ISO映像文件，然后单击“ `Open` 。

![Select Ubuntu ISO](https://img-blog.csdnimg.cn/img_convert/1d55189b5e9b59c2f31edebf9c8c7e1a.png)Select Ubuntu ISO选择Ubuntu ISO

We can check provided ISO file validity by calculating hash values. Rufus provides `MD5`,`SHA1` and `SHA256` hashes of the given ISO files. We will click on the following check button.

我们可以通过计算哈希值来检查提供的ISO文件的有效性。 Rufus提供给定ISO文件的`MD5` ， `SHA1`和`SHA256`哈希。 我们将单击以下检查按钮。

![Rufus Calculate ISO Hash](https://img-blog.csdnimg.cn/img_convert/6d97c3c3d7a8b058c2edc184f37d5775.png)Rufus Calculate ISO HashRufus计算ISO哈希

Calculated hash values will be printed with the following message box.

计算出的哈希值将显示在以下消息框中。

![Rufus ISO Hash Values](https://img-blog.csdnimg.cn/img_convert/ac0bbad4e6f7df3dc7aa476d1b5f913c.png)Rufus ISO Hash ValuesRufus ISO哈希值

We will start the burning provides by clicking the `Start` button like below. There will be some questions related to the USB Flash Drive creation.

我们将通过单击如下所示的`Start`按钮来`Start`刻录提供的内容。 将会有一些有关USB闪存驱动器创建的问题。

![Start USB Flash Drive Creation](https://img-blog.csdnimg.cn/img_convert/29dcada57854aea240c4ce247c5a1cb2.png)Start USB Flash Drive Creation开始创建USB闪存驱动器

As new Ubuntu ISO images provide different burning options we have two options `ISO Mode` or `DD Mode`. By default, we will select the ISO Mode.

由于新的Ubuntu ISO映像提供了不同的刻录选项，因此我们有两个选项： `ISO Mode`或`DD Mode` 。 默认情况下，我们将选择ISO模式。

![Rusuf ISO Mode](https://img-blog.csdnimg.cn/img_convert/6c06475fa8c4d1c264ab1e8ace7185b8.png)Rufus ISO ModeRufus ISO模式

For the last warning, all data stored in the plugged USB media will be deleted. So please take a backup of the USB flash drive. We will click `OK` to continue.

对于最后的警告，存储在插入的USB介质中的所有数据将被删除。 因此，请备份USB闪存驱动器。 我们将单击“ `OK`继续。

![Rufus Destroy Warning](https://img-blog.csdnimg.cn/img_convert/ce0c78fb434190cc5c82b67c0f42700a.png)Rufus Destroy Warning鲁弗斯毁灭警告

We will see that the progress will be shown in the `Status` part of Rufus. There are different phases during a USB installation media creation.

我们将看到进度将显示在Rufus的“ `Status`部分中。 USB安装介质创建期间有不同的阶段。

![Rufus USB Creation](https://img-blog.csdnimg.cn/img_convert/35b6355b960a3edccc08f9b86fe531b6.png)Rufus USB CreationRufus USB创建

When the burning process is completed we will the `Status` part as `Ready` in green color like below.

刻录过程完成后，我们将`Status`部分`Ready`为绿色，如下所示。

![Rufus Completed](https://img-blog.csdnimg.cn/img_convert/f3a492b049fe04d3a4a94f7666224b12.png)Rufus CompletedRufus完成

## Rufus替代品**(**Rufus Alternatives**)**

Rufus is the most useful and stable USB Flash Disk Installation Media creator there are also some alternatives which provide different features.

Rufus是最有用和最稳定的USB闪存盘安装介质创建器，还有一些提供不同功能的替代方法。

[LEARN MORE What Is Kernel (Operating System)?](https://www.poftut.com/what-is-kernel-operating-system/)

了解更多什么是内核(操作系统)？

### Live Linux USB Creator **(**Live Linux USB Creator**)**

Live Linux is mainly developed to create Linux USB installation media. It provides a lot of different Linux distributions automatically without any explicit download. It can also add some virtual box software to run the Linux distributions on Windows without a reboot.

Live Linux主要用于创建Linux USB安装介质。 它会自动提供许多不同Linux发行版，而无需任何明确的下载。 它还可以添加一些虚拟机软件，以在Windows上运行Linux发行版而无需重新启动。

![Live Linux USB Creator](https://img-blog.csdnimg.cn/img_convert/8c5a0350e9056bed9be62e7bec7e013c.png)Live Linux USB CreatorLive Linux USB Creator

### UNetbootin **(**UNetbootin**)**

Unetbootin is a cross-platform USB Flash Disk installation media creator where it supports Windows, Linux, MacOS. It can also automatically download some Linux distributions.

Unetbootin是跨平台的USB闪存盘安装媒体创建器，它支持Windows，Linux和MacOS。 它还可以自动下载一些Linux发行版。

![UNetbootin](https://img-blog.csdnimg.cn/img_convert/36bdd0395391c2cd1e5c4d0dcfc4d347.png)UNetbootinUNetbootin

### 通用USB安装程序 **(Universal USB Installer)**

Universal USB Installer is another tool alternative to Rufus. It is a bit outdated and provided by the `Pendrivelinux` community.

通用USB安装程序是Rufus的另一种替代工具。 `Pendrivelinux`社区提供了一些过时的功能。

### Windows 7 USB下载工具 **(**Windows 7 USB Download Tool**)**

As its name contains download but it can also burn Windows 7 Images into the USB Flash Drive.

由于其名称包含下载内容，但它也可以将Windows 7映像刻录到USB闪存驱动器中。

### Windows Media创建工具 **(**Windows Media Creation Tool**)**

Windows Media Creation Tool is created for Windows 10 USB Flask Drive. It can also download Windows 10 Images. More details and usage information can be found in the following link.

Windows Media创建工具是为Windows 10 USB Flask驱动器创建的。 它还可以下载Windows 10映像。 可以在以下链接中找到更多详细信息和使用信息。

[How To Download and Use Windows 10 Media Creation Tool To Create Windows 10 USB or DVD?](https://www.poftut.com/how-to-download-and-use-windows-10-media-creation-tool-to-create-windows-10-usb-or-dvd/)

[如何下载和使用Windows 10 Media Creation Tool创建Windows 10 USB或DVD？](https://www.poftut.com/how-to-download-and-use-windows-10-media-creation-tool-to-create-windows-10-usb-or-dvd/)

> 翻译自: https://www.poftut.com/how-to-create-bootable-usb-flash-drive-with-rufus-for-any-os-like-ubuntu-windows/

相关资源：[*linu**系统*安装u盘制作方法*rufus**使用*方法_*rufus**使用*教程-网管软件...](https://download.csdn.net/download/ls763344978/7871841?spm=1001.2101.3001.5697)