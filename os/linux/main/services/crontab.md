# crontab

crond/crontab是一个linux下的定时执行工具。

crond 是后台服务，crontab是定时事件管理工具。

注意： redhat/centos下是 /usr/sbin/crond，debian/ubuntu下是 /usr/sbin/cron。

## crond

crond是一个linux下的定时执行工具（相当于windows下的scheduled task），可以在无需人工干预的情况下定时地运行任务task。由于crond是Linux的service（deamon），可以用以下的方法启动、关闭这个服务：

``` bash
# debian
systemctl status cron # 查看服务状态

# centos
service crond start # 启动服务
service crond stop # 关闭服务
service crond status # 查看服务状态
service crond restart # 重启服务
service crond reload # 重新载入配置
```

你也可以将这个服务在系统启动的时候自动启动：
在/etc/rc.d/rc.local这个脚本的末尾加上：`/sbin/service crond start`



~~crond位于/etc/rc.d/init.d/crond 或 /etc/init.d 或 /etc/rc.d /rc5.d/S90crond, 最总引用/var/lock/subsys/crond。~~

## crontab


crontab位于`/usr/bin/crontab`。

### help
```
crontab: invalid option -- '-'
crontab: usage error: unrecognized option
usage:  crontab [-u user] file
        crontab [ -u user ] [ -i ] { -e | -l | -r }
                (default operation is replace, per 1003.2)
        -e      (edit user's crontab)
        -l      (list user's crontab)
        -r      (delete user's crontab)
        -i      (prompt before deleting user's crontab)
```


### demo
cron服务提供crontab命令来设定cron服务的，以下是这个命令的一些参数与说明：


``` bash
crontab -u # 设定某个用户的cron服务，一般root用户在执行这个命令的时候需要此参数
crontab -l # 列出某个用户cron服务的详细内容
crontab -r # 删除某个用户的cron服务
crontab -e # 编辑某个用户的cron服务  

crontab -u root -l # 比如说root查看自己的cron设置：
crontab -u fred -r # root想删除fred的cron设置
crontab -u root -e
```
### log

crontab的日志位置一般位于`/var/log/cron`，利用下面的语句即可查看日志。

`tail -f /var/log/cron`

如果使用默认的syslog，则log文件位于 `/var/log/syslog`。


### cron content

在编辑cron服务时，编辑的内容有一些格式和约定，输入：`crontab -u root -e` 进入vi编辑模式，编辑的内容一定要符合下面的格式：

--------------------------------------

语法如下：  [参数间必须使用空格隔开]
Minute Hour Day Month Dayofweek command
分钟 小时 天 月 天每星期 命令

每个字段代表的含义及取值范围如下：
- Minute ：分钟（0-59），表示每个小时的第几分钟执行该任务
- Hour ： 小时（1-23），表示每天的第几个小时执行该任务
- Day ： 日期（1-31），表示每月的第几天执行该任务
- Month ： 月份（1-12），表示每年的第几个月执行该任务
- DayOfWeek ： 星期（0-6，0代表星期天），表示每周的第几天执行该任务
- Command ： 指定要执行的命令（如果要执行的命令太多，可以把这些命令写到一个脚本里面，然后在这里直接调用这个脚本就可以了，调用的时候记得写出命令的完整路径）

在这些字段里，除了“Command”是每次都必须指定的字段以外，其它字段皆为可选字段，可视需要决定。对于不指定的字段，要用“*”来填补其位置。同时，cron支持类似正则表达式的书写，支持如下几个特殊符号定义：
- “ * ” ，代表所有的取值范围内的数字；
- ” / “， 代表”每”（“*/5”，表示每5个单位）；
- ” – “， 代表从某个数字到某个数字（“1-4”，表示1-4个单位）；
- ” , “， 分开几个离散的数字；

- 段 含义 取值范围
- 第一段 代表分钟 0—59
- 第二段 代表小时 0—23
- 第三段 代表日期 1—31
- 第四段 代表月份 1—12
- 第五段 代表星期几，0代表星期日 0—6


