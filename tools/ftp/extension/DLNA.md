# DLNA



Part 1. 简介
Part 2. 常见的手机应用场景
Part 3. DLNA 认证的设备
Part 4. DLNA 的一些显著特点**（** 3月5日补充**）**

**Part 1. 简介**

DLNA - Digital Living Network Alliance 作为一个老旧的标准，仍然有其存在的必要，因为这些以 SONY 为首的不思进取的厂商既不更新 DLNA，也没有推出类似的其他标准！坐视 AirPlay 蚕食这片大市场。

DLNA 2003年诞生是为了能够把当时相互独立的电视机及其相关设备（功放、音响、DVD/蓝光播放机）、PC及其相关设备（数码相机、音乐播放器）和移动电话在家庭中有机地整合起来，使得多媒体内容能够在各个设备上便捷地播放。

**Part 2. 常见的手机应用场景**

**通常 Android 手机中的 DLNA 功能是把手机作为 DMS(Digital Media Server) 或者 DMC(Digital Media Controller) 这两种角色。**有时候也作为 DMP (Digital Media Player) 或者 DMD(Digital Media Downloader) 或者 DMU(Digital Media Uploader) 查看/下载/上传网络上其他服务器的内容，不过这些功能很多厂商并不一定实现了。【注1】

此时你需要**连上局域网**，如果局域网中存在 DMP(Digital Media Player) 或者 DMR(Digital Media Render)，通常是电视或者音响，**就可以把手机上**（也可以是同一个网络上的 NAS 或者其他服务器）的**内容通过网络在电视或者音响上播放**。如果局域网中存在 DMPr(Digital Media Printer)，就可以把手机上或者其他服务器上的照片透过网络打印出来。

场景一：通过网络可以把手机上播放的本地照片、视频或者照片在电视或者扬声器播放，需要手机端软件支持，同时电视或者扬声器支持。

下图以 SONY Xperia Z2 及自带的 Album 程序为例，简述一下使用过程。打开一张图片后，点击菜单如图一即出现 Throw【注2】，点击 Throw 即出现搜索框，搜索网络中可用于传输的设备（此处包含 DLNA 和 WiFi Direct）。如果网络中支持 DLNA 的电视，即刻就会出现在搜索结果中，DLNA 是基于 UPnP 的，不需要双方做任何设置，就可以完成推送过程。

