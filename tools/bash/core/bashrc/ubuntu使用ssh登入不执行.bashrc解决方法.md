# [ubuntu使用ssh登入不执行.bashrc解决方法](https://www.cnblogs.com/bigben0123/p/3184115.html)

解决方法，可以直接输入 bash即可。

理解 bashrc 和 profile

linux bashrc profile

SEP 30TH, 2011 BY SUNTEYA

在一般的 linux 或者 unix 系统中, 都可以通过编辑 bashrc 和 profile 来设置用户的工作环境, 很多文章对于 profile 和 bashrc 也都有使用, 但究竟每个文件都有什么作用和该如何使用呢?

首先我们来看系统中的这些文件, 一般的系统可能会有

| `1 2 3 4 5 ` | `/etc/profile /etc/bashrc ~/.bashrc ~/.profile ` |
| ------------ | ------------------------------------------------ |
|              |                                                  |

而如果系统是 ubuntu 或者 debian 的话, 就不会有 `/etc/bashrc` 而会有 `/etc/bash.bashrc` 文件.

以上这些就是常用 profile 和 bashrc 文件了. 要理解这些文件之前还需要了解 Shell, Shell 的 login(登入) 和 interactive(交互式) 模式.

## Shell 的模式

### Shell 的分类

系统的 shell 有很多种, 比如 bash, sh, zsh 之类的, 如果要查看某一个用户使用的是什么 shell 可以通过 `finger [USERNAME]` 命令来查看. **我们这里只说 shell 是 bash 的情况**, 因为如果是 sh 或者其他 shell 显然不会运行 bashrc 的.

### login shell 和 no-login shell

“login shell” 代表用户登入, 比如使用 “su -“ 命令, 或者用 ssh 连接到某一个服务器上, 都会使用该用户默认 shell 启动 login shell 模式.

**该模式下的 shell 会去自动执行 /etc/profile 和 ~/.profile 文件, 但不会执行任何的 bashrc 文件, 所以一般再 /etc/profile 或者 ~/.profile 里我们会手动去 source bashrc 文件.**

而 no-login shell 的情况是我们在终端下直接输入 bash 或者 bash -c “CMD” 来启动的 shell.

**该模式下是不会自动去运行任何的 profile 文件.**

### interactive shell 和 non-interactive shell

interactive shell 是交互式shell, 顾名思义就是用来和用户交互的, 提供了命令提示符可以输入命令.

**该模式下会存在一个叫 PS1 的环境变量, 如果还不是 login shell 的则会去 source /etc/bash.bashrc 和 ~/.bashrc 文件**

non-interactive shell 则一般是通过 bash -c “CMD” 来执行的bash.

**该模式下不会执行任何的 rc 文件, 不过还存在一种特殊情况这个我之后详细讲述**

## 在可能存在的模式组合中 RC 文件的执行

### SSH login, `sudo su - [USER]` 或者 mac 下开启终端

ssh 登入和 `su -` 是典型的 interactive login shell, 所以会有 PS1 变量, 并且会执行

```
/etc/profile
~/.profile
```

### 在命令提示符状态下输入 `bash` 或者 ubuntu 默认设置下打开终端

这样开启的是 interactive no-login shell, 所以会有 PS1 变量, 只会执行

```
/etc/bash.bashrc
~/.bashrc
```

### 通过 bash -c “CMD” 或者 bash BASHFILE 命令执行的 shell

这些命令什么都不会执行, 也就是设置 PS1 变量, 不执行任何 RC 文件

### 最特殊! 通过 “ssh server CMD” 执行的命令 或 通过程序执行远程的命令

这是最特殊的一种模式, 理论上应该既是 非交互 也是 非登入的, 但是实际上他不会设置 PS1, 但是还会执行

```
/etc/bash.bashrc
~/.bashrc
```

**这里还有一点值得注意的是 /etc/bashrc 任何情况下都不会执行.**

## bashrc 和 profile 的区别

看了之前那么多种状态组合, 最关键的问题是, 究竟 bashrc 和 profile 有什么区别呢?

### profile

其实看名字就能了解大概了, profile 是某个用户唯一的用来设置环境变量的地方, 因为用户可以有多个 shell 比如 bash, sh, zsh 之类的, 但像环境变量这种其实只需要在统一的一个地方初始化就可以了, 而这就是 profile.

### bashrc

bashrc 也是看名字就知道, 是专门用来给 bash 做初始化的比如用来初始化 bash 的设置, bash 的代码补全, bash 的别名, bash 的颜色. 以此类推也就还会有 shrc, zshrc 这样的文件存在了, 只是 bash 太常用了而已.

