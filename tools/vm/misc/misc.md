# misc


### 共享网络

### 共享文件
虚拟机和宿主机之间怎么共享文件？


- 使用系统提供的协议
    - windows提供的smb文件共享协议
    - linux提供的nfs文件系统
    - 苹果系统提供了AFP文件系统
- 使用虚拟机提供的工具
    - 使用vmware提供的hgfs文件共享系统
    - vmware提供的剪贴板工具
    - hyperV 使用mstsc提供的剪贴板工具，硬盘挂载工具
    - hyperV 提供的虚拟硬盘vhd挂载工具
- 使用第三方协议
    - 使用 ftp, ftps共享
    - 使用 webdav 共享
    - 使用 sftp共享

