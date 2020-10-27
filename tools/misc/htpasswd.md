# htpasswd

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