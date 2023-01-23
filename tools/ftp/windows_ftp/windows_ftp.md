# windows ftp 


## ftp command

"ftp"切换到到ftp下面.
然后输入"open 服务器地址".点击回车键.会提示你输入用户名和密码.登陆成功后.
输入"cd"命令.会显示"远程目录",
输入"dir"命令会显示目录下的文件,权限等相关信息.
可以通过"cd 文件名"命令进入到要下载的文件目录下.
然后输入"ls"命令 显示文件夹下的所有文件.如图

输入"lcd 本地文件目录"(就是要下载到那个文件夹下 就输入那个目录,如果不输入就是默认c盘的当前系统用户目录下)
输入"prompt"命令(打开交互模式，如果是打开的就不需要),
最后输入"mget 服务其上要下载的文件名",回车键.这样就可以进行下载了.看到"Transfer complete"就表示下载成功了.到本地路径下就能看到下载的文件了.

``` bash
# ftp localhost
连接到 DESKTOP-PGE4ABC。
220-FileZilla Server 0.9.60 beta
220-written by Tim Kosse (tim.kosse@filezilla-project.org)
220 Please visit https://filezilla-project.org/
202 UTF8 mode is always enabled. No need to send this command.
用户(DESKTOP-PGE4ABC:(none)): ftpuser
331 Password required for ftpuser
密码:
230 Logged on
ftp> cd
远程目录
cd 远程目录。
ftp> ls
200 Port command successful
150 Opening data channel for directory listing of "/"
installs
pub
226 Successfully transferred "/"
ftp: 收到 18 字节，用时 0.00秒 18.00千字节/秒。
ftp> dir
200 Port command successful
150 Opening data channel for directory listing of "/"
drwxr-xr-x 1 ftp ftp              0 May 16 21:08 installs
drwxr-xr-x 1 ftp ftp              0 May 16 11:27 pub
226 Successfully transferred "/"
ftp: 收到 116 字节，用时 0.01秒 16.57千字节/秒。
ftp> cd installs
250 CWD successful. "/installs" is current directory.
ftp> ls
200 Port command successful
150 Opening data channel for directory listing of "/installs"
crx
zip
226 Successfully transferred "/installs"
ftp: 收到 75 字节，用时 0.01秒 12.50千字节/秒。
ftp> lcd
目前的本地目录 C:\Windows.old\Users\Administrator\AppData\Local\Android\Sdk\platform-tools。
ftp> lcd H:\
目前的本地目录 H:\。
ftp> lcd tmp
目前的本地目录 H:\tmp。
ftp> prompt
交互模式 关 。
ftp> prompt
交互模式 开 。
ftp> cd zip
250 CWD successful. "/installs/zip" is current directory.
ftp> ls
200 Port command successful
150 Opening data channel for directory listing of "/installs/zip"
7z1900-x64.exe
7z1900.exe
226 Successfully transferred "/installs/zip"
ftp: 收到 31 字节，用时 0.00秒 10.33千字节/秒。
ftp> mget 7z1900.exe
200 Type set to A
mget 7z1900.exe?
200 Port command successful
150 Opening data channel for file download from server of "/installs/zip/7z1900.exe"
226 Successfully transferred "/installs/zip/7z1900.exe"
ftp: 收到 1185968 字节，用时 0.04秒 33884.80千字节/秒。
```
## help

``` bash

open server
close
cd 
ls
dir
pwd # 查看当前路径
delete
rmdir
get  # 使用get（下载多个文件用mget）路径+文件名来下载文件。
put # 上传文件
send # 上传文件
recv
rename
type

lcd



mdir
mls
mkdir
mget # 使用get（下载多个文件用mget）路径+文件名来下载文件。
mput
mdelete

bye # 断开连接
disconnect                  
quit            

prompt

!                         
literal                   
?               
debug                                      
status
append                                     
trace
ascii           

bell                                     
quote           
user
binary                                 
            
verbose
glob
hash
remotehelp
help

```

``` bash

get ./test.txt # 下载文件
mget ./test.txt ./test1.txt # 下载多个文件
```

1. 使用dir（如果是linux服务器的话应该使用ls）来查看当前ftp目录的文件，dir[remote-dir][local-file]：显示远程主机目录，并将结果存入本地文件local-file。
2. 使用cd来切换ftp系统目录。
3. 使用mkdir来新建一个目录（文件夹）。
4. 使用delete 路径+文件名来删除文件。
5. 使用mdelete remote-file批量删除远程主机文件。
5. 使用rm 路径名来删除文件夹。
6. 使用lcd设置当前用户工作路径，也就是要把资源下载到本地哪个文件夹。
7. !xx是跳出ftp模式，在命令行中执行xx命令，比如说使用lcd切换到本地另外一个文件夹之后，你想看当前文件夹下有什么文件，就可以使用!dir来实现。
8. 使用pwd命令查看当前路径。