# [ubuntu新内核不能用启动回滚到旧内核的方法](https://www.cnblogs.com/tfanalysis/p/4004939.html)

查看已安装的linux内核版。

``` bash
uname -a 
```



先看一看自己电脑上有哪些内核文件

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
merlin@tfAnalysis:~$ dpkg --get-selections|grep linux
libselinux1:i386                install
linux-firmware                    install
linux-headers-3.13.0-24                install
linux-headers-3.13.0-24-generic            install
linux-headers-3.13.0-32                install
linux-headers-3.13.0-32-generic            install
linux-headers-3.13.0-35                install
linux-headers-3.13.0-35-generic            install
linux-headers-3.13.0-36                install
linux-image-3.13.0-24-generic            install
linux-image-3.13.0-32-generic            install
linux-image-3.13.0-35-generic            install
linux-image-3.13.0-36-generic            deinstall
linux-image-extra-3.13.0-24-generic        install
linux-image-extra-3.13.0-32-generic        install
linux-image-extra-3.13.0-35-generic        install
linux-image-extra-3.13.0-36-generic        deinstall
linux-libc-dev:i386                install
linux-sound-base                install
pptp-linux                    install
qtcreator-plugin-remotelinux:i386        install
syslinux                    install
syslinux-common                    install
syslinux-legacy                    install
util-linux                    install
merlin@tfAnalysis:~$ 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

之后再将最新的内核，这儿是36删除掉：

```
merlin@tfAnalysis:~$ sudo apt-get remove linux-headers-3.13.0-36-generic linux-image-3.13.0-36-generic linux-image-extra-3.13.0-36-generic 
```

这样，下次启动的时候就会启动旧的35内核了。



切记要更新grub启动选项，删除最新的内核后，次优的内核会变成默认启动选项。

``` bash
update-grub
```



许多显示什么的问题就解决了。



分类: [Ubuntu&Linux](https://www.cnblogs.com/tfanalysis/category/579926.html)