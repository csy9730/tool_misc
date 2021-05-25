# ldd



```
$ ldd --help
用法：ldd [选项]… 文件…
      --help              印出这份说明然后离开
      --version           印出版本信息然后离开
  -d, --data-relocs       进程数据重寻址
  -r, --function-relocs   进程数据和函数重寻址
  -u, --unused            印出未使用的直接依赖关系
  -v, --verbose           印出所有信息

要知道错误报告指令，请参看:
<https://bugs.launchpad.net/ubuntu/+source/glibc/+bugs>.
```

### c demo
```
$ldd /home/parseDemo

linux-vdso.so.1 (0x00007ffe7c7ea000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f4d5e1bd000)
/lib64/ld-linux-x86-64.so.2 (0x00007f4d5e7b3000)
```
### c++ demo
```
$ldd /home/jsonDemo

linux-vdso.so.1 (0x00007ffe44ed2000)
libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007fc1cd3c1000)
libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007fc1cd1a9000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fc1ccdb8000)
libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fc1cca1a000)
/lib64/ld-linux-x86-64.so.2 (0x00007fc1cd9fa000)
```

```
$ldd /usr/lib/x86_64-linux-gnu/libstdc++.so.6
linux-vdso.so.1 (0x00007fff7c5bb000)
libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fa6e4693000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fa6e42a2000)
/lib64/ld-linux-x86x-64.so.2 (0x00007fa6e4dba000)
libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007fa6e408a000)
```

```
$ ldd /lib/x86_64-linux-gnu/libgcc_s.so.1 
linux-vdso.so.1 (0x00007ffd0e2c0000)
libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f5d82a24000)
/lib64/ld-linux-x86-64.so.2 (0x00007f5d8302d000)
``` 

## c runtime
### libc
### glibc
### libstdc++
### libc++
libstdc++是gcc搞的，libc++是llvm搞的，他们都是C++标准库的实现。
libc++是针对clang编译器特别重写的C++标准库
两套c++标准库，使用取决于编译器优先集成哪个，一般libstdc++兼容性好些，发展的比较早。

相比glibc，libstdc++虽然提供了c++程序的标准库，但它并不与内核打交道。对于系统级别的事件，libstdc++首先是会与glibc交互，才能和内核通信。相比glibc来说，libstdc++就显得没那么基础了。
### openbsd libm
[https://github.com/openbsd/src/tree/master/lib/libm/src](https://github.com/openbsd/src/tree/master/lib/libm/src)

### openbsd libz
zlib是软件包的名称，里面包括库文件libz.so
[http://www.zlib.net/](http://www.zlib.net/)
### misc
libz  压缩库（Z）
librt 实时库（real time）
libm  数学库（math）
libc  标准C库（C lib）