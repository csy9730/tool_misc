# linux关于systemctl service和chkconfig区别与使用        

[       学习     ](https://www.bilibili.com/read/technology#rid=34?from=articleDetail)2020-3-8170阅读 ·    2喜欢 ·    1评论

[             ![img](https://i0.hdslb.com/bfs/face/aa9e31c9d0804ea72cc27f3a1354764c43233c02.jpg@96w_96h_1c_1s.jpg)                              ](https://space.bilibili.com/12294474)

[         叁楛hatsun](https://space.bilibili.com/12294474)

粉丝：41文章：8

​    关注

随着各种发行版版本一路更新，很多遗留下来的老命令与各类新命令发生重复，而教材大多又都是旧命令，下面我就来记一下老命令service、chkconfig与新命令systemctl的区别与使用方法

1. service命令与systemctl

   service常用命令就是启动，停止，重启动和查看服务，这些与之相对systemctl都有对应，下面列出相对应的命令

   查询，以cups举例

   service cups status    对应    systemctl status cups

   

​          ![img](https://i0.hdslb.com/bfs/article/6aaa9cb29c241d318d42eb2e21eea6f13541cb1f.png@699w_150h_progressive.png)service

​          ![img](https://i0.hdslb.com/bfs/article/015ae9624a7508d526bc771e49afd14bd5dddc74.png@942w_245h_progressive.png)systemctl

启动

service cups start 对应 systemctl start cups

​          ![img](https://i0.hdslb.com/bfs/article/73d437f2217a21290b0f74350ddab85ba3ebf9c8.png@942w_107h_progressive.png)service

​          ![img](https://i0.hdslb.com/bfs/article/d2e8f0727c3c71387a964555ecbe557bad68ec58.png@683w_119h_progressive.png)systemctl

停止

service cups stop 对应 systemctl stop cups

​          ![img](https://i0.hdslb.com/bfs/article/a6e4c763eebfca401324a451a9c12ca5ef7e368d.png@942w_60h_progressive.png)

​          ![img](https://i0.hdslb.com/bfs/article/0788c692c3bdecb734132d0ad26f592512e6ce9f.png@942w_156h_progressive.png)

虽然报警告，但其实命令执行成功了

重新启动

service cups restart 对应 systemctl restart cups

​          ![img](https://i0.hdslb.com/bfs/article/62c737985a65e4609b8f41bf0083364e2986712d.png@942w_143h_progressive.png)

​          ![img](https://i0.hdslb.com/bfs/article/f3dc71029111cefbbfb9bded177339acb5dc492c.png@699w_90h_progressive.png)

2.chkconfig与systemctl

chkconfig常用于查看系统开机自动的服务，这些也可被systemctl代替

停止开机自启

chkconfig cups off 对应 systemctl disable cups

​          ![img](https://i0.hdslb.com/bfs/article/ab3ce6ef19e11395b63bee9f86fed2f17fe0d2f6.png@636w_93h_progressive.png)

​          ![img](https://i0.hdslb.com/bfs/article/33ca7752c7330892485b29a97082e5b20d440256.png@942w_218h_progressive.png)

启动开机自启

chkconfig cups on 对应 systemctl enable cups

​          ![img](https://i0.hdslb.com/bfs/article/766150b18b9e6ee984c5c0c33de44fca68085a97.png@639w_101h_progressive.png)

​          ![img](https://i0.hdslb.com/bfs/article/6976dfda6889d982e658a1322297cc1501f7245a.png@942w_125h_progressive.png)

查看所有开机项

chkconfig --list或直接输入chkconfig  对应systemctl list-unit-files

​          ![img](https://i0.hdslb.com/bfs/article/afad737a9277da8e318a1a8e6a152827fc92540a.png@942w_282h_progressive.png)

​          ![img](https://i0.hdslb.com/bfs/article/6f3c0f73ddf6d7f999c89d94804858c5a1d2a18c.png@873w_249h_progressive.png)

至此 老版service命令和chkconfig命令已经被新版systemctl命令所取代，下面列出小结

service cups status对应systemctl status cups

service cups start对应systemctl start cups

service cups stop对应systemctl stop cups

service cups restart对应systemctl restart cups

chkconfig cups off对应systemctl disable cups

chkconfig cups on对应systemctl enable cups

chkconfig --list或直接输入chkconfig对应systemctl list-unit-files



以上就是常用选项 若有dalao愿意补充其他选项，欢迎在评论区补充

本文为我原创

[             学习           ](https://search.bilibili.com/article?keyword=学习&from_source=article)[             笔记           ](https://search.bilibili.com/article?keyword=笔记&from_source=article)[             硬核           ](https://search.bilibili.com/article?keyword=硬核&from_source=article)[             linux           ](https://search.bilibili.com/article?keyword=linux&from_source=article)[             linux命令           ](https://search.bilibili.com/article?keyword=linux命令&from_source=article)[             linux运维           ](https://search.bilibili.com/article?keyword=linux运维&from_source=article)[             service           ](https://search.bilibili.com/article?keyword=service&from_source=article)[             systemctl           ](https://search.bilibili.com/article?keyword=systemctl&from_source=article)[             命令的新老对比           ](https://search.bilibili.com/article?keyword=命令的新老对比&from_source=article)[             chkconfig           ](https://search.bilibili.com/article?keyword=chkconfig&from_source=article)