这个格式的前一部分是对时间的设定，后面一部分是要执行的命令，如果要执行的命令太多，可以把这些命令写到一个脚本里面，然后在这里直接调用这个脚本就可以了，调用的时候记得写出命令的完整路径。


除了数字还有几个个特殊的符号就是"*"、"/"和"-"、","，*代表所有的取值范围内的数字，"/"代表每的意思,"*/5"表示每5个单位，"-"代表从某个数字到某个数字,","分开几个离散的数字。以下举几个例子说明问题：

``` bash
# 每分钟执行一次
* * * * * echo "run on `date`." >> /tmp/test.txt

# 注意单纯echo，从屏幕上看不到任何输出，因为cron把任何输出都email到root的信箱了。

# 每天早上6点
0 6 * * * echo "Good morning." >> /tmp/test.txt 

# 每两个小时
0 */2 * * * echo "Have a break now." >> /tmp/test.txt

# 晚上11点到早上8点之间每两个小时，早上八点
0 23-7/2，8 * * * echo "Have a good dream：）" >> /tmp/test.txt

# 每个月的4号和每个礼拜的礼拜一到礼拜三的早上11点
0 11 4 * 1-3 command line

# 1月1日早上4点
0 4 1 1 * command line

```


#### 实例

crontab文件的一些例子：
``` ini
30 21 * * * /usr/local/etc/rc.d/lighttpd restart
# 上面的例子表示每晚的21:30重启lighttpd 。

45 4 1,10,22 * * /usr/local/etc/rc.d/lighttpd restart
# 上面的例子表示每月1、10、22日的4 : 45重启lighttpd 。

10 1 * * 6,0 /usr/local/etc/rc.d/lighttpd restart
# 上面的例子表示每周六、周日的1 : 10重启lighttpd 。

0,30 18-23 * * * /usr/local/etc/rc.d/lighttpd restart
# 上面的例子表示在每天18 : 00至23 : 00之间每隔30分钟重启lighttpd 。

0 23 * * 6 /usr/local/etc/rc.d/lighttpd restart
# 上面的例子表示每星期六的11 : 00 pm重启lighttpd 。

* */1 * * * /usr/local/etc/rc.d/lighttpd restart
# 每一小时重启lighttpd

* 23-7/1 * * * /usr/local/etc/rc.d/lighttpd restart
# 晚上11点到早上7点之间，每隔一小时重启lighttpd

0 11 4 * mon-wed /usr/local/etc/rc.d/lighttpd restart
# 每月的4号与每周一到周三的11点重启lighttpd

0 4 1 jan * /usr/local/etc/rc.d/lighttpd restart
# 一月一号的4点重启lighttpd
```
 

#### 特殊用法

@hourly /usr/local/www/awstats/cgi-bin/awstats.sh
使用 @hourly 對應的是 0 * * * *, 還有下述可以使用:
string            meaning
------           -------
@reboot        Run once, at startup.
@yearly         Run once a year, "0 0 1 1 *".
@annually      (same as @yearly)
@monthly       Run once a month, "0 0 1 * *".
@weekly        Run once a week, "0 0 * * 0".
@daily           Run once a day, "0 0 * * *".
@midnight      (same as @daily)
@hourly         Run once an hour, "0 * * * *". 


#### run-parts

``` ini
01 * * * * root run-parts /etc/cron.hourly  # 每小时执行/etc/cron.hourly内的脚本
02 4 * * * root run-parts /etc/cron.daily  # 每天执行/etc/cron.daily内的脚本
22 4 * * 0 root run-parts /etc/cron.weekly  # 每星期执行/etc/cron.weekly内的脚本
42 4 1 * * root run-parts /etc/cron.monthly  # 每月去执行/etc/cron.monthly内的脚本
```

大家注意"run-parts"这个参数了，如果去掉这个参数的话，后面就可以写要运行的某个脚本名，而不是文件夹名了。

