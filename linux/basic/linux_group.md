linux下查看所有用户及所有用户组
groups 查看当前登录用户的组内成员
groups gliethttp 查看gliethttp用户所在的组,以及组内成员
whoami 查看当前登录用户名

/etc/group文件包含所有组
/etc/shadow和/etc/passwd系统存在的所有用户名

1、/etc/group 解说；
/etc/group 文件是用户组的配置文件，内容包括用户和用户组，并且能显示出用户是归属哪个用户组或哪几个用户组，因为一个用户可以归属一个或多个不同的用户组；同一用 户组的用户之间具有相似的特征。比如我们把某一用户加入到root用户组，那么这个用户就可以浏览root用户家目录的文件，如果root用户把某个文件 的读写执行权限开放，root用户组的所有用户都可以修改此文件，如果是可执行的文件（比如脚本），root用户组的用户也是可以执行的；

用户组的特性在系统管理中为系统管理员提供了极大的方便，但安全性也是值得关注的，如某个用户下有对系统管理有最重要的内容，最好让用户拥有独立的用户组，或者是把用户下的文件的权限设置为完全私有；另外root用户组一般不要轻易把普通用户加入进去，

2、/etc/group 内容具体分析
/etc/group 的内容包括用户组（Group）、用户组口令、GID及该用户组所包含的用户（User），每个用户组一条记录；格式如下：
group_name:passwd:GID:user_list

在/etc/group 中的每条记录分四个字段：
第一字段：用户组名称；
第二字段：用户组密码；
第三字段：GID
第四字段：用户列表，每个用户之间用,号分割；本字段可以为空；如果字段为空表示用户组为GID的用户名；
============================================================================
Linux 用户（user）和用户组（group）管理概述
参考网址：http://fedora.linuxsir.org/main/?q=node/91
一、理解Linux的单用户多任务，多用户多任务概念；

Linux 是一个多用户、多任务的操作系统；我们应该了解单用户多任务和多用户多任务的概念；

1、Linux 的单用户多任务；
单用户多任务；比如我们以beinan 登录系统，进入系统后，我要打开gedit 来写文档，但在写文档的过程中，我感觉少点音乐，所以又打开xmms 来点音乐；当然听点音乐还不行，MSN 还得打开，想知道几个弟兄现在正在做什么，这样一样，我在用beinan 用户登录时，执行了gedit 、xmms以及msn等，当然还有输入法fcitx ；这样说来就有点简单了，一个beinan用户，为了完成工作，执行了几个任务；当然beinan这个用户，其它的人还能以远程登录过来，也能做其它的工作。

2、Linux 的多用户、多任务；
有时可能是很多用户同时用同一个系统，但并不所有的用户都一定都要做同一件事，所以这就有多用户多任务之说；

举个例子，比如LinuxSir.Org 服务器，上面有FTP 用户、系统管理员、web 用户、常规普通用户等，在同一时刻，可能有的弟兄正在访问论坛；有的可能在上传软件包管理子站，比如luma 或Yuking 兄在管理他们的主页系统和FTP ；在与此同时，可能还会有系统管理员在维护系统；浏览主页的用的是nobody 用户，大家都用同一个，而上传软件包用的是FTP用户；管理员的对系统的维护或查看，可能用的是普通帐号或超级权限root帐号；不同用户所具有的权限也不同，要完成不同的任务得需要不同的用户，也可以说不同的用户，可能完成的工作也不一样；

值得注意的是：多用户多任务并不是大家同时挤到一接在一台机器的的键盘和显示器前来操作机器，多用户可能通过远程登录来进行，比如对服务器的远程控制，只要有用户权限任何人都是可以上去操作或访问的；

