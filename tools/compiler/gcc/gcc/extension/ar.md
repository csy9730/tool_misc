# ar


### 合并多个静态库.a为一个.a
注意区分 .a 和 .o文件

每个c文件对应一个o文件，多个o文件打包成a文件。

```
$ ar rc libxtar.a *.c.o


$ ar x libxtar.a 
$ ls
libxtar.a  list.c.o  xtar.c.o xtar_list.c.o

```

如果想把一个静态库包含到另一个静态库里，比如:`ar rc liball.a libtest1.a libtest2.a`
即把libtest1.a和libtest2.a包含到liball.a里面。这样是不行的。
需要包 a文件拆分成o文件，再重新打包。
``` bash
cd temp
ar x libtest1.a
ar x libtest2.a
ar rc liball.a *.o
```