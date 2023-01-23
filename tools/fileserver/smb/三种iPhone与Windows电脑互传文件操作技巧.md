# 实用！三种iPhone与Windows电脑互传文件操作技巧，建议收藏 

2020-04-13 17:35

如果你是苹果全家桶用户，一定会对 「AirDrop（隔空投送）」 功能赞誉有加，使用 AirDrop 可以在 iPhone 与 MacBook、iPad 等设备之间快速传递照片、视频或文件。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/2944398104cb405e90a673e8141305ea.jpeg)

遗憾的是，「AirDrop 仅限苹果设备之间使用」，而很多小伙伴应该和小兽一样，更习惯用 Windows 系统的电脑，没有了 AirDrop，我们可以用什么工具来快速传送文件呢？

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/7a4156349a584e4a8bdd2ae582bb4319.jpeg)

估计很多人日常是通过微信、QQ 自带的「文件传输助手」来与电脑互传文件，这种方式没什么问题，但也确实麻烦，而且不适合传送大文件。其实没必要用聊天工具，下面小兽就来分享三种更棒的方法，收藏起来你一定能用上。

文件 App

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/5b536cbbaaad45afb5ce8cb75be5ef9b.jpeg)

苹果在 iOS 13 系统对内置的文件 App 功能进一步加强，不仅支持 iPad 读取 U 盘，而且「支持连接 SMB 服务器」，这就提供了一个 iPhone 与 Windows 电脑互相传输文件的途径。

> SMB（Server Message Block）是一种在局域网上共享文件以及打印机的一种通信协议，它可以为局域网内的不同操作系统的计算机之间提供文件及打印机等资源的共享服务。

我们首先要做的，就是在 Windows 系统电脑上创建一个共享文件夹。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/1efd022b9b3742dca629365bf48f2701.jpeg)

右击文件夹选择「属性」，在「共享」选项卡里面点击「高级共享」，勾选「共享此文件夹」。再点击「权限」，为“Everyone”用户允许所有权限。这样设置以后此文件夹就会在局域网内共享了。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/0e12bcecf5d24e12b217b8364867eec9.jpeg)

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/2f98ec25228b41058c101473abf4f74b.jpeg)

那其他设备如何发现这个共享文件夹呢？这就要知道这台电脑的 IP 地址（内网）才行。键盘点击「Windows 徽标键+R」弹出运行，输入「cmd」打开命令提示符。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/87409813d8ea4567af95762da407203e.jpeg)

在命令提示符里面输入「ipconfig」回车执行，查看当前网卡的 IPv4 地址，这个地址我们待会要用到。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/5ed73f21add548e88369806a4ac21018.jpeg)

输入inconfig查看ip地址

之后轮到 iPhone 操作了，首先确保 iPhone 与 Windows 电脑处在同一个网络下，然后打开文件 App。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/8b3cdd5e0d4a42ba9ed91d3d0d46cdf5.jpeg)

点击右上角 「···」，选择「连接服务器」，服务器地址输入刚刚获取的电脑 IP，点击连接。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/6e1234a899c445a1bc50747b3ed7fc01.jpeg)

输入电脑用户名与密码，下一步。接着就会看到电脑上共享的文件夹了。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/199c8d29ba2344098190e0e954454232.jpeg)

可以直接拷贝电脑共享文件夹内的文件，如果是视频、照片的话也能直接播放或保存到 iPhone 相册，非常方便。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/b74a6e21865c49aa93b4d3e89a89f0d3.jpeg)

当然也可以将 iPhone 手机上的文件传到共享文件夹里面。比如相册中的照片，点击「存储到“文件”」，选择连接的电脑与文件夹，这样存储就会直接发送到电脑了，比使用什么文件传输助手方便太多。

Documents

上面的方法使用的是 iOS 13 的文件 App，小兽用了几天以后发现不是很稳定，经常要重新连接（苹果的锅）。如果你也感觉不够稳定，可以试试用第三方 App 比如 Documents 来替代它。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/c367a38e31364e01a2ba08b731368ec9.jpeg)

「Documents」 是一款备受好评的免费工具，App Store 搜索即可下载。

> 注意：第一次打开 Documents 提示内购 PDF 功能，跳过即可。

打开 Documents 以后进入「连接」界面，选择「Windows SMB」，随便起一个标题比如办公室，URL 后面填写电脑的 IP 地址。输入电脑用户名和密码以后点击完成进行连接。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/fb0319ea6cb74a0f90b24ac99d23b516.jpeg)

连接成功后电脑上面的共享文件夹就会出现了，各种操作全都支持。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/82ed5172a7bb4619834fef1d81383a5d.jpeg)

Documents 比 iPhone 自带的文件 App 功能更强也更加稳定，至少目前是这样，两者的使用前提相同：要求 Windows 电脑共享文件夹、iPhone 与电脑处在同一个局域网。

小编猜测有许多小伙伴感到麻烦，又是共享文件夹，又是获取 IP 地址什么的，电脑小白搞不定呀！「有没有更简单的方法呢？」

有的！下面这个方法就很简单，不需要共享文件夹、也不需要下载任何 App，会上网就能学会！

Snapdrop

Snapdrop**[1]**是一个开源的文件传输工具，可以在 Windows、Mac、Linux、iOS、Android 任何平台使用，只要浏览器支持 WebRTC 就可以（Chrome、Safari 都能用）。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/851f1ca7d42549b18665446c3bac8a45.jpeg)

> 必须要提到的一点：Snapdrop 提供的文件传输是基于 P2P（点对点）进行的，传送的「文件不会上传到任何第三方服务器」，因此「传输速度与文件大小没有任何限制」，也不必担心有隐私泄露的风险。

电脑使用 Chrome 浏览器、iPhone 手机使用 Safari 浏览器，打开下面的网址：

「snapdrop.net」

网页上会出现相同局域网下访问 snapdrop 的浏览器，iPhone 点击屏幕上出现的电脑端浏览器图标，可以发送照片或文件，电脑端的浏览器则会弹出下载框。不需要通过任何服务器进行中转，传输速度非常快。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/39d1638b5e214ff8b2177f2b409b47ea.jpeg)

另外，长按图标可以快速发送一段文字，另一端收到后能直接复制，体验非常棒。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/761511b0229f485e865181d1ef96c128.jpeg)

因为是通过浏览器进行的传输，所以 snapdrop 同样可以用于在 iPhone 与安卓手机之间互传文件，只要同处在一个局域网就可以。

![img](http://5b0988e595225.cdn.sohucs.com/images/20200413/098270b4a0134074b72e5120eac4b35f.jpeg)

目前 Snapdrop 没有任何广告，使用起来也极其简单。如果你觉得还不错，可以点击 Safari 浏览器的分享按钮，将其「添加到主屏幕」，这样以后用到的时候直接点击桌面图标就能打开。

最后的话

虽然 Windows 没有 AirDrop 功能，但通过以上三种方式，iPhone 与电脑互传文件的操作也能变得更简单。「收藏起来，相信以后你会用上！