3、用户的角色区分；
用户在系统中是分角色的，在Linux 系统中，由于角色不同，权限和所完成的任务也不同；值得注意的是用户的角色是通过UID和识别的，特别是UID；在系统管理中，系统管理员一定要坚守UID 唯一的特性；
root 用户：系统唯一，是真实的，可以登录系统，可以操作系统任何文件和命令，拥有最高权限；
虚拟用户：这类用户也被称之为伪用户或假用户，与真实用户区分开来，这类用户不具有登录系统的能力，但却是系统运行不可缺少的用户，比如bin、daemon、adm、ftp、mail等；这类用户都系统自身拥有的，而非后来添加的，当然我们也可以添加虚拟用户；
普通真实用户：这类用户能登录系统，但只能操作自己家目录的内容；权限有限；这类用户都是系统管理员自行添加的；

4、多用户操作系统的安全；
多用户系统从事实来说对系统管理更为方便。从安全角度来说，多用户管理的系统更为安全，比如beinan用户下的某个文件不想让其它用户看到，只是设置一下文件的权限，只有beinan一个用户可读可写可编辑就行了，这样一来只有beinan一个用户可以对其私有文件进行操作，Linux 在多用户下表现最佳，Linux能很好的保护每个用户的安全，但我们也得学会Linux 才是，再安全的系统，如果没有安全意识的管理员或管理技术，这样的系统也不是安全的。

从服务器角度来说，多用户的下的系统安全性也是最为重要的，我们常用的Windows 操作系统，它在系纺权限管理的能力只能说是一般般，根本没有没有办法和Linux或Unix 类系统相比；

