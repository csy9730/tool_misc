# 说说SSH、SCP和SFTP的那些事儿

2018-02-12阅读 13.2K0

![img](https://ask.qcloudimg.com/http-save/yehe-1008345/y5a5mj6dwv.jpeg?imageView2/2/w/1620)

## **SSH、SCP和SFTP都是SSH软件包的组成部分。**

SSH 是 Secure Shell 的缩写，由 IETF 的网络小组（Network Working Group）所制定；SSH 为建立在应用层基础上的安全协议。SSH 是目前广泛采用的安全登录协议，专为远程登录会话和其他网络服务提供安全性的协议，替代以前不安全的Telnet协议。利用 SSH 协议可以有效防止远程管理过程中的信息泄露问题。

SSH包括二个部分，服务端的SSHD（Secure Shell Daemon）和SSH客户端。我们通常所说的用SSH登录到某某主机，指的是用SSH客户端远程登录到某台主机（该主机运行了SSHD服务端程序）。

SSH最初是UNIX系统上的一个程序，后来又迅速扩展到其他操作平台，目前几乎所有UNIX平台—包括HP-UX、Linux、AIX、Solaris、Digital UNIX、Irix，以及其他系统平台，都可运行SSH。

　　**再说一说SCP和SFTP。**

SCP是Secure Copy的简称，是用来与远程主机之间进行数据传输的协议，相当于经过加密的Copy命令。SCP数据传输使用 ssh协议，并且和ssh 使用相同的认证方式，提供相同的安全保证 。 根据实际需要，scp进行验证时会要求你输入密码或口令。

SFTP=SSH File Transfer Protocol ，有时也被称作 Secure File Transfer Protocol 。SFTP是用SSH封装过的FTP协议，相当于经过加密的FTP协议，功能与FTP一样，只是传输数据经过加密。

SFTP也有二个部分，服务端的SFTP-Server及SFTP Client。通常所说的用SFTP登录到某台主机，指的是用SFTP客户端登录到某台主机（该主机运行了SFTP-Server服务端程序）。

## **SCP和SFTP异同：**

不管SCP还是SFTP，都是SSH的功能之一，也都是使用SSH协议来传输文件的。

不只是登录时的用户信息，相互传输的文件内容也是经过SSH加密的，所以说SCP和SFTP实现了安全的文件传输。

SCP和CP命令相似，SFTP和FTP的使用方法也类似。SCP和SFTP的共同之处在于「使用SSH将文件加密才传输的」

使用「WinSCP」或者「FileZilla」之类的客户端，还可以和Windows之间进行文件传输。

SCP和SFTP的不同之处，首先就是之前提到的，SCP使用「SCP命令」，SFTP则类似「FTP处理文件」的使用方式。

它们的不同之处还不止如此，还有「SCP比较简单，是轻量级的，SFTP的功能则比较多」。

虽然还有很多不同之处，但二者的最大不同之处在于「SFTP在文件传输过程中中断的话，连接后还可以继续传输，但SCP不行」。

由于各种原因导致的文件传输中断是经常讨论的话题，所以这个区别（SFTP支持断点续传，SCP则不支持）被认为是最大的区别。

【知识扩展】

FTP：文件传输协议（ File Transfer Protocol的缩写 ）是用于在网络上进行文件传输的一套标准协议。它属于网络协议组的应用层。

FTP端口知识：

FTP服务器和客户端要进行文件传输，就需要通过端口来进行。FTP协议需要的端口一般包括两种：

控制链路---TCP端口21。控制器端口，用于发送指令给服务器以及等待服务器响应。所有你发往FTP服务器的命令和服务器反馈 的指令都是通过服务器上的21端口传送的。

数据链路---TCP端口20。数据传输端口，用来建立数据传输通道的。主要用来从客户向服务器发送一个文件、从服务器向客户发送一个文件、从服务器向客户发送文件或目录列表。数据链路主要是用来传送数据的，比如客户端 上传、下载内容，以及列目录显示的内容等。

FTP、Telnet和POP，其本质上都是不安全的；因为它们在网络上用明文传送数据、用户帐号和用户口令。

## **常见的SSH客户端：**

图形化客户端：

WinSCP，是一个Windows环境下使用SSH的开源图形化SFTP客户端。同时支持FTP、SCP、webdav协议。它的主要功能就是在本地与远程计算机间安全的复制文件。

Xftp，是一个基于 MS windows 平台的功能强大的SFTP、FTP 文件传输软件。使用了 Xftp 以后，MS windows 用户能安全地在 UNIX/Linux 和 Windows PC 之间传输文件。

FileZilla是一个免费开源的FTP软件，分为客户端版本和服务器版本，具备所有的FTP软件功能。支持FTP，SFTP(SSH File Transfer Protocol)， FTPS(FTP over SSL/TLS)等多种协议。

终端工具类：

PuTTY是一个Telnet、SSH、rlogin、纯TCP以及串行接口连接软件。PuTTY是一款开放源代码软件，使用MIT licence授权。

Xshell 是一个强大的安全终端模拟软件，它支持SSH1, SSH2, SFTP以及Microsoft Windows 平台的TELNET 协议。