# Termux安装jupyter以及matplotlib、scipy和numpy安装失败的解决方法

[学习 ](https://www.bilibili.com/read/technology#rid=34?from=articleDetail)2021-12-18 01:04315阅读 · 5喜欢 · 2评论

![img](https://i0.hdslb.com/bfs/face/ec15312dffcbe645d5e39a41e25e0c493c27389d.jpg@96w_96h_1c_1s.webp)

雅楠居民





粉丝：26文章：2

关注



之前网上有很多在Termux上面安装numpy和scipy的教程，比如

> https://zhuanlan.zhihu.com/p/338266408

> https://zhuanlan.zhihu.com/p/146555866

但是以上是依赖于python3.9版本。

自从，termux官方在几个月前把python升级到了3.10版本，上述方法都已经失效了。

这是因为its-pointless上面的numpy和scipy只支持3.9版本python。

目前，只可以用pip方法安装numpy，而scipy由于缺少必要的Fortran库无法用pip安装。

> scipy and numpy from its-pointless repository are compiled for python 3.9 instead of python 3.10. There are a few bug reports about it already at 
>
> https://github.com/its-pointless/its-pointless.github.io/issues
>
> Closing since there is nothing we can do from the termux-packages side of things

因此，如果现在想在Termux上安装scipy，一种方案是等its-pointless更新，另一种方案是安装3.9版本python

要安装3.9python，首先卸载3.10版本

```javascript
pkg uninstall python
```

接着查询自己的cpu架构 <CPU_ARCH.>

```javascript
uname -m
```

接着去 https://github.com/Termux-pod/termux-pod 查找自己cpu对应的3.9版本python

```javascript
wget https://github.com/Termux-pod/termux-pod/blob/main/<CPU_ARCH.>/python/python_3.9.7_<CPU_ARCH.>.deb
```

最后执行命令安装

```javascript
dpkg -i ./python_3.9.7_<CPU_ARCH.>.deb
```

为了不让termux把3.9版本升级回去，这里还要禁止python自动升级

```javascript
echo "python hold" | dpkg --set-selections
```

然后安装numpy和scipy

```javascript
pkg install numpy scipy
```



注意，如果这里3.9版本python安装成功后，安装numpy和scipy的时候还报错

建议将3.10版本python的所有依赖包以及3.9版本python全部卸载，然后重新依次安装3.9版本python，numpy以及scipy



关于安装matplotlib，先安装

```javascript
apt install freetype clang libjpeg-turbo binutils libzmq fftw make
```

以及Pillow等依赖

```javascript
LDFLAGS="-L/system/lib64/" CFLAGS="-I/data/data/com.termux/files/usr/include/" pip install Pillow
```

最后安装matplotlib

```javascript
pip list matplotlib
```



在此基础上，既可以装jupyter了

```javascript
pip install jupyter
```



本文为我原创本文禁止转载或摘编