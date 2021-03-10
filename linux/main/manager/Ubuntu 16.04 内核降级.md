# Ubuntu 16.04 内核降级

以下为原博客内容：

 

由于锐速不支持 Ubuntu 16.04 自带内核 4.4.0-31-generic，因此需要给它降级，我决定将内核降到 3.16.0-43-generic，操作步骤如下：

**修改软件源**

\1. 备份源配置文件

```bash
$ sudo cp /etc/apt/sources.list /etc/apt/sources.list_bak
```

\2. 用编辑器打开源配置文件

```bash
$ sudo vim /etc/apt/sources.list
```

在文件最后面增加一行并保存

```
deb http://security.ubuntu.com/ubuntu trusty-security main
```

\3. 执行以下命令更新配置

```bash
$ sudo apt-get update
```

**安装新内核**

\1. 执行以下命令安装

```bash
$ sudo apt-get install linux-image-extra-3.16.0-43-generic
```

\2. 执行以下命令查看是否安装成功

```bash
$ dpkg -l | grep 3.16.0-43-generic
```

![img](http://www.xf5000.com/wp-content/uploads/2016/12/QQ%E6%88%AA%E5%9B%BE20161220224355.png)

\3. 用编辑器打开 grub 配置文件

```bash
$ sudo vim /etc/default/grub
```

找到

```bash
GRUB_DEFAULT=0
```

![img](http://www.xf5000.com/wp-content/uploads/2016/12/2.png)

修改为：

```
GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux 3.16.0-43-generic"
```

![img](http://www.xf5000.com/wp-content/uploads/2016/12/3.png)

\4. 保存退出，然后执行以下命令更新 Grub 引导

```bash
$ sudo update-grub
```

![img](http://www.xf5000.com/wp-content/uploads/2016/12/4.png)

\5. 更新完成后重启系统

```bash
$ sudo reboot
```

\6. 不出意外的话重启系统后启用的就是新的内核了，执行以下命令查看一下

```bash
$ uname -r
```

![img](http://www.xf5000.com/wp-content/uploads/2016/12/5.png)

 

------------------------------------------------------------------------------------更新---------------------------

# 删除多余内核

\1. 查看所有内核：

```bash
$ dpkg --get-selections| grep linux
```

结果类似下图：

![img](https://img-blog.csdn.net/20180912163241677?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM0MzE5MTY=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

\2. 将其他版本的内核删除，如(对deinstall的需要用dpkg卸载)：

```
$ sudo apt-get remove linux-headers-4.15.0-33



$ sudo dpkg -P linux-image-4.8.0-36-generic
```

# 参考

[删除 Ubuntu 系统旧内核](https://www.jianshu.com/p/a593067fe9fc)