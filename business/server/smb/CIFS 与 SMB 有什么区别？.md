# CIFS 与 SMB 有什么区别？

```
https://www.getnas.com/2018/11/30/cifs-vs-smb/

网络协议 一知半解 学习一下挺好的.. 

记得 win2019 已经废弃了CIFS1.1的协议. 
```

 

## SMB

Server Message Block - SMB，即服务(器)消息块，是 IBM 公司在 80 年代中期发明的一种文件共享协议。它只是系统之间通信的一种方式（协议），并不是一款特殊的软件。

SMB 协议被设计成为允许计算机通过本地局域网（LAN）在远程主机上读写文件。远程主机上通过 SMB 协议开放访问的目录称为 `共享文件夹`。

## CIFS

Common Internet File System - CIFS，即通用因特网文件系统。CIFS 是 SMB 协议的衍生品，即 CIFS 是 SMB 协议的一种特殊实现，由美国微软公司开发。

## CIFS 与 SMB

由于 CIFS 是 SMB 的另一中实现，那么 CIFS 和 SMB 的客户端之间可以互访就不足为奇。

二者都是协议级别的概念，名字不同自然存在实现方式和性能优化方面的差别，如文件锁、LAN/WAN 网络性能和文件批量修改等。

## CIFS 与 SMB：该用哪个？

时至今日，你仍旧应该使用 SMB 这个名称。

你可能会想：“既然它们几乎是相同的，为什么一定要叫 SMB？”

这里有两个原因：

1. CIFS 实现的协议至今仍很少被使用。大多数现代存储系统不再使用 CIFS，而是使用 SMB2 或 SMB3。在 Windows 系统环境中，SMB2 和 SMB3 是事实使用的标准。
2. 在学术上 CIFS 有消极的含义。SMB2 和 SMB3 是对 CIFS 协议的重大升级，存储架构工程师大多不喜欢这种命名。

## Samba 和 NFS

CIFS 和 SMB 远不是文件共享协议的全部，如果要与旧版系统相互操作，很可能还需要其他的协议。Samba 和 NFS 就是你应该了解的另外两种优秀的文件共享协议。

### SAMBA

Samba 是一组不同功能程序组成的应用集合，它能让 Linux 服务器实现文件服务器、身份授权和认证、名称解析和打印服务等功能。

与 CIFS 类似，Samba 也是 SMB 协议的实现，它允许 Windows 客户访问 Linux 系统上的目录、打印机和文件（就像访问 Windows 服务器时一样）。

重要的是，Samba 可以将 Linux 服务器构建成一个域控制器。这样一来，就可以直接使用 Windows 域中的用户凭据，免去手动在 Linux 服务器上重新创建的麻烦。

### NFS

Network File System - NFS，即网络文件系统。由 Sun 公司面向 SMB 相同的功能（通过本地网络访问文件系统）而开发，但它与 CIFS/SMB 完全不兼容。也就是说 NFS 客户端是无法直接与 SMB 服务器交互的。

NFS 用于 Linux 系统和客户端之间的连接。而 Windows 和 Linux 客户端混合使用时，就应该使用 Samba。

## port
139端口和445端口的作用

详述139端口，那必须提NBT协议（即Net Bios Over TCP/IP），其属于SMB（Server Message Block）Windows协议族，提到SMB当然得提445端口，但是为了避免跑题，445端口至于下方进行详述。NBT使用137（UDP）、138（UDP）和139（TCP）来实现基于TCP/IP的NETBIOS网际互联。而139端口的作用就是获得NETBIOS/SMB服务（即NetBIOS File and Print Sharing协议），这个协议被用于Windows文件和打印机共享。

445端口是一个毁誉参半的端口，它能够让我们可以在局域网中轻松访问各种共享文件夹或共享打印机，但是也正因为有它，黑客们才有机可乘，比如说著名的 MS17-010 永恒之蓝漏洞，影响范围极大，直接导致那年的蠕虫病毒泛滥。445端口使用的是SMB（Server Message Block）协议，在Windows NT中SMB基于NBT实现，而在 Windows 2000/XP/2003 中，SMB除了基于NBT实现还直接通过445端口实现。

139端口与445端口的区别

139端口是在NBT协议基础上，而445端口是在TCP/IP协议基础上。
在客户端开启了NBT的情况下，139得到回应则从139端口进行会话，而如果是445端口得到回应则445端口进行会话。
在服务器禁用了NBT的情况下，不会监听139端口，只会监听445端口