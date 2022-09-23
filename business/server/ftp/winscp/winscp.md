# winscp

[https://winscp.net/eng/index.php](https://winscp.net/eng/index.php)

> Free Award-Winning File Manager
> WinSCP is a popular SFTP client and FTP client for Microsoft Windows! Copy file between a local computer and remote servers using FTP, FTPS, SCP, SFTP, WebDAV or S3 file transfer protocols.


支持文件协议：
- sftp
- ftp
- webdav
- SCP
- amazon S3

### download

[https://sourceforge.net/projects/winscp/files/WinSCP/5.21.3/WinSCP-5.21.3-Portable.zip/download](https://sourceforge.net/projects/winscp/files/WinSCP/5.21.3/WinSCP-5.21.3-Portable.zip/download)



## faq

#### 密钥登录
该软件似乎不支持密钥登录？

支持密钥登陆，
1. 点击高级advance按钮，打开对话框。
2. 切换到分页
3. 输入ppk私钥文件路径

如果只有openssh私钥文件，必须转换成ppk文件WinSCP才能使用。


#### 竞品软件
其他竞品软件：

- filezilla 支持 ftp,ftps, sftp界面
- putty 支持 ssh终端 , sftp命令，scp命令
- mobaxterm 支持 ssh终端

#### WinSCP.ini

个人的帐户密码存在WinSCP.ini文件中，需要注意WinSCP.ini文件的安全。


