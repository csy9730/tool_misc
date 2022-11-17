# [嵌入式Linux安装Dropbear SSH server](https://www.cnblogs.com/Jimmy1988/p/9060826.html)

# 0. 背景

OpenSSH因为其相对较大，一般不太适用于嵌入式平台，多用于PC或者服务器的Linux版本中。
Dropbear是一个相对较小的SSH服务器和客户端。它运行在一个基于POSIX的各种平台。 Dropbear是开源软件，在麻省理工学院式的许可证。 Dropbear是特别有用的“嵌入”式的Linux（或其他Unix）系统，如无线路由器。(一个完整的openssh大小有7M左右)。

> 参考：https://matt.ucc.asn.au/dropbear/dropbear.html

# 1. 平台

> - **嵌入式Linux平台：** ARM 9
> - **嵌入式Linux系统：** TinaLinux 3.4.39
> - **宿主系统：** Ubuntu 16.04.4 LTS
> - **SSH程序：** dropbear 2016.74

软件下载地址：

> - zlib : http://www.zlib.net/ (PS:博主用的1.2.8版本)
> - dropbear ： http://matt.ucc.asn.au/dropbear/releases/ (PS:博主用的2016.74, 2018.76版本有bug，慎用，不怕死的可以试试)
> - 若果想要整体编译好的(包含源文件)，请 [点击这里](https://files.cnblogs.com/files/Jimmy1988/drop-20180517.zip)

# 2. 交叉编译

因为需要在宿主机上编译嵌入式arm的东西，所以编译器应该是arm的。
此处编译，包括两个部分：zlib和dropbear。dropbear依赖zlib的库，所以必须先编译zlib才可以。

## 2.1 zlib编译

> - 1). 解压zlib：

```bash
tar -zxvf zlib1.2.8.tar.gz -C /usr/local/zlib/src   (此处目录根据自己情况定义)
```

> - 2). 进入zlib的解压目录

```bash
cd /usr/local/zlib/src
```

> - 3). 配置zlib

```bash
./configure --prefix=/usr/local/zlib  (即将zlib的库生成到该目录下)  
```

> - 4). 上面步骤做完，将会生成Makefile，vim进去，修改Makefile

```javascript
CC=/home/BvSDK/toolchain/bin/arm-openwrt-linux-gcc  //你交叉编译工具的绝对路径  
AR=/home/BvSDK/toolchain/bin/arm-openwrt-linux-gcc-ar  
RANLIB=/home/BvSDK/toolchain/bin/arm-openwrt-linux-gcc-ranlib    
LDSHARED=/home/BvSDK/toolchain/bin/arm-openwrt-linux-gcc -shared   -Wl,-soname,libz.so.1,--version-script,zlib.map   //(我只是将原来的gcc改成了我自己的编译工具，后面的参数没动过)
```

> - 5). 执行make
> - 6). 执行make install

完成以上步骤，你去/usr/local/zlib目录下看，会发现多了几个目录，代表zlib交叉编译成功！！

![mark](http://ory0rmuh5.bkt.clouddn.com/blog/180519/48I4B0B1A9.png)

## 2.2 dropbear编译

> - **1). 解压dropbear：**

```delphi
tar -jxvf dropbear-2016.74.tar.bz2 -C /usr/local/dropbear/src   //(此处目录根据自己情况定义)
```

> - **2). 进入dropbear的解压目录**

```bash
cd /usr/local/dropbear/src
```

> - **3). 配置dropbear**

```javascript
./configure --prefix=/usr/local/dropbear  --with-zlib=/usr/local/zlib/ CC=/home/BvSDK/toolchain/bin/arm-openwrt-linux-gcc --host=arm  //(根据自己的情况修改)
```

> - **4). 上面步骤做完，Makefile内的CC会自动修改掉，不用再人为修改Makefile了**
> - **5). 执行make**

```go
make PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp" 
```

> - **6). 执行make install**

```go
make PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp" install
```

> - **7). 注意，因为默认不编译scp，PROGRAMS=xxx是强制编译出scp来，不这样干也可以，但是需要自己生成scp：**

```bash
make scp  
cp scp /usr/local/dropbear
```

完成以上步骤，你去/usr/local/dropbear目录下看，会发现多了几个目录，代表dropbear交叉编译成功！！

![mark](http://ory0rmuh5.bkt.clouddn.com/blog/180519/f2jB7eCKAe.png)

# 3. 移植到开发板

> - 将/usr/local/dropbear/bin/移植到板卡的/usr/bin/下；
> - 将/usr/local/dropbear/sbin/下的文件都复制到板卡的/usr/sbin/目录下

然后去板卡上执行如下操作：

```bash
cd /etc
mkdir dropbear      //这个名字是固定的，千万不可变动
cd dropbear
dropbearkey -t rsa -f dropbear_rsa_host_key
dropbearkey -t dss -f dropbear_dss_host_key
```

# 4. 嵌入式系统配置

既然弄好了dropbear，我们肯定是希望它可以开机启动喽，谁也不愿意每次开机在手动去启动这个东西吧！！！

### 4.1 开机启动步骤：

```bash
cd /etc/init.d/
touch dropbear_autorun

//将下面内容加入到dropbear_autorun文件
#!/bin/sh /etc/rc.common
# Copyright (C) 2006 OpenWrt.org

START=99
start() {
        cd /usr/sbin/
        ./dropbear
        cd -
}

//然后将该文件链接到rc.d中
cd /etc/rc.d/
ln -s ../init.d/dropbear_autorun S99dropbear
```

### 4.2 新建账号或者给root设置密码

因为SSH要求必须有密码，所以，如果板卡上可以增加新用户，则可以直接增加一个新的用户：

```undefined
useradd admin
passwd admin
```

但是我的板卡不允许建立其它用户，只能给root赋密码了，不然SSH无法登陆

# 5. 问题

> - 1). 如果其它主机scp、ssh到板卡有问题，你可以尝试着将文件在/usr/sbin/ 、 /usr/bin/ 和/sbin/ 目录下移动，然后再次试验，看是否有同样问题发生 (我不会告诉你我卡在这个问题上好久的)

> - 2). scp需要移植到/usr/bin/下，不然可能其它主机无法scp推送文件到本板卡中，出现以下错误：

```diff
-ash: scp: not found
lost connection
```

> - 3). 板卡中执行dropbear没反应
>
> > 原因1：没有执行dropbearkey, 或者执行了没生成key文件
> > 原因2：key文件不在/etc/dropbear/文件中，这个目录名称是固定死的，不可更改

标签: [scp](https://www.cnblogs.com/Jimmy1988/tag/scp/), [ssh](https://www.cnblogs.com/Jimmy1988/tag/ssh/), [dropbear](https://www.cnblogs.com/Jimmy1988/tag/dropbear/)