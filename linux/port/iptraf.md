# iptraf


``` bash
# 安装iptraf
sudo apt install iptraf  # debian\ubuntu
sudo yum install iptraf  # centos\redhat

# 使得iptraf后台运行并产生日志
sudo iptraf -i eth0 -L /var/log/traffic_log -B

# 查看日志
less /var/log/traffic_log

# 每周定期清理日志，防止日志过大
 0 0 * * 0 rm -f /var/log/traffic_log

 ```


-i 网络接口：立即在指定网络接口上开启IP流量监视；
-g：立即开始生成网络接口的概要状态信息；
-d 网络接口：在指定网络接口上立即开始监视明细的网络流量信息；
-s 网络接口：在指定网络接口上立即开始监视TCP和UDP网络流量信息；
-z 网络接口：在指定网络接口上显示包计数；
-l 网络接口：在指定网络接口上立即开始监视局域网工作站信息；
-t 时间：指定iptraf指令监视的时间；
-B；将标注输出重新定向到“/dev/null”，关闭标注输入，将程序作为后台进程运行；
-f：清空所有计数器；
-h：显示帮助信息。