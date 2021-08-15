# Shadowsocks服务器运行时，有log文件么？



[https://github.com/shadowsocks/shadowsocks-libev/issues/1836](https://github.com/shadowsocks/shadowsocks-libev/issues/1836)

 Closed

[alexya](https://github.com/alexya) opened this issue on 15 Dec 2017 · 7 comments

 Closed

# [Shadowsocks服务器运行时，有log文件么？](https://github.com/shadowsocks/shadowsocks-libev/issues/1836#)#1836

[alexya](https://github.com/alexya) opened this issue on 15 Dec 2017 · 7 comments

## Comments

[![@alexya](https://avatars.githubusercontent.com/u/2831220?s=88&u=0ecc7d8720e431374b9f99db4c6e3a41872f9174&v=4)](https://github.com/alexya)



### **[alexya](https://github.com/alexya)** commented [on 15 Dec 2017](https://github.com/shadowsocks/shadowsocks-libev/issues/1836#issue-282366220)

(PS, you can remove 3 lines above, including this one, before post your issue.)What version of shadowsocks-libev are you using?3.1.1What operating system are you using?Ubuntu 14.04What did you do?使用 ss-server to 运行 shadowsocks-libv. `ss-server -s 0.0.0.0 -p 1777 -m aes-256-cfb -k barfoo! --fast-open`What did you expect to see?看了一下帮助文档，发现没有参数是设置log文件的 想知道，ss-server运行时，有没有error log能够用来帮助查看服务器无法工作时，是什么原因失败的。What did you see instead?无法工作，不清楚原因。What is your config in detail (with all sensitive info masked)?`ss-server -s 0.0.0.0 -p 1777 -m aes-256-cfb -k barfoo! --fast-open`



[![@madeye](https://avatars.githubusercontent.com/u/627917?s=60&v=4)](https://github.com/madeye) [madeye](https://github.com/madeye) added the [question](https://github.com/shadowsocks/shadowsocks-libev/labels/question) label [on 15 Dec 2017](https://github.com/shadowsocks/shadowsocks-libev/issues/1836#event-1389257844)

[![@smarxpan](https://avatars.githubusercontent.com/u/11388498?s=88&u=b866268d57c1a78cbf9d40b314f95b4a1dc04a1e&v=4)](https://github.com/smarxpan)



### **[smarxpan](https://github.com/smarxpan)** commented [on 20 Dec 2017](https://github.com/shadowsocks/shadowsocks-libev/issues/1836#issuecomment-352997702)

你运行的时候可以前面加nohup命令，这样就会输出到nohup.out文件了

[![@evenardo](https://avatars.githubusercontent.com/u/20626333?s=88&u=8041acaf7ab373fdf5d9ef34fb1c6764695ade4a&v=4)](https://github.com/evenardo)



### **[evenardo](https://github.com/evenardo)** commented [on 20 Dec 2017](https://github.com/shadowsocks/shadowsocks-libev/issues/1836#issuecomment-353017137)

According to my experience , maybe you lost a argument -l , a local port , it's be 1080 generally .-l 1080

[![@evenardo](https://avatars.githubusercontent.com/u/20626333?s=88&u=8041acaf7ab373fdf5d9ef34fb1c6764695ade4a&v=4)](https://github.com/evenardo)



### **[evenardo](https://github.com/evenardo)** commented [on 20 Dec 2017](https://github.com/shadowsocks/shadowsocks-libev/issues/1836#issuecomment-353019313)

Don't know why , happened before . set server listen ip address 0.0.0.0 worse then delete line in config.json . or must be accurate fill ip , not a broadcast address . Not to matter , it's no longer happened , when I try to write a issue . :P

[![@alexya](https://avatars.githubusercontent.com/u/2831220?s=88&u=0ecc7d8720e431374b9f99db4c6e3a41872f9174&v=4)](https://github.com/alexya)



Author

### **[alexya](https://github.com/alexya)** commented [on 21 Dec 2017](https://github.com/shadowsocks/shadowsocks-libev/issues/1836#issuecomment-353309973)

[@evenardo](https://github.com/evenardo) [@smarxpan](https://github.com/smarxpan) 你们的ss-server运行后是什么样子的？ 例如，我的ss-server运行后，我到container里面去看，这个样子的`[ss-server]`，我认为有问题，但我不知道是什么问题？`bash-4.4# ps aux | grep ss-server    5 root       0:00 [ss-server]   13 root       0:00 grep ss-server `正常应该是类似这样子的吧，例如：`bash-4.4# ps aux | grep ss-server    5 root       0:00 ss-server -s 0.0.0.0 -p 8388 -m aes-256-cfb -k barfoo! --fast-open   11 root       0:00 grep ss-server `

[![@evenardo](https://avatars.githubusercontent.com/u/20626333?s=88&u=8041acaf7ab373fdf5d9ef34fb1c6764695ade4a&v=4)](https://github.com/evenardo)



### **[evenardo](https://github.com/evenardo)** commented [on 21 Dec 2017](https://github.com/shadowsocks/shadowsocks-libev/issues/1836#issuecomment-353386097)

[@alexya](https://github.com/alexya) I'm setup with /etc/shadowsocks-libev/config.json and start with /etc/init.d/shadowsocks-libev startnobody 2443 0.0 0.5 31848 5484 ? Ss 13:45 0:02 /usr/bin/ss-server -c /etc/shadowsocks-libev/config.json -u root 5016 0.0 0.1 14628 1076 pts/0 S+ 15:47 0:00 grep --color=auto ss-server[@alexya](https://github.com/alexya) plz frome original appearance : s-server -s 0.0.0.0 -p 8388 -m aes-256-cfb -k barfoo! --fast-open to add argument ' -l 1080 ' like this s-server -s 0.0.0.0 -p 8388 -l 1080 -m aes-256-cfb -k barfoo! --fast-open



[![@madeye](https://avatars.githubusercontent.com/u/627917?s=60&v=4)](https://github.com/madeye) [madeye](https://github.com/madeye) closed this [on 26 Dec 2017](https://github.com/shadowsocks/shadowsocks-libev/issues/1836#event-1401663434)

[![@rickyzhan](https://avatars.githubusercontent.com/u/15228224?s=88&u=1220589d268de65d86a0c8ec9d14cb501cf9a61c&v=4)](https://github.com/rickyzhan)



### **[rickyzhan](https://github.com/rickyzhan)** commented [on 7 May 2019](https://github.com/shadowsocks/shadowsocks-libev/issues/1836#issuecomment-490072010)

/var/log/shadowsocks.log

👍 13

[![@just4StoringRepos](https://avatars.githubusercontent.com/u/16283511?s=88&v=4)](https://github.com/just4StoringRepos)



### **[just4StoringRepos](https://github.com/just4StoringRepos)** commented [on 13 Dec 2019](https://github.com/shadowsocks/shadowsocks-libev/issues/1836#issuecomment-565118882) • edited 

如果你是通过官方包管理器默认安装的话(也就是通过systemd的方式管理ss-libev启动项的话），可以这样： journalctl -u shadowsocks-libev.service 这会以less的浏览模式从头到尾列出所有日志，你也可以通过加其他参数加以限定，可以自行搜索看看