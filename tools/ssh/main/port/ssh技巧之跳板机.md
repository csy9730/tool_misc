# ssh技巧之跳板机

2019-09-10阅读 1.6K0

在管理外网服务器时，出于安全等因素的考虑，我们一般不会把所有服务器都设置成可ssh直连，而是会从中挑选出一台机器作为跳板机，当我们想要连接外网服务器时，我们要先通过ssh登录到跳板机，再从跳板机登录到目标服务器。

下面我们用实验来展示一下跳板机的登录流程。

在该实验中，我们用机器192.168.57.3来代表目标服务器，该服务器不能ssh直连，只能通过跳板机连接，用机器192.168.56.5来代表跳板机，该跳板机可以用ssh直接连接。

为了方便测测试，我们先把我们自己电脑上的ssh的public key拷贝到跳板机及目标服务器的.ssh/authorized_keys文件里，这样我们就可以无密码登录了。

下面是测试流程：

\1. ssh登录跳板机。

```javascript
$ ssh u3@192.168.56.5
Last login: Sun Sep  8 19:51:48 2019 from 192.168.56.1
u3@h3:~$
```

\2. 从跳板机登录到目标服务器。

```javascript
u3@h3:~$ ssh -o "PasswordAuthentication no" u2@192.168.57.3
u2@192.168.57.3: Permission denied (publickey,password).
```

该命令中的参数 -o "PasswordAuthentication no" 表示不使用密码登录。

因为我们已经把我们电脑上的ssh的public key拷贝到目标机器的.ssh/authorized_keys文件里了，理论上来说，应该是可以登录成功的，但上面的命令却显示登录失败，哪里错了呢？

其实很简单，ssh的key登录是要public key和private key成对存在的，虽然public key已经拷贝到了目标机器，但我们此时是在跳板机上，而跳板机上并没有我们自己机器的private key。

那我们把private key拷贝到跳板机可以不？

不行，因为private key一旦拷贝到跳板机，那其他能登录到跳板机的人就都可以拿到我们的private key了，这非常不安全。

那怎么办呢？

这个问题其实可以通过ssh的agent forwarding来解决，我们先看下具体操作，然后再讲解其工作原理。

我们先退回到自己的机器上，然后执行以下流程：

\1. 开启ssh-agent，然后将我们的private key添加到ssh-agent中。

```javascript
$ eval $(ssh-agent)
Agent pid 8350
$ ssh-add
Identity added: /home/yt/.ssh/id_rsa (yt@arch)
Identity added: /home/yt/.ssh/id_ed25519 (yt@arch)
```

\2. ssh登录到跳板机（不过此次加上了-A参数，表示开启agent forwarding）。

```javascript
$ ssh -A u3@192.168.56.5
Last login: Sun Sep  8 21:13:01 2019 from 192.168.56.1
u3@h3:~$
```

\3. 从跳板机登录到目标机器。

```javascript
u3@h3:~$ ssh u2@192.168.57.3
Last login: Sun Sep  8 20:45:03 2019 from 192.168.57.4
u2@h2:~$
```

由上可见，这次从跳板机登录目标机器是成功了的，原因就是我们开启了agent forwarding，但它是怎么帮助我们从跳板机上登录目标机器的呢？

当我们在跳板机上ssh登录目标机器时，目标机器会要求跳板机用对应的ssh的private key做认证，但跳板机是没有这个key的，这个key保存在我们自己的电脑上，又因为我们在从自己的电脑ssh登录跳板机时开启了agent forwarding，所以跳板机会把该认证请求转发给我们自己的电脑，我们自己电脑在收到这个认证请求时，会找ssh-agent进程进行认证，而又因为开始的时候，我们通过ssh-add命令将我们的private key加入到了ssh-agent中，所以，此次认证是成功的，我们的机器把认证结果再转给跳板机，跳板机再将该结果转给目标机器，就这样，在跳板机没有我们的ssh的private key的情况下，登录目标机器还是成功了。

这个就是跳板机的登录流程，不过，这只是一种最基本的方式，其实还有更简单的方式，我们还是用实验看下。

还是先退回到我们自己的机器，然后执行下面的命令：

```javascript
$ ssh -J u3@192.168.56.5 u2@192.168.57.3
Last login: Sun Sep  8 21:09:13 2019 from 192.168.57.4
u2@h2:~$
```

喔，居然用一条命令就直接成功了，根本就没有经历从跳板机到目标机器的过程。

该命令中的-J参数是用来指定跳板机的，该命令执行后，ssh会帮我们先登录跳板机，然后再登录目标机器，一切都是自动的。

用-J参数指定跳板机还有一个好处就是在使用scp拷贝文件时更加方便。

如果是普通方式，我们要先将文件拷贝到跳板机上，再从跳板机上拷贝到目标机器，非常麻烦，如果使用-J参数，我们用一条命令就可以搞定了。

```javascript
$ scp -J u3@192.168.56.5 abc.txt u2@192.168.57.3:/home/u2/
abc.txt
```

完美！

有关ssh跳板机的知识就讲到这吧，希望对大家有所帮助。

完。