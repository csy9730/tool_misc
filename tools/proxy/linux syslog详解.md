# [linux syslog详解](https://www.cnblogs.com/skyofbitbit/p/3674664.html)

分三部分

**一、syslog协议介绍**

 

**二、****syslog函数**

**三、****linux syslog配置**

 

**一、syslog协议介绍**

**1、介绍**

  在Unix类操作系统上，syslog广泛应用于系统日志。syslog日志消息既可以记录在本地文件中，也可以通过网络发送到接收syslog的服务器。接收syslog的服务器可以对多个设备的syslog消息进行统一的存储，或者解析其中的内容做相应的处理。常见的应用场景是网络管理工具、安全管理系统、日志审计系统。

  完整的syslog日志中包含产生日志的程序模块（Facility）、严重性（Severity或 Level）、时间、主机名或IP、进程名、进程ID和正文。在Unix类操作系统上，能够按Facility和Severity的组合来决定什么样的日志消息是否需要记录，记录到什么地方，是否需要发送到一个接收syslog的服务器等。由于syslog简单而灵活的特性，syslog不再仅限于 Unix类主机的日志记录，任何需要记录和发送日志的场景，都可能会使用syslog。

  长期以来，没有一个标准来规范syslog的格式，导致syslog的格式是非常随意的。最坏的情况下，根本就没有任何格式，导致程序不能对syslog 消息进行解析，只能将它看作是一个字符串。

在2001年定义的RFC3164中，描述了BSD syslog协议：
http://www.ietf.org/rfc/rfc3164.txt
  不过这个规范的很多内容都不是强制性的，常常是“建议”或者“约定”，也由于这个规范出的比较晚，很多设备并不遵守或不完全遵守这个规范。接下来就介绍一下这个规范。

  约定发送syslog的设备为Device，转发syslog的设备为Relay，接收syslog的设备为Collector。Relay本身也可以发送自身的syslog给Collector，这个时候它表现为一个Device。Relay也可以只转发部分接收到的syslog消息，这个时候它同时表现为Relay和Collector。

  syslog消息发送到Collector的UDP 514端口，不需要接收方应答，RFC3164建议 Device 也使用514作为源端口。规定syslog消息的UDP报文不能超过1024字节，并且全部由可打印的字符组成。完整的syslog消息由3部分组成，分别是PRI、HEADER和MSG。大部分syslog都包含PRI和MSG部分，而HEADER可能没有。

**2、syslog的格式**

  下面是一个syslog消息：
<30>Oct 9 22:33:20 hlfedora auditd[1787]: The audit daemon is exiting.
  其中“<30>”是PRI部分，“Oct 9 22:33:20 hlfedora”是HEADER部分，“auditd[1787]: The audit daemon is exiting.”是MSG部分。

**2.1、PRI部分 
**  PRI部分由尖括号包含的一个数字构成，这个数字包含了程序模块（Facility）、严重性（Severity），这个数字是由Facility乘以 8，然后加上Severity得来。不知道他们为什么发明了这么一种不直观的表示方式。
也就是说这个数字如果换成2进制的话，低位的3个bit表示Severity，剩下的高位的部分右移3位，就是表示Facility的值。
十进制30 = 二进制0001 1110
0001 1... = Facility: DAEMON - system daemons (3)
.... .110 = Severity: INFO - informational (6)

Facility的定义如下，可以看出来syslog的Facility是早期为Unix操作系统定义的，不过它预留了User（1），Local0～7 （16～23）给其他程序使用：

   Numerical       Facility
     Code

​     0       kernel messages
​     1       user-level messages
​     2       mail system
​     3       system daemons
​     4       security/authorization messages (note 1)
​     5       messages generated internally by syslogd
​     6       line printer subsystem
​     7       network news subsystem
​     8       UUCP subsystem
​     9       clock daemon (note 2)
​     10       security/authorization messages (note 1)
​     11       FTP daemon
​     12       NTP subsystem
​     13       log audit (note 1)
​     14       log alert (note 1)
​     15       clock daemon (note 2)
​     16       local use 0 (local0)
​     17       local use 1 (local1)
​     18       local use 2 (local2)
​     19       local use 3 (local3)
​     20       local use 4 (local4)
​     21       local use 5 (local5)
​     22       local use 6 (local6)
​     23       local use 7 (local7)

