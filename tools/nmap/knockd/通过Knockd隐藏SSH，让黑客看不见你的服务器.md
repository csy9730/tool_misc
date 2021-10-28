# 通过Knockd隐藏SSH，让黑客看不见你的服务器

[![Ms08067实验室](https://pic2.zhimg.com/v2-ea89d753c7058fab69b8d103fd1be7d0_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/ms08067)

[Ms08067实验室](https://www.zhihu.com/people/ms08067)

专注于网络安全技术的普及与教育！

关注他

**出品｜MS08067实验室（[http://www.ms08067.com](https://link.zhihu.com/?target=http%3A//www.ms08067.com)）**

> 本文作者：大方子（Ms08067实验室核心成员）



**0X01设备信息**

Ubuntu14.04：192.168.61.135

Kali：192.168.61.130



**0X02配置过程**

先用Kali探测下Ubuntu的端口情况，可以看到Ubuntu的22端口是正常开放的

![img](https://pic4.zhimg.com/80/v2-e0c0385b07ea180e978d4b5317108257_1440w.jpg)

接下来在Ubuntu上安装Knockd

``` bash
apt-get install update
apt-get install build-essential -y
apt-get install knockd -y
```

安装完成后就cat下Knockd的配置/etc/knockd.conf

![img](https://pic3.zhimg.com/80/v2-c1aa6f601f57e333b6bf7485a657c536_1440w.jpg)

配置解释：

``` ini
[options]
UseSyslog # 用来定义日志输出位置以及文件名

[openSSH]
sequence = 7000,8000,9000 # 设置（开门）敲门顺序，可以自定义
seq_timeout = 5 # 设置超时时间
command = /sbin/iptables ‐A INPUT ‐s %IP% ‐p tcp ‐‐dport 22 ‐j ACCEPT # 开门成功后添加防火墙规则命令（打开SSH端口）
tcpflags = syn

[closeSSH]
sequence = 9000,8000,7000 # 设置（关门）敲门顺序，与开门顺序相反
seq_timeout = 5 # 设置超时时间
command = /sbin/iptables ‐D INPUT ‐s %IP% ‐p tcp ‐‐dport 22 ‐j ACCEPT # 关门成功后删除之前添加的防火墙规则（关闭SSH端口）
tcpflags = syn
```

接下来对/etc/knockd.conf进行配置

``` ini
[options]
#UseSyslog
LogFile = /knock.log #配置日志路径

[openSSH]
sequence = 7000,8000,9000
seq_timeout = 5
command = /sbin/iptables ‐I INPUT ‐s 192.168.61.130 ‐p tcp ‐‐dport 22 ‐j ACCEPT # 这里把A改成I,让knockd插入的规则能够优先生效
tcpflags = syn

[closeSSH]
sequence = 9000,8000,7000
seq_timeout = 5
command = /sbin/iptables ‐D INPUT ‐s 192.168.61.130 ‐p tcp ‐‐dport 22 ‐j ACCEPT
tcpflags = syn
```

配置/etc/default/knockd，修改START_KNOCKD=1

![img](https://pic2.zhimg.com/80/v2-c5eff54e5ba2b378120a634c2c070381_1440w.jpg)

然后重启下knockd服务

`service knock restart`

![img](https://pic3.zhimg.com/80/v2-e59ad74f3e241f5dffbdc4296a3df652_1440w.png)

然后我们在Ubuntu的防火墙上添加几条规则

``` bash
iptables ‐A INPUT ‐s 192.168.61.1 ‐j ACCEPT //允许宿主机连接，方便实验的时候可以用SSH进行连接
iptables ‐A INPUT ‐s 127.0.0.0/8 ‐j ACCEPT //允许本机的连接
iptables ‐A INPUT ‐j DROP //拒绝其他所有IP的连接
```

![img](https://pic1.zhimg.com/80/v2-8d9ee185d3417e4c53ea216fd9167308_1440w.jpg)

我们在Kali上用nmap对Ubuntu的22端进行探测，可以看到22端口的状态是被过滤了

``` bash
nmap ‐sC ‐Pn ‐sV ‐p 22 ‐A 192.168.61.135
```

![img](https://pic1.zhimg.com/80/v2-139c83335012765ae8d5b3acf2c57b10_1440w.jpg)

接下来我们用nmap进行敲门

``` bash
for x in 7000 8000 9000;do nmap ‐Pn ‐‐max‐retries 0 ‐p $x 192.168.61.135;done
```

![img](https://pic3.zhimg.com/80/v2-8837a8e2d8f11e8c3dae076cea5fd4a2_1440w.jpg)

我们再次查看Ubuntu上的防火墙规则，添加了一条关于192.168.61.130的规则

![img](https://pic4.zhimg.com/80/v2-a6678940b4ace61b8234c24a02eadf6f_1440w.jpg)

我们再次用Kali进行探测并尝试连接

![img](https://pic1.zhimg.com/80/v2-8d8eba5e5b3b7b8c71b3be6e58c21c54_1440w.jpg)

![img](https://pic3.zhimg.com/80/v2-2220702269847e2cba512dd8013cf0da_1440w.jpg)

使用完毕之后，我们再次用nmap进行关门，只需要倒过来敲击各个端口即可

```text
for x in 9000 8000 7000;do nmap ‐Pn ‐‐max‐retries 0 ‐p $x 192.168.61.135;done
```

![img](https://pic4.zhimg.com/80/v2-c9596dee56810cceeedc62ebd64e44df_1440w.jpg)

再次查看Ubuntu的防火墙规则，可以看到之前关于192.168.61.130的规则已经被删除

![img](https://pic4.zhimg.com/80/v2-4667235b96a0b4a97746bb38997719c7_1440w.jpg)

此时再次用nmap进行探测以及进行连接都会被拒绝

![img](https://pic4.zhimg.com/80/v2-26d0d5a1f3e02bd2f503bb5417553d3f_1440w.jpg)

![img](https://pic4.zhimg.com/80/v2-97e5d3771de87a65384d82e0cce7e6f7_1440w.jpg)




Ms08067安全实验室专注于网络安全知识的普及和培训。团队已出版《Web安全攻防：渗透测试实战指南》，《内网安全攻防：渗透测试实战指南》，《Python安全攻防：渗透测试实战指南》，《Java代码安全审计（入门篇）》等书籍。

团队公众号定期分享关于CTF靶场、内网渗透、APT方面技术干货，从零开始、以实战落地为主，致力于做一个实用的干货分享型公众号。

官方网站：[www.ms08067.com](https://link.zhihu.com/?target=http%3A//www.ms08067.com/)