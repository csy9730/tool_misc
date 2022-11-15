# [aarch64-linux-gnu交叉编译Qt4.7.3](https://www.cnblogs.com/wanglouxiaozi/p/9521950.html)



到 Qt 官网下载合适的 Qt 版本，地址：<http://download.qt-project.org/archive/qt/>

#### 1.环境搭建:

1.安装automake、libtool 和主机上的 Qt 工具：

```
$ sudo apt-get install automake autoconf libtool m4
$ sudo apt-get install libX11-dev libXext-dev libXtst-dev libXrender-dev 
$ sudo apt-get install libqt4-core libqt4-dev libqt4-webkit qt4-demos
```

2.搭建交叉编译环境：
环境搭建很简单,只要把交叉编译工具链解压后，在/etc/profile文件最后一行处添加环境变量，系统启动时会自动设置。

解压后进入目录，ls bin/可以看到aarch64-linux-gnu-gcc、aarch64-linux-gnu-g++等编译器。



```
[~/qtArm64Toolchain/Ambarella_Linaro_Toolchain_2016.02_For_S5/linaro-aarch64-2016.02-gcc5.3 root@jz4775dev]
[root@jz4775dev]# ls
aarch64-linux-gnu  bin  include  lib  lib64  libexec  share
[~/qtArm64Toolchain/Ambarella_Linaro_Toolchain_2016.02_For_S5/linaro-aarch64-2016.02-gcc5.3 root@jz4775dev]
[root@jz4775dev]# ls bin/
aarch64-linux-gnu-addr2line  aarch64-linux-gnu-cpp        aarch64-linux-gnu-gcc-ar      aarch64-linux-gnu-gdb     aarch64-linux-gnu-objcopy          aarch64-linux-gnu-readelf
aarch64-linux-gnu-ar         aarch64-linux-gnu-elfedit    aarch64-linux-gnu-gcc-nm      aarch64-linux-gnu-gprof   aarch64-linux-gnu-objdump          aarch64-linux-gnu-size
aarch64-linux-gnu-as         aarch64-linux-gnu-g++        aarch64-linux-gnu-gcc-ranlib  aarch64-linux-gnu-ld      aarch64-linux-gnu-pkg-config       aarch64-linux-gnu-strings
aarch64-linux-gnu-c++        aarch64-linux-gnu-gcc        aarch64-linux-gnu-gcov        aarch64-linux-gnu-ld.bfd  aarch64-linux-gnu-pkg-config-real  aarch64-linux-gnu-strip
aarch64-linux-gnu-c++filt    aarch64-linux-gnu-gcc-5.3.1  aarch64-linux-gnu-gcov-tool   aarch64-linux-gnu-nm      aarch64-linux-gnu-ranlib　
```

```
[root@jz4775dev]# vim /etc/profile
```

在最后一行添加：

```
export PATH=/root/qtArm64Toolchain/Ambarella_Linaro_Toolchain_2016.02_For_S5/linaro-aarch64-2016.02-gcc5.3/bin:$PATH
```

 

#### 2.编译安装Qt4.7.3

把qt-everywhere-opensource-src-4.7.3.tar.gz拷贝到/opt 目录下，使用下面command解压：

```
tar -xvf qt-everywhere-opensource-src-4.7.3.tar.gz
```

 

并在/opt目录下新建目录qt-4.7.3-arm64（qt-4.7.3-arm64是编译完成后的安装目录):

```
mkdir qt-4.7.3-arm64
```

然后进入qt-everywhere-opensource-src-4.7.3目录：
a.修改mkspecs/qws/linux-arm-gnueabi-g++/qmake.conf文件如下:

``` makefile
#
# qmake configuration for building with arm-none-linux-gnueabi-g++
#

include(../../common/g++.conf)
include(../../common/linux.conf)
include(../../common/qws.conf)

# modifications to g++.conf
QMAKE_CC                = aarch64-linux-gnu-gcc
QMAKE_CXX               = aarch64-linux-gnu-g++
QMAKE_LINK              = aarch64-linux-gnu-g++
QMAKE_LINK_SHLIB        = aarch64-linux-gnu-g++

# modifications to linux.conf
QMAKE_AR                = aarch64-linux-gnu-ar cqs
QMAKE_OBJCOPY           = aarch64-linux-gnu-objcopy
QMAKE_STRIP             = aarch64-linux-gnu-strip

load(qt_config)
```



 