​    Note 1 - Various operating systems have been found to utilize
​     Facilities 4, 10, 13 and 14 for security/authorization,
​     audit, and alert messages which seem to be similar.
​    Note 2 - Various operating systems have been found to utilize
​     both Facilities 9 and 15 for clock (cron/at) messages.

Severity的定义如下：

​    Numerical     Severity
​    Code

​     0    Emergency: system is unusable
​     1    Alert: action must be taken immediately
​     2    Critical: critical conditions
​     3    Error: error conditions
​     4    Warning: warning conditions
​     5    Notice: normal but significant condition
​     6    Informational: informational messages
​     7    Debug: debug-level messages

  也就是说，尖括号中有1～3个数字字符，只有当数字是0的时候，数字才以0开头，也就是说00和01这样在前面补0是不允许的。

**2.2、HEADER部分 
**  HEADER部分包括两个字段，时间和主机名（或IP）。
  时间紧跟在PRI后面，中间没有空格，格式必须是“Mmm dd hh:mm:ss”，不包括年份。“日”的数字如果是1～9，前面会补一个空格（也就是月份后面有两个空格），而“小时”、“分”、“秒”则在前面补“0”。月份取值包括：
Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec

  时间后边跟一个空格，然后是主机名或者IP地址，主机名不得包括域名部分。

  因为有些系统需要将日志长期归档，而时间字段又不包括年份，所以一些不标准的syslog格式中包含了年份，例如：
<165>Aug 24 05:34:00 CST 1987 mymachine myproc[10]: %% It's
time to make the do-nuts. %% Ingredients: Mix=OK, Jelly=OK #
Devices: Mixer=OK, Jelly_Injector=OK, Frier=OK # Transport:
Conveyer1=OK, Conveyer2=OK # %%
  这样会导致解析程序将“CST”当作主机名，而“1987”开始的部分作为MSG部分。解析程序面对这种问题，可能要做很多容错处理，或者定制能解析多种syslog格式，而不仅仅是只能解析标准格式。

HEADER部分后面跟一个空格，然后是MSG部分。
  有些syslog中没有HEADER部分。这个时候MSG部分紧跟在PRI后面，中间没有空格。

**2.3、MSG部分 
**  MSG部分又分为两个部分，TAG和Content。其中TAG部分是可选的。
  在前面的例子中（“<30>Oct 9 22:33:20 hlfedora auditd[1787]: The audit daemon is exiting.”），“auditd[1787]”是TAG部分，包含了进程名称和进程PID。PID可以没有，这个时候中括号也是没有的。
  进程PID有时甚至不是一个数字，例如“root-1787”，解析程序要做好容错准备。

  TAG后面用一个冒号隔开Content部分，这部分的内容是应用程序自定义的。


**3、RFC3195 
**  BSD syslog协议使用UDP协议在网络中传递，然而UDP是一个不可靠的协议，并且syslog也没有要求接收方有所反馈。为了解决这个问题，RFC又定义了一个新的规范来可靠的传递syslog消息，它使用TCP协议：
http://www.ietf.org/rfc/rfc3195.txt
  不过大多数情况下，使用UDP发送不需要确认的syslog消息，已经能够满足要求了，并且这样做非常简单。因此到目前为止，RFC3195的应用还是很少见的。

 

 

**二、****syslog函数**

 

Linux C中提供一套系统日记写入接口，包括三个函数：openlog，syslog和closelog。

调用openlog是可选择的。如果不调用openlog，则在第一次调用syslog时，自动调用openlog。调用closelog也是可选择的，它只是关闭被用于与syslog守护进程通信的描述符。

 

