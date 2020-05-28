# todo


20200528

查看adb命令帮助：adb help
列出fastboot设备：fastboot devices
查看fastboot命令帮助：fastboot help

holer，shadowsocks，frp
shadowsocks
Privoxy
假设有一台 Shadowsocks 服务器，攻击者通过嗅探或其它方式抓到了这个 Shadowsocks 服务器返回的一个包。
为了知道明文内容，攻击者要么暴力破解密码（几乎不可行），要么想办法利用这台 Shadowsocks 服务器帮忙解密。
作者选择了后者，即想办法把这个包变成客户端发的包，让服务器解密后代理到自己指定的服务器，这被称为重定向攻击。

RuntimeBroker是什么进程，
RuntimeBroker.exe进程win10或者win10.1系统中才会出现的进程，是一个重要的系统核心进程，是win10或者win10.1用来进行Metro App权限管理的一个进程。该程序正常情况下位于C：\windows\system32目录下，大小一般为32.7KB

```
#!/usr/bin/expect
set timeout 30
spawn ssh -l username 192.168.1.1
expect "password:"
send "ispass\r"
interact
```

github.io 和 github.com 有什么区别？
关注问题

如果使用相同的域名，是可以在此域名下任意地“读”和“写”cookie，
这是很危险的，
比如“cookie劫持”或者“cookie注入攻击”。

以前没有http://github.io的时候，
代码仓库和pages服务都在http://github.com域名下，
而pages是可以由用户自由编写的。

只需要简单地几行js代码，
就可以通过pages进行与cookie有关的攻击，
而且由于域名相同，
这可以影响到仓库下的内容，
造成用户代码／数据的损失。

有了http://github.io之后，
pages服务则独立地运行在http://github.io域名下，
cookie有关的攻击被限制在http://github.io域名下，
这就变得安全了很多。

nginx+ gitlab/workwpress
ftp,nas,pypi,http-server

