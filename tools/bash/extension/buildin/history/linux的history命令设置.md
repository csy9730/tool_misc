# [linux的history命令设置](https://www.cnblogs.com/shengulong/p/9034821.html)

history的历史记录，同一个用户的各个会话，读取到的内容也是不一样的，原因是它读取的是shell会话缓存里的内容。只有当用户退出当前会话的时候，会话里的缓存内容才会写入~/.bash_history里。
猜测：用户登录后，首先把~/.bash_history里的内容读入缓存，然后当前会话的命令执行记录，也写入缓存中，这样相同用户不同会话，读到的history内容是不一样的。
linux默认配置是当打开一个shell终端后，执行的所有命令均不会写入到~/.bash_history文件中，只有当前用户退出后才会写入，这期间发生的所有命令其它终端是感知不到的。

export HISTTIMEFORMAT="`whoami` : | %F | %T: | "
网管还应该在"/etc/skel/.bash_logout" 文件中添加下面这行"rm -f $HOME/.bash_history" 。这样，当用户每次注销时，“.bash_history”文件都会被删除.
$HISTSIZE 设置bash会员期间历史包含的命令数量
$HISTFILESIZE 设置历史文件中实际存储的命令数量
$HISTFILE bash启动的时候会读取~/.bash_history文件并载入到内存中，这个变量就用于设置.bash_history文件，bash退出时也会把内存中的历史回写到.bash_history文件
清空当前会话缓存里历史命令 history -c 要想彻底清空历史命令，需要先将 .bash_history的内容删除，接着使用 history -c， 这样才会彻底清空命令历史。

HISTSIZE：shell进程的缓冲区保留的历史命令的条数；
HISTFILESIZE：命令历史文件可保存的历史命令的条数；
HISTIGNORE="str1:str2:…"忽略string1,string2历史；

history -w 让bash将历史命令立即从内存写到.bash_history文件
history -a 将目前新增的 history 历史命令写入.bash_history文件

history 命令常见用法 ？
语法：

history [n | -c | -rnaw histfile]
参数：

n：数字，列出最近的 n 条历史命令
-c：将当前shell 缓存中的 history 内容全部清除
-a：将当前shell缓存中的history 内容append附加到 histfile 中，如果没有指定 histfile，则默认写入 ~/.bash_histroy；-a：将bash 内存中历史命令追加到 .bash_history 历史命令文件中， 默认只有退出 shell 是才会保存
-r：将 histfile 中的内容读取到当前shell的缓存中；-r：读取历史文件到历史列表（将 .bash_history重新读取一遍，写入到当前bash进程的内存中）
-w：将当前shell缓存的history历史列表写入到指定的文件；-w：保存历史列表到指定的历史文件（history -w /PATH/TO/SOMEFILE 将内存中命令执行的历史列表保存到指定的 /PATH/TO/SOMEFILE中）
-a: 追加本次会话新执行的命令历史列表至历史文件，因为多终端所以如果想看当前都发生了什么操作就可以执行-a进行查看
-n: 读历史文件（本地数据）中未读过的行到历史列表（内存数据）
-r: 读历史文件（本地数据）附加到历史列表（内存数据）
-w: 保存历史列表（内存数据）到指定的历史文件（本地数据）
-s: 展开历史参数成一行，附加在历史列表后。用于伪造命令历史

http://blog.51cto.com/skypegnu1/1941153　　

 

　　利用history命令，可以使每个登录会话只看到自己的命令历史记录，这样即保证安全，又方便使用。即使是同一个用户的不同会话，也要保证同一个用户的各个会话只能看到自己的历史记录。不方便的是，你每次登录进去，都是一个新的会话，就看不到任何的history记录。

