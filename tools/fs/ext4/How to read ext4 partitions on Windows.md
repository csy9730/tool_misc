# [How to read ext4 partitions on Windows?](https://superuser.com/questions/37512/how-to-read-ext4-partitions-on-windows)



## DiskInternals [Linux Reader](http://www.diskinternals.com/linux-reader/)

> This program plays the role of a bridge between your Windows and Ext2/Ext3/Ext4, HFS and ReiserFS file systems.

[Linux Reader Website](http://www.diskinternals.com/linux-reader/)

**Features**

1. Integrated with Windows Explorer
2. Reader for Ext2/3/4, ReiserFS, Reiser4, HFS, HFS+, FAT, exFAT, NTFS, ReFS, UFS2
3. Can create and open disk images
4. Freeware

## [Ext2Read](http://sourceforge.net/projects/ext2read/) 

[Ext2Read](http://sourceforge.net/projects/ext2read/) works well. It can also open & read disk images ( eg: Wubi disk images)

> Ext2Read is an explorer like utility  to explore ext2/ext3/ext4 files. It  now supports LVM2 and EXT4 extents. It  can be used to view and copy files and  folders. It can recursively copy  entire folders. It can also be used to  view and copy disk and file

![alt text](https://i.stack.imgur.com/hvFv8.jpg)



​            [Share](https://superuser.com/a/141919)        

​                    [Improve this answer](https://superuser.com/posts/141919/edit)                

##        EXT2FSD

> **WARNING**
>  According to multiple reports, it does not work on Windows 10 version 1909 and later

[EXT2FSD](http://sourceforge.net/projects/ext2fsd/) works for reading ext4 filesystems, though not all of ext4's capabilities are supported.

After installing set a letter to each Linux drive (see screen-shot)  and then restart the application. After that Windows Explorer will show  the Linux partitions as any other partition.

## VirtualBox

Well not really a solution, but I use VirtualBox, use it as a bridge.



## WSL2 on Windows 10 Build 20211

Windows allows now to mount physical disks using the **Windows Subsystem for Linux 2 (WSL)**.

For people who are not familiar with WSL2:

> ... Windows Subsystem for Linux is a compatibility layer for running Linux binary executables natively on Windows 10 and Windows Server 2019. In May 2019, WSL 2 was announced, introducing important changes  such as a real Linux kernel, through a subset of Hyper-V features. ...
>
> [find more on Wikipedia](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux)

The Windows 10 WSL2 now supports a mount command for linux filesystems called **wsl**.

First of all you have to install WSL2 on your windows10+ release. I recommend to simply follow the [microsoft installation guide](https://docs.microsoft.com/en-us/windows/wsl/install-win10) (note the minimum version required).



​        

​            9        

​                    



# [ext4explorer](http://sourceforge.net/projects/ext4explore/?source=directory)

> Ext4Explore is a program that allows Linux partitions to be browsed from Microsoft Windows. It has a GUI which will be familiar to users of Windows Explorer.

[Ext4Explore Web Site](http://sourceforge.net/projects/ext4explore/?source=directory)

**Features**

1. Displays Windows Icons
2. Symbolic Links Displayed with 'Shortcut' Overlay
3. Follows Symbolic Links and Displays Correct File Information
4. Copy Files and Directories
5. Configurable Edit Context Menu Option