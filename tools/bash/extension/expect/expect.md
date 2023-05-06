# expect

常用的两种密码输入参数

使用重定向"<<"，或者使用管道"|"。对于ssh工具，这两者都不能生效

### 管道"|"
比如如下命令，需要我们交互式输入一个y，才能执行
```
[root@192_168_31_102 ~]# docker container prune
WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N] N
Total reclaimed space: 0B
```
我们利用管道，直接非交互式执行
```
[root@192_168_31_102 ~]# echo y | docker container prune
```

## expect
只能使用expect工具

使用场景: ssh，scp，ftp，sftp，telnet
### demo

#### ssh login
``` bash
#!/usr/bin/expect
set timeout 30
spawn ssh -l username 192.168.1.1
expect "password:"
send "ispass\r"
interact
```

#### telnet

```
spawn telnet aixserver
expect "login:"
send "mynamer"
expect "Password:"
send "mypassr"
send "lsr"
send "prtconfr"
expect eof
```
#### ssh

保存成 ssh_foo.txt
```
spawn ssh foo@ali -p 17122
expect "*yes/no/*"
send "yes\n"
expect "*password*"
send "password\r"
send uname
expect eof
```

`expect ssh_foo.txt`
#### sftp
