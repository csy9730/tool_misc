# undefined symbol问题的查找、定位与解决方法

[FM_1ad7](https://www.jianshu.com/u/8704933999e1)关注



通过执行程序，或者通过ldd伪执行程序，可以发现符号缺失错误。

这种情况，一般是运行环境的so文件和编译时环境的so文件不一致，替换即可。



2020.04.09 14:33:42字数 1,327阅读 2,011

版权声明：本文为CSDN博主「n大橘为重n」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。

原文链接：https://blog.csdn.net/buknow/article/details/96130049

今天被客户测出来一个问题：程序执行中报错，报错内容如下

XXXX：symbol lookup error：/home/....../libpdfium.so：undefined symbol：CRYPT_MD5Generate

报错分析：

​        这个问题表明是符号未定义的问题，而且直接定位于产品链接的第三方动态库libpdfium.so中，于是从libpdfium.so中着手。

因为有这个第三方库的源码，给错误的查找提供了可能。

错误定位：

​        但是这个符号未定义的错误很头疼，因为在我原来的想法中，符号位定义不应该是直接是在编译的时候就应该报错的吗? 所以为了确认，我重新编译了一遍第三方源码，编译时没有报错，生成了新的so，替换进去重新运行，结果也还是会包符号未定义的错误。在网上查找，知道了在链接时链接有误也会造成后期的符号未定义的错误（参考内容见最后）。这块可以通过ldd -r命令查看生成的so是否存在符号未定义的内容。

​        看这些未定义的符号，缺的实在太多了，按理说不应该的。在我的情况里，生成libpdfium.so动态库时会链接好几个静态库文件。根据网上查到的资料，确认一下链接的静态库顺序是否正确。直接在第三方源码中全局搜索报错的字符串“CRYPT_MD5Generate”，发现有两处cpp文件中存在，一处是声明定义的，另一处是调用的。

​        而这块可以看到fpdf_parse_encrypt是依赖于下边的fx_crypt文件的，再看静态库，fpdf_parse_encrypt被编译成fpdfapi.a，而fx_crypt被编译进pdrm.a静态库，所以应该是fpdfapi.a要依赖于pdrm.a静态库的。再检查Makefile中链接顺序，发现顺序是反的！！！罪魁祸首找到了！就是Makefile中链接的顺序错误导致最终so中符号未定义！



下面附上我这次查找过程中用到的几个很有用的命令，和参考的资料。

编译生成动态链接库后，调用时出现：

\# lichunhong @ lichunhong-ThinkPad-T470p in ~/Documents/src/effective_robotics_programming_with_ros-master/catkin_ws on git:lichunhong/dev x [18:54:05] C:127

$ rosrun path_plan PathPlanSimulation

/home/lichunhong/Documents/src/effective_robotics_programming_with_ros-master/catkin_ws/devel/lib/path_plan/PathPlanSimulation:

symbol lookup error: /home/lichunhong/Documents/src/effective_robotics_programming_with_ros-master/catkin_ws/src/pathPlan/lib/libpathplan.so:

undefined symbol: _ZN12ninebot_algo10AprAlgoLog9instance_E

即 symbol lookup error: libpathplan.so: undefined symbol: _ZN12ninebot_algo10AprAlgoLog9instance_E

出现这种问题时，往往是链接时出现了问题，下面分3步解决

（1）使用file 命令查看 so库的架构，看看是否与平台一致

可以看到，当前so库架构为x86-64，可以在GNU/Linux平台下使用。平台与架构一致

\# lichunhong @ lichunhong-ThinkPad-T470p in ~/Documents/src/motion_planner/bin on git:dev x [18:47:54]

$ file libpathplan.so

libpathplan.so: ELF 64-bit LSB shared object, x86-64, version 1 (GNU/Linux), dynamically linked,

BuildID[sha1]=32ae641e73c547376df20ca94746fbf5507de415, not stripped

接下来，需要定位一下 undefined symbol的具体信息

(2)通过 ldd -r xxx.so 命令查看so库链接状态和错误信息

ldd命令，可以查看对应的可执行文件或库文件依赖哪些库，但可执行文件或库文件要求与操作系统的编译器类型相同，即电脑是X86的GCC编译器，那么无法通过ldd命令查看ARM交叉编译器编译出来的可执行文件或库文件。

如果想在Ubuntu等Linux宿主机上查看ARM交叉编译好的可执行程序和库文件的相关依赖关系，可以通过以下命令：

readelf -d xxx.so | grep NEEDED



\# lichunhong @ lichunhong-ThinkPad-T470p in ~/Documents/src/effective_robotics_programming_with_ros-master/catkin_ws/src/pathPlan/lib on git:lichunhong/dev x [18:57:19]

$ ldd -r libpathplan.so

linux-vdso.so.1 =>  (0x00007ffec1bd8000)

libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f186cc0a000)

libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f186c901000)

libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f186c6eb000)

libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f186c321000)

/lib64/ld-linux-x86-64.so.2 (0x00007f186d27a000)

undefined symbol: pthread_create (./libpathplan.so)

undefined symbol: _ZN12ninebot_algo10AprAlgoLog9instance_E (./libpathplan.so)

undefined symbol: _ZN2cv3maxERKNS_3MatES2_ (./libpathplan.so)

undefined symbol: _ZN12ninebot_algo10AprAlgoLog8WriteLogE10LEVEL_TYPEPKcS3_z (./libpathplan.so)

undefined symbol: _ZN2cv6dilateERKNS_11_InputArrayERKNS_12_OutputArrayES2_NS_6Point_IiEEiiRKNS_7Scalar_IdEE (./libpathplan.so)

undefined symbol: _ZN2cvgtERKNS_3MatEd (./libpathplan.so)

undefined symbol: _ZN2cv8fastFreeEPv (./libpathplan.so)

undefined symbol: _ZN2cv3Mat5setToERKNS_11_InputArrayES3_ (./libpathplan.so)

undefined symbol: _ZN12ninebot_algo10AprAlgoLog9instance_E (./libpathplan.so)

可以看到有好多 undefined symbol ，其中就有提到的 _ZN12ninebot_algo10AprAlgoLog9instance_E 错误

(3) 使用 c++filt symbol 定位错误在那个C++文件中

从上面的undefined symbol中，通过c++filt <symbol>，可以定位到大多是opencv的问题

\# lichunhong @ lichunhong-ThinkPad-T470p in ~/Documents/src/effective_robotics_programming_with_ros-master/catkin_ws/src/pathPlan/lib on git:lichunhong/dev x [19:04:26] C:1

$ c++filt _ZN2cv7waitKeyEi

cv::waitKey(int)

\# lichunhong @ lichunhong-ThinkPad-T470p in ~/Documents/src/effective_robotics_programming_with_ros-master/catkin_ws/src/pathPlan/lib on git:lichunhong/dev x [19:04:31]

$ c++filt _ZN2cv3maxERKNS_3MatES2_