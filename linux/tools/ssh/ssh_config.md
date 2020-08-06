# config


## config

/etc/ssh/ssh_config 文件是ssh的配置文件
/etc/ssh/sshd_config 文件是sshd的配置文件
配置文件的大部分内容和ssh的命令行参数类似

重要配置项：
* PasswordAuthentication 是否允许使用基于密码的认证。默认为"yes"。
* PubkeyAuthentication  是否允许 Public Key 
* ListenAddress 指定 sshd(8) 监听的网络地址，默认监听所有地址。
* PasswordAuthentication 是否允许使用基于密码的认证。默认为"yes"。
* PermitRootLogin 是否允许 root 登录
* Port 指定 sshd(8) 守护进程监听的端口号，默认为 22 。
* AuthorizedKeysFile 


**Q**: 网速不好的情况下，如何避免ssh断开？

**A**:
不修改配置文件,在命令参数里ssh -o ServerAliveInterval=60 ,这样子只会在需要的连接中保持持久连接.
如果希望永久修改，可以在client端的etc/ssh/ssh_config添加以下

``` ini
ServerAliveInterval 60 ＃ client每隔60秒发送一次请求给server，然后server响应，从而保持连接
ServerAliveCountMax 3  ＃ client发出请求后，服务器端没有响应得次数达到3，就自动断开连接，正常情况下，server不会不响应
```

## config


ssh_config 内容如下
``` ini
#	$OpenBSD: ssh_config,v 1.33 2017/05/07 23:12:57 djm Exp $

# This is the ssh client system-wide configuration file.  See
# ssh_config(5) for more information.  This file provides defaults for
# users, and the values can be changed in per-user configuration files
# or on the command line.

# Configuration data is parsed as follows:
#  1. command line options
#  2. user-specific file
#  3. system-wide file
# Any configuration value is only changed the first time it is set.
# Thus, host-specific definitions should be at the beginning of the
# configuration file, and defaults at the end.

# Site-wide defaults for some commonly used options.  For a comprehensive
# list of available options, their meanings and defaults, please see the
# ssh_config(5) man page.

# Host *
#   ForwardAgent no
#   ForwardX11 no
#   PasswordAuthentication yes
#   HostbasedAuthentication no
#   GSSAPIAuthentication no
#   GSSAPIDelegateCredentials no
#   BatchMode no
#   CheckHostIP yes
#   AddressFamily any
#   ConnectTimeout 0
#   StrictHostKeyChecking ask
#   IdentityFile ~/.ssh/id_rsa
#   IdentityFile ~/.ssh/id_dsa
#   IdentityFile ~/.ssh/id_ecdsa
#   IdentityFile ~/.ssh/id_ed25519
#   Port 22
#   Protocol 2
#   Ciphers aes128-ctr,aes192-ctr,aes256-ctr,aes128-cbc,3des-cbc,aes256-cbc,aes192-cbc
#   MACs hmac-md5,hmac-sha1,umac-64@openssh.com
#   EscapeChar ~
#   Tunnel no
#   TunnelDevice any:any
#   PermitLocalCommand no
#   VisualHostKey no
#   ProxyCommand ssh -q -W %h:%p gateway.example.com
#   RekeyLimit 1G 1h
# Added by git-extra
Ciphers +aes128-cbc,3des-cbc,aes256-cbc,aes192-cbc

```

