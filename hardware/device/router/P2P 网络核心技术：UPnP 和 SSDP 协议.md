# P2P 网络核心技术：UPnP 和 SSDP 协议

[juniway](https://www.zhihu.com/people/juniway)

微信公众号：知辉（ID：deliverit）

72 人赞同了该文章

## **背景知识**

UPnP， Universal Plug and Play，中文是 “通用即插即用”。在理解 UPnP 之前，我们先了解一下传统的 PnP 技术，因为 UPnP 是对于传统 PnP（即插即用）概念的扩展。

传统的 PnP **“即插即用”**是指 PC 电脑在添加硬件设备时可以自动处理的一种标准。在 PnP 技术出现以前，当需要为 PC 电脑安装新的硬件（比如：声卡，CD-ROM，打印机）时，这些设备需要用到 PC 电脑的 DMA 和 IRQ 等资源，为了避免硬件设备对计算机这些资源使用上的冲突，我们就需要**手工为新添加的硬件设备设置中断和 I/O 端口**（比如，想要为添加的声卡占用中断 5，就找一个小跳线在卡上标着中断 5的针脚上一插）。这样的操作需要用户了解中断和 I/O 端口的知识，并且能够自己分配中断地址而不发生冲突，对普通用户提出这样的要求是不切实际的。

PnP “即插即用”技术出现以后，可以**自动为新添加的硬件分配中断和 I/O 端口，用户无须再做手工跳线，也不必使用软件配置程序**。唯一的要求就是操作系统需要支持 PnP 标准，同时所安装的新硬件也符合 PnP 规范的。

## **UPnP 协议介绍**

现在我们讲 UPnP，在网络世界里，**当一个主机加入网络时，其行为模式跟我们上述的添加和删除设备是类似的。**尤其是在私有网络和公网交互的时候，私有网络中的主机使用的是内网 IP 地址，是无法被外网的主机直接访问的。必须借助 NAT 网关设备（本地路由器）把内网地址映射到网关的公网地址上。

简单来说就是， NAT 网关设备拥有一个公网 IP 地址（比如 10.59.116.19），内网中的主机（比如 192.168.1.101）想要与外界通信的话，NAT 网关设备可以为其做一个端口映射（比如：180.59.116.19 :80 —> 192.168.1.101 :80），这样，外部的主机发往 NAT 网关的数据包都会被转发给内网的该主机，从而实现了内网中的主机与外部主机的通信。

![img](https://pic1.zhimg.com/80/v2-b9a7c969540269a0f1243ad02487c084_1440w.jpg)



当内网中的主机想要被外界主机直接访问（比如开放 80 端口，对外提供 HTTP 服务），我们就需要在 NAT 设备中为当前主机手工配置端口映射，如果内网中有多台主机都想要被外界主机直接访问的话，我们必须在同一个 NAT 设备上为这些主机分别做端口映射，它们之间不能使用有冲突的端口。这个过程需要用户手工一一配置，显然给用户带来了很大的麻烦。

![img](https://pic1.zhimg.com/80/v2-c0bea083aa0415c42042f7fe60506640_1440w.jpg)



UPnP 技术标准的出现就是为了解决这个问题，只要 NAT 设备（路由器）支持 UPnP，并开启。那么，当我们的主机（或主机上的应用程序）向 NAT 设备发出端口映射请求的时候，**NAT 设备就可以自动为主机分配端口并进行端口映射**。这样，我们的主机就能够像公网主机一样被网络中任何主机访问了。

## **UPnP 的应用场景**

UPnP 典型的应用场景就是家庭智能设备的互联，还有，目前在网络应用比如 BitTorrent, eMule，IPFS，Ethereum 等使用 P2P 技术的软件，UPnP 功能为它们带来极大的便利。比如：利用 UPnP 能自动的把它们侦听的端口号映射到公网地址上，这样，公网上的用户也能对当前的 NAT 内网主机直接发起连接。

实现 UPnP 必须同时满足三个条件：

- NAT 网关设备必须支持 UPnP 功能；这是因为它需要扮演控制点（239.255.255.250:1900）的角色，控制点提供的是 SSDP 服务。
- 操作系统必须支持 UPnP 功能；比如 Windows 系列操作系统；
- 应用程序必须支持 UPnP 功能；比如 Bt、eMule、IPFS, Ethereum 等。

以上三个条件必须同时满足，缺一不可。

**注：**大多数路由器都是支持 UPnP 的，有的是默认开启，有的需要手工开启。

![img](https://pic3.zhimg.com/80/v2-0640425d49c52e1aa83870111a608cb2_1440w.jpg)

## UPnP 这么好，那么我们应该立即开启吗？

非也，如果我们的电脑并不需要 UPnP 所提供的功能，比如，我们的电脑并不想要对外直接提供服务，也不运行上述 P2P 软件，那么我们就无需开启 UPnP。因为一旦开启 UPnP，就意味着我们把自己的主机暴露在公网环境中，任何主机都可以向我们的电脑发起连接，NAT 设备会对所有收到的数据包不进行任何 authentication 认证而转发给我们的主机，这样，路由防火墙就会完全失效，我们的主机就很容易受到恶意的网络窥探，感染病毒或者恶意程序的几率也大大增加。

**注：**上述 NAT 设备通常就是指我们本地的路由器。



## **SSDP 协议**

介绍完了 UPnP 的概况，为了完整性，现在再介绍一下 UPnP 规范下的 SSDP 协议，SSDP 全称是 Simple Service Discover Protocol 简单服务发现协议，这个协议是 UPnP 的核心，在 UPnP 中定义了一组协议框架，其中有控制点，根设备等概念，UPnP 设备通过 SSDP 协议与根设备（用户设备）进行交互。SSDP 是应用层协议，使用 HTTPU 和 HTTPMU 规范，基于 UDP 端口进行通信。

SSDP 使用一个固定的组播地址 `239.255.255.250` 和 UDP 端口号 `1900` 来监听其他设备的请求。

SSDP 协议的请求消息有两种类型，第一种是服务通知，设备和服务使用此类通知消息声明自己存在；第二种是查询请求，协议客户端用此请求查询某种类型的设备和服务。

## **1）设备查询**

当一个客户端接入网络的时候，它可以向一个特定的多播地址的 SSDP 端口使用 `M-SEARCH` 方法发送 “ssdp:discover” 消息。当设备监听到这个保留的多播地址上由控制点发送的消息的时候，设备将通过单播的方式直接响应控制点的请求。

典型的设备查询请求消息格式：

```bash
M-SEARCH * HTTP/1.1
S:uuid:ijklmnop-7dec-11d0-a765-00a0c91e6bf6
Host:239.255.255.250:1900
Man:"ssdp:discover"ST:ge:fridge
MX:3
```



**响应消息**

响应消息应该包含服务的位置信息（Location 或AL头），ST和USN头。响应消息应该包含cache控制信息（max-age 或者 Expires头）。

典型的响应消息格式：

```js
HTTP/1.1 200 OK
Cache-Control: max-age= seconds until advertisement expires
S: uuid:ijklmnop-7dec-11d0-a765-00a0c91e6bf6
Location: URL for UPnP description for root device
Cache-Control: no-cache="Ext",max-age=5000ST:ge:fridge // search targetUSN: uuid:abcdefgh-7dec-11d0-a765-00a0c91e6bf6 // advertisement UUIDAL: <blender:ixl><http://foo/bar>
```

## **2、设备通知消息**

在设备加入网络时，它应当向一个特定的多播地址的 SSDP 端口使用 NOTIFY 方法发送 “ssdp:alive” 消息，以便宣布自己的存在，更新期限信息，更新位置信息。

## （1）ssdp:alive 消息

由于 UDP 协议是不可信的，设备应该定期发送它的公告消息。在设备加入网络时，它必须用 NOTIFY 方法发送一个多播传送请求。NOTIFY 方法发送的请求没有回应消息。

典型的设备通知消息格式如下：

```text
NOTIFY * HTTP/1.1HOST: 239.255.255.250:1900CACHE-CONTROL: max-age = seconds until advertisement expiresLOCATION: URL for UPnP description for root deviceNT: search targetNTS: ssdp:aliveUSN: advertisement UUID
```

## （2）ssdp:byebye消息

当一个设备计划从网络上卸载的时候，它也应当向一个特定的多播地址的 SSDP 端口使用 NOTIFY 方法发送 “ssdp:byebye” 消息。但是，即使没有发送 “ssdp:byebye” 消息，控制点也会根据 “ssdp:alive” 消息指定的超时值，将超时并且没有再次收到的 “ssdp:alive” 消息对应的设备认为是失效的设备。

典型的设备卸载消息格式如下：

```text
NOTIFY * HTTP/1.1
HOST: 239.255.255.250:1900NT: search target
NTS: ssdp:byebye
USN: advertisement UUID
```



全文完！



参考资料：
1、SSDP 协议原文：[http://tools.ietf.org/html/draft-cai-ssdp-v1-03](https://link.zhihu.com/?target=http%3A//tools.ietf.org/html/draft-cai-ssdp-v1-03)
2、UPnP协议框架：[http://www.upnp.org/specs/arch/UPnP-arch-DeviceArchitecture-v1.0.pdf](https://link.zhihu.com/?target=http%3A//www.upnp.org/specs/arch/UPnP-arch-DeviceArchitecture-v1.0.pdf)



编辑于 2018-07-23

[P2P](https://www.zhihu.com/topic/19557216)

[对等网络（P2P）](https://www.zhihu.com/topic/19665362)

[区块链(Blockchain)](https://www.zhihu.com/topic/19901773)