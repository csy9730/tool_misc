# download tools

## download 协议
### P2P
P2P 是一种协议，BT、ED2k（电驴）都是基于 P2P 。
磁力链接 只是 BT 种子的一种储存方式，解析磁力链接后就会获得 BT 种子文件，然后再进行 BT 下载。
FTP 只要支持常规 HTTP 下载的软件都会支持的。

用种子下载和磁力下载，在本质的下载方式上是一样的：都是P2P下载

他们的区别：仅仅是寻找其他下载者的方式不同
### uTP
uTP 是Torrent 2.0 及更高版本使用的一种便于使用的新 BitTorrent 协议 – 它大大提高了网络宽带的使用效率，同时减少了网络问题的发生。uTP 可以在缩短网络时间和减少拥塞的同时最大化网络吞吐量 – 当网络超载时（此时进行发送和接收只能让情况变得更糟！），它会自行放慢速度– 这样，不仅提高了用户的下载速度，而且降低了网络问题对用户和 ISP 造成的影响。

### eD2k
典型的、基础的eD2k文件链接只包含必要的三样信息：文件名、文件大小、文件的eD2k Hash。形如：
`ed2k://|file|<文件名>|<文件大小>|<文件Hash>|/`
eMule也可兼容带HTTP来源的eD2k链接，形如：
`ed2k://|file|<文件名>|<文件大小>|<文件Hash>|s=<文件的HTTP地址>|/`
### 磁力连接
磁力连接：`magnet:?xt=urn:btih:48f5ec0f623b4021b94b3c02a242ad0eef4103ea`

### 协议转码
迅雷链接，包括曾经的快车链接、旋风链接都不是协议，只是单纯对字符串做一些编码操作，好让别的下载软件识别不了，而自家的软件因为知道解码规则所以可以。

但是网上有可以解码的工具：https://tool.lu/urlconvert/

#### Internet Download Manager
Internet Download Manager
#### FreeDownloadManager
[Free Download Manager](https://www.freedownloadmanager.org)
完全免费的 Free Download Manager（以下简称 FDM）。除了智能限速、断点续传、计划任务、网页抓取等常规功能外，FDM 还支持在下载同时预览播放音视频文件。此外，它也支持 BT 磁力链接，同时支持直接浏览 FTP 服务器目录，是一款轻巧而强大的下载工具佳选。


#### aria2
首先介绍一下 Aria2，这是一款开源的跨平台下载工具，占用少、体积轻盈而功能强大，支持 HTTP、HTTPS、FTP、SFTP、BitTorrent 和 Metalink 等众多下载协议，是极客们的下载神器。
#### Persepolis Download Manager
Aria2 需要学习使用命令行操作，编写复杂的配置文件，门槛居高不下。而 PDM 就是专为大众打造的 Aria 图形界面客户端，它同样支持 Aria2 的各种功能，但是所有界面均直观易懂，推荐给想尝试 Aria2 的各位使用。

文件名称：Persepolis Download Manager (Windows 64位)

零配置！Persepolis Download Manager 开源的 Aria 2 图形界面版下载工具
Persepolis Download Manager (简称 PDM) 是一款封装了 Aria2 作为内核，并为其套上图形界面的开源免费下载软件。它能让你享受 Aria2 一切的特性，同时又帮助你完全跳过安装和配置 Aria2 那些繁琐的过程，并且有一个图形化的直观界面供你用鼠标进行操作，你就像用迅雷、Folx 等下载工具一样的简单明了，而不必再对着命令行发愁。

[persepolis](https://github.com/persepolisdm/persepolis)
#### Qdown
Qdown也是集成aria2，但是在此基础上支持路由器穿透（UPnP）等功能，比原始的aria2好用很多，而且下载速度也更快，链接：

## misc
 BaiduPCS-Go, amule、transmission， uget