sshd_config 内容如下
``` ini
#	$OpenBSD: sshd_config,v 1.103 2018/04/09 20:41:22 tj Exp $

# This is the sshd server system-wide configuration file.  See
# sshd_config(5) for more information.

# This sshd was compiled with PATH=/bin:/usr/sbin:/sbin:/usr/bin

# The strategy used for options in the default sshd_config shipped with
# OpenSSH is to specify options with their default value where
# possible, but leave them commented.  Uncommented options override the
# default value.

#Port 22
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

#HostKey /etc/ssh/ssh_host_rsa_key
#HostKey /etc/ssh/ssh_host_ecdsa_key
#HostKey /etc/ssh/ssh_host_ed25519_key

# Ciphers and keying
#RekeyLimit default none

# Logging
#SyslogFacility AUTH
#LogLevel INFO

# Authentication:

#LoginGraceTime 2m
#PermitRootLogin prohibit-password
#StrictModes yes
#MaxAuthTries 6
#MaxSessions 10

PubkeyAuthentication yes

# The default is to check both .ssh/authorized_keys and .ssh/authorized_keys2
# but this is overridden so installations will only check .ssh/authorized_keys
AuthorizedKeysFile	.ssh/authorized_keys

#AuthorizedPrincipalsFile none

#AuthorizedKeysCommand none
#AuthorizedKeysCommandUser nobody

# For this to work you will also need host keys in /etc/ssh/ssh_known_hosts
#HostbasedAuthentication no
# Change to yes if you don't trust ~/.ssh/known_hosts for
# HostbasedAuthentication
#IgnoreUserKnownHosts no
# Don't read the user's ~/.rhosts and ~/.shosts files
#IgnoreRhosts yes

# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication yes 
#PermitEmptyPasswords no

# Change to no to disable s/key passwords
#ChallengeResponseAuthentication yes

# Kerberos options
#KerberosAuthentication no
#KerberosOrLocalPasswd yes
#KerberosTicketCleanup yes
#KerberosGetAFSToken no

# GSSAPI options
#GSSAPIAuthentication no
#GSSAPICleanupCredentials yes

# Set this to 'yes' to enable PAM authentication, account processing,
# and session processing. If this is enabled, PAM authentication will
# be allowed through the ChallengeResponseAuthentication and
# PasswordAuthentication.  Depending on your PAM configuration,
# PAM authentication via ChallengeResponseAuthentication may bypass
# the setting of "PermitRootLogin without-password".
# If you just want the PAM account and session checks to run without
# PAM authentication, then enable this but set PasswordAuthentication
# and ChallengeResponseAuthentication to 'no'.
#UsePAM no

#AllowAgentForwarding yes
#AllowTcpForwarding yes
#GatewayPorts no
#X11Forwarding no
#X11DisplayOffset 10
#X11UseLocalhost yes
#PermitTTY yes
#PrintMotd yes
#PrintLastLog yes
#TCPKeepAlive yes
#PermitUserEnvironment no
#Compression delayed
#ClientAliveInterval 0
#ClientAliveCountMax 3
#UseDNS no
#PidFile /etc/ssh/sshd.pid
#MaxStartups 10:30:100
#PermitTunnel no
#ChrootDirectory none
#VersionAddendum none

# no default banner path
#Banner none

# override default of no subsystems
Subsystem	sftp	/usr/lib/ssh/sftp-server

# Example of overriding settings on a per-user basis
#Match User anoncvs
#	X11Forwarding no
#	AllowTcpForwarding no
#	PermitTTY no
#	ForceCommand cvs server
```


## linux SSH各配置项解释
Linux下SSH各配置项解释

关于ssh 设置的相关总结（ssh最大连接数、ssh连接时长、安全性配置等)
以redhat6.3为例

ssh配置文件在：

/etc/ssh/sshd_config
可以打开查看相应配置，默认情况下只开放了几个选项，其余全部#屏蔽掉了。

英文手册参考:http://www.openbsd.org/cgi-bin/man.cgi?query=sshd_config

国内有人已经翻译了：（直接贴过来了）

sshd_config 中文手册
SSHD_CONFIG(5) OpenBSD Programmer's Manual SSHD_CONFIG(5)

名称
sshd_config - OpenSSH SSH 服务器守护进程配置文件

大纲
/etc/ssh/sshd_config

