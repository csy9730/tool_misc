# [Git 常用的几种处理大型二进制文件的组件](https://www.oschina.net/news/71365/git-annex-lfs-bigfiles-fat-media-bigstore-sym)

来源: OSCHINA

编辑: [oschina](https://my.oschina.net/osadmin)

2016-03-09

[ 5](https://www.oschina.net/news/71365/git-annex-lfs-bigfiles-fat-media-bigstore-sym#comments)

[数据湖、Serveless、微服务、边缘计算，大厂的「云原生」都怎么玩？>>> ![img](https://www.oschina.net/img/hot3.png)](https://cloud.tencent.com/developer/salon/live-1359?channel=oschina)

![img](http://static.oschina.net/uploads/space/2016/0309/160505_EgI5_1774694.png)


**Git大文件存储（Large File Storage，简称LFS）**的目标是更好地把“大型二进制文件，比如音频文件、数据集、图像和视频”集成到Git的工作流中。**众所周知，Git在存储二 进制文件时效率不高**，因为：Git默认会压缩并存储二进制文件的所有完整版本，如果二进制文件很多，这种做法显然不是最优。因此，在Git仓库处理大量的二进制文件似乎是很多Git用户的瓶颈。由于Git的分散性，这意味着每个开发人员对文件的操作是变化的，对二进制文件的更改导致Git仓库文件不断变化增长。当数据文件需要恢复的时候，这就变成一个很难操作的问题。存储虚拟机映像的快照，改变其状态，并存储新的状态到Git仓库将与各自的快照的大小约为成长库的大小。如果这是你的团队每天的日常运作，你可能已经感受到来自过度肿胀Git仓库的痛苦。

**本文将介绍几种常用的处理大型二进制文件的组件，旨在为你解决上述问题。**

[**Git annex**](http://www.oschina.net/p/git-annex) : 允许映射 Git 资料库到文件，Git annex 采用 [Haskell Script](http://www.oschina.net/p/haskell) 编写。

[**Git LFS**](http://www.oschina.net/search?scope=project&q=git+LFS) : 一个命令行扩展和规范用于利用Git来管理大文件。其客户端采用Go开发，为Mac, Windows, Linux, and FreeBSD提供预编译好的binaries。

[**Git bigfiles**](http://www.oschina.net/p/git+bigfiles) : 提供了Python接口，允许用户处理没有存储在Git上的大文件。

优点：

Git 操作可以回滚。

可以设置文件大小的阈值，以限定“大文件”这个概念。

缺点：

存在兼容性问题。

[**Git fat**](http://www.oschina.net/p/git-fat) : 可以简单的处理一些比较大的文件，而无需提交到Git。同时，Git-fat 也支持 rsync 同步处理。

优点：
    使用透明

缺点：
    仅支持rsync的作为后端。



[**Git media**](http://www.oschina.net/p/git+media) : 可能是可供选择的最古老的多媒体处理方案。 Git media使用类似过滤器，并支持亚马逊的S3，本地文件系统路径，SCP，ATMOS和WebDAV作为后端存储大文件。 Git media是用Ruby编写的。

优点：
    支持多种后端
    使用透明
缺点：
    不再发展。
    含糊的命令（e.g. git update-index --really refresh)）。
    并不完全与Windows兼容。



[**Git bigstore**](http://www.oschina.net/p/git+bigstore) : 最初实现是作为 [Git media](http://www.oschina.net/p/git+media?fromerr=3psbVGbr) 替代品。它支持Amazon S3的，谷歌云端存储或Rackspace公司云帐户作为后端存储二进制文件。Git bigstore 提高协同开发时的稳定性。 Git bigstore是根据Apache 2.0许可授权。Git bigstore是用Python编写，需要Python2.7以上的运行环境。

优点：

仅需要Python2.7以上运行环境

使用透明

缺点：

目前只支持基于云存储。

[**Git sym**](http://www.oschina.net/p/git-sym) : 是一款通过git符号链接的进行大文件处理的软件，其目的是从修订控制中分离出庞大的文件缓存。

结论：

有多种方式来处理Git仓库大型二进制文件，其中许多人使用几乎相同的工作流程和方法来处理这些文件。然而，一些解决方案都不再积极开发，因此，**选择一个有技术支持的解决方案尤为重要**。如果Windows支持或透明度是一个必须具备的条件，你最好选择Git LFS，因为它会被长期支持。