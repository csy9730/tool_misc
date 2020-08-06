# scp

scp是基于ssh服务的文件传输程序

可以实现以下功能：

1. 上传本地文件到服务器
2. 从服务器上下载文件
3. 上传目录到服务器
4. 从服务器下载整个目录

   

``` bash
# 下载文件
scp username@servername:/path/filename /var/www/local_dir 
scp root@192.168.0.101:/var/www/test.txt 
# 把192.168.0.101上的/var/www/test.txt 的文件下载到/var/www/local_dir（本地目录）

scp -r username@servername:/var/www/remote_dir/ /var/www/local_dir
scp -r root@192.168.0.101:/var/www/test /var/www/ 
# 下载文件夹

scp /path/filename username@servername:/path/
scp /var/www/test.php root@192.168.0.101:/var/www/ 
#把本机/var/www/目录下的test.php文件上传到192.168.0.101服务器上的/var/www/目录中
scp -r local_dir username@servername:remote_dir
scp -r test root@192.168.0.101:/var/www/ 
#把当前目录下的test目录上传到服务器的/var/www/ 目录

scp -P 8022 -i /c/Users/admin/Documents/ssh/id_rsa.txt  u0_a190@192.168.1.111:/data/data/com.termux/files/home/storage/shared/Tencent/MicroMsg/Download/abc.7z .abc

```

## help
``` bash
(base) D:\projects\my_lib\tool_misc>scp --help
unknown option -- -
usage: scp [-346BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file]
           [-l limit] [-o ssh_option] [-P port] [-S program] source ... target


-v 和大多数 linux 命令中的 -v 意思一样 , 用来显示进度 . 可以用来查看连接,认证,或是配置错误
-C 使能压缩选项 .
-P 选择端口 . 注意 -p 已经被 rcp 使用 .
-p：保留原文件的修改时间，访问时间和访问权限。
-4 强行使用 IPV4 地址 .
-6 强行使用 IPV6 地址 .
-i 指定pem文件 此参数直接传递给ssh。
-r 文件夹复制
-l limit： 限定用户所能使用的带宽，以Kbit/s为单位。

```

## winscp

<https://winscp.net/eng/download.php>
## misc

不同的Linux之间copy文件常用有3种方法：
第一种就是ftp，也就是其中一台Linux安装ftp Server，这样可以另外一台使用ftp的client程序来进行文件的copy。
第二种方法就是采用samba服务，类似Windows文件copy 的方式来操作，比较简洁方便。
第三种就是利用scp命令来进行文件复制。