描述
sshd(8) 默认从 /etc/ssh/sshd_config 文件(或通过 -f 命令行选项指定的文件)读取配置信息。
配置文件是由"指令 值"对组成的，每行一个。空行和以'#'开头的行都将被忽略。
如果值中含有空白符或者其他特殊符号，那么可以通过在两边加上双引号(")进行界定。
[注意]值是大小写敏感的，但指令是大小写无关的。

当前所有可以使用的配置指令如下：

AcceptEnv
指定客户端发送的哪些环境变量将会被传递到会话环境中。[注意]只有SSH-2协议支持环境变量的传递。
细节可以参考 ssh_config(5) 中的 SendEnv 配置指令。
指令的值是空格分隔的变量名列表(其中可以使用'*'和'?'作为通配符)。也可以使用多个 AcceptEnv 达到同样的目的。
需要注意的是，有些环境变量可能会被用于绕过禁止用户使用的环境变量。由于这个原因，该指令应当小心使用。
默认是不传递任何环境变量。

AddressFamily
指定 sshd(8) 应当使用哪种地址族。取值范围是："any"(默认)、"inet"(仅IPv4)、"inet6"(仅IPv6)。

AllowGroups
这个指令后面跟着一串用空格分隔的组名列表(其中可以使用"*"和"?"通配符)。默认允许所有组登录。
如果使用了这个指令，那么将仅允许这些组中的成员登录，而拒绝其它所有组。
这里的"组"是指"主组"(primary group)，也就是/etc/passwd文件中指定的组。
这里只允许使用组的名字而不允许使用GID。相关的 allow/deny 指令按照下列顺序处理：
DenyUsers, AllowUsers, DenyGroups, AllowGroups

AllowTcpForwarding
是否允许TCP转发，默认值为"yes"。
禁止TCP转发并不能增强安全性，除非禁止了用户对shell的访问，因为用户可以安装他们自己的转发器。

AllowUsers
这个指令后面跟着一串用空格分隔的用户名列表(其中可以使用"*"和"?"通配符)。默认允许所有用户登录。
如果使用了这个指令，那么将仅允许这些用户登录，而拒绝其它所有用户。
如果指定了 USER@HOST 模式的用户，那么 USER 和 HOST 将同时被检查。
这里只允许使用用户的名字而不允许使用UID。相关的 allow/deny 指令按照下列顺序处理：
DenyUsers, AllowUsers, DenyGroups, AllowGroups

AuthorizedKeysFile
存放该用户可以用来登录的 RSA/DSA 公钥。
该指令中可以使用下列根据连接时的实际情况进行展开的符号：
%% 表示'%'、%h 表示用户的主目录、%u 表示该用户的用户名。
经过扩展之后的值必须要么是绝对路径，要么是相对于用户主目录的相对路径。
默认值是".ssh/authorized_keys"。

Banner
将这个指令指定的文件中的内容在用户进行认证前显示给远程用户。
这个特性仅能用于SSH-2，默认什么内容也不显示。"none"表示禁用这个特性。

ChallengeResponseAuthentication
是否允许质疑-应答(challenge-response)认证。默认值是"yes"。
所有 login.conf(5) 中允许的认证方式都被支持。

Ciphers
指定SSH-2允许使用的加密算法。多个算法之间使用逗号分隔。可以使用的算法如下：
"aes128-cbc", "aes192-cbc", "aes256-cbc", "aes128-ctr", "aes192-ctr", "aes256-ctr",
"3des-cbc", "arcfour128", "arcfour256", "arcfour", "blowfish-cbc", "cast128-cbc"
默认值是可以使用上述所有算法。

ClientAliveCountMax
sshd(8) 在未收到任何客户端回应前最多允许发送多少个"alive"消息。默认值是 3 。
到达这个上限后，sshd(8) 将强制断开连接、关闭会话。
需要注意的是，"alive"消息与 TCPKeepAlive 有很大差异。
"alive"消息是通过加密连接发送的，因此不会被欺骗；而 TCPKeepAlive 却是可以被欺骗的。
如果 ClientAliveInterval 被设为 15 并且将 ClientAliveCountMax 保持为默认值，
那么无应答的客户端大约会在45秒后被强制断开。这个指令仅可以用于SSH-2协议。

ClientAliveInterval
设置一个以秒记的时长，如果超过这么长时间没有收到客户端的任何数据，
sshd(8) 将通过安全通道向客户端发送一个"alive"消息，并等候应答。
默认值 0 表示不发送"alive"消息。这个选项仅对SSH-2有效。

Compression
是否对通信数据进行加密，还是延迟到认证成功之后再对通信数据加密。
可用值："yes", "delayed"(默认), "no"。

DenyGroups
这个指令后面跟着一串用空格分隔的组名列表(其中可以使用"*"和"?"通配符)。默认允许所有组登录。
如果使用了这个指令，那么这些组中的成员将被拒绝登录。
这里的"组"是指"主组"(primary group)，也就是/etc/passwd文件中指定的组。
这里只允许使用组的名字而不允许使用GID。相关的 allow/deny 指令按照下列顺序处理：
DenyUsers, AllowUsers, DenyGroups, AllowGroups

DenyUsers
这个指令后面跟着一串用空格分隔的用户名列表(其中可以使用"*"和"?"通配符)。默认允许所有用户登录。
如果使用了这个指令，那么这些用户将被拒绝登录。
如果指定了 USER@HOST 模式的用户，那么 USER 和 HOST 将同时被检查。
这里只允许使用用户的名字而不允许使用UID。相关的 allow/deny 指令按照下列顺序处理：
DenyUsers, AllowUsers, DenyGroups, AllowGroups

ForceCommand
强制执行这里指定的命令而忽略客户端提供的任何命令。这个命令将使用用户的登录shell执行(shell -c)。
这可以应用于 shell 、命令、子系统的完成，通常用于 Match 块中。
这个命令最初是在客户端通过 SSH_ORIGINAL_COMMAND 环境变量来支持的。

GatewayPorts
是否允许远程主机连接本地的转发端口。默认值是"no"。
sshd(8) 默认将远程端口转发绑定到loopback地址。这样将阻止其它远程主机连接到转发端口。
GatewayPorts 指令可以让 sshd 将远程端口转发绑定到非loopback地址，这样就可以允许远程主机连接了。
"no"表示仅允许本地连接，"yes"表示强制将远程端口转发绑定到统配地址(wildcard address)，
"clientspecified"表示允许客户端选择将远程端口转发绑定到哪个地址。

GSSAPIAuthentication
是否允许使用基于 GSSAPI 的用户认证。默认值为"no"。仅用于SSH-2。

GSSAPICleanupCredentials
是否在用户退出登录后自动销毁用户凭证缓存。默认值是"yes"。仅用于SSH-2。

HostbasedAuthentication
这个指令与 RhostsRSAAuthentication 类似，但是仅可以用于SSH-2。推荐使用默认值"no"。
推荐使用默认值"no"禁止这种不安全的认证方式。

HostbasedUsesNameFromPacketOnly
在开启 HostbasedAuthentication 的情况下，
指定服务器在使用 ~/.shosts ~/.rhosts /etc/hosts.equiv 进行远程主机名匹配时，是否进行反向域名查询。
"yes"表示 sshd(8) 信任客户端提供的主机名而不进行反向查询。默认值是"no"。

HostKey
主机私钥文件的位置。如果权限不对，sshd(8) 可能会拒绝启动。
SSH-1默认是 /etc/ssh/ssh_host_key 。
SSH-2默认是 /etc/ssh/ssh_host_rsa_key 和 /etc/ssh/ssh_host_dsa_key 。
一台主机可以拥有多个不同的私钥。"rsa1"仅用于SSH-1，"dsa"和"rsa"仅用于SSH-2。

IgnoreRhosts
是否在 RhostsRSAAuthentication 或 HostbasedAuthentication 过程中忽略 .rhosts 和 .shosts 文件。
不过 /etc/hosts.equiv 和 /etc/shosts.equiv 仍将被使用。推荐设为默认值"yes"。

IgnoreUserKnownHosts
是否在 RhostsRSAAuthentication 或 HostbasedAuthentication 过程中忽略用户的 ~/.ssh/known_hosts 文件。
默认值是"no"。为了提高安全性，可以设为"yes"。

KerberosAuthentication
是否要求用户为 PasswordAuthentication 提供的密码必须通过 Kerberos KDC 认证，也就是是否使用Kerberos认证。
要使用Kerberos认证，服务器需要一个可以校验 KDC identity 的 Kerberos servtab 。默认值是"no"。

KerberosGetAFSToken
如果使用了 AFS 并且该用户有一个 Kerberos 5 TGT，那么开启该指令后，
将会在访问用户的家目录前尝试获取一个 AFS token 。默认为"no"。

KerberosOrLocalPasswd
如果 Kerberos 密码认证失败，那么该密码还将要通过其它的认证机制(比如 /etc/passwd)。
默认值为"yes"。

KerberosTicketCleanup
是否在用户退出登录后自动销毁用户的 ticket 。默认值是"yes"。

KeyRegenerationInterval
在SSH-1协议下，短命的服务器密钥将以此指令设置的时间为周期(秒)，不断重新生成。
这个机制可以尽量减小密钥丢失或者黑客攻击造成的损失。
设为 0 表示永不重新生成，默认为 3600(秒)。

ListenAddress
指定 sshd(8) 监听的网络地址，默认监听所有地址。可以使用下面的格式：

ListenAddress host|IPv4_addr|IPv6_addr
ListenAddress host|IPv4_addr:port
ListenAddress [host|IPv6_addr]:port

如果未指定 port ，那么将使用 Port 指令的值。
可以使用多个 ListenAddress 指令监听多个地址。

LoginGraceTime
限制用户必须在指定的时限内认证成功，0 表示无限制。默认值是 120 秒。

LogLevel
指定 sshd(8) 的日志等级(详细程度)。可用值如下：
QUIET, FATAL, ERROR, INFO(默认), VERBOSE, DEBUG, DEBUG1, DEBUG2, DEBUG3
DEBUG 与 DEBUG1 等价；DEBUG2 和 DEBUG3 则分别指定了更详细、更罗嗦的日志输出。
比 DEBUG 更详细的日志可能会泄漏用户的敏感信息，因此反对使用。

MACs
指定允许在SSH-2中使用哪些消息摘要算法来进行数据校验。
可以使用逗号分隔的列表来指定允许使用多个算法。默认值(包含所有可以使用的算法)是：
hmac-md5,hmac-sha1,umac-64@openssh.com,hmac-ripemd160,hmac-sha1-96,hmac-md5-96

Match
引入一个条件块。块的结尾标志是另一个 Match 指令或者文件结尾。
如果 Match 行上指定的条件都满足，那么随后的指令将覆盖全局配置中的指令。
Match 的值是一个或多个"条件-模式"对。可用的"条件"是：User, Group, Host, Address 。
只有下列指令可以在 Match 块中使用：AllowTcpForwarding, Banner,
ForceCommand, GatewayPorts, GSSApiAuthentication,
KbdInteractiveAuthentication, KerberosAuthentication,
PasswordAuthentication, PermitOpen, PermitRootLogin,
RhostsRSAAuthentication, RSAAuthentication, X11DisplayOffset,
X11Forwarding, X11UseLocalHost

MaxAuthTries
指定每个连接最大允许的认证次数。默认值是 6 。
如果失败认证的次数超过这个数值的一半，连接将被强制断开，且会生成额外的失败日志消息。

MaxStartups
最大允许保持多少个未认证的连接。默认值是 10 。
到达限制后，将不再接受新连接，除非先前的连接认证成功或超出 LoginGraceTime 的限制。

PasswordAuthentication
是否允许使用基于密码的认证。默认为"yes"。

PermitEmptyPasswords
是否允许密码为空的用户远程登录。默认为"no"。

PermitOpen
指定TCP端口转发允许的目的地，可以使用空格分隔多个转发目标。默认允许所有转发请求。
合法的指令格式如下：
PermitOpen host:port
PermitOpen IPv4_addr:port
PermitOpen [IPv6_addr]:port
"any"可以用于移除所有限制并允许一切转发请求。

PermitRootLogin
是否允许 root 登录。可用值如下：
"yes"(默认) 表示允许。"no"表示禁止。
"without-password"表示禁止使用密码认证登录。
"forced-commands-only"表示只有在指定了 command 选项的情况下才允许使用公钥认证登录。
同时其它认证方法全部被禁止。这个值常用于做远程备份之类的事情。

PermitTunnel
是否允许 tun(4) 设备转发。可用值如下：
"yes", "point-to-point"(layer 3), "ethernet"(layer 2), "no"(默认)。
"yes"同时蕴含着"point-to-point"和"ethernet"。

PermitUserEnvironment
指定是否允许 sshd(8) 处理 ~/.ssh/environment 以及 ~/.ssh/authorized_keys 中的 environment= 选项。
默认值是"no"。如果设为"yes"可能会导致用户有机会使用某些机制(比如 LD_PRELOAD)绕过访问控制，造成安全漏洞。

PidFile
指定在哪个文件中存放SSH守护进程的进程号，默认为 /var/run/sshd.pid 文件。

Port
指定 sshd(8) 守护进程监听的端口号，默认为 22 。可以使用多条指令监听多个端口。
默认将在本机的所有网络接口上监听，但是可以通过 ListenAddress 指定只在某个特定的接口上监听。

PrintLastLog
指定 sshd(8) 是否在每一次交互式登录时打印最后一位用户的登录时间。默认值是"yes"。

PrintMotd
指定 sshd(8) 是否在每一次交互式登录时打印 /etc/motd 文件的内容。默认值是"yes"。

Protocol
指定 sshd(8) 支持的SSH协议的版本号。
'1'和'2'表示仅仅支持SSH-1和SSH-2协议。"2,1"表示同时支持SSH-1和SSH-2协议。

PubkeyAuthentication
是否允许公钥认证。仅可以用于SSH-2。默认值为"yes"。

RhostsRSAAuthentication
是否使用强可信主机认证(通过检查远程主机名和关联的用户名进行认证)。仅用于SSH-1。
这是通过在RSA认证成功后再检查 ~/.rhosts 或 /etc/hosts.equiv 进行认证的。
出于安全考虑，建议使用默认值"no"。

RSAAuthentication
是否允许使用纯 RSA 公钥认证。仅用于SSH-1。默认值是"yes"。

ServerKeyBits
指定临时服务器密钥的长度。仅用于SSH-1。默认值是 768(位)。最小值是 512 。

StrictModes
指定是否要求 sshd(8) 在接受连接请求前对用户主目录和相关的配置文件进行宿主和权限检查。
强烈建议使用默认值"yes"来预防可能出现的低级错误。

Subsystem
配置一个外部子系统(例如，一个文件传输守护进程)。仅用于SSH-2协议。
值是一个子系统的名字和对应的命令行(含选项和参数)。比如"sft /bin/sftp-server"。

SyslogFacility
指定 sshd(8) 将日志消息通过哪个日志子系统(facility)发送。有效值是：
DAEMON, USER, AUTH(默认), LOCAL0, LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7

TCPKeepAlive
指定系统是否向客户端发送 TCP keepalive 消息。默认值是"yes"。
这种消息可以检测到死连接、连接不当关闭、客户端崩溃等异常。
可以设为"no"关闭这个特性。

UseDNS
指定 sshd(8) 是否应该对远程主机名进行反向解析，以检查此主机名是否与其IP地址真实对应。默认值为"yes"。

UseLogin
是否在交互式会话的登录过程中使用 login(1) 。默认值是"no"。
如果开启此指令，那么 X11Forwarding 将会被禁止，因为 login(1) 不知道如何处理 xauth(1) cookies 。
需要注意的是，login(1) 是禁止用于远程执行命令的。
如果指定了 UsePrivilegeSeparation ，那么它将在认证完成后被禁用。

UsePrivilegeSeparation
是否让 sshd(8) 通过创建非特权子进程处理接入请求的方法来进行权限分离。默认值是"yes"。
认证成功后，将以该认证用户的身份创建另一个子进程。
这样做的目的是为了防止通过有缺陷的子进程提升权限，从而使系统更加安全。

X11DisplayOffset
指定 sshd(8) X11 转发的第一个可用的显示区(display)数字。默认值是 10 。
这个可以用于防止 sshd 占用了真实的 X11 服务器显示区，从而发生混淆。

X11Forwarding
是否允许进行 X11 转发。默认值是"no"，设为"yes"表示允许。
如果允许X11转发并且sshd(8)代理的显示区被配置为在含有通配符的地址(X11UseLocalhost)上监听。
那么将可能有额外的信息被泄漏。由于使用X11转发的可能带来的风险，此指令默认值为"no"。
需要注意的是，禁止X11转发并不能禁止用户转发X11通信，因为用户可以安装他们自己的转发器。
如果启用了 UseLogin ，那么X11转发将被自动禁止。

X11UseLocalhost
sshd(8) 是否应当将X11转发服务器绑定到本地loopback地址。默认值是"yes"。
sshd 默认将转发服务器绑定到本地loopback地址并将 DISPLAY 环境变量的主机名部分设为"localhost"。
这可以防止远程主机连接到 proxy display 。不过某些老旧的X11客户端不能在此配置下正常工作。
为了兼容这些老旧的X11客户端，你可以设为"no"。

XAuthLocation
指定 xauth(1) 程序的绝对路径。默认值是 /usr/X11R6/bin/xauth

时间格式
在 sshd(8) 命令行参数和配置文件中使用的时间值可以通过下面的格式指定：time[qualifier] 。
其中的 time 是一个正整数，而 qualifier 可以是下列单位之一：
<无> 秒
s | S 秒
m | M 分钟
h | H 小时
d | D 天
w | W 星期

可以通过指定多个数值来累加时间，比如：
1h30m 1 小时 30 分钟 (90 分钟)

文件
/etc/ssh/sshd_config
sshd(8) 的主配置文件。这个文件的宿主应当是root，权限最大可以是"644"。

参见
sshd(8)

作者
OpenSSH is a derivative of the original and free ssh 1.2.12 release by
Tatu Ylonen. Aaron Campbell, Bob Beck, Markus Friedl, Niels Provos, Theo
de Raadt and Dug Song removed many bugs, re-added newer features and cre-
ated OpenSSH. Markus Friedl contributed the support for SSH protocol
versions 1.5 and 2.0. Niels Provos and Markus Friedl contributed support
for privilege separation.

OpenBSD 4.2 January 1, 2008 9
Vbird网络篇里的说明：
``` bash
# 1. 关于 SSH Server 的整体设定,包含使用的 port 啦,以及使用的密码演算方式
# 先留意一下,在预设的文件内,只要是被批注的设定值(#),即为『默认值!』
Port 22
# SSH 预设使用 22 这个 port,也可以使用多个 port,即重复使用 port 这个设定项目! # 例如想要开放 sshd 在 22 与 443 ,则多加一行内容为:
# Port 443
# 这样就好了!不过,不建议修改 port number

 

rotocol 1,2
# 选择的 SSH 协议版本,可以是 1 也可以是 2 ,
# 如果要同时支持两者,就必须要使用 2,1 这个分隔了(Protocol 1,2)! # 目前我们会建议您,直接使用 Protocol 2 即可!

 

#ListenAddress 0.0.0.0
# 监听的主机适配卡!举个例子来说,如果您有两个 IP,

# 分别是 192.168.0.100 及 192.168.2.20 ,那么只想要

# 开放 192.168.0.100 时,就可以写如同下面的样式:

ListenAddress 192.168.0.100
# 只监听来自 192.168.0.100 这个 IP 的 SSH 联机。
# 如果不使用设定的话,则预设所有接口均接受 SSH

 

#PidFile /var/run/sshd.pid
# 可以放置 SSHD 这个 PID 的文件!左列为默认值

 

LoginGraceTime 2m
# 当使用者连上 SSH server 之后,会出现输入密码的画面,在该画面中,
# 在多久时间内没有成功连上 SSH server ,就断线!若无单位则预设时间为秒!

 

Compression yes
# 是否可以使用压缩指令?当然可以

 

# 2. 说明主机的 Private Key 放置的档案,预设使用下面的档案即可!

HostKey /etc/ssh/ssh_host_key # SSH version 1 使用的私钥
HostKey /etc/ssh/ssh_host_rsa_key # SSH version 2 使用的 RSA 私钥
HostKey /etc/ssh/ssh_host_dsa_key # SSH version 2 使用的 DSA 私钥
# 还记得我们在主机的 SSH 联机流程里面谈到的,这里就是 Host Key

 

# 2.1 关于 version 1 的一些设定!
KeyRegenerationInterval 1h
# 由前面联机的说明可以知道, version 1 会使用 server 的 Public Key ,

# 那么如果这个 Public Key 被偷的话,岂不完蛋?所以需要每隔一段时间
# 来重新建立一次!这里的时间为秒!不过我们通常都仅使用 version 2 ,
# 所以这个设定可以被忽略喔!

 

ServerKeyBits 768
# 没错!这个就是 Server key 的长度!用默认值即可。

 

# 3. 关于登录文件的讯息数据放置与 daemon 的名称!
SyslogFacility AUTHPRIV
# 当有人使用 SSH 登入系统的时候,SSH 会记录信息,这个信息要记录在什么 daemon name

# 底下?预设是以 AUTH 来设定的,即是 /var/log/secure 里面!
# 其它可用的 daemon name 为:DAEMON,USER,AUTH,LOCAL0,LOCAL1,LOCAL2,LOCAL3,LOCAL4,LOCAL5,

 

LogLevel INFO
# 登录记录的等级!注意登机信息可参照vbird基础篇详解。

 

# 4. 安全设定项目!极重要!
# 4.1 登入设定部分
PermitRootLogin no
# 是否允许 root 登入!预设是允许的,但是建议设定成 no!

UserLogin no
# 在 SSH 底下本来就不接受 login 这个程序的登入!

StrictModes yes
# 当使用者的 host key 改变之后,Server 就不接受联机,可以抵挡部分的木马程序!

RSAAuthentication yes

# 是否使用纯的 RSA 认证!?仅针对 version 1 !

PubkeyAuthentication yes

# 是否允许 Public Key ?当然允许啦!仅针对 version 2

AuthorizedKeysFile .ssh/authorized_keys
# 上面这个在设定若要使用不需要密码登入的账号时,那么那个账号的存放密码所在文件名!

# 这个设定值很重要喔!文件名记一下!

# 4.2 认证部分
RhostsAuthentication no
# 本机系统不使用 .rhosts,因为仅使用 .rhosts 太不安全了,所以这里一定要设定为 no

IgnoreRhosts yes
# 是否取消使用 ~/.ssh/.rhosts 来做为认证!当然是!

RhostsRSAAuthentication no
# 这个选项是专门给 version 1 用的,使用 rhosts 文件在 /etc/hosts.equiv

# 配合 RSA 演算方式来进行认证!不要使用啊!

HostbasedAuthentication no
# 这个项目与上面的项目类似,不过是给 version 2 使用的!

IgnoreUserKnownHosts no
# 是否忽略家目录内的 ~/.ssh/known_hosts 这个文件所记录的主机内容?

# 当然不要忽略,所以这里就是 no 啦!

PasswordAuthentication yes
# 密码验证当然是需要的!所以这里写 yes 啰!

PermitEmptyPasswords no
# 若上面那一项如果设定为 yes 的话,这一项就最好设定为 no

# 这个项目在是否允许以空的密码登入!当然不许!

ChallengeResponseAuthentication no
# 允许任何的密码认证!所以,任何 login.conf 规定的认证方式,均可适用!
# 但目前我们比较喜欢使用 PAM 模块帮忙管理认证,因此这个选项可以设定为 no 喔! UsePAM yes
# 利用 PAM 管理使用者认证有很多好处,可以记录与管理。
# 所以这里我们建议您使用 UsePAM 且 ChallengeResponseAuthentication 设定为 no

# 4.3 与 Kerberos 有关的参数设定!因为我们没有 Kerberos 主机,所以底下不用设定!

#KerberosAuthentication no
#KerberosOrLocalPasswd yes
#KerberosTicketCleanup yes

#KerberosTgtPassing no# 4.4 底下是有关在 X-Window 底下使用的相关设定!

X11Forwarding yes
#X11DisplayOffset 10
#X11UseLocalhost yes

# 4.5 登入后的项目:
PrintMotd no
# 登入后是否显示出一些信息呢?例如上次登入的时间、地点等等,预设是 yes
# 亦即是打印出 /etc/motd 这个档案的内容。但是,如果为了安全,可以考虑改为 no !

PrintLastLog yes
# 显示上次登入的信息!可以啊!预设也是 yes !

KeepAlive yes
# 一般而言,如果设定这项目的话,那么 SSH Server 会传送 KeepAlive 的讯息给
# Client 端,以确保两者的联机正常!在这个情况下,任何一端死掉后,SSH 可以立刻知道!而不会有僵尸程序的发生!

UsePrivilegeSeparation yes
# 使用者的权限设定项目!就设定为 yes 吧!

MaxStartups 10
# 同时允许几个尚未登入的联机画面?当我们连上 SSH ,但是尚未输入密码时,
# 这个时候就是我们所谓的联机画面啦!在这个联机画面中,为了保护主机,
# 所以需要设定最大值,预设最多十个联机画面,而已经建立联机的不计算在这十个当中

# 4.6 关于使用者抵挡的设定项目:
DenyUsers *
# 设定受抵挡的使用者名称,如果是全部的使用者,那就是全部挡吧!

# 若是部分使用者,可以将该账号填入!例如下列!
DenyUsers test

DenyGroups test
# 与 DenyUsers 相同!仅抵挡几个群组而已!

# 5. 关于 SFTP 服务的设定项目!

Subsystem sftp /usr/lib/ssh/sftp-server