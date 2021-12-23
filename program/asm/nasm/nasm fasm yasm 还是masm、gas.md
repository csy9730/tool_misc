

# [nasm fasm yasm 还是masm、gas](https://www.cnblogs.com/findumars/p/4145407.html)

留个爪，稍后学习

选择编译器
nasm？fasm？yasm？还是masm、gas或其他？

前面三个是免费开源的汇编编译器，总体上来讲都使用Intel的语法。yasm是在nasm的基础上开发的，与nasm同宗。由于使用了相同的语法，因此nasm的代码可以直接用yasm来编译。

yasm虽然更新较慢，但对nasm一些不合理的地方进行了改良。从这个角度来看，yasm比nasm更优秀些，而nasm更新快，能支持更新的指令集。在Windows平台上，fasm是另一个不错的选择，平台支持比较好，可以直接用来开发Windows上的程序，语法也比较独特。在对Windows程序结构的支持上，fasm是3个免费的编译器里做得最好的。

masm是微软发布的汇编编译器，现在已经停止单独发布，被融合在Visual Studio产品中。gas是Linux平台上的免费开源汇编编译器，使用AT&T的汇编语法，使用起来比较麻烦。

由于本书的例子是在祼机上直接运行，因此笔者使用nasm，因为它的语法比较简洁，使用方法简单，更新速度非常快。不过如果要是用nasm来写Windows程序则是比较痛苦的，这方面的文档很少。

从nasm的官网可以下载最新的版本：http://www.nasm.us/pub/nasm/releasebuilds/?C=M，也可以浏览和下载其文档：http://www.nasm.us/docs.php。


参考：

http://book.2cto.com/201209/5464.html
http://blog.csdn.net/broadview2006/article/details/8176974
http://blog.csdn.net/broadview2006/article/details/8181182
http://blog.csdn.net/broadview2006/article/details/8058755

编程ING:人人都能学会程序设计

http://blog.csdn.net/broadview2006/article/details/7789622

支撑处理器的技术——永无止境地追求速度的世界

http://blog.csdn.net/broadview2006/article/details/8174696

\-----------------------------------------

特别需要补充的两个开源软件是：FreeDOS，MiniGUI



分类: [ASM-学习](https://www.cnblogs.com/findumars/category/329299.html)