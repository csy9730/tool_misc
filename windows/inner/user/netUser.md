# net user


## 用户管理

``` bash
# 添加账户密码
net user admin my_password /add
net user admin my_password /DELETE
net user username [/TIMES:{times | ALL}]
# 添加账户到管理员群
net localgroup Administrators admin /add


net user admin /active:yes # 激活我们新建的账号
# 禁用账户
net user admin /active:no 

net user admin "" # 将移除密码

# 限制时间
net user 用户名 /times:M-F,10:00-22:00;Sa-Su,09:00-23:00
```


C:\Users\admin\AppData\Local\Microsoft\Windows\INetCache
### usage

#### 查看用户信息

```
(base) PS C:\Users\admin> net user admin
用户名                 admin
全名
注释
用户的注释
国家/地区代码          000 (系统默认值)
帐户启用               Yes
帐户到期               从不

上次设置密码           2024/1/27 17:22:56
密码到期               2024/1/8 17:22:56
密码可更改             2024/1/27 17:22:56
需要密码               Yes
用户可以更改密码       Yes

允许的工作站           All
登录脚本
用户配置文件
主目录
上次登录               2024/1/5 23:53:30

可允许的登录小时数     All

本地组成员             *Administrators       *Performance Log Users
                       *Users
全局组成员             *None
命令成功完成。
```

- 帐户到期  ``
- 帐户启用  `net user admin /active:yes`
- 设置密码  `passwd admin`

#### help

```
(base) PS C:\Users\admin> net user /?
此命令的语法是:

NET USER
[username [password | *] [options]] [/DOMAIN]
         username {password | *} /ADD [options] [/DOMAIN]
         username [/DELETE] [/DOMAIN]
         username [/TIMES:{times | ALL}]
         username [/ACTIVE: {YES | NO}]

```
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