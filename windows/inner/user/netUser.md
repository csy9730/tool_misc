# net user


## 用户管理

``` bash
net user admin my_password /add
net user admin my_password /DELETE
net user username [/TIMES:{times | ALL}]
net localgroup Administrators admin /add


net user admin /active:yes # 激活我们新建的账号

net user admin "" # 将移除密码

```


C:\Users\admin\AppData\Local\Microsoft\Windows\INetCache


### 密码永不过期

以下命令可以实现在命令行中设置用户属性为密码永不过期（需要安装wmic.exe环境）：
``` bash
wmic.exe UserAccount Where Name="用户名" Set PasswordExpires="false"
```
 

也可以通过注册表实现：把以下内容保存成wmic.reg，双击执行。

 
``` ini
Windows Registry Editor Version 5.00

 

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce]
"PasswordExpires"="C:\\Windows\\System32\\wbem\\WMIC.exe UserAccount Where Name='SX' Set PasswordExpires=false"
```