\#include //头文件

void openlog (char*ident, int option, int facility); 

void closelog(); 

void syslog(int priority, char*format,……);

 

priority参数的格式（severity level|facility code）

示例：

LOG_ERR|LOG_USER

 

severity level：

Priority Level        Description

LOG_EMERG           An emergency situation

LOG_ALERT           High-priority problem, such as database corruption

LOG_CRIT           Critical error, such as hardware failure

LOG_ERR            Errors

LOG_WARNING          Warning

LOG_NOTICE          Special conditions requiring attention

LOG_INFO           Informational messages

LOG_DEBUG           Debug messages 

 

facility value（转自syslog.h头文件）：

 

\#define LOG_KERN     (0<<3)  

\#define LOG_USER     (1<<3)  

\#define LOG_MAIL     (2<<3)  

\#define LOG_DAEMON    (3<<3)  

\#define LOG_AUTH     (4<<3)  

\#define LOG_SYSLOG    (5<<3)  

\#define LOG_LPR     (6<<3)  

\#define LOG_NEWS     (7<<3)  

\#define LOG_UUCP     (8<<3)  

\#define LOG_CRON     (9<<3)  

\#define LOG_AUTHPRIV   (10<<3)

\#define LOG_FTP     (11<<3)

**三、****linux syslog配置**

1）、syslog日志服务：

1、守护进程：syslog

2、端口：514

3、配置文件:/etc/syslog.conf

4、常见日志文件:

/var/log/dmesg    内核引导信息日志

/var/log/message   标准系统错误信息日志

/var/log/maillog   邮件系统信息日志

/var/log/cron    计划任务日志

/var/log/secure   安全信息日志

2）、 配置文件：

syslog配置文件如下

\-----------------------------------------------------------------

[root@server ~]# vim /etc/syslog.conf

\# Log all kernel messages to the console.

\# Logging much else clutters up the screen.

\#kern.*                         /dev/console

\# Log anything (except mail) of level info or higher.

\# Don't log private authentication messages!

*.info;mail.none;authpriv.none;cron.none         /var/log/messages

\# The authpriv file has restricted access.

authpriv.*                        /var/log/secure

\# Log all the mail messages in one place.

mail.*                          -/var/log/maillog

\# Log cron stuff

cron.*                          /var/log/cron

\# Everybody gets emergency messages

*.emerg                         *

\# Save news errors of level crit and higher in a special file.

uucp,news.crit                      /var/log/spooler

\# Save boot messages also to boot.log

local7.*   

\-----------------------------------------------------------------

配置文件中每行表示一个项目，格式为：facility.level   action

由两个部分组成:

第一部分：选择条件（可以有一个或者多个条件），分为两个字段。

第二部分：操作动作；

  1、选择条件

  选择条件本身分为两个字段，之间用一个小数点（.）分隔。前一字段是一项服务，后一字段是一个优先级。选择条件是对消息类型的一种分类，这种分类便于人们把不同类型的消息发送到不同的地方。在同一个syslog配置行上允许出现一个以上的选择条件，但必须用分号（;）隔开。

  常见facility:

kern         内核信息；

user         用户进程信息；

mail         电子邮件相关信息；

daemon      后台进程相关信息；

authpriv       包括特权信息如用户名在内的认证活动；

cron         计划任务信息；

syslog      系统日志信息

lpr       打印服务相关信息。

news       新闻组服务器信息

uucp         uucp 生成的信息

local0----local7     本地用户信息

  2、重要级：

重要级是选择条件的第二个字段，它代表消息的紧急程度。

按严重程度由低到高排序：

debug    不包含函数条件或问题的其他信息

info       提供信息的消息

none     没有重要级，通常用于排错

notice    具有重要性的普通条件

warning   预警信息

err     阻止工具或某些子系统部分功能实现的错误条件

crit       阻止某些工具或子系统功能实现的错误条件

