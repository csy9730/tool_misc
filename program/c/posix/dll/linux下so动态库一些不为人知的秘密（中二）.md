# [linux下so动态库一些不为人知的秘密（中二）](https://www.cnblogs.com/lidabo/p/5705170.html)

继续上一篇《 [linux下so动态库一些不为人知的秘密（中）](http://blog.chinaunix.net/uid-27105712-id-3313327.html) 》介绍so搜索路径，还有一个类似于**-path**，叫**LD_RUN_PATH**环境变量, 它也是把路径编译进可执行文件内，不同的是它只设置RPATH。

 [stevenrao] **$** **g++ -o demo -L /tmp/  -ltmp main.cpp**

 [stevenrao] **$** **readelf -d demo**

 Dynamic section at offset 0xb98 contains 25 entries:

  Tag        Type                         Name/Value

 0x0000000000000001 (NEEDED)             Shared library: [libtmp.so]

 ....

 0x000000000000000f **(RPATH)**              Library rpath: [/tmp/]

 

  另外还可以通过配置**/etc/ld.so.conf**，在其中加入一行

  /tmp/

  这个配置项也是只对运行期有效，并且是全局用户都生效，需要root权限修改，修改完后需要使用命令**ldconfig** 将 /etc/ld.so.conf 加载到**ld.so.cache**中，避免重启系统就可以立即生效。

  除了前面介绍的那些搜索路径外，还有缺省搜索路径/usr/lib/ /lib/ 目录，可以通过**-z nodefaultlib**编译选项禁止搜索缺省路径。

  [stevenrao] $ **g++ -o demo -z nodefaultlib  -L/tmp -ltmp main.cpp**

  [stevenrao] $  **./demo**

   ./demo: error while loading shared libraries: libstdc++.so.6: cannot open shared object file

 

  这么多搜索路径，他们有个先后顺序如下

  1、RUMPATH 优先级最高

  2、RPATH   其次

  3、LD_LIBRARY_PATH

  4、/etc/ld.so.cache

  5、/usr/lib/ /lib/

 

  查看一个程序搜索其各个动态库另一个简单的办法是使用 LD_DEBUG这个环境变量；

  [stevenrao] $ **export LD_DEBUG=libs**

  [stevenrao] $ **./demo**

  下一篇介绍动态库内符号问题