二、用户(user）和用户组（group）概念；

1、用户（user）的概念；
通过前面对Linux 多用户的理解，我们明白Linux 是真正意义上的多用户操作系统，所以我们能在Linux系统中建若干用户（user）。比如我们的同事想用我的计算机，但我不想让他用我的用户名登录，因为我的用户名下有不想让别人看到的资料和信息（也就是隐私内容）这时我就可以给他建一个新的用户名，让他用我所开的用户名去折腾，这从计算机安全角度来说是符合操作规则的；

当然用户（user）的概念理解还不仅仅于此，在Linux系统中还有一些用户是用来完成特定任务的，比如nobody和ftp 等，我们访问LinuxSir.Org 的网页程序，就是nobody用户；我们匿名访问ftp 时，会用到用户ftp或nobody ；如果您想了解Linux系统的一些帐号，请查看 /etc/passwd ；

2、用户组（group）的概念；
用户组（group）就是具有相同特征的用户（user）的集合体；比如有时我们要让多个用户具有相同的权限，比如查看、修改某一文件或执行某个命令，这时我们需要用户组，我们把用户都定义到同一用户组，我们通过修改文件或目录的权限，让用户组具有一定的操作权限，这样用户组下的用户对该文件或目录都具有相同的权限，这是我们通过定义组和修改文件的权限来实现的；

举例：我们为了让一些用户有权限查看某一文档，比如是一个时间表，而编写时间表的人要具有读写执行的权限，我们想让一些用户知道这个时间表的内容，而不让他们修改，所以我们可以把这些用户都划到一个组，然后来修改这个文件的权限，让用户组可读，这样用户组下面的每个用户都是可读的；

用户和用户组的对应关系是：一对一、多对一、一对多或多对多；
一对一：某个用户可以是某个组的唯一成员；
多对一：多个用户可以是某个唯一的组的成员，不归属其它用户组；比如beinan和linuxsir两个用户只归属于beinan用户组；
一对多：某个用户可以是多个用户组的成员；比如beinan可以是root组成员，也可以是linuxsir用户组成员，还可以是adm用户组成员；
多对多：多个用户对应多个用户组，并且几个用户可以是归属相同的组；其实多对多的关系是前面三条的扩展；理解了上面的三条，这条也能理解；

三、用户（user）和用户组（group）相关的配置文件、命令或目录；

1、与用户（user）和用户组（group）相关的配置文件；

1）与用户（user）相关的配置文件；
/etc/passwd 注：用户（user）的配置文件；
/etc/shadow 注：用户（user）影子口令文件；

2）与用户组（group）相关的配置文件；
/etc/group 注：用户组（group）配置文件；
/etc/gshadow 注：用户组（group）的影子文件；

2、管理用户（user）和用户组（group）的相关工具或命令；

1）管理用户（user）的工具或命令；

 
useradd 注：添加用户
adduser 注：添加用户
passwd 注：为用户设置密码
usermod 注：修改用户命令，可以通过usermod 来修改登录名、用户的家目录等等；
pwcov 注：同步用户从/etc/passwd 到/etc/shadow
pwck 注：pwck是校验用户配置文件/etc/passwd 和/etc/shadow 文件内容是否合法或完整；
pwunconv 注：是pwcov 的立逆向操作，是从/etc/shadow和 /etc/passwd 创建/etc/passwd ，然后会删除 /etc/shadow 文件；
finger 注：查看用户信息工具 id 注：查看用户的UID、GID及所归属的用户组 chfn 注：更改用户信息工具
su 注：用户切换工具 sudo 注：sudo 是通过另一个用户来执行命令（execute a command as another user），su 是用来切换用户，然后通过切换到的用户来完成相应的任务，
但sudo 能后面直接执行命令，比如sudo 不需要root 密码就可以执行root 赋与的执行只有root才能执行相应的命令；但得通过visudo 来编辑/etc/sudoers来实现；
visudo 注：visodo 是编辑 /etc/sudoers 的命令；也可以不用这个命令，直接用vi 来编辑 /etc/sudoers 的效果是一样的；
sudoedit 注：和sudo 功能差不多；
 
2）管理用户组（group）的工具或命令；

groupadd 注：添加用户组；
groupdel 注：删除用户组；
groupmod 注：修改用户组信息
groups 注：显示用户所属的用户组
grpck grpconv 注：通过/etc/group和/etc/gshadow 的文件内容来同步或创建/etc/gshadow ，如果/etc/gshadow 不存在则创建；
grpunconv 注：通过/etc/group 和/etc/gshadow 文件内容来同步或创建/etc/group ，然后删除gshadow文件；
 
3、/etc/skel 目录；

/etc/skel目录一般是存放用户启动文件的目录，这个目录是由root权限控制，当我们添加用户时，这个目录下的文件自动复制到新添加的用户的家目录下；/etc/skel 目录下的文件都是隐藏文件，也就是类似.file格式的；我们可通过修改、添加、删除/etc/skel目录下的文件，来为用户提供一个统一、标准的、默认的用户环境；

[root@localhost beinan]# ls -la /etc/skel/
总用量 92
drwxr-xr-x    3 root root  4096  8月 11 23:32 .
drwxr-xr-x  115 root root 12288 10月 14 13:44 ..
-rw-r--r--    1 root root    24  5月 11 00:15 .bash_logout
-rw-r--r--    1 root root   191  5月 11 00:15 .bash_profile
-rw-r--r--    1 root root   124  5月 11 00:15 .bashrc
-rw-r--r--    1 root root  5619 2005-03-08  .canna
-rw-r--r--    1 root root   438  5月 18 15:23 .emacs
-rw-r--r--    1 root root   120  5月 23 05:18 .gtkrc
drwxr-xr-x    3 root root  4096  8月 11 23:16 .kde
-rw-r--r--    1 root root   658 2005-01-17  .zshrc

/etc/skel 目录下的文件，一般是我们用useradd 和adduser 命令添加用户（user）时，系统自动复制到新添加用户（user）的家目录下；如果我们通过修改 /etc/passwd 来添加用户时，我们可以自己创建用户的家目录，然后把/etc/skel 下的文件复制到用户的家目录下，然后要用chown 来改变新用户家目录的属主；

4、/etc/login.defs 配置文件；
/etc/login.defs 文件是当创建用户时的一些规划，比如创建用户时，是否需要家目录，UID和GID的范围；用户的期限等等，这个文件是可以通过root来定义的；

比如Fedora 的 /etc/logins.defs 文件内容；

 
# *REQUIRED* # Directory where mailboxes reside, _or_ name of file, relative to the # home directory. If you _do_ define both, MAIL_DIR takes precedence.
# QMAIL_DIR is for Qmail
# #QMAIL_DIR Maildir MAIL_DIR /var/spool/mail 注：创建用户时，要在目录/var/spool/mail中创建一个用户mail文件； #MAIL_FILE .mail
# Password aging controls: #
# PASS_MAX_DAYS Maximum number of days a password may be used.
# PASS_MIN_DAYS Minimum number of days allowed between password changes.
 # PASS_MIN_LEN Minimum acceptable password length.
# PASS_WARN_AGE Number of days warning given before a password expires.
 # PASS_MAX_DAYS 99999 注：用户的密码不过期最多的天数；
 PASS_MIN_DAYS 0 注：密码修改之间最小的天数；
PASS_MIN_LEN 5 注：密码最小长度；
PASS_WARN_AGE 7 注： #
# Min/max values for automatic uid selection in useradd
# UID_MIN 500 注：最小UID为500 ，也就是说添加用户时，UID 是从500开始的； UID_MAX 60000 注：最大UID为60000； #
 # Min/max values for automatic gid selection in groupadd # GID_MIN 500 注：GID 是从500开始； GID_MAX 60000 #
 # If defined, this command is run when removing a user.
 # It should remove any at/cron/print jobs etc. owned by
# the user to be removed (passed as the first argument). #
 #USERDEL_CMD /usr/sbin/userdel_local #
# If useradd should create home directories for users by default
 # On RH systems, we do. This option is ORed with the -m flag on
 # useradd command line
. # CREATE_HOME yes 注：是否创用户家目录，要求创建；
 
5、/etc/default/useradd 文件；
通过useradd 添加用户时的规则文件；
# useradd defaults file
GROUP=100
HOME=/home  注：把用户的家目录建在/home中；
INACTIVE=-1  注：是否启用帐号过期停权，-1表示不启用；
EXPIRE=   注：帐号终止日期，不设置表示不启用；
SHELL=/bin/bash  注：所用SHELL的类型；
SKEL=/etc/skel   注： 默认添加用户的目录默认文件存放位置；也就是说，当我们用adduser添加用户时，用户家目录下的文件，都是从这个目录中复制过去的；

后记：
关于用户（user）和用户组（group）管理内容大约就是这么多；只要把上面所说的内容了解和掌握，用户（user）和用户组（group）管理就差不多了；由于用户（user）和用户组（group）是和文件及目录权限联系在一起的，所以文件及目录权限的操作也会独立成文来给大家介绍；

本文只是让新手弟兄明白用户（user）和用户组（group）一些原理，所以我在写此文的时候，大多是解说内容，我的意思是通过解说和索引一些命令，让新手弟兄明白一点理论是比较重要的，技术操作无非是命令的用法；

=================================================================
Linux用户、用户组、文件权限学习笔记
参考网址：http://www.sourcejoy.com/other_dev_tech/linux-user-and-file-manage.html

最近打算更仔细学习一下linux操作系统。先是恶补了一下用户、用户组、文件权限这三样比较重要的知识。
学习这几样东西，得先掌握linux的权限系统相关知识。
linux的权限系统主要是由用户、用户组和权限组成。
用户就是一个个的登录并使用linux的用户。linux内部用UID表示。
用户组就是用户的分组。linux内部用GID表示。
权限分为读、写、执行三种权限。

linux的用户信息保存在/etc/passwd文件中，另外，/etc/shadow文件存放的是用户密码相关信息。

/etc/passwd文件格式：
用户名:密码:UID:GID:用户信息:HOME目录路径:用户shell
其中UID为0则是用户root，1～499为系统用户，500以上为普通用户

/etc/shadow保存用户密码信息，包括加密后的密码，密码过期时间，密码过期提示天数等。

用户组信息保存在/etc/group文件中.
格式如下：
用户组名:组密码:GID:组内帐号（多个帐号用逗号分隔）

用户登录后，/etc/passwd文件里的GID为用户的初始用户组。
用户的初始用户组这一事实不会再/etc/group中体现。

查看当前用户的用户组命令：
[root@local opt]#groups
root bin daemon sys adm disk wheel
输出的信息中，第一个用户组为当前用户的有效用户组（当前用户组）

切换有效用户组命令：
[root@local opt]#newgrp 用户组名
要离开新的有效用户组，则输入exit回车。

新建用户命令：
[root@local opt]#useradd 用户名 -g 初始用户组 -G 其他用户组（修改/etc/group） -c 用户说明 -u 指定UID

建完用户需要为用户设置密码：
[root@local opt]#passwd 用户名

用户要修改自己密码命令：
[root@local opt]#passwd

修改用户信息命令：
[root@local opt]#usermod 参数 用户名
参数:
 -c 说明
 -g 组名 初始用户组
-e 过期日期 格式：YYYY-MM-DD
 -G 组名 其他用户组
 -l 修改用户名
 -L 锁定账号（在/etc/shadow文件中用户对应密码密码串的前面加上两个叹号(!!)）
 -U 解锁

删除用户命令：
[root@local opt]#userdel [-r] 用户名
其中，参数-r为删除用户的home目录。
其实，可能在系统其他地方也有该用户文件，要完整删除一个用户和其文件要先找到属于他的文件：
[root@local opt]#find / -user 用户名
然后删除，再运行userdel删除用户。

查看可用shell命令：
[root@local opt]#chsh -l
修改自己的shell命令：
[root@local opt]#chsh -s

查看自己或某人UID/GID信息：
[root@local opt]#id [用户名]
返回信息中groups为有效用户组

新增用户组命令：
[root@local opt]#groupadd 用户组名

修改用户组名命令：
[root@local opt]#groupmod -n 名称

删除用户组命令：
[root@local opt]#groupdel 用户组名

设置用户组密码命令：
[root@local opt]#gpasswd 用户组名

如果gpasswd加上参数则有其他功能

设置用户组管理员命令：
[root@local opt]#gpasswd -A 用户名 用户组名

添加某帐号到组命令：
[root@local opt]#gpasswd -M 用户名 用户组名

从组中删除某帐号命令：
[root@local opt]#gpasswd -d 用户名 用户组名

passwd相关参数操作：
-l 锁用户
-u 解锁用户
-n 天数  密码不可改天数
-x 天数  密码过期天数
-w 天数  警告天数

 文件权限知识

先看个实例：
[root@local opt]#ls -al
ls -al 命令是列出目录的所有文件，包括隐藏文件。隐藏文件的文件名第一个字符为'.'
-rw-r--r--  1 root root    81 08-02 14:54 gtkrc-1.2-gnome2
-rw-------  1 root root   189 08-02 14:54 ICEauthority
-rw-------  1 root root    35 08-05 10:02 .lesshst
drwx------  3 root root  4096 08-02 14:54 .metacity
drwxr-xr-x  3 root root  4096 08-02 14:54 nautilus

列表的列定义如下：
[权限属性信息] [连接数] [拥有者] [拥有者所属用户组] [大小] [最后修改时间] [文件名]

权限属性列表为10个字符：
第一个字符表示文件类型，d为目录 -为普通文件 l为连接 b为可存储的接口设备 c为键盘鼠标等输入设备
2、3、4个字符表示所有者权限，5、6、7个字符表示所有者同组用户权限，8、9、10为其他用户权限
第二个字符表示所有者读权限，如果有权限则为r，没有权限则为-
第三个字符表示所有者写权限，如果有权限则为w，没有权限则为-
第四个字符表示所有者执行权限，如果有权限则为x，没有权限则为-
第五个字符表示所有者同组用户读权限，如果有权限则为r，没有权限则为-
第六个字符表示所有者同组用户写权限，如果有权限则为w，没有权限则为-
第七个字符表示所有者同组用户执行权限，如果有权限则为x，没有权限则为-
第八个字符表示其他非同组读权限，如果有权限则为r，没有权限则为-
第九个字符表示其他非同组写权限，如果有权限则为w，没有权限则为-
第十个字符表示其他非同组执行权限，如果有权限则为x，没有权限则为-

修改文件所属组命令：
[root@local opt]#chgrp [-R] 组名 文件名
其中-R为递归设置

修改文件的所有者和组命令：
[root@local opt]#chown [-R] 用户[:用户组] 文件名

修改文件访问权限命令：
[root@local opt]#chmod [-R] 0777 文件名

至此，用户、文件和权限相关的东西，就总结个7788了，接下来的就是，平常要敢于用各种命令，勤于看看本篇总结啦。
====================================================================
linux 查看用户及用户组的方法
whois
功能说明：查找并显示用户信息。
语　　法：whois [帐号名称]
补充说明：whois指令会去查找并显示指定帐号的用户相关信息，因为它是到Network Solutions 的WHOIS数据库去查找，所以该帐号名称必须在上面注册方能寻获，且名称没有大小写的差别。
---------------------------------------------------------
whoami
功能说明：先似乎用户名称。
语　　法：whoami [--help][--version]
补充说明：显示自身的用户名称，本指令相当于执行"id -un"指令。
参　　数：
--help 　在线帮助。
--version 　显示版本信息。
---------------------------------------------------
who
功能说明：显示目前登入系统的用户信息。
语　　法：who [-Himqsw][--help][--version][am i][记录文件]
补充说明：执行这项指令可得知目前有那些用户登入系统，单独执行who指令会列出登入帐号，使用的 　　　终端机，登入时间以及从何处登入或正在使用哪个X显示器。
参　　数：
-H或--heading 　显示各栏位的标题信息列。
-i或-u或--idle 　显示闲置时间，若该用户在前一分钟之内有进行任何动作，将标示成"."号，如果该用户已超过24小时没有任何动作，则标示出"old"字符串。
-m 　此参数的效果和指定"am i"字符串相同。
-q或--count 　只显示登入系统的帐号名称和总人数。
-s 　此参数将忽略不予处理，仅负责解决who指令其他版本的兼容性问题。
-w或-T或--mesg或--message或--writable 　显示用户的信息状态栏。
--help 　在线帮助。
--version 　显示版本信息。
----------------------------------------------------
w
功能说明：显示目前登入系统的用户信息。
语　　法：w [-fhlsuV][用户名称]
补充说明：执行这项指令可得知目前登入系统的用户有那些人，以及他们正在执行的程序。单独执行w
指令会显示所有的用户，您也可指定用户名称，仅显示某位用户的相关信息。
参　　数：
-f 　开启或关闭显示用户从何处登入系统。
-h 　不显示各栏位的标题信息列。
-l 　使用详细格式列表，此为预设值。
-s 　使用简洁格式列表，不显示用户登入时间，终端机阶段作业和程序所耗费的CPU时间。
-u 　忽略执行程序的名称，以及该程序耗费CPU时间的信息。
-V 　显示版本信息。
-----------------------------------------------------
finger命令
finger 命令的功能是查询用户的信息，通常会显示系统中某个用户的用户名、主目录、停滞时间、登录时间、登录shell等信息。如果要查询远程机上的用户信息，需要在用户名后面接“@主机名”，采用[用户名@主机名]的格式，不过要查询的网络主机需要运行finger守护进程。
该命令的一般格式为：
finger [选项] [使用者] [用户@主机]
命令中各选项的含义如下：
-s 显示用户的注册名、实际姓名、终端名称、写状态、停滞时间、登录时间等信息。
-l 除了用-s选项显示的信息外，还显示用户主目录、登录shell、邮件状态等信息，以及用户主目录下的.plan、.project和.forward文件的内容。
-p 除了不显示.plan文件和.project文件以外，与-l选项相同。　
[例]在本地机上使用finger命令。
$ finger xxq
Login: xxq Name:
Directory: /home/xxq Shell: /bin/bash
Last login Thu Jan 1 21:43 （CST） on tty1
No mail.
No Plan.　
$ finger
Login Name Tty Idle Login Time Office Office Phone
root root *1 28 Nov 25 09:17
……
------------------------------------------------------------------
/etc/group文件包含所有组
/etc/shadow和/etc/passwd系统存在的所有用户名
修改当前用户所属组的方法
usermod 或者可以直接修改 /etc/paaawd文件即可
----------------------------------------------------------------
vlock(virtual console lock)
功能说明：锁住虚拟终端。
语　　法：vlock [-achv]
补充说明：执行vlock指令可锁住虚拟终端，避免他人使用。
参　　数：
-a或--all 　锁住所有的终端阶段作业，如果您在全屏幕的终端中使用本参数，则会将用键盘
切换终端机的功能一并关闭。
-c或--current 　锁住目前的终端阶段作业，此为预设值。
-h或--help 　在线帮助。
-v或--version 　显示版本信息。
--------------------------------------------------------
usermod
功能说明：修改用户帐号。
语　　法：usermod [-LU][-c <备注>][-d <登入目录>][-e <有效期限>][-f <缓冲天数>][-g <群组>][-G <群组>][-l <帐号名称>][-s ][-u ][用户帐号]
补充说明：usermod可用来修改用户帐号的各项设定。
参　　数：
-c<备注> 　修改用户帐号的备注文字。
-d登入目录> 　修改用户登入时的目录。
-e<有效期限> 　修改帐号的有效期限。
-f<缓冲天数> 　修改在密码过期后多少天即关闭该帐号。
-g<群组> 　修改用户所属的群组。
-G<群组> 　修改用户所属的附加群组。
-l<帐号名称> 　修改用户帐号名称。
-L 　锁定用户密码，使密码无效。
-s 　修改用户登入后所使用的shell。
-u 　修改用户ID。
-U 　解除密码锁定。
-------------------------------------------------------
userdel
功能说明：删除用户帐号。
语　　法：userdel [-r][用户帐号]
补充说明：userdel可删除用户帐号与相关的文件。若不加参数，则仅删除用户帐号，而不删除相关文件。
参　　数：
-f 　删除用户登入目录以及目录中所有文件。
----------------------------------------------------------
userconf
功能说明：用户帐号设置程序。
语　　法：userconf [--addgroup <群组>][--adduser <用户ID><群组><用户名称>][--delgroup <群组>][--deluser <用户ID>][--help]
补充说明：userconf实际上为linuxconf的符号连接，提供图形界面的操作方式，供管理员建立与管理各类帐号。若不加任何参数，即进入图形界面。
参　　数：
--addgroup<群组> 　新增群组。
--adduser<用户ID><群组><用户名称> 　新增用户帐号。
--delgroup<群组> 　删除群组。
--deluser<用户ID> 　删除用户帐号。
--help 　显示帮助。
------------------------------------------------------
useradd
功能说明：建立用户帐号。
语　　法：useradd [-mMnr][-c <备注>][-d <登入目录>][-e <有效期限>][-f <缓冲天数>][-g <群组>][-G <群组>][-s ][-u ][用户帐号] 或 useradd -D [-b][-e <有效期限>][-f <缓冲天数>][-g <群组>][-G <群组>][-s ]
补充说明：useradd可用来建立用户帐号。帐号建好之后，再用passwd设定帐号的密码．而可用userdel删除帐号。使用useradd指令所建立的帐号，实际上是保存在/etc/passwd文本文件中。
参　　数：
-c<备注> 　加上备注文字。备注文字会保存在passwd的备注栏位中。　
-d<登入目录> 　指定用户登入时的启始目录。
-D 　变更预设值．
-e<有效期限> 　指定帐号的有效期限。
-f<缓冲天数> 　指定在密码过期后多少天即关闭该帐号。
-g<群组> 　指定用户所属的群组。
-G<群组> 　指定用户所属的附加群组。
-m 　自动建立用户的登入目录。
-M 　不要自动建立用户的登入目录。
-n 　取消建立以用户名称为名的群组．
-r 　建立系统帐号。
-s　 　指定用户登入后所使用的shell。
-u 　指定用户ID。