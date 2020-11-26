# htpasswd

什么是 htpasswd ?
htpasswd 是开源 http 服务器 apache httpd 的一个命令工具，用于生成 http 基本认证的密码文件。

加密方式有什么区别？
MD5:使用MD5加密密码。在Windows, Netware 和TPF上，这是默认的加密方式。

crypt:使用crypt()加密密码。在除了Windows, Netware和TPF的平台上，这是默认的。 虽然它在所有平台上可以为htpasswd所支持， 但是在Windows, Netware和TPF上不能为httpd服务器所支持。

SHA:使用SHA加密密码。 它是为了方便转入或移植到使用LDAP Directory Interchange Format (ldif)的Netscape而设计的。

plain:不加密，使用纯文本的密码。虽然在所有平台上 htpasswd 都可以建立这样的密码， 但是httpd后台只在Windows, Netware和TPF上支持纯文本的密码。

## install
``` bash
# ubuntu
apt-get install -y apache2-utils

# centos安装：

yum -y install httpd
```


## htpasswd --help 
```                                                                                     │
Usage:                                                                                               
        htpasswd [-cimBdpsDv] [-C cost] passwordfile username                                        
        htpasswd -b[cmBdpsDv] [-C cost] passwordfile username password                               
                                                                                                     
        htpasswd -n[imBdps] [-C cost] username                                                       
        htpasswd -nb[mBdps] [-C cost] username password                                              
 -c  Create a new file.                                                                              
 -n  Don't update file; display results on stdout.                                                   
 -b  Use the password from the command line rather than prompting for it.                            
 -i  Read password from stdin without verification (for script usage).                               
 -m  Force MD5 encryption of the password (default).                                                 
 -B  Force bcrypt encryption of the password (very secure).                                          
 -C  Set the computing time used for the bcrypt algorithm                                            
     (higher is more secure but slower, default: 5, valid: 4 to 31).                                 
 -d  Force CRYPT encryption of the password (8 chars max, insecure).                                 
 -s  Force SHA encryption of the password (insecure).                                                
 -p  Do not encrypt the password (plaintext, insecure).                                              
 -D  Delete the specified user.                                                                      
 -v  Verify password for the specified user.                                                         
On other systems than Windows and NetWare the '-p' flag will probably not work.                      
The SHA algorithm does not use a salt and is less secure than the MD5 algorithm.  

-c 创建passwdfile.如果passwdfile 已经存在,那么它会重新写入并删去原有内容.
-n 不更新passwordfile，只将加密后的用户名密码显示在屏幕上；
-m 默认采用MD5算法对密码进行加密
-d 采用CRYPT算法对密码进行加密
-p 不对密码进行进行加密，即使用普通文本格式的密码
-s 采用SHA算法对密码进行加密
-b 命令行中一并输入用户名和密码而不是根据提示输入密码，可以看见明文，不需要交互
-D 删除指定的用户
```

``` bash
# 新建密码文件
$ htpasswd -c boo.passwd foo
New password: ***
Re-type new password: ***
Adding password for user foo

# 追加账号和密码
htpasswd /root/.pypipasswd john


# 验证账户和密码匹配
$ htpasswd -v boo.passwd foo
Enter password: ***
Password for user foo correct.

```

``` bash
echo 123>htpasswd -c boo.passwd foo -i 
cat boo.passwd
# 直接设置密码，适合脚本使用。
```

## core

``` bash
$ htpasswd -b -c boo.passwd foo 123456
Adding password for user foo

$ cat boo.passwd

foo:$apr1$Nro/9dGI$GmSJ.IEMbg5pyA1C8uCyr.

# 在重复一次

$ htpasswd -b -c boo2.passwd foo 123456
Adding password for user foo

$ cat boo2.passwd
foo:$apr1$Nro/9dGI$GmSJ.IEMbg5pyA1C8uCyr.
```

可以发现两次生成文件的内容不一样，这是因为用了加盐hash，通过$分隔：apr1代表hash算法，Nro/9dGI代表随机加盐部分，GmSJ.IEMbg5pyA1C8uCyr是hash值。
所以每次生成的文件不一样。

**Q**: 如何验证两次的密码是同一个？
**A**: 因为随机加盐，所以不能验证。只有知道密码才能验证两次是同一个密码。

``` bash
username="something"
htpasswd -c /usr/local/apache/passwd/passwords $username
****Enter password:****

salt=$($(cat passwords | cut -d$ -f3)
password=$(openssl passwd -apr1 -salt $salt)
****Enter password:****

grep -q $username:$password passwords 
if [ $? -eq 0 ]
 then echo "password is valid"
else 
 echo "password is invalid"
fi

```