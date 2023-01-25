# C++ 性能分析工具调研
### gperftools
https://github.com/gperftools/gperftools

### valgrind
https://valgrind.org/

> Valgrind is an instrumentation framework for building dynamic analysis tools. There are Valgrind tools that can automatically detect many memory management and threading bugs, and profile your programs in detail. You can also use Valgrind to build new tools.

valgrind 本质就是一个虚拟机，能在上面跑很多应用（tool）
### perf
perf是Linux下的一款性能分析工具，能够进行函数级与指令级的热点查找。

perf是一种系统级性能分析工具，它涉及内核调用，所以安装需要知道内核版本


利用perf剖析程序性能时，需要指定当前测试的性能时间。性能事件是指在处理器或操作系统中发生的，可能影响到程序性能的硬件事件或软件事件


#### demo


``` bash
# 录制程序
perf record -e cpu-clock -g ./test

# 使用report查看
perf report -i perf.data
```

#### source
[https://mirror.bjtu.edu.cn/kernel/linux/kernel/](https://mirror.bjtu.edu.cn/kernel/linux/kernel/)

#### install
```bash
yum install perf
```
### gprof

无需安装, gcc自带工具。