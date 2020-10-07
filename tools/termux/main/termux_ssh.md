# SSH

## introduction


远程连接服务器： 就是通过文字或图形接口的方式来远程登陆另外一台服务器系统，让你在远程的终端前面登陆linux 主机以取得可操作主机的接口

* 文字接口明文传输 ： Telnet ，RSH 等，因不加密传输所以很少使用　　
* 文字接口加密传输： SSH为主　　
* 图形接口： XDMCP VNC XRDP 等

SSH服务器
### SSH
1. 建立连接
``` bash
sshd -p 9000 # 指定端口号
ssh u0_a198@192.168.1.101 -p 8022
``` 
2. 断开连接
Ctrl+D
logout
 


### windows下连接termux
ssh可以使用账号密码登录，也可以使用pem文件登录，在termux中，只能使用pem文件登录

1. 远程端生成RSA密码公钥文件和私钥文件
2. 使用公钥文件并提升权限
3. 记录ip和用户名，指定端口号8022开启sshd
4. 发送私钥到本地端
5. 本地端调用 putty-gen 打开私钥pem文件，转换成ppk文件
6. putty指定ip，端口号，ppk文件，远程连接，使用用户名登录远程端。

本地端windows可以使用putty，xshell，或mingw.ssh连接，
linux可以使用ssh连接。

主机端（termux端），推荐使用mintty（git-bash）作为终端
``` bash
apt update
apt install openssh
cd /data/data/com.termux/files/home/.ssh/
ssh-keygen -t rsa # 两个文件id_rsa和id_rsa.pub，pub是公钥，另一个是私钥
cat ./id_rsa.pub >> authorized_keys
# send id_rsa.pub to other_pc
cd ..
ls -al
chmod 700 .ssh
chown u0_a256:u0_a256 .ssh # 修改权限rwx------

whoami # 得到用户名
ifconfig # ip address

sshd -p 9000 # 指定端口号启动sshd服务

```

客户端
``` bash
@other_pc

# putty-gen 把.pem密钥文件转成ppk文件，此时可以使用空密码
# putty的connection->SSH->auth菜单，选择刚刚保存的ppk

ssh u0_a198@192.168.1.101 -p 8022
ssh -i ~/.ssh/sshkey developer@192.168.1.237 -p 23

```
![0400611a1e67637b6cc8ee07b57cd793.png](en-resource://database/5491:1)

