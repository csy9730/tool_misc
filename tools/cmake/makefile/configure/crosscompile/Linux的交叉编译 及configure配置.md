# [Linux的交叉编译 及configure配置](https://www.cnblogs.com/louyihang-loves-baiyan/p/4171368.html)



这两天需要把一个CDVS的工程代码从Linux 平台上移植到ARM平台上，花了两天才搞定，之前很早申请的博客，到现在还没有技术文章会，以后决定凡是花两三天才搞定的东西都会把解决过程发到这里，很多东西靠百度什么的不太好使，必要的时候确实Google更好用。想想也是，在百度上搜，很多都是迄今为止中国程序员碰到过的问题，在Google上搜就是全世界程序员碰到过的问题。废话不多说了，切入正题。

由于原工程已经在PC-Linux上跑通，所以只需要修改configure的配置参数即可。这里我通过linux下的build.sh来对configure传入脚本。

下面试build.sh的脚本内容：


```
 1 #!/bin/sh
 2 # build the CDVS Test Model
 3 # with full optimizations and multithreading:
 4 CFLAGS="-march=armv7-a -O2 -DNDEBUG -fopenmp -pipe"
 5 export PATH=$PATH:/usr/local/arm/arm-hik_v7a-linux-uclibcgnueabi/bin
 6 # run configure with optimization flags and prepending "tm-" to all binaries (e.g. tm-extract, tm-match, etc.)
 7 mkdir -p build
 8 cd build
 9 CC=arm-hik_v7a-linux-uclibcgnueabi-gcc CXX=arm-hik_v7a-linux-uclibcgnueabi-c++ LD=arm-hik_v7a-linux-uclibcgnueabi-ld AR=arm-hik_v7a-linux-uclibcgnueabi-ar AS=arm-hik_v7a-linux-uclibcgnueabi-as NM=arm-hik_v7a-linux-uclibcgnueabi-nm STRIP= RANLIB=arm-hik_v7a-linux-uclibcgnueabi-strip  OBJDUMP=arm-hik_v7a-linux-uclibcgnueabi-objdump ../configure --build=i386-pc-linux-gnu --host=arm-hik_v7a-linux-uclibcgnueabi --target=arm-hik_v7a-linux-uclibcgnueabi --cache-file=arm-hik_v7a-linux-uclibcgnueabi.cache prefix=$HOME/cdvs_bin_for_arm --program-prefix="tm-" CFLAGS="${CFLAGS}" CXXFLAGS="${CFLAGS}" 
10 # build all binaries
11 make
12 # install all binaries in $HOME/bin (no need of admin priviledges)
13 make install
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

对脚本的内容进行分析：

首先是CFLAGS，里面定义了需要传入到configure的参数这里的-march变量是目标机的系统架构也就是architecture，由于我们的目标机上平台是armv7-a，所以此处赋值armv7-a。此处要留心，我一开始没有改，依然是native，那么configure会自动的用本机的arch值传入，这样就会编译失败。我一开始也不清楚这个地方具体应该填什么。这样我们可以查看编译器支持的芯片类型。

我的编译器的前缀是arm-hik_v7a-linux-uclibcgnueabi，所以这是这个编译器下所有工具的前缀。

由于交叉编译器已经安装在/usr/local/arm目录下，并且已经把/uar/local/arm/arm-hik_v7a-linux-uclibcgnueabi/bin目录添加到/etc/profile文件中，所以在控制台中可以直接调用编译器。

在控制台中我们输入arm-hik_v7a-linux-uclibcgnueabi-gcc -v 此命令会输出该编译器的版本信息

![img](https://images0.cnblogs.com/blog/686170/201412/181433568133725.jpg)

 

在输出图片中我们可以看到变量--with-arch=armv7-a，一开始输成了ARMv7-A，各种乱试，确实需要从根源下手，直接查看编译器版本信息。OK，接下来进入下一步。

可以看到脚本中还有一句PATH=$PATH:/usr/local/arm/arm-hik_v7a-linux-uclibcgnueabi/bin 这是对当前脚本执行的环境加上环境变量，不知道为什么在系统中添加环境变量后还是脚本运行时不能检索到编译器位置，一直报错，可以看config.log的输出日志。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
PATH: /usr/local/sbin
PATH: /usr/local/bin
PATH: /usr/sbin
PATH: /usr/bin
PATH: /sbin
PATH: /bin
```

在这里并没有将我们环境变量的值给读进来，

 而我打开终端中直接打印PATH，发现值已经在里面了。此处不太明白，所以我在build.sh里又中添加了export语句在临时追加环境变量。

```
louyihang@ubuntu:~$ echo $PATH
/home/louyihang/bin:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/arm/arm-hik_v7a-linux-uclibcgnueabi/bin:/usr/local/arm/arm-hik_v7a-linux-uclibcgnueabi/bin
```

 

接着我们在当前目录下用mkdir 创建build文件夹，整个编译过程中的各种输出文件都将会在这里除了最后的exe。

在下面可以看到我定义了一堆变量，用来指定编译器

```
CC=arm-hik_v7a-linux-uclibcgnueabi-gcc CXX=arm-hik_v7a-linux-uclibcgnueabi-c++ LD=arm-hik_v7a-linux-uclibcgnueabi-ld AR=arm-hik_v7a-linux-uclibcgnueabi-ar AS=arm-hik_v7a-linux-uclibcgnueabi-as NM=arm-hik_v7a-linux-uclibcgnueabi-nm STRIP= RANLIB=arm-hik_v7a-linux-uclibcgnueabi-strip  OBJDUMP=arm-hik_v7a-linux-uclibcgnueabi-objdump ../configure --build=i386-pc-linux-gnu --host=arm-hik_v7a-linux-uclibcgnueabi --target=arm-hik_v7a-linux-uclibcgnueabi --cache-file=arm-hik_v7a-linux-uclibcgnueabi.cache prefix=$HOME/cdvs_bin_for_arm --program-prefix="tm-" CFLAGS="${CFLAGS}" CXXFLAGS="${CFLAGS}" 
```

