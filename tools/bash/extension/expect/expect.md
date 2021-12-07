# expect

常用的两种密码输入参数

使用重定向"<<"，或者使用管道"|"。对于ssh工具，这两者都不能生效

只能使用expect工具

``` bash
#!/usr/bin/expect
set timeout 30
spawn ssh -l username 192.168.1.1
expect "password:"
send "ispass\r"
interact
```