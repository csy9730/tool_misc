# 工具|FinalShell，必备终端利器

[![img](https://upload.jianshu.io/users/upload_avatars/3884693/37384b11-2470-4337-a425-f4a1cc8d5c27.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96)](https://www.jianshu.com/u/b6608e27dc74)

[王诗翔](https://www.jianshu.com/u/b6608e27dc74)[![  ](https://upload.jianshu.io/user_badge/b8f6544c-367e-4c1a-81f6-4a4875c556d8)](http://www.jianshu.com/p/ed7ca899d796)

0.9912018.09.19 22:00:56字数 624阅读 51,350

FinalShell，全平台支持，必备终端利器，国人开发，值得推荐。

------

[FinalShell主页](http://www.hostbuf.com/t/988.html)

## 主要特性

1.多平台支持Windows,Mac OS X,Linux
 2.多标签,批量服务器管理.
 3.支持登录Ssh和Windows远程桌面.
 4.漂亮的平滑字体显示,内置100多个配色方案.
 5.终端,sftp同屏显示,同步切换目录.
 6.命令自动提示,智能匹配,输入更快捷,方便.
 7.sftp支持,通过各种优化技术,加载更快,切换,打开目录无需等待.
 8.服务器网络,性能实时监控,无需安装服务器插件.
 9.内置海外服务器加速,加速远程桌面和ssh连接,操作流畅无卡顿.
 10.双边加速功能,大幅度提高访问服务器速度.
 11.内存,Cpu性能监控,Ping延迟丢包,Trace路由监控.
 12.实时硬盘监控.
 13.进程管理器.
 14.快捷命令面板,可同时显示数十个命令.
 15.内置文本编辑器,支持语法高亮,代码折叠,搜索,替换.
 16.ssh和远程桌面均支持代理服务器.
 17.打包传输,自动压缩解压.
 18.免费内网穿透,无需设置路由器,无需公网ip.
 19.支持rz,sz (zmodem)

界面：

![img](https://upload-images.jianshu.io/upload_images/3884693-880168e85a1daeab.png?imageMogr2/auto-orient/strip|imageView2/2/w/806)

image

## 下载与安装

### Windows版本

http://www.hostbuf.com/downloads/finalshell_install.exe

### MAC与Linux

该版本功能和windows版基本一样,但是主机检测和远程桌面功能由于兼容性问题暂时无法使用,以后会支持.

Mac版安装路径
 /Applications/finalshelldata

Linux版安装路径
 /usr/lib/finalshelldata

**注意:
 1.FinalShell运行需要java或者jdk支持,java版本至少1.8,安装后如果无法启动,运行 java -version,如果提示不存在请手动安装java,如果版本小于1.8,请更新到1.8或以上版本. java安装好之后再重新运行一键脚本.
 2.使用双边加速需要安装libpcap,才能支持tcp协议.**

JDK for Mac下载:
 http://www.cr173.com/mac/122803.html

软件更新:
 执行一键安装自动完成更新

卸载:
 删除安装目录(注意:连接配置文件夹conn也会删除,如需保留请提前备份)

Mac一键安装脚本

```undefined
curl -L -o finalshell_install.sh www.hostbuf.com/downloads/finalshell_install.sh;chmod +x finalshell_install.sh;sudo ./finalshell_install.sh
```

Linux一键安装脚本1(通用)

```undefined
rm -f finalshell_install.sh ;wget finalshell_install.sh www.hostbuf.com/downloads/finalshell_install.sh;chmod +x finalshell_install.sh;sudo ./finalshell_install.sh
```

Linux一键安装脚本2(适合系统没有sudo或未加入sudoer,比如debian)

```swift
rm -f finalshell_install.sh ;wget finalshell_install.sh www.hostbuf.com/downloads/finalshell_install.sh;chmod +x finalshell_install.sh;su -l --preserve-environment -c ./finalshell_install.sh
```

------

整理自官方主页



[上一篇](https://www.jianshu.com/p/bf8a92bd0b10)

[下一篇](https://www.jianshu.com/p/c4643cbffd07)