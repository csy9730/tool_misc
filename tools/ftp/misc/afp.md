## AFP
Apple Filing Protocol （AFP）是一种网络协议，为Mac计算机提供文件服务。

NFS服务器可以让Unix Like的机器互相分享档案，而在微软(Microsoft)操作系统上面也有类似的文件系统，那就是Common Internet File System, CIFS，网上邻居就是依据该协议实现的
NFS仅能让Unix机器沟通， CIFS只能让Windows机器沟通。而samba是可以让类unix机器与windows机器共享文件

afp是用在Mac平台上的文件共享

## misc
FTP与前面不同的是，如果要修改服务器上的文件，就不得不先把文件下载下来，然后再上传上去，而不能直接修改服务器上的文件。

另外，NFS是架构在RPC Server上面，而 SAMBA这个文件系统是架构在NetBIOS (Network Basic Input/Output System, NetBIOS) 这个通讯协议上面所开发出来的