![img](https://images2018.cnblogs.com/blog/692500/201805/692500-20180514102809931-1699526411.png)

![img](https://images2018.cnblogs.com/blog/692500/201805/692500-20180514103204208-1604499603.png)

 

- HISTCONTROL：如果设置为 ignorespace, 以 space 开头的行将不会插入到历史列表中。如果设置为 ignoredups, 匹配上一次历史记录的行将不会插入。设置为 ignoreboth 会结合这两种选项。如果没有定义，或者设置为其他值，所有解释器读取的行都将存入历史列表，但还要经过 HISTIGNORE 处理。这个变量的作用可以被 HISTIGNORE 替代。多行的组合命令的第二和其余行都不会被检测，不管 HISTCONTROL 是什么，都会加入到历史中。
- HISTFILE：保存命令历史的文件名 (参见下面的 HISTORY 历史章节)。默认值是 ~/.bash_history。如果取消定义，在交互式 shell 退出时命令历史将不会保存。
- HISTFILESIZE：历史文件中包含的最大行数。当为这个变量赋值时，如果需要的话，历史文件将被截断来容纳不超过这个值的行。默认值是 500。历史文件在交互式 shell 退出时也会被截断到这个值。
- HISTIGNORE：一个冒号分隔的模式列表，用来判断那个命令行应当保存在历史列表中。每个模式都定位于行首，必须匹配整行 (没有假定添加 ‘*’)。在 HISTCONTROL 指定的测试结束后，这里的每个模式都要被测试。除了平常的 shell 模式匹配字符， ‘&’ 匹配上一个历史行。‘&’ 可以使用反斜杠来转义；反斜杠在尝试匹配之前将被删除。多行的组合命令的第二行以及后续行都不会被测试，不管 HISTIGNORE 是什么，都将加入到历史中。
- HISTSIZE：命令历史中保存的历史数量 (参见下面的 HISTORY 历史章节)。默认值是 500。

　　

**实例来自https://blog.csdn.net/m0_38020436/article/details/78730631**
设置uid大于等于500的用户的history安全性
需求：
记录统一转移到/var/history目录下；
用户无法删除自己的history文件，无法清空history；
多个终端共享history，实时追加；
限制history文件大小和保存的条数；
举例用户，lionel；uid=523


```
1）配置全局环境变量文件/etc/profile
```bash
# vi /etc/profile       //添加以下内容
# add by coolnull
if [ $UID -ge 500 ];then
    readonly HISTFILE=/var/history/$USER-$UID.log
    readonly HISTFILESIZE=50000
    readonly HISTSIZE=10000
    readonly HISTTIMEFORMAT='%F %T '
    readonly HISTCONTROL=ignoredups
    shopt -s histappend                      # 这条配置，就可以使一个终端的用户监控到另一个终端用户输入的命令内容
    readonly PROMPT_COMMAND="history -a"
fi
```


``` bash
# 创建目录结构
# mkdir /var/history

# 配置目录权限，使得用户有权限创建自己的history文件
chmod 777 /var/history
chmod a+t /var/history
```

2）限制用户删除自己的history文件
`# chattr +a /var/history/lionel-522.log`

3）限制用户修改自己主目录的环境变量配置文件
`# chattr +a /home/lionel/.bash*`

`# lsattr /home/lionel/.bash*`
-----a------- /home/lionel/.bash_logout
-----a------- /home/lionel/.bash_profile
-----a------- /home/lionel/.bashrc

4）禁止普通用户切换到系统中其他shell环境（一般包括csh,tcsh,ksh）
``` bash
chmod 750 tcsh #（csh是tcsh的软连接，设置tcsh就可以了）
chmod 750 /bin/ksh
```
普通帐号测试
[zhangfei@node1 ~]$ tcsh
-bash: /bin/tcsh: Permission denied
[zhangfei@node1 ~]$ ksh
-bash: /bin/ksh: Permission denied
```

 

## Bash Shell 中的 PROMPT_COMMAND的含义：每天命令执行前，先执行Bash Shell 中的 PROMPT_COMMAND命令。

https://jaminzhang.github.io/shell/PROMPT-COMMAND-in-bash-shell/

http://blog.51cto.com/chenchao40322/411855

参考shell十三问：http://wiki.jikexueyuan.com/project/13-questions-of-shell/double-single.html

参考：

1、https://blog.csdn.net/m0_38020436/article/details/78730631

2、http://xiaqunfeng.cc/2017/01/11/Linux%E5%91%BD%E4%BB%A4%E2%80%94%E2%80%94history%E5%8F%8A%E5%85%B6%E4%BC%98%E5%8C%96/

3、https://askubuntu.com/questions/80371/bash-history-handling-with-multiple-terminals 如何保存多个终端会话的历史命令

分类: [linux安全系列](https://www.cnblogs.com/shengulong/category/942159.html)

标签: [linux的history命令](https://www.cnblogs.com/shengulong/tag/linux的history命令/)