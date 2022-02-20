# watch

watch是一个非常实用的命令，基本所有的Linux发行版都带有这个小工具，如同名字一样，watch可以帮你监测一个命令的运行结果，省得你一遍遍的手动运行。在Linux下，watch是周期性的执行下个程序，并全屏显示执行结果。你可以拿他来监测你想要的一切命令的结果变化，比如 tail 一个 log 文件，ls 监测某个文件的大小变化，看你的想象力了！


### 命令参数
-n或--interval  watch缺省每2秒运行一下程序，可以用-n或-interval来指定间隔的时间。
-d或—differences  用-d或—differences 选项watch 会高亮显示变化的区域。 而-d=cumulative选项会把变动过的地方(不管最近的那次有没有变动)都高亮显示出来。
-t 或-no-title  会关闭watch命令在顶部的时间间隔,命令，当前时间的输出。
-h, —help 查看帮助文档


## help
```
(base) root@DESKTOP:/mnt/h/tmp# watch

Usage:
 watch [options] command

Options:
  -b, --beep             beep if command has a non-zero exit
  -c, --color            interpret ANSI color and style sequences
  -d, --differences[=<permanent>]
                         highlight changes between updates
  -e, --errexit          exit if command has a non-zero exit
  -g, --chgexit          exit when output from command changes
  -n, --interval <secs>  seconds to wait between updates
  -p, --precise          attempt run command in precise intervals
  -t, --no-title         turn off header
  -x, --exec             pass command to exec instead of "sh -c"

 -h, --help     display this help and exit
 -v, --version  output version information and exit

For more details see watch(1).
```

## demo

### 实例1
命令：每隔一秒高亮显示网络链接数的变化情况
```
watch -n 1 -d netstat -ant
```
Shell输出结果：
```
Every 1.0s: netstat -ant                                Mon Feb 27 20:49:38 2017

Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN
tcp        0      0 192.168.0.210:22        192.168.0.5:51577       ESTABLISHED
tcp6       0      0 :::80                   :::*                    LISTEN
tcp6       0      0 :::22                   :::*                    LISTEN
tcp6       0      0 ::1:25                  :::*                    LISTEN
Shell
```
说明：其它操作：//原文出自【易百教程】，商业转载请联系作者获得授权，非商业请保留原文链接：https://www.yiibai.com/linux/watch.html

### 实例5
实例5：10秒一次输出系统的平均负载命令：
watch -n 10 'cat /proc/loadavg'
Shell
输出结果如下：
Every 10.0s: cat /proc/loadavg                          Mon Feb 27 20:54:45 2017

0.01 0.04 0.05 1/132 6335//原文出自【易百教程】，商业转载请联系作者获得授权，非商业请保留原文链接：https://www.yiibai.com/linux/watch.html

### 显示时间
```
watch -n1 "date '+%D%n%T'"
```