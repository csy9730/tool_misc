# NSIS 压缩算法、方式 对比



[漫步繁华街](https://blog.csdn.net/xiezhongyuan07) 2018-11-16 21:50:08 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 1648 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏 1

分类专栏： [NSIS](https://blog.csdn.net/xiezhongyuan07/category_7455148.html) 文章标签： [NSIS](https://www.csdn.net/gather_2b/MtzaMg0sODc3MTEtYmxvZwO0O0OO0O0O.html) [压缩](https://www.csdn.net/gather_21/MtTaEg0sNDkxNzEtYmxvZwO0O0OO0O0O.html) [算法](https://www.csdn.net/gather_28/MtTaEg0sMTE3MjUtYmxvZwO0O0OO0O0O.html) [对比](https://www.csdn.net/gather_22/MtTaEg0sMjk3MjktYmxvZwO0O0OO0O0O.html)

版权

对于安装包打包使用的NSIS,提供了7种压缩方式：

1. ZLIB
2. ZLIB(固实)
3. BZIP2
4. BZIP2(固实)
5. LZMA
6. LZMA(固实)
7. 极限压缩

**在脚本中是:**

SetCompressor [/SOLID] [/FINAL] **zlib**|bzip2|lzma

该命令设置了安装程序压缩文件、数据使用的压缩算法。该命令只能在区段、函数之外或在任何数据被压缩之前使用。不同的压缩方式不能在同一个安装程序里用来压缩不同的文件。建议在脚本的开始处使用这个命令来尽可能避免编译错误。

支持三种压缩方式：ZLIB，BZIP2 和lzma。

**ZLIB** (默认值) 使用收缩算法，是一个快速简单的方法。默认的压缩级别它消耗大约 300KB 内存。

**BZIP2** 通常比 ZLIB 的压缩率好，但是稍微慢了一点并且内存的使用也多一点。默认的压缩级别它消耗大约 4MB 内存。

LZMA 是一个压缩率比较理想的新式压缩方式。它的解压速度非常快(在 2GHz 的 CPU 上能达到 10-20MB/s 的速度)，但是压缩速度很慢。解压时内存的使用量是字典的大小加上一些 KB，默认值为 8MB。

如果使用了*/FINAL* ，则后来调用的 SetCompressor 都会被忽略。

如果使用了*/SOLID* 的话，所有的数据将被压缩在一个区块里，这样可以提高压缩率。

**此外还有一个选项 设置字典大小SetCompressorDictSize**

字典大小以 MB 为单位。

设置使用 压缩器时的字典大小 (默认为 8MB)。

设置最大32MB，可以提高压缩率。

```
SetCompressor /SOLID lzma
SetCompressorDictSize 32
```

下面是我的实际的对比

![img](https://img-blog.csdnimg.cn/20181116215058753.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3hpZXpob25neXVhbjA3,size_16,color_FFFFFF,t_70)

 

## FAQ

问： 我用NSIS做好了一个安装程序，因为数据较多，一共有400多M，用的LZMA压缩方式，做好后的安装程序约200M，但是我发现在运行这个安装程序时会在系统TEMP目录产生一个同安装后的全部内容同样大的临时文件（一边运行一边加大，最后到400多M去了），如果我做的程序小倒没什么，可是这个程序有400多M，除了要写入安装的数据外还要同样大小的空间放临时文件，这样子也实在是太花不来，我想请问：有什么办法能让其在安装时不使用这么多的临时空间吗？安装的脚本是用HM NIS Edit的向导生成的。

答： 这是因为 NSIS 在用 LZMA 时采用了固实压缩，何谓固实压缩，其实就是把所有文件统一起来压缩，所以这样压出来的文件更加的小，
同时也带来了一个问题，安装解压的时候，在临时文件夹中生成一个临时文件，随着安装的进程逐渐增大，到最后，
需要临时文件会变成跟原安装程序一样大，也就是说，需要原安装程序 2 倍的空间才可以安装这个程序，所以对于安装大量文件时，这是不适合的。
　　NSIS 2.07 版本之前 LZMA 算法是固实压缩的，没有非固实的选项，如果需要这样做，只有下载非固实压缩的编译器，但是 2.07 后的 NSIS 的 LZMA 压缩已经改为默认非固实压缩了，所以这个问题同时也不再存在。如果在制作少量文件的安装时，仍然想取用固实压缩可以加入 /SOLID 参数。像这样： `SetCompressor /SOLID lzma`