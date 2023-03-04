# Shell history详解：查看历史命令

Bash 有完善的历史命令，这对于简化管理操作、排查系统错误都有重要的作用，而且使用简单方便，建议大家多使用历史命令。系统保存的历史命令可以使用 history 命令查询，命令格式如下：

[root@localhost ~]# history [选项] [历史命令保存文件]

选项：

- -c：清空历史命令；
- -w：把缓存中的历史命令写入历史命令保存文件中。如果不手工指定历史命令保存文件，则放入默认历史命令保存文件 ~/.bash_history 中；

如果 history 命令直接回车，则用于查询系统中的历史命令，命令如下：
```
[root@localhost ~]# history
…省略部分输出…
421 chmod 755 hello.sh
422/root/sh/hello.sh
423 ./hello.sh
424 bash hello.sh
425 history
```
这样就可以查询我们刚刚输入的系统命令，而且每条命令都是有编号的。历史命令默认会保存 100 条，这是通过环境变量 HISTSIZE 进行设置的，我们可以在环境变量配置文件 /etc/profile 中进行修改。命令如下：
```
[root@localhost ~]#vi /etc/profile
…省略部分输出…
HISTSIZE=1000
…省略部分输出…
```
如果觉得 1000 条历史命令不够曰常管理使用，那么是否可以増加呢？只需修改 /etc/profile 环境变量配置文件中的 HISTSIZE 字段即可，不过我们需要考虑一个问题：这些历史命令是保存在哪里的呢？如果历史命令是保存在文件中的，那么历史命令的保存数量可以放心地增加，因为哪怕有几万条历史命令，也不会占用多大的硬盘空间。但是，如果历史命令是保存在内存当中的，就要小心了。好在历史命令是保存在 ~/.bash_history 文件中的，所以可以放心地把总历史命令条数改大，比如 10 000 条，命令如下：
```
[root@localhost ~]#vi /etc/profile
…省略部分输出…
HISTSIZE=10000
…省略部分输出…
```
大家需要注意，每个用户的历史命令是单独保存的，所以每个用户的家目录中都有 .bash_history 这个历史命令文件。

如果某个用户的历史命令总了历史命令保存条数，那么新命令会变成最后一条命令，而最早的命令则被删除。假设系统保存 1000 条历史命令，而我已经保存了 1000 条历史命令，那么我新输入的命令会被保存成第 1000 条命令，而最早的第一条命令会被删除。

还要注意一下，我们使用 history 命令查看的历史命令和 ~/.bash_history 文件中保存的历史命令是不同的。那是因为当前登录操作的命令并没有直接写入 ~/.bash_history 文件中，而是保存在缓存当中的，需要等当前用户注销之后，缓存中的命令才会写入 ~/.bash_history 文件中。

如果我们需要把内存中的命令直接写入 ~/.bash_history 文件中，而不等用户注销时再写入，就需要使用"-w"选项。命令如下：
```
[root@localhost ~]# history -w
\#把缓存中的历史命令直接写入~/.bash_history
```
这时再去查询 ~/.bash_history 文件，历史命令就和 history 命令查询的结果一致了。

如果需要清空历史命令，则只需要执行如下命令：

[root@localhost ~]# history -c
\#清空历史命令

这样就会把缓存和 ~/.bash_history 文件中的历史命令清空。

## 历史命令的调用

如果想要使用原先的历史命令，则有这样几种方法：

- 使用上、下箭头调用以前的历史命令。
- 使用"!n"重复执行第 n 条历史命令。
```
[root@localhost ~]# history
…省略部分输出…
421 chmod 755 hello.sh
422/root/sh/hello.sh
423 ./hello.sh
424 bash hello.sh
425 history
[root@localhost sh]# !424
\#重复执行第424条命令
```
- 使用"!!"重复执行上一条命令。
```
[root@localhost sh]#!!
\#如果接着上一条命令，则会把424命令再执行一遍
```
- 使用"！字符串"重复执行最后一条以该字符串开头的命令。

[root@localhost sh]#!bash
\#重复执行最后一条以bash开头的命令，也就是第424条命令bash hello.sh

- 使用"!$"重复上一条命令的最后一个参数。

[root@localhost ~]# cat /etc/sysconfig/network-scripts/ifcfg-eth0
\#查看网卡配置文件内容
[root@localhost ~]# vi !$
\# "!$"代表上一条命令的最后一个参数，也就是/etc/sysconfig/network-scripts/ifcfg-eth0