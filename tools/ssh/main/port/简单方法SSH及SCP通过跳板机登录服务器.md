# 简单方法SSH及SCP通过跳板机登录服务器

Published 2019/01/14 by zocodev

**文章目录**

1. [SSH通过跳板机登录远程服务器](https://zocodev.com/ssh-scp-over-jump-server.html#title-0)
2. [SCP通过跳板机登录远程服务器](https://zocodev.com/ssh-scp-over-jump-server.html#title-1)
3. [sshd_config配置](https://zocodev.com/ssh-scp-over-jump-server.html#title-2)

最近新开了一台[Linode](https://affu.me/linode)的按量付费服务器，发现在国内访问不通，但是看到分配的IP挺好的，又不忍心删了，正好可以不用直接对国内用户提供服务，于是找了找简单的通过跳板机登录服务器的办法，这里做个记录，以备后用。


先来说说使用方法。

## SSH通过跳板机登录远程服务器

其实使用方法很简单，直接一行命令就可以了，命令格式如下：

```
ssh -J username@jump_server_ip_or_name:port username@endpoint_server_ip_or_name -p port
```

举例来说，跳板机的用户名为user1，IP为**1.2.3.4**，端口为22，目的服务器用户名为**user2**，IP为**5.6.7.8**，SSH端口为22，则命令为：

```
ssh -J user1@1.2.3.4:22 user2@5.6.7.8 -p 22
```

当然，如果端口默认就是22，也可以缩略如下：

```
ssh -J user1@1.2.3.4 user2@5.6.7.8
```

回车之后，只需要分别输入登录跳板服务器的用户的密码及登录目的服务器的用户的密码就可以了。

其实就是使用SSH的**J**参数，跟别的堡垒机的方法有所不同的是，这样可以大部分主机无需改动而直接进行当做跳板机使用。比如说我这种情况，无法直接从本地登录目的服务器，但是可以通过可以访问目的服务器的中间服务器进行登录目的服务器，怎么样，简单吧哈哈。

## SCP通过跳板机登录远程服务器

既然可以SSH通过跳板服务器登录远程服务器，那如果我们使用SCP进行上传下载是否也可以使用相同的方式连接呢。

摸索了一下，发现还真的可以，格式如下：

```
scp -P endpoint_server_port -o 'ProxyJump user1@jump_server_ip_or_name -p port' file.txt user2@endpoint_server_ip_or_name:~
```

举个例子就是：

```
scp -P 22 -o 'ProxyJump user@1.2.3.4 -p 22' file.txt user2@5.6.7.8:~
```

省略一些参数就是：

```
scp -o 'ProxyJump user@1.2.3.4' file.txt user2@5.6.7.8:~
```

其余跟普通scp命令一致，没啥特别的。

这种方法除了适用我上述说的本地无法直接访问目的服务器的方法之外，还能作为一个中转节点对文件上传下载进行加速，比如说，本地下载目的服务器上一个大文件，而本地到目的服务器网络并不是很理想，就可以找一个中转服务器加速本地到目的服务器之间的网络连接。

## sshd_config配置

正常来说，上述命令是可以直接使用的，但是如果遇到不能直接将中间服务器当做跳板机的情况，可以检查一下**跳板机**的sshd_config文件，记得将如下内容的值改成如下形式：

```
vim /etc/ssh/sshd_config

AllowTcpForwarding yes
PermitTunnel yes
```

改完之后重启一下**跳板机**的SSH服务端就好了。

![zocodev](https://secure.gravatar.com/avatar/f2bb946e303b1c232b09f066a5b8431a?s=65&d=mm&r=g)

### [zocodev](https://zocodev.com/author/zocodev)



Published in [服务器](https://zocodev.com/category/server)

- [SSH](https://zocodev.com/tag/ssh)