![img](https://pic4.zhimg.com/50/fd5dd9b01fb62975910ebe060e7d07ae_hd.jpg?source=1940ef5c)![img](https://pic4.zhimg.com/80/fd5dd9b01fb62975910ebe060e7d07ae_720w.jpg?source=1940ef5c)

![img](https://pic2.zhimg.com/50/b1ac6c595e0e74a15c2ba16639f1e246_hd.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/b1ac6c595e0e74a15c2ba16639f1e246_720w.jpg?source=1940ef5c)

场景二：通过网络可以把手机上播放的

在线

照片、视频或者照片在电视或者扬声器播放，需要手机端软件支持，同时电视或者扬声器支持。



场景三：通过手机控制卧室的电视或者扬声器播放客厅联网的 Play Station 3/4 上的多媒体内容。

场景四：打开手机上的 DMS(Digital Media Server) 功能，通过电视或者播放器可以选择播放手机上的多媒体内容，要求电视支持相关功能。
下图是在 SONY Xperia Z2 上，设置 -> Xperia 连接 -> 媒体服务器设定 的界面，打开此服务器，处于同一网络下的支持 DLNA 的电视或者 Play Station 3/4 就可以浏览此手机上的多媒体内容了。浏览之前需要在手机端进行批准（这一步并非必需，因为有些手机厂商可能是预置为默认批准的。）这界面一看就知道从我多年前开发以后就没怎么动过，嘻嘻。

![img](https://pic2.zhimg.com/50/9d2bb92a341c60dcba9f2d9e88eb61ff_hd.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/9d2bb92a341c60dcba9f2d9e88eb61ff_720w.jpg?source=1940ef5c)



还有很多使用场景如下，不过都需要相关的设备支持：

- 多个屏幕或者扬声器同步播放同一内容
- 客厅看到一半到卧室继续看
- 手机双向同步更新局域网中的 DLNA 服务器的多媒体数据

【注1】严格来说，手机上的 DLNA 角色都应该加上 M(obile) 前缀，不过为了理解方便，就不引入过多的概念。而且事实上对于用户日常使用来说 M-DMS 和 DMS 并无区别。
【注2】『Throw』是索尼关于 DLNA 使用的特有品牌，并非所有的手机中都叫 Throw，特此澄清。据我所知，三星手机的 DLNA 功能叫『AllShare』，其他的不知道了，欢迎补充。

**Part 3. DLNA 认证的设备**

支持 DLNA 的设备还算比较多，可以购买的时候看包装上是否有 DLNA 认证的 logo。不过国内很多厂商省钱都没有过 DLNA 认证，可能没有这个标志，不过只要宣称支持的话，日常使用应该问题不大。

![img](https://pic1.zhimg.com/50/fabba08b0c3c8b6b1756bd7d89aa8c79_hd.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/fabba08b0c3c8b6b1756bd7d89aa8c79_720w.jpg?source=1940ef5c)

首先，最常见也是最常用的电视。通常 DLNA 联盟内的电视厂商出的电视都带有 DLNA 认证，比如 SONY / SamSung / LG 几乎全线都支持，其他大厂比如 Panasonic 应该中高端的也都有。其次，像扬声器、DVD 机、蓝光机、机顶盒、路由器、NAS、Play Station 都有很多支持的，打印机现在比较难找了，不过确实还有。所有这些东西支持最全的应该就是 SONY 的产品线了，毕竟 SONY 是 DLNA 的 Founder。



**国内常见的支持 DLNA 的设备：**SONY 目前在卖的有 RJ45 接口（网线口）的电视，几乎全线支持
SamSung / LG 目前在卖的大部分电视（因为不了解，所以低端的不敢保证，目前我个人就是用的三年前买的三星的，DLNA 没问题）
Netgear 、Cisco 和 华硕 500RMB+ 的路由器，原生固件都带 DLNA Server。（因为不了解，所以低端的不敢保证。其他大厂像 Baffulo / Belkin / D-Link 应该也都有，不过没用过不敢保证）其他路由器只要能刷 DDWRT/Tomato/OpenWRT 也都能支持 DLNA Server。
群晖 NAS 全线完美支持 DLNA
Play Station 3/4 完美支持 DLNA

**Part 4. DLNA 的一些显著特点（** 3月5日补充**）**

简单谈一下 DLNA 的特点，由于是早年的标准且很久未更新，我手头上最新的是 2009 年8月的 Guideline，这份 Guideline 要成为会员才能拿的到，国内很多厂商都是会员，像小米/Oppo/魅族/华为/中兴等等（据说成为会员要交10000刀？欢迎知情者核实）。所以这个协议的特点非常突出：

\1. 在服务器端 (DMS/M-DMS)，多媒体数据不是以文件夹的结构 Publish 给客户端的。而是以 Meta-data 为结构的。比如音乐是按照年份和流派等属性分类的，完全没有文件夹结构的。

\2. 服务器端的多媒体文件会有多种编码格式 Publish 给客户端，以供选择。举个例子，服务器端存储的 wav 音频文件，客户端如果不支持的话，服务器端会提供 mp3 的版本给客户端播放或者下载。图片和视频也一样。呵呵，好玩吧，估计是早年电视、扬声器之类的能够支持的格式比较少，所以才规定成这样子。

\3. 不支持外挂字幕。其实说实在的，理论上也不是不能支持，视频实时编码都做了，再实时加个字幕嵌进去也不是什么难事儿。不过日本厂商对这种事情完全没兴趣，他们只关心各种加密解密 DRM 啊，DTCP-IP 啊什么的。看哪天国内厂商有兴趣做一做吧，如果不违反 DLNA 的规定的话。

\4. DLNA 的 3-box 模式很好，反正我个人很喜欢。就是把网络上的内容通过手机推送到电视或者扬声器，手机只是起到一个控制的作用，数据流是可以不经过手机的，这样的话只要电视或者播放机是有线连接的话，就不会受到无线的速度限制。这一点是比 AirPlay 要好的。在播放 NAS 大码率高清影片和卧室观看客厅蓝光播放机内容时，就会很从容了。而且手机也不耗电，关机也不影响。:)