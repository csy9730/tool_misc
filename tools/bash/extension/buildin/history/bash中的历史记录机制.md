# [bash中的历史记录机制](https://segmentfault.com/a/1190000022146475)

[![img](https://avatar-static.segmentfault.com/817/251/81725100-5e758a5ccba30_huge128)**1996scarlet**](https://segmentfault.com/u/1996scarlet)发布于 2020-03-25

![img](https://sponsor.segmentfault.com/lg.php?bannerid=0&campaignid=0&zoneid=25&loc=https%3A%2F%2Fsegmentfault.com%2Fa%2F1190000022146475&referer=https%3A%2F%2Fcn.bing.com%2F&cb=eb9c0cd735)

# 基本用法

## 显示历史记录

使用`history`可以查看当前用户最近执行的`HISTSIZE`条命令，这些记录被存储在`HISTFILE`文件中，在`bash`启动时会自动加载到历史记录缓冲队列，其简单使用方法如下：

```bash
> history  # 显示全部历史记录
    1  ip a
    2  exit
    3  ls -la
    4  history
> history 2  # 显示最后两条历史记录
    4  history
    5  history 2
```

## 搜索与批量查询

使用`Ctrl + R`快捷键可以进入历史记录搜索模式，根据用户输入的字符按照**最近最相似**原则将搜索结果打印到命令提示符后面，输入回车可以直接执行这条结果。另一种方式是使用`grep`配合管道进行批量搜索：

```bash
> history | grep ffmpeg | grep gif | grep yuv444p  
 119  ffmpeg -y -f gif -i 79557166.gif -c:v libx264 -vf format=yuv444p yuv444p.mp4  
 120  ffmpeg -y -f gif -i 79557166.gif -c:v libx264 -vf format=yuv444p yuv444p.mkv
```

## 立即执行（危险）

使用`!!`能够立即执行历史记录中的最后一条命令，也就是重复上一条命令；使用`![number]`能够根据`number`执行对应编号的历史命令；使用`![string]`能够根据`string`按照**最近最相似**原则执行历史命令。这类命令最人性化的是会在执行前打印要执行的命令（让你知道系统是怎么挂的）。

```bash
> date
Sun 23 Feb 2020 06:18:16 PM CST
> !!  # 不安全
date  
Sun 23 Feb 2020 06:18:18 PM CST
> !907  # 危险
make  
make: \*\*\* No targets specified and no makefile found.  Stop.
> !shut  # 非常危险
shutdown now
```

通过`!`开头的命令直接执行对应的历史记录是十分危险的，尤其是在高权限用户环境下，因此建议在执行之前通过以下方式查看对应的命令：

```bash
> !!:p      #查看记录中最后一条命令
> !123:p    #查看记录中第123条命令
> !sys:p    #查看记录中sys开头的最近一条命令
```

## 删除记录

使用`history -d <hist_num>`可以删除指定序号的历史记录，该模式只接收一个参数，其他参数会被忽略，利用这一特性可以实现在bash中执行不被记录的命令。

```bash
> echo "secret command";history -d $(history 1)
secret command
```

如果你想完全清除当前会话内的使用痕迹，可以使用`history -c`清空历史记录缓冲队列，值得注意的是这个命令不会清空历史记录文件。

> [warning]**注意**：除了上述方法外，用户还可以通过`unset HISTFILE`直接取消历史记录功能，这对服务器的日常维护来说是十分危险的。

## 文件操作

在退出终端时bash会自动将当前会话中执行过的命令写入历史记录文件中，默认写入方式为覆盖。你也可以通过`-w`和`-a`模式将当前会话中的命令手动写入文件中：

```bash
> history -w  # 缓冲队列覆盖写入文件
> history -a  # 当前会话的命令追加写入文件
```

# 高级设置

以`Ubuntu 20.04 LTS`为例，默认情况下历史记录相关的环境变量被定义在`~/.bashrc`文件中。

## 添加时间戳

通过修改`HISTTIMEFORMAT`变量可以对历史记录添加时间戳，`%F`代表日期，`%T`代表时间。

```shell
> export HISTTIMEFORMAT='%F %T '
> echo 'history with time'
> history 1
1032  2020-02-23 17:01:26 history
```

## 修改记录策略

通过修改`HISTCONTROL`变量可以控制`history`的记录策略，如下表所示：

| 可选值      | 记录策略                         |
| ----------- | -------------------------------- |
| ignoredups  | 默认，不记录**连续**的相同命令   |
| ignorespace | 不记录空格开头的命令             |
| ignoreboth  | ignoredups 和 ignorespace 的组合 |
| erasedups   | 不记录重复的命令                 |

我们还可以通过设置`HISTIGNORE`变量指定要忽略的命令，命令之间用`:`分隔：

```bash
> echo 'export HISTIGNORE="ls:cd"' >> ~/.bashrc
> source ~/.bashrc
```

## 修改存储文件

当前用户的历史记录默认存储到`~/.bash_history`文件中，可以通过修改`HISTFILE`变量改变历史记录存储的位置。

```bash
> echo 'export HISTFILE="<new_histfile_path>"' >> ~/.bashrc
> source ~/.bashrc
```

## 修改存储大小

变量`HISTSIZE`决定了使用`history`时**显示**的记录数量，其默认值为`1000`。

```bash
> echo $HISTSIZE
1000
> HISTSIZE=200 # 仅针对当前会话生效
> sed -i 's/^HISTSIZE=1000/HISTSIZE=200/' ~/.bashrc # 永久生效
> echo $HISTSIZE
200
```

变量`HISTFILESIZE`定义了**存储**在文件中的历史命令总数，默认值为`2000`。历史记录的存储方式类似于队列，`bash`初始化时会将`HISTFILE`文件中存储的所有历史记录加载到内存中，以队列的形式存储，用户在使用过程中产生的命令也会被添加到队列中，每次用户调用`history`都会显示最近的`HISTSIZE`条记录。

## 修改存储策略

在终端退出时会将当前会话（session）中产生的记录写入到文件中，为了防止同时开启多个终端导致历史记录丢失，建议在`~/.bashrc`文件中添加`shopt -s histappend`，让终端在退出时将当前会话产生的历史记录追加写入到`HISTFILE`文件中。

> [warning] **注意**：默认情况下的历史记录写入方式为覆盖，例如：开启终端A -> 开启终端B -> 关闭终端A -> 关闭终端B，这个操作序列会导致终端A在运行过程中产生的历史记录全部丢失。

断电、非法关机等特殊情况会让`bash`无法正常结束，进而导致当前会话的历史记录丢失。可以在`~/.bashrc`文件中添加以下内容实现自动追加写入每条命令：

```bash
PROMPT_COMMAND=”history -a”
```

在`bash`的配置文件中，如果设置了`PROMPT_COMMAND`环境变量，则在每次显示命令提示符（例如：`remilia@CT7GK:~$`）之前，该变量的值将被作为命令执行，这里我们设置为自动执行执行`history -a`，将历史记录追加写入到文件中。

[bash](https://segmentfault.com/t/bash)[linux](https://segmentfault.com/t/linux)[shell](https://segmentfault.com/t/shell)[history](https://segmentfault.com/t/history)