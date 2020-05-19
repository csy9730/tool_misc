# IIS ftp



**Q**:  ftp默认是主动模式还是被动模式？如何配置端口？
**A**: 
准备个大的文件，往共享的文件夹里上传文件，再查看会话进程就可以看见了。注意文件要大，不然等还没查看到，会话就结束了。


**Q**： connection closed by remote host ？
**A**: 


iis ftp防火墙设置,让IIS的FTP服务器通过防火墙

防火墙设置-》允许应用或功能通过windows防火墙-》
1、找到FTP服务器，打勾
2、允许其它应用-》浏览-》找到C:\Windows\System32\svchost.exe，添加并打勾 然后就可以了。。。