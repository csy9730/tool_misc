# scp

scp是基于ssh服务的文件传输程序

可以实现以下功能：

1. 上传本地文件到服务器

2. 从服务器上下载文件

3. 上传目录到服务器

4. 从服务器下载整个目录

   

``` bash
scp /path/filename username@servername:/path/
scp /var/www/test.php root@192.168.0.101:/var/www/ #把本机/var/www/目录下的test.php文件上传到192.168.0.101这台服务器上的/var/www/目录中

scp username@servername:/path/filename /var/www/local_dir 
scp root@192.168.0.101:/var/www/test.txt # 把192.168.0.101上的/var/www/test.txt 的文件下载到/var/www/local_dir（本地目录）

scp -r username@servername:/var/www/remote_dir/ /var/www/local_dir
scp -r root@192.168.0.101:/var/www/test /var/www/ 

scp -r local_dir username@servername:remote_dir
scp -r test root@192.168.0.101:/var/www/ #把当前目录下的test目录上传到服务器的/var/www/ 目录
```

 

## winscp

<https://winscp.net/eng/download.php>