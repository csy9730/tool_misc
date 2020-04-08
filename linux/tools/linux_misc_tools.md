# linux工具

适合Linux系统环境的WEB网站浏览器工具，常用的有w3m、Links、Lynx三个工具
``` bash
apt­-get install w3m
apt­-get install links
apt­-get install lynx 
apt­-get install autoconf  automake libtool # autotools

apt install sl cmatrix # 
sudo apt install screenfetch # 命令行形式输出linux的平台信息
apt-get install fortune fortune-zh cowsay # 输出名人名言、古诗词
fortune | cowsay -f stegosaurus 
```

ntpd linux时间同步


jobs
ps aux

apache+php+mysql
kcp
xtcp

**Q**：我们想要退出当前终端，但又想让程序在后台运行？
**A** ： 

&可以使程序后台执行。通过重定向可以避免标准输入输出阻塞终端：`./test >> out.txt 2>&1 &` 
如果进一步，希望程序在终端退出之后依然执行，需要使用nohup命令。nohup就是不挂起的意思( no hang up)。该命令的一般形式为：
`nohup ./test &`
需要使用exit正常退出当前账户，这样才能保证命令一直在后台运行，避免意外退出导致nohup失效。