b.执行configure生成Makefile文件，命令如下：

```
./configure -opensource -prefix /opt/qt-4.7.3-arm64 -xplatform qws/linux-arm-gnueabi-g++ -embedded armv8 -release -webkit -no-cups -qt-zlib -qt-libjpeg -qt-libmng -qt-libpng -depths all -qt-gfx-linuxfb -qt-g
    fx-transformed -no-gfx-qvfb -qt-gfx-vnc -qt-gfx-multiscreen -qt-kbd-tty  -no-openssl -no-phonon -no-phonon-backend -no-nas-sound -no-exceptions -svg -no-qt3support -no-multimedia -no-xmlpatterns -no-pch -con
    firm-license
```

 

配置成功显示如下：

```
NOTICE: Atomic operations are not yet supported for this
        architecture.

        Qt will use the 'generic' architecture instead, which uses a
        single pthread_mutex_t to protect all atomic operations. This
        implementation is the slow (but safe) fallback implementation
        for architectures Qt does not yet support.

Qt is now configured for building. Just run 'make'.
Once everything is built, you must run 'make install'.
Qt will be installed into /opt/qt-4.7.3-arm64

To reconfigure, run 'make confclean' and 'configure'.
```


然后：

```
make
```

 

注意：

\1. qt4.7.3 configure时要加上-embedded armv8参数，armv8是arm芯片的架构(arm9对应armv5，arm11对应armv6，cortex-a8和cortex-a9对应armv7),不然会出现以下情况:



```
You have not explicitly asked to use pkg-config and are cross-compiling.
pkg-config will not be used to automatically query cflag/lib parameters for
dependencies


This is the Qt for Linux/X11 Open Source Edition.

You are licensed to use this software under the terms of
the Lesser GNU General Public License (LGPL) versions 2.1.
You are also licensed to use this software under the terms of
the GNU General Public License (GPL) versions 3.

You have already accepted the terms of the  license.

Creating qmake. Please wait...
g++ -c -o option.o -m64 -pipe -DQMAKE_OPENSOURCE_EDITION -I. -Igenerators -Igenerators/unix -Igenerators/win32 -Igenerators/mac -Igenerators/symbian -I/opt/qt-everywhere-opensource-src-4.7.3/include -I/opt/qt-everywhere-opensource-src-4.7.3/include/QtCore -I/opt/qt-everywhere-opensource-src-4.7.3/src/corelib/global -I/opt/qt-everywhere-opensource-src-4.7.3/src/corelib/xml -I/opt/qt-everywhere-opensource-src-4.7.3/tools/shared -DQT_NO_PCRE -DQT_BUILD_QMAKE -DQT_BOOTSTRAPPED -DQLIBRARYINFO_EPOCROOT -DQT_NO_TEXTCODEC -DQT_NO_UNICODETABLES -DQT_NO_COMPONENT -DQT_NO_STL -DQT_NO_COMPRESS -I/opt/qt-everywhere-opensource-src-4.7.3/mkspecs/linux-g++-64 -DHAVE_QCONFIG_CPP -DQT_NO_THREAD -DQT_NO_QOBJECT -DQT_NO_GEOM_VARIANT  option.cpp
g++ -o "/opt/qt-everywhere-opensource-src-4.7.3/bin/qmake" project.o property.o main.o makefile.o unixmake2.o unixmake.o mingw_make.o option.o winmakefile.o projectgenerator.o meta.o makefiledeps.o metamakefile.o xmloutput.o pbuilder_pbx.o borland_bmake.o msvc_vcproj.o msvc_vcxproj.o msvc_nmake.o msvc_objectmodel.o msbuild_objectmodel.o symmake.o initprojectdeploy_symbian.o symmake_abld.o symmake_sbsv2.o symbiancommon.o registry.o epocroot.o qtextcodec.o qutfcodec.o qstring.o qtextstream.o qiodevice.o qmalloc.o qglobal.o qbytearray.o qbytearraymatcher.o qdatastream.o qbuffer.o qlist.o qfile.o qfsfileengine_unix.o qfsfileengine_iterator_unix.o qfsfileengine.o qfsfileengine_iterator.o qregexp.o qvector.o qbitarray.o qdir.o qdiriterator.o quuid.o qhash.o qfileinfo.o qdatetime.o qstringlist.o qabstractfileengine.o qtemporaryfile.o qmap.o qmetatype.o qsettings.o qlibraryinfo.o qvariant.o qvsnprintf.o qlocale.o qlinkedlist.o qurl.o qnumeric.o qcryptographichash.o qxmlstream.o qxmlutils.o  -m64 
Basic XLib functionality test failed!
 You might need to modify the include and library search paths by editing
 QMAKE_INCDIR_X11 and QMAKE_LIBDIR_X11 in /opt/qt-everywhere-opensource-src-4.7.3/mkspecs/qws/linux-arm-gnueabi-g++.
```



