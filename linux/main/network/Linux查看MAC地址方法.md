# Linux查看MAC地址方法

[狗达Da](https://www.jianshu.com/u/89fa0e5fcff0)关注

0.0772018.04.23 18:09:09字数 441阅读 73,622

PS：一般默认的网卡文件名是eth0，根据IP地址对应的实际情况区判断是ethx即可。

1、 ifconfig -a 其中 HWaddr字段就是MAC地址，这是最常用的方式



![img](https://upload-images.jianshu.io/upload_images/2787869-ebcfe23c06a0c3e9.png?imageMogr2/auto-orient/strip|imageView2/2/w/880/format/webp)

image.png

2、cat /etc/sysconfig/network-scripts/ifcfg-eth0（CentOS or Redhat配置文件）



![img](https://upload-images.jianshu.io/upload_images/2787869-aade7bfdc6ddbecb.png?imageMogr2/auto-orient/strip|imageView2/2/w/870/format/webp)

image.png

下面两种在未设置IP前可以查看。可以用来解决MAC和操作系统绑定的问题。比如你把操作系统装到远程服务器，操作系统的mac地址是A主机的地址，在B主机上由于MAC地址不同无法远程启动(因为这时配置文件仍是A的mac地址)。由于OS在启动时会检测硬件，获得硬件的MAC地址，写到/sys/class/net/eth0/address文件中，我们在OS获得mac地址之后，使用原来的MAC配置文件之前(也就是/etc/sysconfig/network-scripts/ifcfg-eth0 )，把真正的mac地址写到配置文件中。

3、cat /sys/class/net/eth0/address 查看eth0的MAC地址



![img](https://upload-images.jianshu.io/upload_images/2787869-c8d7875643f018fa.png?imageMogr2/auto-orient/strip|imageView2/2/w/667/format/webp)

image.png

4、dmesg | grep eth0
dmesg’命令设备故障的诊断是非常重要的。在‘dmesg’命令的帮助下进行硬件的连接或断开连接操作时,我们可以看到硬件的检测或者断开连接的信息。
对dmesg命令感兴趣的小伙伴，可参考：[https://www.cnblogs.com/zhaoxuguang/p/7810651.html](https://link.jianshu.com/?t=https%3A%2F%2Fwww.cnblogs.com%2Fzhaoxuguang%2Fp%2F7810651.html)

![img](https://upload-images.jianshu.io/upload_images/2787869-6f96e026403a0f7c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1077/format/webp)

image.png



1. cat /proc/net/arp 查看连接到本机的远端IP的MAC地址
   不能看到本机的MAC，只能看到远程连接，服务端用的比较多。

   ![img](https://upload-images.jianshu.io/upload_images/2787869-98bea94d1545b11f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1004/format/webp)

   image.png

2. 程序中使用SIOCGIFHWADDR的ioctl命令获取MAC地址
   这个用法，暂时没有摸索出来。