- [ ] ss: powerdns 
- [ ] ss: DDNS（Dynamic Domain Name Server，动态域名服务）是将用户的动态IP地址映射到一个固定的域名解析服务上，用户每次连接网络的时候客户端程序就会通过信息传递把该主机的动态IP地址传送给位于服务商主机上的服务器程序，服务器程序负责提供DNS服务并实现动态域名解析。
- [ ] ss: [feeder](https://feeder.co/)
- [ ] [nextcloud](https://github.com/nextcloud/news)
- [ ] gitlite
- [ ]  ss: Gitblit  下载Gitblit.下载地址：[gitblit](http://www.gitblit.com/), 系统：Windows ,JDK1.7,gitblit1.8.0(类似软件gitlab这个好像功能更多，svn)
- [ ]  adb kindle  https://www.zhihu.com/question/22210090
- [ ]  https://github.com/sitaramc/gitolite

- [ ]  ss:GitPHP
- [ ]  ss:Git-Lighttp
- [ ]  git 
- [ ]  ffmpeg
- [ ]  git-lfs/git-lfs 
- [ ]  WordPress
- [ ]  Discuz 
- [ ]  用watchdog来监视新文件，当新文件来时候，调用相应的解析脚本，进行解析入库。
- [ ]  http://irreader.fatecore.com/

Ansible
NTLM验证关系
OpenSSH + PowerShell 
Total Commande

CVS 编辑
CVS是一个C/S系统，是一个常用的代码版本控制软件。主要在开源软件管理中使用。与它相类似的代码版本控制软件有subversion。多个开发人员通过一个中心版本控制系统来记录文件版本，从而达到保证文件同步的目的。CVS版本控制系统是一种GNU软件包，主要用于在多人开发环境下的源码的维护。但是由于之前CVS编码的问题，大多数软件开发公司都使用SVN替代了CVS。


20200508
- [ ] ss: RISC-V
- [ ] QEMU 
- [ ] KVM
- [ ] openwrt
- [ ] Sencha是由Ext JS、jQTouch 以及 Raphael 三个项目合并而成的一个开源项目。 [sencha](https://www.sencha.com/)
- [ ] extjs
- [ ] netstat SYN_RECV tcp 安全
- [ ] ss: mqtt
- [ ] ss: coap 
- [ ] ss: IoT
- [ ] ss: PCB板子设计
- [ ] gitolite [gitolite](https://github.com/sitaramc/gitolite)


互联网的思路是实现万物互联

20200501
- [x] add: suikang code
- [x] add:adb
- [x] ss: adb
- [ ] ss: idb
- [ ] ss: 域名部署
- [ ] ss: 路由器
- [ ] ss: android remote
- [ ] ss: tplink
- [ ] ss: github.io

[natapp](https://natapp.cn/)

20200413
- [ ] ss: docker
- [ ] debug: frp & go
- [ ] add: openssh or startup mingw_sshd
- [ ] add: 
- [ ] ss: fabric


- [ ] windows to open ftp
- [x] windows telnet
- [ ] cali
- [x] frp
- [ ] nginx
- [ ] file sync
- [ ] vue + flask
- [x] ssh -R
- [ ] 设计常用软件，添加快捷方式和快捷bat

- [ ] ss: wsl System has not been booted with systemd as init system (PID 1). Can't operate
- [ ] ss: windows XP上实现python2.7.5和python3.4.3
- [x] everythin cmd 
- [ ] ss:auto keras
- [ ] Win10自带的Openssh怎么安装 如何启动SSH服务

ss: openstack
ss: log4qt,log4j
ss: log.level
ss 区块连

## main

* 单机
  * 快速装系统
  * 虚拟机技术，
  * 软件库管理
  * 工具链设计
  * 账户管理
* 服务器
  * ftp服务器，实现多媒体管理
  * 黑群晖
  * 与手机交互的多媒体文件中转站，接力下载
  * flask实现网站化远程管理手机
* 网络
  * 网络穿透技术
  * 科学上网
* 爬虫技术
  * 天气预报采集
  * 淘宝信息采集


### 服务器
- [x] pypi-server
- [x] http.server服务器
- [ ] ftp服务器
- [ ] ftpd服务器
- [ ] nginx
- [ ] gitlab服务器
- [ ] wordpress
- [x] ‌‌内网穿透 rdp frp
- [ ] nas 家庭服务器
- [ ] ‌minecraft服务器



### auto
- [ ] ‌qq group 信息 自动导出处理,备份，差分，处理
- [ ] 企业qq 通过pywin32捕捉企业架构，
- [ ] ‌ITchat
- [ ] 全连接方式：电话/短信/邮箱/微信/QQ/企业微信/企业qq/丁丁
‌- [ ] ‌appium

工作程序从脚本化开始
中转源，公共可用服务器
收发编辑权限的文档编辑:邮箱，短信，手机电话，微信qq
可执行权限:浏览器，termux，
协议，把文档转成可解析，交给shell执行
聊天机器人，脚本机器人。
‌串口/端口收发+数据缓存+正则抽取，数据处理，数据绘图。
采集，更新，分析，预测

### crawler
- [ ] ‌robot采集 更新漫画发送到kindle
‌- [ ] 采集RSS发送给kindle。
- [ ] 通过pyqt操作‌无头chrome
- [ ] ‌fiddle
- [ ] ‌小说采集，全站，分类书列表，单本目录，单章。
- [ ] ‌bj58，百度翻译，51小说
- [ ] ‌自动备份，禁止rm
- [ ] ‌dll注入和hook
- [ ] ‌漫画采集
- [ ] ‌bili
- [ ] ‌csdn 内容下载
- [ ] ‌知乎登录
- [ ] ‌天眼通
- [ ] ‌音乐采集，
- [ ] ‌dytt8
- [ ] ‌墨迹天气
- [ ] ‌qt ui Area toolbox +scrapy cmd line
- [ ] 图类/漫画书/动漫/文字书
ip池 

### ui
- [ ] ‌小说阅读器html
- [ ] 可视化容器 
- [ ] ‌添加可放缩编辑文本框，可收缩，类似blog
- [ ] ‌Redis
- [ ] ‌phocket sphinx 


### net
- [ ] ss: netsh
- [ ] tool: wireshark
- [ ] ‌ssr
‌私网公网边界路由承担分配ip端口池映射的重任
远程ssh。
‌vnc

## misc
聊天机器人：聊天会话，点歌/听书/广播

tool:leanote
tool:docker
abs: 模块划分
abs: 架构
tool:autojs 
tool:ios python 
‌油猴
‌ss:llvm
‌ss:awtk
‌docker
‌protobuf
‌计算棒
https://github.com/wistbean/learn_python3_spider
https://www.genymotion.com/download
‌abs: 重视filter和sorter
wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/ssr.sh && chmod +x ssr.sh && sudo bash ssr.sh
研究chrome 插件，vscode插件，pycharm，fox fire，


fix: notepad ++崩溃
Dalvikvm
context 打包相关变量(类似环境变量)，在结构间传递，像足球运动员传球一样传递变量。
不同语言，不同进程协程线程，不同场景，的概念颗粒度都有区别，


[Anti-Anti-Spider](https://github.com/luyishisi/Anti-Anti-Spider)
[captcha-dataset](https://github.com/skdjfla/captcha-dataset)
[captcha_trainer](https://github.com/kerlomz/captcha_trainer)



## windows
命令行参数传递  最大长度 windows7:8192

nuget
[nuget_cli](https://dist.nuget.org/win-x86-commandline/latest/nuget.exe)

在禁用 Device/Credential Guard 后，可以运行 VMware Workstation。有关更多详细信
1、出现此问题的原因是Device Guard或Credential Guard与Workstation不兼容。
2、Windows系统的Hyper-V不兼容导致。
bcdedit /set hypervisorlaunchtype off

ubuntu samba 安装