## 期望的执行顺序

`=>` 代表 在文件内部 source, 换行的 `=>` 代表自身执行结束以后在 source, 同一行表示先 source 在执行自身

### 普通 login shell

```
/etc/profile
   => /etc/bash.bashrc

~/.profile
  => ~/.bashrc => /etc/bashrc
```

### 终端种直接运行 bash

```
/etc/bash.bashrc
~/.bashrc => /etc/bashrc
```

### bash -c “CMD”

什么都不执行

### ssh server “CMD”

```
/etc/bash.bashrc => /etc/profile
~/.bashrc => | /etc/bashrc => /etc/profile
             | ~/.profile
```

这里会有点小混乱, 因为既有 /etc/bash.bashrc 又有 /etc/bashrc, 其实是这样的 ubuntu 和 debian 有 /etc/bash.bashrc 文件但是没有 /etc/bashrc, 其他的系统基本都是只有 /etc/bashrc 没有 /etc/bash.bashrc.

## 最终修改

为了达到上述我们需要的执行流程, 那必须对系统的 rc 文件做修改. 我们拿 Ubuntu 举例

首先 我们编辑 `/etc/profile` 在文件头部加入

```
export system_profile_loaded=1
```

这样其他文件就可以根据 $system_profile_loaded 来判断是否已经载入过 profile, 接着我们可以看到

```
  unset i
fi

if [ "$PS1" ]; then
  if [ "$BASH" ]; then
    PS1='\u@\h:\w\$ '
    if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
    fi
  else
    if [ "`id -u`" -eq 0 ]; then
      PS1='# '
    else
      PS1='$ '
    fi
  fi
fi

umask 022
```

按照我们刚才的方案, 应该是不管任何情况都应该在文件末尾去载入 bashrc, 所以我们修改成

```
  unset i
fi

umask 022

if [ "$BASH" ]; then
  if [ "$PS1" ]; then
    PS1='\u@\h:\w\$ '
  fi

  if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
  fi
else
  if [ "`id -u`" -eq 0 ]; then
    PS1='# '
  else
    PS1='$ '
  fi
fi
```

当然也可以有其他该法，只要符合在文件末尾载入 bashrc 就可以了.

接着我们修改 `/etc/bash.bashrc`, 我们需要在文件头加入

```
[ -n "${system_bashrc_running}" ] && return
system_bashrc_running=1
[ -z "${system_profile_loaded}" ] && source /etc/profile
unset system_bashrc_running
system_bashrc_runned=1
```

其中 system_bashrc_running 这样的变量都是为了防止2次反复调用而加入的.

这样系统级别的 rc 文件基本修改好了, 最好还可以再修改一下本地的rc文件, 所以我们编辑 “~/.profile”, 发现起内容是

```
# ~/.profile: executed by Bourne-compatible login shells.

if [ -n "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n
```

而按照上述的修改规则只需要替换成

```
export local_profile_loaded=1

if [ -n "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi
```

这样就始终再载入完 profile 以后去载入 bashrc 了, 接着我们像编辑 `/etc/bash.bashrc` 一样的去修改 `~/.bashrc`, 文件头上加入

```
[ -n "${local_bashrc_running}" ] && return
local_bashrc_running=1
[ -r /etc/bashrc -a -z "${system_bashrc_runned}" ] && source /etc/bashrc
[ -r ~/.profile -a -z "${local_profile_loaded}" ] && source ~/.profile
unset local_bashrc_running
```

用来防止反复加载 profile, 并且这里需要特殊注明的是

```
[ -r /etc/bashrc -a -z "${system_bashrc_runned}" ] && source /etc/bashrc
```

`/etc/bashrc` 这个文件只有在 mac 之类的系统下才有, 所以 ubuntu 这里这行可以不加, 不过有判断是否存在所以加了也没关系.

到这里基本上就可以比较完美的解决不通的 shell 加载顺序问题了, 当然比如这个用户用的是 zsh 之类的也需要按照类型的原理来修改.

另外, 在用户目录下 可能会存在 `~/.bash_profile`, `~/.bash_login` 这样的文件, 但如果有这些文件 bash 就不会去载入 `~/.profile` 了, 所以如果存在的话需要删除 这些文件并把内容合并进 `~/.profile` 和 `~/.bashrc` 才行.

最后还可以参考下 <https://github.com/sunteya/sot> 项目, 这个项目是我目前自己使用的的 dot 系列文件的配置. 里面的 bashrc 和 profile 都是按照上述流程修改的.