# ubuntu子系统



## 文件访问

1. 在win10环境下访问Ubuntu文件系统的home目录：
`C:\Users\gd_cs\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc\LocalState\rootfs\home`

2. 在Ubuntu系统下访问win10的home目录：
/mnt/c/Users/xxx
在WSL环境下可以创建一个访问win10的快捷方式

$ ln -s /mnt/c/Users/xxx ~/win10 
在ubuntu下通过下面的命令直接进入win10的home目录

$ cd win10
