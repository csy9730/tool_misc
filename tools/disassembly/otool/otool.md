# otool

otool可用于解析与OS X Mach-O二进制文件有关的信息，因此，可简单将其描述为：OS X系统下的类似于objdump的实用工具。下面的代码说明了如何使用otool显示一个Mach-O二进制文件的动态库依赖关系，从而执行类似于ldd的功能。