```
 
```

2.执行make后可能会报错，不同的编译器版本出现的错误不一样，本人刚开始使用 ,aarch-linux-gnu 7.2.1版本编译器，出现如下错误：

```
../../include/QtCore/../../src/corelib/tools/qmap.h: In instantiation of ‘T& QMap<Key, T>::operator[](const Key&) [with Key = int; T = inotify_event]’:
io/qfilesystemwatcher_inotify.cpp:364:33:   required from here
../../include/QtCore/../../src/corelib/tools/qmap.h:531:45: error: value-initialization of incomplete type ‘char []’
         node = node_create(d, update, akey, T());
                                             ^~~
```

google了一波并没有找到解决办法，个人感觉可能是qt代码太老的关系，好多东西到现在的Qt5.11都已经弃用，编译器太新导致出错，之前用aarch64-linux-gnu 7.2.1编译qt5.5.1并没有出现这个错误，所以决定换个编译器的版本尝试一下。改用aarch64-linux-gnu 5.3.1版本后,没有出现这个错误。

但是在后面编译时出现了新的错误，如下：



```
runtime/JSValue.h: In constructor 'JSC::JSValue::JSValue(JSC::JSCell*)':
runtime/JSValue.h:494:57: error: cast from 'JSC::JSCell*' to 'int32_t {aka int}' loses precision [-fpermissive]
         u.asBits.payload = reinterpret_cast<int32_t>(ptr);
                                                         ^
runtime/JSValue.h: In constructor 'JSC::JSValue::JSValue(const JSC::JSCell*)':
runtime/JSValue.h:506:78: error: cast from 'JSC::JSCell*' to 'int32_t {aka int}' loses precision [-fpermissive]
         u.asBits.payload = reinterpret_cast<int32_t>(const_cast<JSCell*>(ptr));
                                                                              ^
make[1]: *** [.obj/release-static-emb-armv8/JSBase.o] Error 1
make[1]: Leaving directory `/opt/qt-everywhere-opensource-src-4.7.3/src/3rdparty/webkit/JavaScriptCore'
make: *** [sub-javascriptcore-make_default-ordered] Error 2
```



google了一下，原来是Qt4.7的一个Bug,国外大胸弟们也是一顿操作，然而并没有给出具体的解决办法，想到在64位arm上跑，所以把494和506行的int32_t改成int64_t编译通过了，但是编译完成后并没有生成webkit的动态库，很是无语。这个错误就是编译webkit第三方库的时候出现的，为什么编译通过后没有libQtWebKit.so.4.7.3呢！

既然没有生成webkit库，那就在configure后面加上参数 -webkit，指明编译这个库。configure后生成新的Makefile,make继续填坑。编译过程中又出现了这个错误。打开JSValue.h文件发现是修改过的int64_t，执行command：

```
[root@jz4775dev]# find ./ -name JSValue.h
./src/3rdparty/webkit/WebCore/ForwardingHeaders/runtime/JSValue.h
./src/3rdparty/webkit/JavaScriptCore/runtime/JSValue.h
./src/3rdparty/javascriptcore/JavaScriptCore/runtime/JSValue.h
```

原来有三个!``
``

一个个来查看：

``` cpp
// [root@jz4775dev]# vim ./src/3rdparty/webkit/WebCore/ForwardingHeaders/runtime/JSValue.h
#ifndef WebCore_FWD_JSValue_h
#define WebCore_FWD_JSValue_h
#include <JavaScriptCore/JSValue.h>
#endif
```

不是这个；



``` cpp
// [root@jz4775dev]# vim ./src/3rdparty/webkit/JavaScriptCore/runtime/JSValue.h


  inline JSValue::JSValue(JSCell* ptr)
  {
      if (ptr)
          u.asBits.tag = CellTag;
      else
          u.asBits.tag = EmptyValueTag;
      u.asBits.payload = reinterpret_cast<int32_t>(ptr);
#if ENABLE(JSC_ZOMBIES)
      ASSERT(!isZombie());
#endif
  }

  inline JSValue::JSValue(const JSCell* ptr)
  {
      if (ptr)
          u.asBits.tag = CellTag;
      else
          u.asBits.tag = EmptyValueTag;
      u.asBits.payload = reinterpret_cast<int32_t>(const_cast<JSCell*>(ptr));
#if ENABLE(JSC_ZOMBIES)
        ASSERT(!isZombie());
#endif
    }
