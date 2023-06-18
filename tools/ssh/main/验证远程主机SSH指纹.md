## [验证远程主机SSH指纹](https://www.cnblogs.com/rongfengliang/p/10448225.html)

转自：https://marskid.net/2018/02/05/how-to-verify-ssh-public-key-fingerprint/

使用SSH进行远程连接新的主机的时候，经常会看到一个提示：

```bash
$ ssh 127.0.0.1
The authenticity of host '127.0.0.1 (127.0.0.1)' can't be established.
ECDSA key fingerprint is SHA256:QUfCwW6Br5EwwESsulN2TEidBoDNca888RNflZG++bI.
Are you sure you want to continue connecting (yes/no)? yes
```

如果输入`yes`确认，那么服务器SSH公钥会添加到`~/.ssh/known_hosts`里面。虽然知道这是一个验证步骤，但是应该怎样验证？其中原理又是什么？

```bash
$ cat ~/.ssh/known_hosts
|1|DdBYclZ+pUHyoiLC2zjmf5Efb4Y=|fdd5RRy2SV0775av/4ktZr30aI8= ecdsa-sha2-nistp256 AAAAE2VjZHN.........K+/urI+pGmsSDz6O5PY=
```

第一次连接SSH有提示ECDSA类型的公钥指纹，因为指纹比公钥的长度要短，所以更容易比较。

> SHA256:QUfCwW6Br5EwwESsulN2TEidBoDNca888RNflZG++bI

这个指纹也可以通过`ssh-keyscan`命令结合`ssh-keygen`得到。`ssh-keyscan` 命令可获取服务器公钥，而 `ssh-keygen` 命令可以计算公钥的指纹。只要计算一下服务器上的相应公钥的指纹，并与客户端获取的指纹进行比对一致，就能确定连接的是公钥对应的服务器。

先在客户端获取服务器公钥：

```bash
$ ssh-keyscan -t ECDSA -p 22 127.0.0.1
# 127.0.0.1:22 SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.4
127.0.0.1 ecdsa-sha2-nistp256 AAAAE2VjZHN.........K+/urI+pGmsSDz6O5PY=
BASH 复制 全屏
```

可以看到这个公钥与写入`known_hosts`文件是一致的。

那么这个公钥从哪里来，怎么确认与服务器的连接是正确的？

可以通过`ssh-keygen`命令获取公钥的指纹，可通过-E参数指定指纹的类型。

```bash
$ ssh-keygen -E sha256 -lf ~/.ssh/known_hosts
256 SHA256:QUfCwW6Br5EwwESsulN2TEidBoDNca888RNflZG++bI |1|DdBYclZ+pUHyoiLC2zjmf5Efb4Y=|fdd5RRy2SV0775av/4ktZr30aI8= (ECDSA)
```

有的SSH终端默认提供MD5格式的公钥指纹。

```bash
$ ssh-keygen -E md5 -lf ~/.ssh/known_hosts
256 MD5:e6:f0:2b:fa:23:fb:fe:0d:1d:de:2c:71:70:ea:fe:f9 |1|DdBYclZ+pUHyoiLC2zjmf5Efb4Y=|fdd5RRy2SV0775av/4ktZr30aI8= (ECDSA)
```

这样就方便与服务器的指纹进行比较，虽然直接比较公钥是否相同也可以。

进入服务器，可看到`/etc/ssh/`目录下有几种密钥，这些文件在安装openssh-server后生成。SSH服务就是使用这些密钥与客户端进行加密通信。

```bash
$ ls -1 /etc/ssh/ssh_host*
/etc/ssh/ssh_host_dsa_key
/etc/ssh/ssh_host_dsa_key.pub
/etc/ssh/ssh_host_ecdsa_key
/etc/ssh/ssh_host_ecdsa_key.pub
/etc/ssh/ssh_host_ed25519_key
/etc/ssh/ssh_host_ed25519_key.pub
/etc/ssh/ssh_host_rsa_key
/etc/ssh/ssh_host_rsa_key.pub
```

根据终端的提示，选择ECDSA进行比较。可在服务器通过下面的命令生成服务器的公钥指纹摘要，这是可信的基础。

```bash
$ ssh-keygen -E sha256 -lf /etc/ssh/ssh_host_ecdsa_key.pub
256 SHA256:QUfCwW6Br5EwwESsulN2TEidBoDNca888RNflZG++bI root@localhost (ECDSA)
```

这是MD5格式。

```bash
$ ssh-keygen -E md5 -lf /etc/ssh/ssh_host_ecdsa_key.pub
256 MD5:e6:f0:2b:fa:23:fb:fe:0d:1d:de:2c:71:70:ea:fe:f9 root@localhost (ECDSA)
```

可以在客户端使用如下命令通过网络获取服务器的公钥指纹摘要。

```bash
$ ssh-keyscan -t ECDSA -p 22 127.0.0.1 2>/dev/null | ssh-keygen -E sha256 -lf -
256 SHA256:QUfCwW6Br5EwwESsulN2TEidBoDNca888RNflZG++bI 127.0.0.1 (ECDSA)
```

这是MD5格式。

```bash
$ ssh-keyscan -t ECDSA -p 22 127.0.0.1 2>/dev/null | ssh-keygen -E md5 -lf -
256 MD5:e6:f0:2b:fa:23:fb:fe:0d:1d:de:2c:71:70:ea:fe:f9 127.0.0.1 (ECDSA)
```

可以看到，在服务器上直接生成的

> 256 SHA256:QUfCwW6Br5EwwESsulN2TEidBoDNca888RNflZG++bI root@localhost (ECDSA)

与客户端获取的

> 256 SHA256:QUfCwW6Br5EwwESsulN2TEidBoDNca888RNflZG++bI 127.0.0.1 (ECDSA)

公钥指纹是一致的，并且`~/.ssh/known_hosts`文件中的对应主机的公钥也与服务器相应类型的公钥一致。可以据此判断SSH建立的连接是正确的。

分类: [工具](https://www.cnblogs.com/rongfengliang/category/543066.html), [持续集成](https://www.cnblogs.com/rongfengliang/category/934639.html), [云运维&&云架构](https://www.cnblogs.com/rongfengliang/category/1107309.html), [openssh](https://www.cnblogs.com/rongfengliang/category/1580002.html)