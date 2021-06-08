# 使用objdump objcopy查看与修改符号表



[麦晓宇](https://blog.csdn.net/fishmai) 2017-06-07 19:43:26 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 2027 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏

分类专栏： [mach-o](https://blog.csdn.net/fishmai/category_6922599.html) [mac](https://blog.csdn.net/fishmai/category_6918077.html) [ios](https://blog.csdn.net/fishmai/category_6233401.html)



我们在 Linux 下运行一个程序，有时会无法启动，报缺少某某库。这时需要查看可执行程序或者动态库中的符号表，动态库的依赖项， Linux 有现成的工具可用：objdump 。

​    有时我们拿到一个静态库，想调用其中的函数，而某些函数作用域非全局，也可以通过修改符号来达到目的。 Linux 有现成的工具可用： objcopy 。

​    下面我们来看看具体怎么使用。



​    objdump 是 gcc 套件中用来查看 ELF 文件的工具，详细的用法请 google 之，也可以用 objdump --help 查看帮助，或者 man objdump 查看系统手册。这里只举两个我用到的情况。

​    1). 查看依赖项：objdump -x xxx.so | grep "NEEDED" 。下面是我查看 qq_1.so 时的输出截图：

![img](https://img-blog.csdn.net/20140313102914781?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvZm9ydW9r/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

​    2). 查看动态符号表： objdump -T xxx.so 。假如想知道 xxx.so 中是否导出了符号 yyy ，那么命令为 objdump -T xxx.so | grep "yyy" 。

​    3). 查看符号表： objdump -t xxx.so 。-T 和 -t 选项在于 -T 只能查看动态符号，如库导出的函数和引用其他库的函数，而 -t 可以查看所有的符号，包括数据段的符号



​    objcopy 将目标文件的一部分或者全部内容拷贝到另外一个目标文件中，或者实现目标文件的格式转换。

​    具体用法 google ， man ，或者参考这篇强文《[Linux命令学习手册-objcopy命令](http://blog.chinaunix.net/uid-9525959-id-2001841.html)》。

​    假如我们有个静态库，想做这么几个事儿：把一个函数作用域从全局修改为本地、把一个函数作用域从本地修改为全局、把一个函数的名字修改一下。那么步骤如下：



1. ar -x xxx.a  //释放其中的.o文件
2. objdump -t xxx.o //查看导出符号表，可以看到导出的函数和引用的函数
3. objcopy --localize-symbol function_1 xxx.o xxx_new.o   //把函数设置为本地
4. objcopy --globalize-symbol function_2 xxx.o xxx_new.o //把函数设置为全局可见
5. objcopy --redefine-sym old_func=new_func xxx.o xxx_new.o //重命名函数名
6. ar cqs xxx.a xxx_new.o //打包为静态库



​    上面用到 ar 命令，请 google 或 man 。