```



就是你了，把int32_t改成int64_t后继续编译，编译顺利完成。

这时在 "ls lib/" 查看：



```
[root@jz4775dev]# ls lib/
fonts                libQtCore.so           libQtDeclarative.so.4.7    libQtNetwork.la        libQtScript.la         libQtScriptTools.so.4.7    libQtSvg.so         libQtWebKit.la        libQtXml.so
libphonon.la         libQtCore.so.4         libQtDeclarative.so.4.7.3  libQtNetwork.prl       libQtScript.prl        libQtScriptTools.so.4.7.3  libQtSvg.so.4       libQtWebKit.prl       libQtXml.so.4
libphonon.prl        libQtCore.so.4.7       libQtGui.la                libQtNetwork.so        libQtScript.so         libQtSql.la                libQtSvg.so.4.7     libQtWebKit.so        libQtXml.so.4.7
libpvrQWSWSEGL.prl   libQtCore.so.4.7.3     libQtGui.prl               libQtNetwork.so.4      libQtScript.so.4       libQtSql.prl               libQtSvg.so.4.7.3   libQtWebKit.so.4      libQtXml.so.4.7.3
libQAxContainer.prl  libQtDBus.la           libQtGui.so                libQtNetwork.so.4.7    libQtScript.so.4.7     libQtSql.so                libQtTest.la        libQtWebKit.so.4.7    pkgconfig
libQAxServer.prl     libQtDBus.prl          libQtGui.so.4              libQtNetwork.so.4.7.3  libQtScript.so.4.7.3   libQtSql.so.4              libQtTest.prl       libQtWebKit.so.4.7.3  README
libQt3Support.la     libQtDeclarative.la    libQtGui.so.4.7            libQtOpenGL.la         libQtScriptTools.la    libQtSql.so.4.7            libQtTest.so        libQtXml.la
libQt3Support.prl    libQtDeclarative.prl   libQtGui.so.4.7.3          libQtOpenGL.prl        libQtScriptTools.prl   libQtSql.so.4.7.3          libQtTest.so.4      libQtXmlPatterns.la
libQtCore.la         libQtDeclarative.so    libQtMultimedia.la         libQtOpenVG.la         libQtScriptTools.so    libQtSvg.la                libQtTest.so.4.7    libQtXmlPatterns.prl
libQtCore.prl        libQtDeclarative.so.4  libQtMultimedia.prl        libQtOpenVG.prl        libQtScriptTools.so.4  libQtSvg.prl               libQtTest.so.4.7.3  libQtXml.prl
```



libQtWebKit.so.4.7.3 有了，嗯...美滋滋！

 

然后执行command:

```
make install
```

就会把生成的库等相干东西安装在/opt/qt-4.7.3-arm64目录下。至此，交叉编译告一段落。下面的任务就是移植到arm开发板上。

#### 3.移植到arm开发板上

方法很简单，把qt-4.7.3-arm64打包，生成qt-4.7.3-arm64.tgz。把它放到开发板的上，放在哪你自己决定，我是同样放在/opt目录下,然后解压。

编辑开发板上 /etc/profile文件，在最后一行添加如下环境变量：



```
#
# Configure the runtime environment for Qt
#
export QTDIR=/opt/qt-4.7.3-arm64
export LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH 
export QT_QWS_FONTDIR=$QTDIR/lib/fonts
export QWS_SIZE=800x400
export QWS_DISPLAY=LinuxFb:/dev/fb0(这个根据开发板而定)
```



添加完后wq保存退出，执行command：

```
source /etc/profile
```

使修改生效，然后你就可以在你的开发板上运行你的qtdemo啦...

 

```
localhost:/opt/qt-4.7.3-arm64/examples/webkit # file fancybrowser/fancybrowser
fancybrowser/fancybrowser: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, for GNU/Linux 3.7.0, BuildID[sha1]=68c7b85ea380524f07bcc49da63dff2505ddfb57, stripped

