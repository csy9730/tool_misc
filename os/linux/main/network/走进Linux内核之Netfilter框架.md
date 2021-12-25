# 走进Linux内核之Netfilter框架

# 走进Linux内核之Netfilter框架

**本文正在参与 “走过Linux三十年”话题征文活动**

> 笔者此前对Linux内核相关模块稍有研究，实现内核级通信加密、视频流加密等，涉及：Linux内核网络协议栈、Linux内核通信模块、Linux内核加密模块、秘钥生成分发等。
> 后续考虑开设Linux内核专栏。

话不多说直接上才艺，现在带你走进Linux内核之Netfilter框架。

[走进Linux内核之Netfilter框架](https://juejin.cn/post/7008945265021288484)

[走进Linux内核之XFRM框架](https://juejin.cn/post/7009869273103335455)

------

## 一、概述：Netfilter是什么

对于不经常接触Linux内核的应用层开发者来说，可能对`Netfilter`了解的比较少。但大多数Linux用户多少都用过或知道`iptables`，然而，`iptables`的功能实现就是在`Netfilter`之上完成的。

Netfilter框架由著名的Linux开发人员Rusty Russell于1998年开发，旨在改进以前实现ipchains（Linux2.2.x）和ipfwadm（Linux2.0.x）。

[Netfilter](https://link.juejin.cn/?target=http%3A%2F%2Fen.wikipedia.org%2Fwiki%2FNetfilter)是 Linux 内核中的一个框架，它为以定制处理器形式实施的各种网络相关操作提供了灵活性。Netfilter提供数据包过滤、网络地址翻译和端口翻译的各种选项。

### 1.Netfilter构成

其详细组成： ![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/02c470a981934452a97a0c2f0c9305ee~tplv-k3u1fbpfcp-watermark.awebp?)

Netfilter是 Linux 内核中进行数据包过滤，连接跟踪（Connect Track），网络地址转换（NAT）等功能的主要实现框架；该框架在网络协议栈处理数据包的关键流程中定义了一系列钩子点（Hook 点），并在这些钩子点中注册一系列函数对数据包进行处理。这些注册在钩子点的函数即为设置在网络协议栈内的数据包通行策略，换句话说就是，这些函数可以决定内核是接受还是丢弃某个数据包，函数的处理结果决定网络数据包的“命运”。

从图中我们可以看到，Netfilter 框架采用模块化设计理念，并且贯穿了 Linux 系统的内核态和用户态。

在用户态层面，根据不同的协议类型，为上层用户提供了不同的系统调用工具，比如我们常用的针对IPv4协议`iptables`，IPv6 协议的`ip6tables`，针对ARP协议的`arptables`，针对网桥控制的`ebtables`，针对网络连接追踪的`conntrack`等。

不同的用户态工具在内核中有对应的模块进行实现，而底层都需要调用 Netfilter hook API 接口进行实现。

同时也发现，之前提到的`iptables`，Linux防火墙工具其实也是 Netfilter 框架中的一个组件。

![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c83f9ef00fdf4c0c8619081bab9eb667~tplv-k3u1fbpfcp-watermark.awebp?)

### 2.Netfilter数据包路径

正常数据包在Netfilter中的路径：

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3a09b063ecf14c9eaeed7ad02e4c5999~tplv-k3u1fbpfcp-watermark.awebp?)

------

## 二、Netfilter实现

> Netfilter Hooks in the Linux Kernel

### 1.Netfilter挂载点：Netfilter places

#### （1）函数定义

从上面网络包发送接受流程图中看出,可以在不同的地方注册Nefilter的hook函数.由如下定义:

```c
// include/linux/netfilter.h

enum nf_inet_hooks {
        NF_INET_PRE_ROUTING,
        NF_INET_LOCAL_IN,
        NF_INET_FORWARD,
        NF_INET_LOCAL_OUT,
        NF_INET_POST_ROUTING,
        NF_INET_NUMHOOKS
};
复制代码
```

- `NF_INET_PRE_ROUTING`: incoming packets pass this hook in the () function before they are processed by the routing code. `ip_rcv()``linux/net/ipv4/ip_input.c`
- `NF_INET_LOCAL_IN`: all incoming packets addressed to the local computer pass this hook in the function . `ip_local_deliver()`
- `NF_INET_FORWARD`: incoming packets are passed this hook in the function . `ip_forwared()`
- `NF_INET_LOCAL_OUT`: all outgoing packets created in the local computer pass this hook in the function . `ip_build_and_send_pkt()`
- `NF_INET_POST_ROUTING`: this hook in the ipfinishoutput() function before they leave the computer.

#### （2）挂载点分析

`Netfilter` 通过向内核协议栈中不同的位置注册 `钩子函数（Hooks）` 来对数据包进行过滤或者修改操作，这些位置称为 `挂载点`，主要有 5 个：`PRE_ROUTING`、`LOCAL_IN`、`FORWARD`、`LOCAL_OUT` 和 `POST_ROUTING`。 ![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/e52700e8fdb14362b6e6716bd679f193~tplv-k3u1fbpfcp-watermark.awebp?)

**挂载点解析：**

> - `PRE_ROUTING`：路由前。数据包进入IP层后，但还没有对数据包进行路由判定前。
> - `LOCAL_IN`：进入本地。对数据包进行路由判定后，如果数据包是发送给本地的，在上送数据包给上层协议前。
> - `FORWARD`：转发。对数据包进行路由判定后，如果数据包不是发送给本地的，在转发数据包出去前。
> - `LOCAL_OUT`：本地输出。对于输出的数据包，在没有对数据包进行路由判定前。
> - `POST_ROUTING`：路由后。对于输出的数据包，在对数据包进行路由判定后。

**路由判定：**

从上图可以看出，路由判定是数据流向的关键点。

> - 第一个路由判定通过查找输入数据包 `IP头部` 的目的 `IP地址` 是否为本机的 `IP地址`，如果是本机的 `IP地址`，说明数据是发送给本机的。否则说明数据包是发送给其他主机，经过本机只是进行中转。
> - 第二个路由判定根据输出数据包 `IP头部` 的目的 `IP地址` 从路由表中查找对应的路由信息，然后根据路由信息获取下一跳主机（或网关）的 `IP地址`，然后进行数据传输。

**数据包流向** 从图中可以看到，三个方向的数据包需要经过的钩子节点不完全相同：

> - 发往本地：**NF_INET_PRE_ROUTING**-->**NF_INET_LOCAL_IN**
> - 转发：**NF_INET_PRE_ROUTING**-->**NF_INET_FORWARD**-->**NF_INET_POST_ROUTING**
> - 本地发出：**NF_INET_LOCAL_OUT**-->**NF_INET_POST_ROUTING**

#### （3）挂载链表

通过向这些 `挂载点` 注册钩子函数，就能够对处于不同阶段的数据包进行过滤或者修改操作。由于钩子函数能够注册多个，所以内核使用链表来保存这些钩子函数。当数据包进入本地（`LOCAL_IN` 挂载点）时，就会相继调用`ipt_hook` 和 `fw_confirm` 钩子函数来处理数据包。另外，钩子函数还有优先级，优先级越小越先执行。正因为挂载点是通过链表来存储钩子函数，所以挂载点又被称为 `链`，挂载点对应的链名称如下所示：

- `LOCAL_IN` 挂载点：又称为 `INPUT链`。
- `LOCAL_OUT` 挂载点：又称为 `OUTPUT链`。
- `FORWARD` 挂载点：又称为 `PORWARD链`。
- `PRE_ROUTING` 挂载点：又称为 `PREROUTING链`。
- `POST_ROUTING` 挂载点：又称为 `POSTOUTING链`。

Netfilter 定义了 5 个常量来表示这 5 个位置，如下代码：

```c
// 文件：include/linux/netfilter_ipv4.h
#define NF_IP_PRE_ROUTING   0
#define NF_IP_LOCAL_IN      1
#define NF_IP_FORWARD       2
#define NF_IP_LOCAL_OUT     3
#define NF_IP_POST_ROUTING  4
复制代码
```

### 2.注册钩子函数：Register the hooks

注册和解注册钩子函数：Register the hooks

#### （1）注册和解注册钩子函数

kernel 提供如下函数来注册和解除hook函数.

```c
// include/linux/netfilter.h
/* Function to register/unregister hook points. */

int nf_register_hook(struct nf_hook_ops *reg);
void nf_unregister_hook(struct nf_hook_ops *reg);
int nf_register_hooks(struct nf_hook_ops *reg, unsigned int n);
void nf_unregister_hooks(struct nf_hook_ops *reg, unsigned int n);
复制代码
```

这些函数用于将自定义的钩子操作（struct nf_hook_ops）注册到指定的钩子节点中。

#### （2）钩子操作数据结构

其中结构如下: `nf_hook_ops`

```c
struct nf_hook_ops
{
        struct list_head list;

        /* User fills in from here down. */
        nf_hookfn *hook;
        struct module *owner;
        u_int8_t pf;
        unsigned int hooknum;
        /* Hooks are ordered in ascending priority. */
        int priority;
};
复制代码
```

这个结构体中存储了自定义的钩子函数（nf_hookfn），函数优先级（priority），处理协议类型（pf），钩子函数生效的钩子节点（hooknum）等信息。

#### （3）注册钩子函数

当定义好一个钩子函数结构后，需要调用 `nf_register_hook` 函数来将其注册到 `nf_hooks` 数组中，`nf_register_hook` 函数的实现如下：

```c
// 文件：net/core/netfilter.c

int nf_register_hook(struct nf_hook_ops *reg)
{    struct list_head *i;
    br_write_lock_bh(BR_NETPROTO_LOCK); 
    // 对 nf_hooks 进行上锁
    // priority 字段表示钩子函数的优先级    
    // 所以通过 priority 字段来找到钩子函数的合适位置    
    
    for (i = nf_hooks[reg->pf][reg->hooknum].next; i != &nf_hooks[reg->pf][reg->hooknum];i = i->next) 
    {
        if (reg->priority < ((struct nf_hook_ops *)i)->priority)
        break;
    }
    list_add(&reg->list, i->prev); // 把钩子函数添加到链表中
    br_write_unlock_bh(BR_NETPROTO_LOCK); // 对 nf_hooks 进行解锁
    return 0;
}
复制代码
```

`nf_register_hook` 函数的实现比较简单，步骤如下：

- 对 `nf_hooks` 进行上锁操作，用于保护 `nf_hooks` 变量不受并发竞争。
- 通过钩子函数的优先级来找到其在钩子函数链表中的正确位置。
- 把钩子函数插入到链表中。
- 对 `nf_hooks` 进行解锁操作。

### 3.声明钩子函数：hook functions

其中hook函数由 指定,其函数声明如下: `nf_hookfn *hook`

```c
// include/linux/netfilter.h

typedef unsigned int nf_hookfn(unsigned int hooknum,
                               struct sk_buff *skb,
                               const struct net_device *in,
                               const struct net_device *out,
                               int (*okfn)(struct sk_buff *));
复制代码
```

它返回如下结果之一:

```c
// <linux/netfilter.h>
#define NF_DROP 0
#define NF_ACCEPT 1
#define NF_STOLEN 2
#define NF_QUEUE 3
#define NF_REPEAT 4
#define NF_STOP 5
#define NF_MAX_VERDICT NF_STOP
复制代码
```

### 4.处理协议类型：pf

`pf` (protocol family) 是协议系列的标识符.

```
enum {
        NFPROTO_UNSPEC =  0,
        NFPROTO_IPV4   =  2,
        NFPROTO_ARP    =  3,
        NFPROTO_BRIDGE =  7,
        NFPROTO_IPV6   = 10,
        NFPROTO_DECNET = 12,
        NFPROTO_NUMPROTO,
};
复制代码
```

### 5.钩子标识：hooknum

钩子标识符，每个协议系列的所有有效标识符都在头文件中定义。

例如：
`<linux/netfilter_ipv4.h>`

```c
/* IP Hooks */
/* After promisc drops, checksum checks. */
#define NF_IP_PRE_ROUTING       0
/* If the packet is destined for this box. */
#define NF_IP_LOCAL_IN          1
/* If the packet is destined for another interface. */
#define NF_IP_FORWARD           2
/* Packets coming from a local process. */
#define NF_IP_LOCAL_OUT         3
/* Packets about to hit the wire. */
#define NF_IP_POST_ROUTING      4
#define NF_IP_NUMHOOKS          5
复制代码
```

### 6.钩子优先级：priority

钩子的优先级，每个协议系列的所有有效标识符都在头文件中定义。

例如：
`<linux/netfilter_ipv4.h>`

```c
enum nf_ip_hook_priorities {
        NF_IP_PRI_FIRST = INT_MIN,
        NF_IP_PRI_CONNTRACK_DEFRAG = -400,
        NF_IP_PRI_RAW = -300,
        NF_IP_PRI_SELINUX_FIRST = -225,
        NF_IP_PRI_CONNTRACK = -200,
        NF_IP_PRI_MANGLE = -150,
        NF_IP_PRI_NAT_DST = -100,
        NF_IP_PRI_FILTER = 0,
        NF_IP_PRI_SECURITY = 50,
        NF_IP_PRI_NAT_SRC = 100,
        NF_IP_PRI_SELINUX_LAST = 225,
        NF_IP_PRI_CONNTRACK_CONFIRM = INT_MAX,
        NF_IP_PRI_LAST = INT_MAX,
};
复制代码
enum {
        NFPROTO_UNSPEC =  0,
        NFPROTO_IPV4   =  2,
        NFPROTO_ARP    =  3,
        NFPROTO_BRIDGE =  7,
        NFPROTO_IPV6   = 10,
        NFPROTO_DECNET = 12,
        NFPROTO_NUMPROTO,
};
复制代码
```

### 7.触发调用钩子函数

钩子函数已经被保存到不同的链上，什么时候才会触发调用这些钩子函数来处理数据包？要触发调用某个挂载点上（链）的所有钩子函数，需要使用 `NF_HOOK` 宏来实现，其定义如下：

```c
// 文件：include/linux/netfilter.h

#define   NF_HOOK(pf, hook, skb, indev, outdev, okfn)  (list_empty(&nf_hooks[(pf)][(hook)]) ? (okfn)(skb) : nf_hook_slow((pf), (hook), (skb), (indev), (outdev), (okfn)))
复制代码
```

首先介绍一下 `NF_HOOK` 宏的各个参数的作用：

- `pf`：协议类型，就是 `nf_hooks` 数组的第一个维度，如 IPv4 协议就是 `PF_INET`。
- `hook`：要调用哪一条链（挂载点）上的钩子函数，如 `NF_IP_PRE_ROUTING`。
- `indev`：接收数据包的设备对象。
- `outdev`：发送数据包的设备对象。
- `okfn`：当链上的所有钩子函数都处理完成，将会调用此函数继续对数据包进行处理。

而 `NF_HOOK` 宏的实现也比较简单，首先判断一下钩子函数链表是否为空，如果是空的话，就直接调用 `okfn` 函数来处理数据包，否则就调用 `nf_hook_slow` 函数来处理数据包。我们来看看 `nf_hook_slow` 函数的实现：

```c
// 文件：net/core/netfilter.c

int nf_hook_slow(int pf, unsigned int hook, struct sk_buff *skb,
                 struct net_device *indev, struct net_device *outdev,
                 int (*okfn)(struct sk_buff *))
{
    struct list_head *elem;
    unsigned int verdict;
    int ret = 0;

    elem = &nf_hooks[pf][hook]; // 获取要调用的钩子函数链表

    // 遍历钩子函数链表，并且调用钩子函数对数据包进行处理
    verdict = nf_iterate(&nf_hooks[pf][hook], &skb, hook, indev, outdev, &elem, okfn);
    ...
    // 如果处理结果为 NF_ACCEPT, 表示数据包通过所有钩子函数的处理, 那么就调用 okfn 函数继续处理数据包
    // 如果处理结果为 NF_DROP, 表示数据包被拒绝, 应该丢弃此数据包
    switch (verdict) {
    case NF_ACCEPT:
        ret = okfn(skb);
        break;
    case NF_DROP:
        kfree_skb(skb);
        ret = -EPERM;
        break;
    }

    return ret;
}
复制代码
```

`nf_hook_slow` 函数的实现也比较简单，过程如下：

- 首先调用 `nf_iterate` 函数来遍历钩子函数链表，并调用链表上的钩子函数来处理数据包。
- 如果处理结果为 `NF_ACCEPT`，表示数据包通过所有钩子函数的处理, 那么就调用 `okfn` 函数继续处理数据包。
- 如果处理结果为 `NF_DROP`，表示数据包没有通过钩子函数的处理，应该丢弃此数据包。

既然 Netfilter 是通过调用 `NF_HOOK` 宏来调用钩子函数链表上的钩子函数，那么内核在什么地方调用这个宏呢？

比如数据包进入 IPv4 协议层的处理函数 `ip_rcv` 函数中就调用了 `NF_HOOK` 宏来处理数据包，代码如下：

```c
// 文件：net/ipv4/ip_input.c

int ip_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt)
{
    ...
    return NF_HOOK(PF_INET, NF_IP_PRE_ROUTING, skb, dev, NULL, ip_rcv_finish);
}
复制代码
```

如上代码所示，在 `ip_rcv` 函数中调用了 `NF_HOOK` 宏来处理输入的数据包，其调用的钩子函数链（挂载点）为 `NF_IP_PRE_ROUTING`。而 `okfn` 设置为 `ip_rcv_finish`，也就是说，当 `NF_IP_PRE_ROUTING` 链上的所有钩子函数都成功对数据包进行处理后，将会调用 `ip_rcv_finish` 函数来继续对数据包进行处理。

------

## 三、Netfilter应用案例

如下为在网络上找到的一个内核模块 Demo，该模块的基本功能是将经过 IPv4 网络层 NF_INET_LOCAL_IN 节点的数据包的源 Mac 地址，目的 Mac 地址以及源 IP，目的 IP 打印出来，[源码包下载](https://link.juejin.cn/?target=http%3A%2F%2Fwiki.dreamrunner.org%2Fpublic_html%2FLinux%2FNetworks%2FFiles%2Fnf_test_module.zip).`NF_INET_LOCAL_IN`

代码如下所示：

```c
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/types.h>
#include <linux/skbuff.h>
#include <linux/ip.h>
#include <linux/udp.h>
#include <linux/tcp.h>
#include <linux/netfilter.h>
#include <linux/netfilter_ipv4.h>


MODULE_LICENSE("GPLv3");
MODULE_AUTHOR("SHI");
MODULE_DESCRIPTION("Netfliter test");

static unsigned int
nf_test_in_hook(unsigned int hook, struct sk_buff *skb, const struct net_device *in,
                const struct net_device *out, int (*okfn)(struct sk_buff*));

static struct nf_hook_ops nf_test_ops[] __read_mostly = {
  {
    .hook = nf_test_in_hook,
    .owner = THIS_MODULE,
    .pf = NFPROTO_IPV4,
    .hooknum = NF_INET_LOCAL_IN,
    .priority = NF_IP_PRI_FIRST,
  },
};

void hdr_dump(struct ethhdr *ehdr) {
    printk("[MAC_DES:%x,%x,%x,%x,%x,%x" 
           "MAC_SRC: %x,%x,%x,%x,%x,%x Prot:%x]\n",
           ehdr->h_dest[0],ehdr->h_dest[1],ehdr->h_dest[2],ehdr->h_dest[3],
           ehdr->h_dest[4],ehdr->h_dest[5],ehdr->h_source[0],ehdr->h_source[1],
           ehdr->h_source[2],ehdr->h_source[3],ehdr->h_source[4],
           ehdr->h_source[5],ehdr->h_proto);
}

#define NIPQUAD(addr) \
        ((unsigned char *)&addr)[0], \
        ((unsigned char *)&addr)[1], \
        ((unsigned char *)&addr)[2], \
        ((unsigned char *)&addr)[3]
#define NIPQUAD_FMT "%u.%u.%u.%u"

static unsigned int
nf_test_in_hook(unsigned int hook, struct sk_buff *skb, const struct net_device *in,
                const struct net_device *out, int (*okfn)(struct sk_buff*)) {
  struct ethhdr *eth_header;
  struct iphdr *ip_header;
  eth_header = (struct ethhdr *)(skb_mac_header(skb));
  ip_header = (struct iphdr *)(skb_network_header(skb));
  hdr_dump(eth_header);
  printk("src IP:'"NIPQUAD_FMT"', dst IP:'"NIPQUAD_FMT"' \n",
         NIPQUAD(ip_header->saddr), NIPQUAD(ip_header->daddr));
  return NF_ACCEPT;
}

static int __init init_nf_test(void) {
  int ret;
  ret = nf_register_hooks(nf_test_ops, ARRAY_SIZE(nf_test_ops));
  if (ret < 0) {
    printk("register nf hook fail\n");
    return ret;
  }
  printk(KERN_NOTICE "register nf test hook\n");
  return 0;
}

static void __exit exit_nf_test(void) {
  nf_unregister_hooks(nf_test_ops, ARRAY_SIZE(nf_test_ops));
}

module_init(init_nf_test);
module_exit(exit_nf_test);
复制代码
```

`dmesg | tail` 后的结果:

```
[452013.507230] [MAC_DES:70,f3,95,e,42,faMAC_SRC: 0,f,fe,f6,7c,13 Prot:8]
[452013.507237] src IP:'10.6.124.55', dst IP:'10.6.124.54' 
[452013.944960] [MAC_DES:70,f3,95,e,42,faMAC_SRC: 0,f,fe,f6,7c,13 Prot:8]
[452013.944968] src IP:'10.6.124.55', dst IP:'10.6.124.54' 
[452014.960934] [MAC_DES:70,f3,95,e,42,faMAC_SRC: 0,f,fe,f6,7c,13 Prot:8]
[452014.960941] src IP:'10.6.124.55', dst IP:'10.6.124.54' 
[452015.476335] [MAC_DES:70,f3,95,e,42,faMAC_SRC: 0,f,fe,f6,7c,13 Prot:8]
[452015.476342] src IP:'10.6.124.55', dst IP:'10.6.124.54' 
[452016.023311] [MAC_DES:70,f3,95,e,42,faMAC_SRC: 0,f,fe,f6,7c,13 Prot:8]
[452016.023318] src IP:'10.6.124.55', dst IP:'10.6.124.54'
复制代码
```

这个 Demo 程序是个内核模块，模块入口为**module_init**传入的**init_nf_test**函数。

在**init_nf_test**函数中，其通过 Netfilter 提供的 **nf_register_hooks** 接口将自定义的**nf_test_opt**注册到钩子节点中。**nf_test_opt**为**struct nf_hook_ops**类型的结构体数组，其内部包含了所有关键元素，比如钩子函数的注册节点（此处为**NF_INET_LOCAL_IN**）以及钩子函数（**nf_test_in_hook**）。

在**nf_test_in_hook**函数内部，其检查每一个传递过来的数据包，并将其源 Mac 地址，目的 Mac 地址，源 IP 地址以及目的 IP 地址打印出来。最后返回**NF_ACCEPT**，将数据包交给下一个钩子函数处理。

------

## 四、Linux流量控制

Traffic Control HOWTO：大多利用Netfilter来实现流的控制.
比较详细的文档是 [Linux Advanced Routing & Traffic Control HOWTO](https://link.juejin.cn/?target=http%3A%2F%2Fwww.lartc.org%2Flartc.html%23LARTC.QDISC.TERMINOLOGY) 和缩简版的 [Traffic Control HOWTO](https://link.juejin.cn/?target=http%3A%2F%2Fwww.tldp.org%2FHOWTO%2Fhtml_single%2FTraffic-Control-HOWTO%2F).

------

## 五、扩展阅读

[Monitoring and Tuning the Linux Networking Stack: Sending Data](https://link.juejin.cn/?target=https%3A%2F%2Fpackagecloud.io%2Fblog%2Fmonitoring-tuning-linux-networking-stack-sending-data%2F)

[Linux Netfilter and Traffic Control](https://link.juejin.cn/?target=http%3A%2F%2Fwiki.dreamrunner.org%2Fpublic_html%2FLinux%2FNetworks%2Fnetfilter.html)

[Netfilter](https://link.juejin.cn/?target=http%3A%2F%2Fwww.netfilter.org%2Findex.html) and [iptables](https://link.juejin.cn/?target=http%3A%2F%2Fwww.netfilter.org%2Fprojects%2Fiptables%2Findex.html) homepage

[图解 Linux 网络包发送过程](https://link.juejin.cn/?target=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F373060740)

[网络基础--七层模型](https://link.juejin.cn/?target=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F64959180)

[OSI七层模型与TCP/IP五层模型](https://link.juejin.cn/?target=https%3A%2F%2Fwww.cnblogs.com%2Fqishui%2Fp%2F5428938.html)

[Linux 网络层收发包流程及 Netfilter 框架浅析](https://link.juejin.cn/?target=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F93630586)

[Netfilter & iptables 原理](https://link.juejin.cn/?target=https%3A%2F%2Fmp.weixin.qq.com%2Fs%2F7PGkF4q0nCp6LhvZMUaMcw)

[Netfileter & iptables 实现（一）— Netfilter实现](https://link.juejin.cn/?target=https%3A%2F%2Fmp.weixin.qq.com%2Fs%2F3Os9elb_TBSN9ofRveihDg)

文章分类

后端

文章标签



Linux



后端