# 解决mintty在MSYS上无法启动的问题

 [2015年04月24日 星期五](https://zohead.com/archives/mintty-msys/) [Uranus Zhou](https://zohead.com/archives/author/admin/) [Windows](https://zohead.com/archives/category/technology/windows/)

之前在 Windows 上模仿 Linux Shell 环境的 MSYS 工具集一直都是使用其自带的 rxvt 或者 Windows 命令行 Shell 终端工具，不过这两种终端的用户体验都是比较差的，有各种功能缺失的问题，好在最近发现有一款 mintty 软件可以用来替代 MSYS 和 Cygwin 上的默认终端工具，经过实际测试效果还是比 MSYS 和 Cygwin 自带的好很多的。

mintty 的项目网址：

https://code.google.com/p/mintty/

这两天使用 mintty 的时候却突然发现配合 MSYS 怎么也无法正常启动了，而且没有任何报错信息，最后通过 MSYS 的 rxvt 终端运行才看到了报错提示：

```
[Administrator@msys ~]``# mintty``m.AllocationBase 0x0, m.BaseAddress 0x68550000, m.RegionSize 0x4B0000, m.State 0x10000``C:\msys\bin\mintty.exe: *** Couldn``'t reserve space for cygwin'``s heap (0x68550000 <0x13C0000>) ``in` `child, Win32 error 0
```

在这个网址上看到了有人提出了使用 rebase 命令修改 MSYS DLL 文件首选基地址的解决方法：

http://dreamcloud.artark.ca/msys-not-start/

每个 DLL 文件都有一个首选的基地址，表示映射到使用的进程地址空间中的首选地址，一般默认为 0x10000000。实际情况下可执行程序一般会使用多个 DLL 文件，如果多个 DLL 文件都使用默认的首选基地址会造成系统自动做基地址重定位操作，这样可能导致进程地址空间中碎片的存在，并影响 DLL 的加载效率，因此有些 DLL 文件就直接自己指定了首选基地址。

如果需要查看某个 DLL 文件当前的基地址，可以使用 **dumpbin.exe** 命令行工具来查看，也可以使用 **Dependency Walker** 程序打开 mintty.exe 可执行文件，然后查看使用的 msys-1.0.dll 的基地址，例如我修改之前的效果如下图：

[![查看DLL基地址](https://storage.live.com/items/F799A497307A642E!4215?a.jpg)](https://storage.live.com/items/F799A497307A642E!4215?a.jpg)

查看DLL基地址

从图中可以看出修改之前 msys-1.0.dll 文件的基地址（就是 Base 那一栏了）是 0x68000000。

按照上面链接提供的方法，首先需要退出 MSYS shell，并保证所有使用 MSYS DLL 的程序都停掉，先备份 msys-1.0.dll 文件，然后在 Cygwin 或者 cmd 里直接运行 rebase 命令修改 MSYS DLL 加载基地址为 0x76000000：

```
[Administrator@cygwin ~]``# rebase -b 0x76000000 msys-1.0.dll
```

直接在 MSYS shell 里修改的话会由于 msys-1.0.dll 正在被使用而修改失败。修改成功之后重新运行 mintty.exe 程序，但还是有问题启动不了，报错信息相应也变了：

```
[Administrator@msys ~]``# mintty``m.AllocationBase 0x763C0000, m.BaseAddress 0x76550000, m.RegionSize 0x23A000, m.State 0x1000``C:\msys\bin\mintty.exe: *** Couldn``'t reserve space for cygwin'``s heap (0x76550000 <0x1610000>) ``in` `child, Win32 error 0
```

看来这个修改过的基地址还是有问题的，估计还是和 mintty 程序有冲突的，我们再修改 DLL 基地址为 0x60100000 看看：

```
[Administrator@cygwin ~]``# rebase -b 0x60100000 msys-1.0.dll
```

这下再运行 mintty 程序终于正常工作了，另外如果系统里没有 rebase 命令的话也可以使用 Visual Studio 2010 中自带的 **editbin.exe** 程序来修改 DLL 文件基地址的哦，玩的开心 ^_^。

无相关文章.

- [cygwin](https://zohead.com/archives/tag/cygwin/), 
- [DLL](https://zohead.com/archives/tag/dll/), 
- [mintty](https://zohead.com/archives/tag/mintty/), 
- [MSYS](https://zohead.com/archives/tag/msys/), 
- [rebase](https://zohead.com/archives/tag/rebase/), 
- [Shell](https://zohead.com/archives/tag/shell/), 
- [基地址](https://zohead.com/archives/tag/base-addr/)