查看demo的可执行文件的类型，基于ARM aarch64，正确的。
```

 

### 《题外篇》

如果想要实现触摸功能，需要编译tslib.

#### 4.编译tslib

Tslib是一个开源的程序，能够为触摸屏驱动获得的采样提供诸如滤波、去抖、校准等功能，通常作为触摸屏驱动的适配层，为上层的应用提供了一个统一的接口。在采用触摸屏的移动终端中，触摸屏性能的调试是个重要问题之一，因为电磁噪声的缘故，触摸屏容易存在点击不准确、有抖动等问题。

到 github 下载 tslib最新版，地址：https://github.com/libts/tslib.git 

下载后文件名为tslib-master.zip。

##### 1.建立工作目录

```
cd /opt
mkdir tslib
```

##### 2.编译安装tslib

将下载的tslib源码复制到/opt目录下，并解压：

```
unzip tslib-master.zip
cd tslib-master
```

##### 3.编译

配置tslib，安装路径可以通过 --prefix 参数设置，这里安装到 /opt/tslib：

```
./autogen.sh
./configure CC=aarch64-linux-gnu-gcc CXX=aarch64-linux-gnu-g++ --host=aarch64-linux-gnu  --prefix=/opt/tslib ac_cv_func_malloc_0_nonnull=yes
```

 

编译安装：

```
make 
make install
```

完成后，tslib会按安装到主机 /opt/tslib 目录下。 进入下一步之前，先将主机中 /opt/tslib/etc/ts.conf 文件第二行“#module_raw input”的注释去掉，变为“module_raw input”，注意一定要顶格(哥哥编译好时第二行的注释符#已经去掉了)。

 

### 重新编译Qt-4.7.3

这时qmake.conf文件修改为如下：



```
#
# qmake configuration for building with arm-none-linux-gnueabi-g++
#

include(../../common/g++.conf)
include(../../common/linux.conf)
include(../../common/qws.conf)

# modifications to g++.conf
QMAKE_CC                = aarch64-linux-gnu-gcc -lts
QMAKE_CXX               = aarch64-linux-gnu-g++ -lts
QMAKE_LINK              = aarch64-linux-gnu-g++ -lts
QMAKE_LINK_SHLIB        = aarch64-linux-gnu-g++ -lts

# modifications to linux.conf
QMAKE_AR                = aarch64-linux-gnu-ar cqs 
QMAKE_OBJCOPY           = aarch64-linux-gnu-objcopy
QMAKE_STRIP             = aarch64-linux-gnu-strip

load(qt_config)
```



configure也要添加新的参数:

```
-no-mouse-qvfb -qt-mouse-linuxtp -qt-mouse-tslib -DQT_QLOCALE_USES_FCVT -DQT_NO_QWS_CURSOR -no-pch -I/opt/tslib/include -L/opt/tslib/lib -confirm-license
```

然后再make && make install

 

编译好后把qt-4.7.3-arm64和tslib同时拷贝到开发板/opt下。 编辑/etc/profile添加环境变量：



```
export QTDIR=/opt/qt-4.7.3-arm64
export T_ROOT=/opt/tslib
export PATH=$T_ROOT/bin:$PATH
export LD_LIBRARY_PATH=$T_ROOT/lib:$QTDIR/lib:$LD_LIBRARY_PATH
export TSLIB_CONSOLEDEVICE=none
export TSLIB_FBDEVICE=/dev/fb0
export TSLIB_TSDEVICE=/dev/input/event0
export TSLIB_PLUGINDIR=$T_ROOT/lib/ts
export TSLIB_CONFFILE=$T_ROOT/etc/ts.conf
export TSLIB_CALIBFILE=/etc/pointercal
export QWS_KEYBOARD=USB:/dev/input/event1
export QWS_MOUSE_PROTO=Tslib:/dev/input/event0
export QT_QWS_FONTDIR=$QTDIR/lib/fonts
```



 

```
 
```

本文来自博客园，作者：[王楼小子](https://www.cnblogs.com/wanglouxiaozi/)，转载请注明原文链接：<https://www.cnblogs.com/wanglouxiaozi/p/9521950.html>



分类: [Qt-Arm](https://www.cnblogs.com/wanglouxiaozi/category/1284496.html)