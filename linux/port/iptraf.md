安装iptraf
debian\ubuntu
sudo apt install iptraf 
1
centos\redhat
sudo yum install iptraf 
1
使得iptraf后台运行并产生日志
sudo iptraf -i eth0 -L /var/log/traffic_log -B
1
查看日志
less /var/log/traffic_log
1
每周定期清理日志，防止日志过大
 0 0 * * 0 rm -f /var/log/traffic_log
