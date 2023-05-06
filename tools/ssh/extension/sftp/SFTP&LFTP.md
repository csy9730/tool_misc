# SFTP & LFTP

实现自动sftp，避免交互式输入，有以下方法
- sftp + 脚本
- sftp + expect
- lftp


## SFTP

### script
``` bash
#!/bin/bash
data=$(date +%Y%m%d -d '-1 day')
cd /home/ICBC_HD
#  // <<EOF 不可换行
sftp -oIdentityFile=/home/docker/ftp_rsa -oPort=22 ftpuser@192.168.137.130 <<EOF
cd data
mget *$data*
exit
EOF
```

#### wanted `EOF'
here-document at line 7 delimited by end-of-file (wanted `EOF')

原因是末尾的EOF后面带有空格，EOF前后都不应有空格或其他符号。

去掉EOF两边的空格和符号后，执行通过。


### expect


## LFTP
[https://lftp.yar.ru/](https://lftp.yar.ru/)


> LFTP is a sophisticated file transfer program supporting a number of network protocols (ftp, http, sftp, fish, torrent). Like BASH, it has job control and uses the readline library for input. It has bookmarks, a built-in mirror command, and can transfer several files in parallel. It was designed with reliability in mind. LFTP is free software, distributed under the GNU GPL license.