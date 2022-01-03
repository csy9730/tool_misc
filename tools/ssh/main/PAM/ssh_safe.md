# ssh safe


**Q**:How to Find All Failed SSH login Attempts in Linux
**A**: 
redhat/centos的登录记录在/var/log/secure，
debian/ubuntu的登录记录在/var/log/auth.log
``` bash
grep "Failed password" /var/log/auth.log
cat /var/log/auth.log | grep "Failed password"
cat /var/log/auth.log | grep "Failed password"
cat /var/log/auth.log | grep "Failed password"
```

**Q**:How to Find All Failed SSH login Attempts in windows
**A**:  尚未解决



**Q**: 如何防止被密码暴力攻击？
**A**: 
``` bash
last # 查看正常登录
# 通过以下查看centos 密码登录错误次数
grep "Failed password for root" /var/log/secure | awk '{print $11}' | wc -l
grep "Failed password for root" /var/log/secure | awk '{print $11}' | sort | uniq -c | sort -nr | more
# 通过以下查看Ubuntu 密码登录错误次数
grep "Failed password for root" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr | more

lastb # 查看 登录失败记录，/var/log/btmp

# 读取位于/var/log/wtmp的文件，并把该给文件的内容记录的登录系统的用户名单全部显示出来。
last # 查看登录成功记录
```

1. 修改默认端口22为自定义端口号（例如2222）
2. 增加密码长度到14位以上，包含符号数字字母的组合。
3. 禁止root用户登录，创建一个普通帐号，修改ID为0，成为超级管理权限
4. 禁止密码登录，只能私钥登录
5. 添加hosts.deny
6. 使用denyhosts脚本，或fail2ban
7. 敲门守护进程 knockd
   

本地使用ssh-keygen生成公钥，将公钥放在/root/.ssh/authorized_keys中
``` ini
    AuthorizedKeysFile   .ssh/authorized_keys   # 公钥公钥认证文件
    PubkeyAuthentication yes   # 可以使用公钥登录
    PasswordAuthentication no  # 不允许使用密码登录
```


``` bash
#! /bin/bash
 
cat /var/log/auth.log | awk '/Failed/ {print $(NF-3)}' | uniq -d > /var/black
for IP in `cat /var/black`
do
  grep $IP /etc/hosts.deny > /dev/null
  if [ $? -gt 0 ]; then
    echo "$IP 正在试图暴力登录你的服务器，其IP已被屏蔽，请尽
快登录服务器处理!" | mail -s '服务器攻击预警'  '123456789@qq.com'
    echo "sshd:$IP:deny" >> /etc/hosts.deny
  fi
done
```


