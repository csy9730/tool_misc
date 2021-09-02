# Automake的使用
[和谐共处](https://www.jianshu.com/u/b37773b21ff3)关注

0.3142019.01.09 15:32:36字数 124阅读 6,330

### 进入到你的源码目录

```cpp
$ cd src
$ ls
main.c
cat main.c
# 代码如下：
#include <stdio.h>

int main(int argc, char** argv){

    printf("Hello, Auto Makefile!\n");
    return 0;

}
```

### 开始使用Automake了

- 执行autoscan

```ruby
$ autoscan
$ ls
autoscan.log    configure.scan  main.c
```

- 复制configure.scan为configure.ac(以前为configure.in)

```ruby
$ cp configure.scan configure.ac
```

- 编辑configure.ac或configure.in文件

```ruby
#                                               -*- Autoconf -*-
#Process this file with autoconf to produce a configure script.
AC_PREREQ([2.69])
#包名(最终可执行文件)、版本号、联系地址
AC_INIT(main, 1.0, 1710308677@qq,com)
AC_CONFIG_SRCDIR([main.c])
AC_CONFIG_HEADERS([config.h])
#加这一行：包名、版本号与上面保持一致configure.in写法
#AM_INIT_AUTOMAKE(main,1.0)
#configure.ac写法
#加这两行行：包名、版本号与上面保持一致configure.in写法
AC_CONFIG_SRCDIR([main.c])
AM_INIT_AUTOMAKE
#Checks for programs.
AC_PROG_CC
#Checks for libraries.
#Checks for header files.
#Checks for typedefs, structures, and compiler characteristics.
#Checks for library functions.
#加这一行表示要生产的Makefile这个文件
AC_OUTPUT([Makefile])
```

- 执行aclocal

```ruby
$ aclocal
$ ls
aclocal.m4  autoscan.log    configure.scan
autom4te.cache  configure.in    main.c
```

- 执行autoconf

```ruby
$ autoconf
$ ls
aclocal.m4  autoscan.log    configure.in    main.c
autom4te.cache  configure   configure.scan
```

- 执行autoheader

```ruby
$ autoheader
$ ls
aclocal.m4  autoscan.log    configure   configure.scan
autom4te.cache  config.h.in configure.in    main.c
```

- 创建Makefile.am文件

```ruby
$ vi Makefile.am
如下：
AUTOMAKE_OPTIONS=foreign
bin_PROGRAMS=main
main_SOURCES=main.c
```

- 执行automake --add-missing

```csharp
$ automake --add-missing
automake: warning: autoconf input should be named 'configure.ac', not 'configure.in'
configure.in:8: warning: AM_INIT_AUTOMAKE: two- and three-arguments forms are deprecated.  For more info, see:
configure.in:8: https://www.gnu.org/software/automake/manual/automake.html#Modernize-AM_005fINIT_005fAUTOMAKE-invocation
configure.in:10: installing './compile'
configure.in:8: installing './install-sh'
configure.in:8: installing './missing'
Makefile.am: installing './depcomp'
automake: warning: autoconf input should be named 'configure.ac', not 'configure.in'
$ ls
Makefile.am autom4te.cache  config.h.in configure.scan  main.c
Makefile.in autoscan.log    configure   depcomp     missing
aclocal.m4  compile     configure.in    install-sh
```

- 执行 ./configure

```swift
$ ./configure
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... ./install-sh -c -d
checking for gawk... no
checking for mawk... no
checking for nawk... no
checking for awk... awk
checking whether make sets $(MAKE)... yes
checking whether make supports nested variables... yes
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking whether gcc understands -c and -o together... yes
checking whether make supports the include directive... yes (GNU style)
checking dependency style of gcc... gcc3
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating config.h
config.status: executing depfiles commands
```

- 执行make

```go
$ make
/Applications/Xcode.app/Contents/Developer/usr/bin/make  all-am
gcc -DHAVE_CONFIG_H -I.     -g -O2 -MT main.o -MD -MP -MF .deps/main.Tpo -c -o main.o main.c
mv -f .deps/main.Tpo .deps/main.Po
gcc  -g -O2   -o main main.o  
```

- 测试生成的main可执行包

```ruby
$ ./main
Hello, Auto Makefile!
```

- 打包压缩

```bash
$ make dist
/Applications/Xcode.app/Contents/Developer/usr/bin/make  dist-gzip am__post_remove_distdir='@:'
/Applications/Xcode.app/Contents/Developer/usr/bin/make  distdir-am
if test -d "main-1.0"; then find "main-1.0" -type d ! -perm -200 -exec chmod u+w {} ';' && rm -rf "main-1.0" || { sleep 5 && rm -rf "main-1.0"; }; else :; fi
test -d "main-1.0" || mkdir "main-1.0"
test -n "" \
    || find "main-1.0" -type d ! -perm -755 \
        -exec chmod u+rwx,go+rx {} \; -o \
      ! -type d ! -perm -444 -links 1 -exec chmod a+r {} \; -o \
      ! -type d ! -perm -400 -exec chmod a+r {} \; -o \
      ! -type d ! -perm -444 -exec /bin/sh /Users/hqmac/Desktop/temp/install-sh -c -m a+r {} {} \; \
    || chmod -R a+r "main-1.0"
tardir=main-1.0 && ${TAR-tar} chof - "$tardir" | eval GZIP= gzip --best -c >main-1.0.tar.gz
if test -d "main-1.0"; then find "main-1.0" -type d ! -perm -200 -exec chmod u+w {} ';' && rm -rf "main-1.0" || { sleep 5 && rm -rf "main-1.0"; }; else :; fi
$ ls
Makefile    autoscan.log    config.status   install-sh  missing
Makefile.am compile     configure   main        stamp-h1
Makefile.in config.h    configure.in    main-1.0.tar.gz
aclocal.m4  config.h.in configure.scan  main.c
autom4te.cache  config.log  depcomp     main.o
```

- 供别人使用

```ruby
$ tar -zxvf main-1.0.tar.gz
x main-1.0/
x main-1.0/install-sh
x main-1.0/configure
x main-1.0/config.h.in
x main-1.0/depcomp
x main-1.0/missing
x main-1.0/configure.in
x main-1.0/Makefile.am
x main-1.0/._main.c
x main-1.0/main.c
x main-1.0/compile
x main-1.0/Makefile.in
x main-1.0/aclocal.m4
$ ls
main-1.0    main-1.0.tar.gz
$ cd main-1.0
$ ./configure
$ make
$ ls
Makefile    aclocal.m4  config.h.in configure   install-sh  main.o
Makefile.am compile     config.log  configure.in    main        missing
Makefile.in config.h    config.status   depcomp     main.c      stamp-h1
$ ./main
Hello, Auto Makefile!
```

### 参考

<https://www.gnu.org/software/automake/manual/automake.html>
<https://www.gnu.org/software/automake/manual/automake.html#Modernize-AM_005fINIT_005fAUTOMAKE-invocation>
<https://blog.csdn.net/fd315063004/article/details/7785504>
<https://blog.csdn.net/lichangrui2009/article/details/54889694>





5人点赞



日记本