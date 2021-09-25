# **Port Knocking for Ubuntu 14.04 Server**

OS:ubuntu 14.04 server

原理简单分析：

　　端口敲门服务，即：knockd服务。该服务通过动态的添加iptables规则来隐藏系统开启的服务，使用自定义的一系列序列号来“敲门”，使系统开启需要访问的服务端口，才能对外访问。不使用时，再使用自定义的序列号来“关门”，将端口关闭，不对外监听。进一步提升了服务和系统的安全性。

 

## 1.安装knockd
　　#apt-get install update
　　#apt-get install build_essential -y
　　#apt-get install knockd -y

## 2.配置knockd服务：
　　1)配置/etc/knockd.conf。

```ini
[options]
 #UseSyslog
 LogFile = /knock.log

[openSSH]
sequence = 7000,8000,9000 //定义敲门顺序号
seq_timeout = 30 //设置超时时间太小的话会出错，我开始设置为5的时候不能添加以下iptables规则
command = /sbin/iptables -D INPUT -p tcp --dport 22 -j DROP && /sbin/iptables -A INPUT -s [允许远程的IP] -p tcp --dport 22 -j ACCEPT && /sbin/iptables -A INPUT -p tcp --dport 22 -j DROP
//因为ubuntu系统iptables规则默认是禁止所有的规则，如果在这里直接添加，添加的规则是在drop all规则之后的，相当于无效。所以先删除drop all的规则再添加，然后再开启drop all的规则就可以了。
tcpflags = syn

[closeSSH]
sequence = 9000,8000,7000 //定义关门顺序号
seq_timeout = 30 //设置超时时间太小的话会出错，我开始设置为5的时候不能添加以下iptables规则
command = /sbin/iptables -D INPUT -s [允许远程的IP] -p tcp --dport 22 -j ACCEPT
tcpflags = syn
```

2)配置/etc/default/knockd，修改START_KNOCKD=1。
　　　　

```ini
################################################
#
# knockd's default file, for generic sys config
#
################################################

# control if we start knockd at init or not
# 1 = start
# anything else = don't start
#
# PLEASE EDIT /etc/knockd.conf BEFORE ENABLING

START_KNOCKD=1

# command line options
#KNOCKD_OPTS="-i eth1"
```



## 3.启动knockd。
　　　`#service knockd start`

## 4.添加iptables规则，禁止ssh的包。

```ini
　　#iptables -A INPUT -p tcp --dport 22 -j DROP

　　#iptables-save
```



## 5.测试knockd服务。
　　1)使用ssh登录。
　　　　`root@knockd_server_ip //不能登录`
　　2)使用7000/8000/9000队列号敲门。

```bash
　for x in 7000 8000 9000; do nmap -Pn --host_timeout 201 --max-retries 0 -p $x [knockd_server_ip]; done # 客户端需要安装nmap
 
 # 这条命令和以下三条命令等效
 nmap -p 7000
 nmap -p 8000
 nmap -p 9000
```

　　3)敲门之后ssh登录
　　　　`ssh root@knockd_server_ip //可以登录`
　　4)使用9000/8000/7000队列号关门。

```ini
for x in 9000 8000 7000; do nmap -Pn --host_timeout 201 --max-retries 0 -p $x [knockd_server_ip]; done # 客户端需要安装nmap

# 这条命令和以下三条命令等效
nmap -p 9000
nmap -p 8000
nmap -p 7000
```


　　5)再次ssh测试。
　　　　`ssh root@knockd_server_ip //不能登录`



分类: [Linux](https://www.cnblogs.com/wsjhk/category/680112.html)