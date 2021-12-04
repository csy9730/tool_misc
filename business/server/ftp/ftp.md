# ftp

FTP服务（File Transfer Protocol，文件传输协议）是典型的C/S结构 的应用层协议，需要由服务端软件，客户端软件两部分共同实 现文件传输功能。既可以在局域网使用，又可以在广域网使 用。

FTP协议主动（Port）模式和被动（Passive）两种模式

当我们对FTP协议进行学习的时候，你首先要考虑到的一个问题是使用的是port模式（主动）的还是passive模式（被动）。在过去，客户端缺省为主动模式；近来，由于Port模式的存在安全问题，许多客户端的FTP应用缺省变为了被动模式。FTP是仅基于TCP的服务，不支持UDP。 与众不同的是FTP使用2个端口，一个数据端口和一个命令端口（也可叫做控制端口）。通常来说这两个端口是21－命令端口和20－数据端口。


## server

windows可用：
- windows自带ftp服务端, IIS
- FileZilla Server
- [Wing Ftp server](https://www.wftpserver.com/download.htm)，收费软件 

linux下有：
vsftpd

## client

- windows 下的ftp 命令行
- FileZilla Client
- explorer ，容易阻塞，不方便使用
- chrome 浏览器，逐渐不支持ftp
- android 可以使用 ES浏览器