CC变量指定的是gcc编译器，可以在configure文件中得知这个变量来告诉configure关于交叉编译器gcc的信息，同理CXX 指的是C++，只要前缀不变，所以接下来依样画葫芦把所需要用到的编译器直接定义在 configure语句执行之前。

```
CC=arm-hik_v7a-linux-uclibcgnueabi-gcc CXX=arm-hik_v7a-linux-uclibcgnueabi-c++ LD=arm-hik_v7a-linux-uclibcgnueabi-ld AR=arm-hik_v7a-linux-uclibcgnueabi-ar AS=arm-hik_v7a-linux-uclibcgnueabi-as NM=arm-hik_v7a-linux-uclibcgnueabi-nm STRIP= RANLIB=arm-hik_v7a-linux-uclibcgnueabi-strip  OBJDUMP=arm-hik_v7a-linux-uclibcgnueabi-objdump 
```

需要注意的是其实你这些语句总共是4行，其实这里是没有回车的，因为这整个一长串都是一条语句，只不过在configure的的编译器参数需要再configure之前被设置。

OK这里弄完。接着看我们configure之后的参数。

--build参数指定的是编译器完成整个build的工程的机器结构在这里我们输入i386-pc-linux-gnu

--host参数指定最终生成可执行文件的运行环境 arm-hik_v7a-linux-uclibcgnueabi （也就是我们用的交叉编译器工具的前缀——即编译器的文件夹的名字 ）这些都是一致的

--target参数目标机的环境等同host。

--cache-file在这里指定缓存文件的名字，在该文件中我们可以看到编译过程中的整个测试过程的结果和反馈。

--prefix=$Home/cdvs_bin_for_arm 这里是最终生成可执行文件的安装目录也就是exe的存放目录。可以根据自己的需要调整。

后面的--program-prefix  CFLAGS  CXXFLAGS的参数与linux PC机上一样不用调整。

OK最后在最后跟上make make install 完成整个configure的配置。

当然什么事情都不会跟教程一样顺利，接下来的问题总是不断。

在终端中输入 sudo ./build.sh | more 

看输出内容

 

![img](https://images0.cnblogs.com/blog/686170/201412/181459302045952.jpg)

 

可以看到出现了 checking whether the C compiler works ...no 后面还出现了error。

看来 交叉编译器并没有开始工作。所以转入到build 文件夹下 打开config.log的输出日志。

 

![img](https://images0.cnblogs.com/blog/686170/201412/181502212351935.jpg)

看到一条语句 arm-hik_v7a-linux-uclibcgnueabi-gcc-raw: libgomp.spec: No such file or directory

很明显这是由于库里少了一个文件，没有被编译器找到，所以需要再库里面添加进liggomp.spec这个文件。

当时把我迷糊了好久，上哪里去整个这个文件，上百度也百度不到，上google也不好使。 

想到他毕竟是个gcc的编译器，库里面的东西大概都差不多吧，所以我去找了标准的arm-linux-gcc的库文件，记得当时的百度云里还有一份stm32的资料，整了一个下来。

![img](https://images0.cnblogs.com/blog/686170/201412/181508128603725.jpg)

 

打开这个arm-linux-gcc-4.4.3.tgz直接在压缩包里面检索关键字libgomp

果然在这个编译器同样的lib下有了一堆跟libgomp相关的文件，所以把这些文件拷入到我们所需要的arm-hik_v7a-linux-uclibcgnueabi的编译器库下面

OK再运行一次configure

![img](https://images0.cnblogs.com/blog/686170/201412/181514016579284.jpg)

咦，居然还是不过，再次看config.log文件

![img](https://images0.cnblogs.com/blog/686170/201412/181516282823779.jpg)

看到中间有一句 lib/libgomp.so: file not recognized: treating as linker script 和下面 lib/libgomp.so:1: syntax error。 不识别，这文件应该是不需要的被引入了，所以在Lib中将其删除。再次运行

![img](https://images0.cnblogs.com/blog/686170/201412/181519392356650.jpg)

OK 大功告成，可以看到whether the C  compiler works .... yes 接下来一堆文件的测试，并且在指定目录生成了exe。

整个过程花了差不多2天时间，第一次弄交叉编译，确实是有点费劲的，也发现了一些自己的不足，之前没有看log文件的习惯，后来发现这个东西是非常好的，非常有助于我们分析问题的原因。第一次写blog，写的比较乱，希望能帮到碰到同样问题的你！

![img](https://pic.cnblogs.com/face/686170/20160118205941.png)

[Hello~again](https://home.cnblogs.com/u/louyihang-loves-baiyan/)
[关注 - 1](https://home.cnblogs.com/u/louyihang-loves-baiyan/followees/)
[粉丝 - 271](https://home.cnblogs.com/u/louyihang-loves-baiyan/followers/)


[» ](https://www.cnblogs.com/louyihang-loves-baiyan/p/4445249.html)下一篇： [Ubuntu 14.04 LTS Server 无法挂载光盘 启动initramfs等问题](https://www.cnblogs.com/louyihang-loves-baiyan/p/4445249.html)

posted @ 2014-12-18 15:26  [Hello~again](https://www.cnblogs.com/louyihang-loves-baiyan/)  阅读(43224)  评论(1)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=4171368)  [收藏](javascript:void(0))  [举报](javascript:void(0))