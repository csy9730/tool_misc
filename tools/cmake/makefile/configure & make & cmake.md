# configure & make & cmake

configure 是一个用户编辑的脚本，用来实现目标平台检测，编译器检测，交互式配置等功能。
makefile 也是一个用户编辑的脚本，里面含有编译，清理，安装等功能命令，make命令会在当前目录下搜索makefile脚本并执行。

### configure命令

　　这一步一般用来生成 Makefile，为下一步的编译做准备，你可以通过在 configure 后加上参数来对安装进行控制，比如代码:`./configure –prefix=/usr` 意思是将该软件安装在 /usr 下面，执行文件就会安装在 /usr/bin （而不是默认的 /usr/local/bin),资源文件就会安装在 /usr/share（而不是默认的/usr/local/share）。同时一些软件的配置文件你可以通过指定`–sys-config=` 参数进行设定。有一些软件还可以加上 `–with`、`–enable`、`–without`、`–disable` 等等参数对编译加以控制，你可以通过允许 ./configure –help 察看详细的说明帮助。

### make

make 位于 `/usr/bin/make`。

``make all`, make install, make clean 都是在makefile脚本中搜索对应的命令，并执行。直接make 也是默认执行 `make all`。`make install` 执行makefile里的安装命令。

```makefile
# Makefile begin
all:
        @echo you have typed command "make all"
clean:
        @echo you have typed command "make clean"
install:
        @ehco you have typed command "make $@"
```

### cmake

以上是传统的linux下程序编译安装方法。
现在流行使用cmake，cmake包含configure，命令配置，自动生成makefile，调用make等功能。通过CMake基本取代了configure，通过CMakeLists来配置和生成makefile。