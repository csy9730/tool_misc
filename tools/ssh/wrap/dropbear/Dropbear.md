# Dropbear

Dropbear是由Matt Johnston所开发的Secure Shell软件（包括服务器端与客户端）。期望在存储器与运算能力有限的情况下取代OpenSSH，尤其是嵌入式系统。

Dropbear是一个相对较小的SSH服务器和客户端。它运行在一个基于POSIX的各种平台。 Dropbear是开源软件，在麻省理工学院式的许可证。 Dropbear是特别有用的“嵌入”式的Linux（或其他Unix）系统，如无线路由器。

dropbear实现安全Shell（SSH）协议版本2。
加密算法使用第三方加密库包含在Dropbear分配内部实施。它源于一些地方的OpenSSH来处理BSD风格的伪终端。

dropbear实现完整的SSH客户端和服务器版本2协议。它不支持SSH版本1 的向后兼容性，以节省空间和资源，并避免在SSH版本1的固有的安全漏洞。还实施了SCP的。SFTP支持依赖于一个二进制文件，可以通过提供的OpenSSH或类似的计划。


- dropbear的安装依赖zlib连接库；
- 注意：安装dropbear的时候，生成了dbclient和scp，另外还有dropbearkey和dropbearconvert。


其中：
- Dropbearkey是用来生成公钥的，
- Dropbearconvert是用来与openssh转换的
- Dbclient可以用来连接远程的服务器,类似于Openssh的ssh
- dropbear 类似于Openssh的sshd
- Scp可以向远程的服务器写文件和取文件
- 配置文件目录：/etc/dropbear
- /var/log/messages  登录日志文件

Dbclient的用法，例如
```
$ ./dbclient username@192.168.99.214
```
Scp的用法，例如：
```
./scp /home/bin/a.log username@192.168.99.214:/home/working
```

## misc

### faq

dropbear无法登录？

解决方法：

查看登录记录：
/var/log/messages


出现以下错误
```
Jun 25 01:27:18 Foo authpriv.err dropbear[178]: Couldn't create new file /etc/dropbear/dropbear_ed25519_host_key.tmp178: Read-only file system
Jun 25 01:27:18 Foo authpriv.info dropbear[178]: Exit before auth from <127.0.0.1:47636>: Couldn't read or generate hostkey /etc/dropbear/dropbear_ed25519_host_key
```

或者出现以下错误
```
Jun 25 01:22:14 FOO authpriv.info dropbear[121]: Early exit: String too long
```

一般是签名文件不完整或无法读取，建议重新生成签名
``` bash
cd /etc/dropbear
dropbearkey -t dss -f dropbear_dss_host_key
dropbearkey -t ecdsa -f dropbear_ecdsa_host_key
dropbearkey -t rsa -f dropbear_rsa_host_key
dropbearkey -t ed25519 -f dropbear_ed25519_host_key
```

然后重新启动dropbear服务, 错误就可以解决。