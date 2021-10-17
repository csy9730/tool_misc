# 如何部署一台抗封锁的Shadowsocks-libev服务器



**作者:** Anonymous

日期: 2021年1月26日，星期二



更新: 2021年2月28日，星期天

[English Version: *How to Deploy a Censorship Resistant Shadowsocks-libev Server*](https://gfw.report/blog/ss_tutorial/en)



这篇教程记录了如何安装，配置并维护一台Shadowsocks-libev服务器。 这篇教程的亮点在于， 按照这里的配置建议，你的Shadowsocks-libev服务器可以抵御各种已知的攻击， 包括[来自GFW的主动探测和封锁](https://gfw.report/talks/imc20/en/)以及[partitioning oracle攻击](https://www.usenix.org/system/files/sec21summer_len.pdf#page=13)。 我们还在教程的最后加入了常见的有关Shadowsocks-libev部署的常见问题。

我们致力于更新和维护这篇教程。如果今后发现了新的针对Shadowsocks-libev的攻击，我们将在第一时间在这篇教程中加入缓解攻击的办法。 因此请考虑将这个页面加入到你的收藏夹中。 另外，我们希望这篇教程对技术小白同样友好，因此如果你在任何步骤卡住了，请[联系我们](https://gfw.report)，或在下方评论区留言。我们会对教程作相应改进。

## 安装

### 安装Snap应用商店

通过Snap应用商店安装Shadowsocks-libev是[官方推荐](https://github.com/shadowsocks/shadowsocks-libev#quick-start)的方式。

- 如果你的服务器运行Ubuntu 16.04 LTS及以上的版本，Snap已经默认安装好了。
- 如果你的服务器运行了其他的Linux发行版，你只需跟着[对应的发行版安装Snap core](https://snapcraft.io/core)。

现在来检测一下你的服务器已经安装了需要的`snapd`和Snap `core`:

```sh
sudo snap install core
```

### 安装Shadowsocks-libev

现在我们安装最新的Shadowsocks-libev:

```sh
sudo snap install shadowsocks-libev --edge
```

## 配置

下面是我们推荐的Shadowsocks-libev服务器配置：

``` json
{
    "server":["::0","0.0.0.0"],
    "server_port":8388,
    "encryption_method":"chacha20-ietf-poly1305",
    "password":"ExamplePassword",
    "mode":"tcp_only",
    "fast_open":false
}
```

注意，你需要把里面的`ExamplePassword`替换成一个更强的密码。 强密码有助缓解最新发现的针对Shadowsocks服务器的[Partitioning Oracle攻击](https://www.usenix.org/system/files/sec21summer_len.pdf#page=13)。 你可以用以下命令在终端生成一个强密码：`openssl rand -base64 16`。

你还可以考虑将`server_port`的值从`8388`改为`1024`到`65535`之间的任意整数。

现在打开通过Snap安装的Shadowsocks-libev默认的配置文件：

```sh
sudo nano /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json
```

将上方替换过密码的配置信息复制粘贴到配置文件后， 按`Ctrl + x`退出。 退出时，文本编辑器将问你`"Save modified buffer?"`，请输入`y`然后按回车键。

可以看到，通过Snap安装的Shadowsocks-libev默认的配置文件路径太长了，不便于记忆。同时默认配置路径又没有在官方文档中标出。 我们因此建议你收藏此页面，以备今后查找。

## 防火墙

我们使用`ufw`来管理Shadowsocks服务器的防火墙。

在基于Debian的服务器上，可以通过如下命令安装`ufw`：

```sh
sudo apt update && sudo apt install -y ufw
```

然后开放有关`ssh`和`Shadowsocks-libev`的端口。 请注意，以下命令假设你在`/var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json`中的`server_port`的值为`8388`。 如果你的`server_port`用了其他的值，请对以下命令作相应的修改：

```sh
sudo ufw allow ssh
sudo ufw allow 8388/tcp
```

现在我们启动`ufw`:

```sh
sudo ufw enable
```

启动时如果弹出`Command may disrupt existing ssh connections. Proceed with operation (y|n)?`，请输入`y`并按回车键。

最后，请用`sudo ufw status`检查一下你的配置是否和下面的一样：

```txt
Status: active

To                         Action      From
--                         ------      ----
SSH                        ALLOW       Anywhere
8388/tcp                   ALLOW       Anywhere
SSH (v6)                   ALLOW       Anywhere (v6)
8388/tcp (v6)              ALLOW       Anywhere (v6)
```

## 运行Shadowsocks-libev

现在我们启动Shadowsocks-libev：

```sh
sudo systemctl start snap.shadowsocks-libev.ss-server-daemon.service
```

记得设置Shadowsocks-libev开机自启动：

```sh
sudo systemctl enable snap.shadowsocks-libev.ss-server-daemon.service
```

## 维护

### 检查运行状态和日志

以下命令可以查看Shadowsocks-libev的运行状态：

```sh
sudo systemctl status snap.shadowsocks-libev.ss-server-daemon.service
```

如果你看到绿色的`Active: active (running)`，那么你的Shadowsocks-libev服务器就在正常的运行； 如果你看到红色的`Active: failed`，请用跳至如下命令`journalctl -u snap.shadowsocks-libev.ss-server-daemon.service`的尾部查看问题出在哪里了。

### 重新加载配置文件

每当你修改过配置文件后，请用如下命令重启Shadowsocks-libev以加载修改后的文件：

```sh
sudo systemctl restart snap.shadowsocks-libev.ss-server-daemon.service
```

## 常见问题

##### Q:为什么我用了教程里的配置，服务器还是被封了?

A: 通常来讲，这种事情不会发生，因为通过这篇教程配置的Shadowsocks-libev服务器已经可以抵御已知的所有来自GFW的主动探测。但如果你的服务器确实被封锁了，那么很有可能审查者使用了未知的攻击手段。请[将你的封锁情况汇报给我们](https://gfw.report)，我们会认真地调查。

##### Q: 我应不应该从发行版的仓库下载安装Shadowsocks-libev?

A: 发行版仓库里的Shadowsocks-libev不一定是最新版的。比如，截止2021年1月，Debian buster仓库的Shadowsocks-libev的版本为`v3.2.5`。而这个版本的Shadowsocks-libev是不够防御来自GFW的主动探测的（详见[Figure 10](https://gfw.report/publications/imc20/data/paper/shadowsocks.pdf#page=9)）。

##### Q: 我应该怎样更新用Snap安装的Shadowsocks-libev?

A: 因为Snap会每天自动更新通过其安装的软件，因此通常情况下你不需要手动更新。如若需要手动更新，请用： `sudo snap refresh`。

##### Q: 为什么用`chacha20-ietf-poly1305`作为加密方式?

A: 因为它是其中一种[AEAD ciphers](https://shadowsocks.org/en/wiki/AEAD-Ciphers.html)。而[AEAD ciphers可以抵御来自GFW的主动探测](https://gfw.report/blog/ss_advise/zh/)。它同时也是Shadowsocks-libev及OutlineVPN的默认加密方式。

##### Q: 我应该用Shadowsocks的stream cipher吗?

A: 完全不应该。因为Shadowsocks的stream cipher有着不可接受的安全隐私漏洞，并且可以被准确的主动探测。如[Figure 10](https://gfw.report/publications/imc20/data/paper/shadowsocks.pdf#page=9)所示，即使是最新版的Shadowsocks-libev，在使用stream cipher时同样可以被准确识别。更具灾难性的是，[在不需要密码的情况下，攻击者可以完全解密被记录下来的Shadowsocks会话](https://github.com/net4people/bbs/issues/24)。

##### Q: 但为什么我用的机场仍在使用stream cipher?

A: 这清楚地说明你的机场缺乏安全意识和安全措施。请把[这篇教程](https://gfw.report/blog/ss_tutorial/zh/)，[这个演讲](https://gfw.report/talks/imc20/en/)，和这篇[总结](https://gfw.report/blog/ss_advise/zh/)，分享给你的机场主。

##### Q: 我应该把配置中的`server_port`改为像`443`这样的常见端口吗?

A: 不应该。因为不论你使用哪个端口，GFW都会检测并怀疑你的Shadowsocks流量。

##### Q: 为什么配置文件使用`tcp_only`模式?

A: 这是为了缓解最新发现的[Partitioning Oracle攻击](https://www.usenix.org/system/files/sec21summer_len.pdf#page=13)，文中指出 “Shadowsocks的开发者们已经采取措施，禁用了本默认开启的UDP代理模式（“the Shadowsocks developers  took immediate action to disable UDP proxying where it was enabled by  default."）。当然，如Vinicius[所指出的](https://gfw.report/blog/ss_tutorial/en/#isso-57)，如果你使用了长的随机密码，那么partitioning oracle攻击就不能成功。因此也就不需要禁用UDP代理模式。开启UDP代理模式可能会让经过Shadowsocks代理的视频通话质量更佳。

##### Q: 为什么配置文件禁用了`fast_open`?

A: 我们推荐你阅读[这里的讨论](https://github.com/klzgrad/naiveproxy#why-not-use-go-node-etc-for-performance)。

## 联系

这篇报告首发于[GFW Report](https://gfw.report/blog/ss_tutorial/zh/)。我们鼓励您或公开地或私下地分享您的评论或疑问。我们私下的联系方式可见[GFW Report](https://gfw.report)的页脚。