#### /var/spool/cron/crontabs/<user>

每次编辑完某个用户的cron设置后，cron自动在`/var/spool/cron`下生成一个与此用户同名的文件，此用户的cron信息都记录在这个文件中，这个文件是不可以直接编辑的，只可以用crontab -e 来编辑。cron启动后每过一份钟读一次这个文件，检查是否要执行里面的命令。因此此文件修改后不需要重新启动cron服务。


### /etc/crontab
cron的系统级配置文件位于/etc/crontab。


cron服务每分钟不仅要读一次/var/spool/cron内的所有文件，还需要读一次/etc/crontab配置文件,因此我们配置这个文件也能运用 cron服务做一些事情。用crontab -e进行的配置是针对某个用户的，而编辑/etc/crontab是针对系统的任务。此文件的文件格式是：

``` ini
# /etc/crontab: system-wide crontab
# Unlike any other crontab you don't have to run the `crontab'
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# m h dom mon dow user	command
17 *	* * *	root    cd / && run-parts --report /etc/cron.hourly
25 6	* * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
47 6	* * 7	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6	1 * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )
#

```

- MAILTO=root      //如果出现错误，或者有数据输出，数据作为邮件发给这个帐号
- HOME=/    //使用者运行的路径,这里是根目录

## 原理
Cron 是 *nix 系统中常见的有一个 daemon，用于定时执行任务。cron 的实现非常简单，以最常用的 vixie cron 为例，大概分为三步：

每分钟读取 crontab 配置计算需要执行的任务执行任务，主进程执行或者开启一个 worker 进程执行

Cron 的实现每次都是重新加载 crontab，哪怕计算出来下次可执行时间是 30 分钟之后，也不会说 sleep(30)，这样做是为了能够在每次 crontab 变更的时候及时更新。

### 弊端

cron 是没有运行记录的，并且每次都会重新加载 crontab，所以总体来说 cron 是一个无状态的服务。

这种简单的机制是非常高效且稳健的，但是考虑到一些复杂的场景也会有一些问题，包括本文标题中的问题：

- 如果某个任务在下次触发的时候，上次运行还没有结束怎么办？
    这个问题其实也就是也就是并发的任务是多少。如果定义并发为 1，也就是同一个任务只能执行一个实例，那么当任务运行时间超过间隔的时候，可能会造成延迟，但是好处是不会超过系统负载。如果定义并发为 n，那么可能会有多个实例同时运行，也有可能会超过系统负载。总之，这个行为是未定义的，完全看 cron 的实现是怎么来的。
- 当系统关机的时候有任务需要触发，开机后 cron 还会补充执行么？
    比如说，有个任务是「每天凌晨 3 点清理系统垃圾」，如果三点的时候恰好停电了，那么当系统重启之后还会执行这个任务吗？遗憾的是，因为 cron 是不记录任务执行的记录的，所以这个功能更不可实现了。要实现这个功能就需要记录上次任务执行时间，要有 job id，也就是要有执行日志。
- 如果错过了好多次执行，那么补充执行的时候需要执行多少次呢？
    这个问题是上一个问题的一个衍生。还是举清理垃圾的例子，比如说系统停机五天，那么开机后实际上不用触发五次，只需要清理一次就可以了。

Unix 上传统的 cron daemon 没有考虑以上三个问题，也就是说错过就错过了，不会再执行。为了解决这个问题，又一个辅助工具被开发出来了——anacron, ana 是 anachronistic（时间错误） 的缩写。anacron 通过文件的时间戳来追踪任务的上次运行时间。

apscheduler 是 Python 的一个库，用于周期性地触发单个任务调度，实际上我们完全可以用 apscheduler 来实现一个自己的 cron。
在现代的分布式系统中，除了定时任务之外，更重要的是不同的任务之间的执行次序和依赖关系，在后面的文章中，会介绍一下 airflow, luigi, argo 等工具的使用和实现。敬请期待。