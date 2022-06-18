# su

### 切换用户

`su user2`

### 以指定用户执行命令

`su - user2 nginx`
### This account is currently not available
linux下切换用户出现This account is currently not available
今天在一台新服务器下切换用户的时候出现“This account is currently not available”错误
上网检索了一 下发现是用户的shell禁止登录的问题

解决办法：
比如我是 `su elasticsearch`的时候出现的问题
用cat看看 apache的帐号信息
`# cat /etc/passwd | grep apache`
发现它的shell是“/sbin /nologin”，需要改成“/bin/bash”
`# vi /etc/passwd`
修改完毕后，保存退出

这样再`su elasticsearch`就可以很容易进去了
