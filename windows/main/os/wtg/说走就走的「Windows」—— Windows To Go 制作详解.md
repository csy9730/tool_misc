# 说走就走的「Windows」—— Windows To Go 制作详解

[![少数派_767456](https://cdn.sspai.com/ui/otter_avatar_placeholder.png?imageMogr2/auto-orient/thumbnail/!72x72r/gravity/center/crop/72x72/format/webp/ignore-error/1)](https://sspai.com/u/3q4rcqk4/updates)[少数派_767456](https://sspai.com/u/3q4rcqk4/updates)

2018 年 06 月 02 日

拥有 Mac 的同学大概都会碰到一个头疼的问题，那就是使用 Windows 的使用需求。macOS 虽好，不过总是会有一些讨厌的软件没有 Mac 版本，这时就不得不在 Mac 上跑 Windows 了。使用虚拟机？它对硬件要求比较高；装 Boot Camp？这对于容量紧张的 Mac 用户来说并不是一个好主意。那还有什么办法在 Mac 上愉快的使用 Windows 呢？[Windows To Go](https://sspai.com/link?target=https%3A%2F%2Fwww.google.com%2Furl%3Fsa%3Dt%26rct%3Dj%26q%3D%26esrc%3Ds%26source%3Dweb%26cd%3D1%26cad%3Drja%26uact%3D8%26ved%3D0ahUKEwih39-PxMDbAhVCNrwKHZZuBscQFggnMAA%26url%3Dhttps%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fwindows%2Fdeployment%2Fplanning%2Fwindows-to-go-overview%26usg%3DAOvVaw0k0dqnzHPIZLH1oRXLZr0N) （以下简称为 WTG）让还在纠结的 Mac 用户有了第三个选择。

### WTG 简介

这项功能最早推出于 2011 年 9 月，并包含在之后发布的 Windows 8 企业版、Windows 8.1 企业版、 Windows 10 企业版，教育版和 **1607 版本及之后的 Windows 10 专业版**中。通过此功能，你可以将 Windows 「浓缩」到一个 USB 存储设备上并随身携带，并且由于是储存在**外置设备**中，所以不用担心本机的容量问题。这对那些对 Windows 有短暂需求而又不想装 Boot Camp 和虚拟机的 Mac 用户来说可谓非常友好了。

### 制作 WTG 的前提条件

说了那么多，相信广大 Mac 用户都想跃跃欲试了吧，不过在开始之前还有以下需要值得注意的两点：

#### 硬件要求

微软官方对 WTG 的要求为：接口为 USB 2.0 及以上，容量为 32 G 及以上，不过既然是运行完整的 Windows，那么官方的要求肯定是不达标的，所以一个性能优异的 USB 存储器还是有必要的。虽然微软官方认证了一些第三方的 USB 存储器，不过这些认证的 USB 存储器**价格普遍偏高**，如果预算充足的话可以考虑。

![img](https://cdn.sspai.com/2018/06/02/90af114a91250080e4aada507347073f.png?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)京东上的 WTG 认证 U 盘，价格比一般的 U 盘价格高出许多

如果预算比较有限的话可以考虑使用**小容量固态硬盘**或者是**高性能机械硬盘**，虽然官方没有为这些硬盘进行认证，不过这影响不大，你仍然可以照常安装 WTG 到这些硬盘里，并且实际体验效果也不差。

#### 软件要求

准备好硬件之后，接下来就到了安装环节。如果你想使用**官方工具**进行安装的话，你的系统必须满足 **Windows 8/8.1/10 企业版、Windows 10 教育版和 1607 版本及之后的 Windows 10 专业版**。在这些版本的 Windows 中 WTG 已经内置于系统，只需直接打开即可。

当然，如果你的系统没有满足以上条件的话，你也可以使用**第三方 WTG 工具**来制作，第三方工具相对于官方工具来说限制条件会少许多。

**（以下多图预警）**

### 安装 WTG

在上面的软件要求中就已经提到安装 WTG 的两种方法，接下来我们将分别介绍如何使用官方工具和第三方工具来进行安装。鉴于 Windows 10 在现在的 Windows 中的普遍性，在下列讲解中我将以 **Windows 10** 为例进行介绍。

#### 使用官方工具进行安装

使用官方工具进行安装之前，**确保你的移动设备中的数据已经备份**，并且已提前下载好 **Windows 10 企业版**的镜像。如果一切准备就绪，那么你就可以跟着下面的步骤来进行安装了。

建议前往 [微软官方网站](https://sspai.com/link?target=https%3A%2F%2Fwww.microsoft.com%2Fzh-cn%2Fsoftware-download%2Fwindows10ISO) 下载原版镜像。

第一步：插上外置存储，并装载你所下载的 **Windows 10 企业版**镜像，通常情况下只需双击该镜像文件即可装载。

![img](https://cdn.sspai.com/2018/06/02/5a3683224fb6f8c51a9bcbc74deb68b9.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

第二步：在任务栏中的搜索栏（位于开始按钮右边）处输入「Windows To Go」并打开，你也可以在控制面板中找到「Windows To Go」。

![img](https://cdn.sspai.com/2018/06/02/fbe07d27654b63fefbbe3e8ef88cc409.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

第三步：打开 「Windows To Go」 之后会出现如下画面，选择你所需要的外置存储并按下一步。

![img](https://cdn.sspai.com/2018/06/02/3ef37e30bd5de151a06fb559f8eedbaa.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

这里有一个地方需要注意，如果你碰到如图所示的提示的话，可以不用理会它，直接点击下一步即可。如果在选择好外置存储后发现下一步按钮为灰色的话那说明你的外置存储没有达到官方的标准，需要更换一个以继续。

第四步：在单击下一步之后会来到选择 Windows 映像的界面，在这里选择**企业版**，选择其他版本的话会导致无法继续。如果你已经装载好镜像但是没有看到选项的话，那么点击下方的「添加搜索位置」，接着选择装载好镜像的盘符即可。

![img](https://cdn.sspai.com/2018/06/02/40d8f479b363fe06ddbc9045e60b27c0.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

第五步：接下来就来到了设置 BitLocker 密码的界面，这个的话就根据个人喜好来决定设置或者是不设置了。

![img](https://cdn.sspai.com/2018/06/02/4914e892615f0d5105124253a86bade8.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

第六步：之后，WTG 工具会再次提示你**备份好你的数据**，并在下一步**格式化你的外置设备**。确认完成后点击「创建」，接下来就等待着进度条完成吧。

![img](https://cdn.sspai.com/2018/06/02/d2ac482051d228e08950d7888b565d29.jpeg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

第七步：当进度条完成后，WTG 工具会提示你是否在下次传奇电脑时从该 WTG 工作区启动，这里我们选择「否」并根据需要点击下面的选项。至此，官方工具安装 WTG 的步骤就结束了。

![img](https://cdn.sspai.com/2018/06/02/abfa637867e62c89e57f401d8c0c124b.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

可以发现，官方 WTG 工具在安装 WTG 时会有三个条件：

- 本机系统环境要求偏高，这一点在上面也有提到过。
- 对 Windows 镜像要求非常严格，**必须为企业版**，否则无法安装。
- 对外置存储要求较高，不过这一点的话只要你使用的是高性能固态硬盘或者是 U 盘的话基本上可以无视，它们的性能不比认证的驱动器差。

#### 使用第三方工具安装

官方工具固然方便，不过它的「方便」也是建立在符合条件的前提之下，如果有一条不符合的话那么走官方的这条路就行不通了。不过现在网上有许多大神制作出了安装 WTG 的工具，我们只需使用这些工具即可避免大多数麻烦。

在网上有许多制作 WTG 的第三方工具，在这里我们选取比较知名的 [WTG 辅助工具](https://sspai.com/link?target=https%3A%2F%2Fbbs.luobotou.org%2Fthread-761-1-1.html) 以向大家展示第三方工具的使用方法。

第一步：同样的，连接外置设备，装载你的 Windows 10 镜像。在这里你可以装载**任意版本的 Windows** 镜像。

第二步：打开 WTG 辅助工具，来到以下界面。

![img](https://cdn.sspai.com/2018/06/02/68782094a3d52182999ed32159053d2f.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

第三步：选择你的外置设备和 Windows 镜像，如果你想知道你的外置设备的性能如何，你可以点击「性能测试」按钮。右边的高级选项的话你可以根据需要自行调整，一般情况下**保持默认**即可。

第四步：点击「创建」，会出现一个警告窗口，确认后点击「是」，接下来就等待安装完成吧。

![img](https://cdn.sspai.com/2018/06/02/32f4a0dba01d441790a032e6a80b7ea1.jpeg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

相对于官方工具来说，第三方工具的限制要求没有那么高，并且还有很多高级选项供用户自定义，极大地方便了我们使用。

### 使用 WTG

安装好了 WTG 之后，接下来的工作就是使用 WTG 了。按照官方的说法，你可以把你的 WTG 带到任何的兼容设备上使用。那么接下来我们就来看看 WTG 的实际体验吧。

#### 在 Mac 上使用

在 Mac 上第一次设置 WTG 之前，除了刚刚做好的 WTG U盘，你得先准备好以下两样东西：

- 一个兼容 Windows 的鼠标；
- 一个 8G 以上的 U 盘。

注意，如果你的 MacBook 的 USB 接口不够用的话，你还得准备一个**至少三个口**的 USB HUB 用来转接以上设备。

准备好之后，接下来就跟着我的步骤来使用 WTG 吧。

第一步：在 macOS 中启动「启动转换助理」，点击菜单栏中的「操作」，然后选择「下载 Windows 支持软件」。

![img](https://cdn.sspai.com/2018/06/02/41fcb6f270ffb869af82ffcb5ab1a8c7.png?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

第二步：选择 Windows 支持软件的下载位置，点击「存储」，之后等待下载完成。

![img](https://cdn.sspai.com/2018/06/02/68f65a426d169edc126bd194eb73f06c.png?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

第三步：将下载好的 WindowsSupport 文件夹复制到你准备好的 U 盘上。

第四步：将你的 Mac 关机，接上你的 WTG 设备。然后在开机时按住 option，待显示启动选项之后选择橙色的「EFI Boot」，这个「EFI Boot」就是你的 WTG 启动盘。

![img](https://cdn.sspai.com/2018/06/02/b5eb018c0e4d0743d470d31a07af3960.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

第五步：选择好之后，你的 Mac 的屏幕上会出现 Windows 徽标，等待 Windows 准备好之后会出现设置界面。

![img](https://cdn.sspai.com/2018/06/02/5705d32dd78a42cc0841aa7c14535ebf.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

这时你会发现 Mac 的触控板和键盘**都不能使用**，所以接上你刚刚准备好的鼠标，继续进行设置。

![img](https://cdn.sspai.com/2018/06/02/4ff84bfc064b371400a9206fa00a5585.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

到了输入用户名的步骤时，由于键盘无法使用，这时就得另想办法了，如果你有外接键盘的话是最好的，如果没有的话也不用着急，看到左下角的辅助功能按钮吗？用鼠标点击它，然后选择「屏幕键盘」，这时候就可以继续设置了。

![img](https://cdn.sspai.com/2018/06/02/a45376f92a813f015d3263721a02ff33.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

第六步：按照步骤一步步的设置下去，直到进入桌面。除了电脑自带的触控板和键盘，这时的蓝牙、Wi-Fi 和其他的很多功能也都**无法使用**，所以我们得安装 Apple 提供的 Windows 驱动。接上你刚刚准备的 U 盘，**打开 WindowsSupport 文件夹里的 BootCamp.exe 文件安装驱动**。安装完成之后，自带的键盘、触控板蓝牙、Wi-Fi 等功能就能正常使用了。

![img](https://cdn.sspai.com/2018/06/03/f06fc13ec7256f4f1f9d0d97756be417.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

接下来，你就可以把 Mac「变成」一台 Windows 电脑来用了。

#### 在 PC 上使用

相对于 Mac，在 PC 上使用 WTG 则简单许多。由于 Windows 自带绝大多数 PC 上硬件的驱动，所以不必像 Mac 一样考虑驱动问题。

第一步：按照你的 PC 厂家提供的方法进入启动引导界面，选择你的 WTG 启动盘并回车。

![img](https://cdn.sspai.com/2018/06/02/6cda5c18aaf478803fab103010d33119.jpg?imageView2/2/w/1120/q/90/interlace/1/ignore-error/1/format/webp)

这里提一下，如果你碰到和图上一样的情况，不知道哪个是你的 WTG 启动盘的话（即有两个「Windows Boot Manager」），那么就看后面的硬盘名称以进行区分。

第二步：如果这是你第一次设置 WTG 的话，那么只需按照提示进行设置即可。进入桌面之后，可能会发生某些驱动没有安装的这种极少数情况。这时只需从该硬件的官方网站中搜索驱动并下载即可。

#### 注意事项

在一切准备就绪之后，你就可以享受 WTG 带来的各种便利了。不过在使用时有几点问题还是值得注意的。

- **内部磁盘处于脱机状态**。为保证安全，默认情况下在 WTG 下你不能访问主机的磁盘，当然也有方法将其打开，感兴趣的朋友可以自行查找，这里由于篇幅原因便不再展开。
- **默认情况下，禁用休眠功能**。为确保 WTG 工作区能够随意移动，默认情况下禁用休眠功能。你也可以使用组策略打开该功能。
- **不支持升级 WTG 工作区**。如果你想升级的话，必须以全新安装的方法重新安装 WTG。
- **尽量不要在使用中拔掉 WTG 启动盘，特别是机械硬盘**。在拔掉硬盘后系统会提示你有 60 秒的时间重新插入 WTG 硬盘，否则将关机。并且由于 WTG 启动盘在运行 Windows 时会一直读写数据，如果在此时拔掉硬盘的话将会对硬盘造成较大的损害。

### 总结

WTG 这个功能着实方便了那些对 Windows 有临时需求的小容量 Mac 用户，不占用本机的空间，并且不想使用时还可以随时拔掉。但它也有缺点，就是需要**一直占用**你的那宝贵的接口，这个缺点在我的 12 英寸 MacBook 上尤其突出。

不过瑕不掩瑜，它带来的便携性可以说是史无前例的。如果你是那种不喜欢带电脑，并且要从家到公司两边跑的人，或者只是偶尔使用 Windows 的 Mac 用户的话，相信这个功能一定会很适合你。

------

关于 Windows To Go 的更多细节，欢迎继续阅读《[把 Windows 带在身上，藏在腰间](https://sspai.com/post/42900)》

\> 下载少数派 iOS [客户端](http://sspai.com/s/nqQk)、关注 [少数派公众号](http://sspai.com/s/KEPQ)，让智能设备陪伴你成长 🙆

383

60

[#热门文章](https://sspai.com/tag/热门文章)

[#Mac](https://sspai.com/tag/Mac)

[#Windows](https://sspai.com/tag/Windows)