alert      需要立即被修改的条件

emerg    该系统不可用

  不同的服务类型有不同的优先级，数值较大的优先级涵盖数值较小的优先级。如果某个选择条件只给出了一个优先级而没有使用任何优先级限定符，对应于这个优先级的消息以及所有更紧急的消息类型都将包括在内。比如说，如果某个选择条件里的优先级是“warning”，它实际上将把“warning”、 “err”、“crit”、“alert”和“emerg”都包括在内。

  3、操作动作

日志信息可以分别记录到多个文件里，还可以发送到命名管道、其他程序甚至另一台机器。

syslog 主要支持以下活动：

file           指定文件的绝对路径

terminal 或 prin     完全的串行或并行设备标志符

@host（@IP地址）   远程的日志服务器

 

3）、 搭建Linux日志服务器:

1、编辑/etc/sysconfig/syslog文件,让服务器能够接受客户端传来的数据：

在“SYSLOGD_OPTIONS”行上加“-r”选项以允许接受外来日志消息。

\-----------------------------------------------------------------

[root@client ~]# vim /etc/sysconfig/syslog

\# Options to syslogd

\# -m 0 disables 'MARK' messages.

\# -r enables logging from remote machines

\# -x disables DNS lookups on messages recieved with -r

\# See syslogd(8) for more details

SYSLOGD_OPTIONS="-r -m 0"

\# Options to klogd

\# -2 prints all kernel oops messages twice; once for klogd to decode, and

\#   once for processing with 'ksymoops'

\# -x disables all klogd processing of oops messages entirely

\# See klogd(8) for more details

KLOGD_OPTIONS="-x"

\#

SYSLOG_UMASK=077

\# set this to a umask value to use for all log files as in umask(1).

\# By default, all permissions are removed for "group" and "other".

\-----------------------------------------------------------------

 2、重新启动syslog守护进程。 

\-----------------------------------------------------------------

[root@client ~]# service syslog restart

关闭内核日志记录器：                    [确定]

关闭系统日志记录器：                    [确定]

启动系统日志记录器：                    [确定]

启动内核日志记录器：                    [确定]

[root@client ~]#

\-----------------------------------------------------------------

 3、关闭iptables，也可以开启514端口。本例中我们关闭iptables。

​     四、配置各客户端：

​     1、配置/etc/syslog.conf

​     修改客户机/etc/syslog.conf文件，在有关配置行的操作动作部分用一个“@”字符指向日志服务器

\-----------------------------------------------------------------

[root@client ~]# vim /etc/syslog.conf

\# Log all kernel messages to the console.

\# Logging much else clutters up the screen.

\#kern.*                         /dev/console

*.*                           @10.64.165.210

\# The authpriv file has restricted access.

authpriv.*                        /var/log/secure

……下面省略

\-----------------------------------------------------------------

 另外如果配置了DNS域名的话可以使用域名。

​     2、重启客户端syslog使设置生效。

检测成果：

​    下图是我们在客户端重启iptables服务后在服务端看到的日志情况：

\-----------------------------------------------------------------

[root@client ~]# cat /var/log/messages |tail

Nov 30 16:44:29 10.64.165.200 kernel: klogd 1.4.1, log source = /proc/kmsg started.

Nov 30 16:44:33 10.64.165.200 kernel: Removing netfilter NETLINK layer.

Nov 30 16:44:33 10.64.165.200 kernel: ip_tables: (C) 2000-2006 Netfilter Core Team

Nov 30 16:44:33 10.64.165.200 kernel: Netfilter messages via NETLINK v0.30.

Nov 30 16:44:33 10.64.165.200 kernel: ip_conntrack version 2.4 (4096 buckets, 32768 max) - 228 bytes per conntrack

 

\-----------------------------------------------------------------

分类: [Linux IDE 编译器　makefile制作 GDB调试](https://www.cnblogs.com/skyofbitbit/category/567758.html)

[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)