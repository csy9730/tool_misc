# mtu

[同义词](https://baike.baidu.com/subview/71844/10028254.htm) mtu一般指最大传输单元

本词条由[“科普中国”科学百科词条编写与应用工作项目](https://baike.baidu.com/science) 审核 。

最大传输单元（Maximum Transmission Unit，MTU）用来通知对方所能接受[数据服务](https://baike.baidu.com/item/数据服务/23724818)[单元](https://baike.baidu.com/item/单元/32922)的最大尺寸，说明发送方能够接受的[有效载荷](https://baike.baidu.com/item/有效载荷/3653893)大小。 [1] 

是包或帧的最大长度，一般以[字节](https://baike.baidu.com/item/字节/1096318)记。如果MTU过大，在碰到路由器时会被拒绝转发，因为它不能处理过大的包。如果太小，因为协议一定要在包(或帧)上加上包头，那实际传送的数据量就会过小，这样也划不来。大部分操作系统会提供给用户一个默认值，该值一般对用户是比较合适的。 [2] 

- 中文名

  最大传输单元

- 外文名

  Maximum Transmission Unit

- 英文缩写

  MTU

## 目录

1. 1 [简介](https://baike.baidu.com/item/最大传输单元/9730690?fromtitle=mtu&fromid=508920#1)
2. 2 [MTU字节](https://baike.baidu.com/item/最大传输单元/9730690?fromtitle=mtu&fromid=508920#2)
3. 3 [用途](https://baike.baidu.com/item/最大传输单元/9730690?fromtitle=mtu&fromid=508920#3)
4. 4 [IP分片与重组](https://baike.baidu.com/item/最大传输单元/9730690?fromtitle=mtu&fromid=508920#4)

## 简介

[编辑](javascript:;)[ 语音](javascript:;)

[以太网](https://baike.baidu.com/item/以太网/99684)和802.3对数据帧的长度都有一个限制，其最大值分别是1500[字节](https://baike.baidu.com/item/字节/1096318)和1492字节。链路层的这个特性称为MTU，即最大传输单元。不同类型网络的数帧长度大多数都有一个上限。如果IP层有一个数据报要传，而且数据帧的长度比链路层的MTU还大，那么IP层就需要进行[分片](https://baike.baidu.com/item/分片/13677994)( fragmentation)，即把数据报分成干片，这样每一片就都小于MTU。 [3] 

当同一个网络上的两台主机互相进行通信时，该网络的MTU是非常重要。但是如果两台主机之间的通信要通过多个网络，每个网络的链路层可能有不同的MTU，那么这时重要的不是两台主机所在网络的MTU的值，而是两台主机通信路径中的最小MTU，称为路径MTU( Path mtu，PMTU)。 [3] 

两台主机之间的PMTU不一定是个常数，它取决于当时所选择的路径，而且[路由](https://baike.baidu.com/item/路由/363497)选择也不一定是对称的(从A到B的路由可能与从B到A的路由不同)，因此，[PMTU](https://baike.baidu.com/item/PMTU/1963207)在两个方向上不一定是一致的。 [3] 

RFC1191描述了PMTU的发现机制，即确定路径MTU的方法。ICMP的不可到达错误采用的就是这种方法， traceroute程序也是用这种方法来确定到达目的节点的PMT的。 [3] 

## MTU字节

[编辑](javascript:;)[ 语音](javascript:;)

在远端节点的配置响应中将包含在该信道使用的实际的MTU大小，信道的方向是流向本地节点，MTU值取在configReq中的MTU和远端节点的输出MTU能力中最小值。该MTU只能用于这个信道，不能用于相反方向的信道。 [4] 

MTU[字段](https://baike.baidu.com/item/字段/2885972)：2个字节。 [4] 

MTU字段表示发起请求方可以接受的最大的L2CAP分组净荷(按字节计)。MTU是非对称的，请求的发送方指定在该信道上它可以接收的MTU值。L2CAP的实现必须支持最小的48字节的MTU值。缺省值是672字节。 [4] 

## 用途

[编辑](javascript:;)[ 语音](javascript:;)

MTU是网络调节的重要因素，因为包中的额外开销量相当高。高的MTU减少了头信息浪费的字节数。对大量数据传输尤其重要，而对小于MTU的传输没有影响。因此，注意配置传输大量数据流的服务器(如文件服务器和FTPH&．务器)上的MTU。 [5] 

选择MTU时，规则是选择传输中不需分段的最大MTU。如果网络使用一种媒体类型，缺省的设置就可以。选择比媒体最大值更小的MTU并没有好处，整个数据报会因为每个包的错误而重发。换言之，不能重发单个段。 [5] 

## IP分片与重组

[编辑](javascript:;)[ 语音](javascript:;)

数据链路不同，最大传输单元( Maximum transmission Unit，MTU)也不同，由于IP协议是数据链路的上一层，所以它必须不受数据链路的MTU大小的影响能够加以利用。当[IP数据报](https://baike.baidu.com/item/IP数据报/1581132)太大时，就要采用分片技术，以保证数据帧不大于要过的网络的MTU。 [3] 

IP协议除了具有路由寻址功能外，另一个重要的功能就是IP数据报的分片处理。每个[数据链路层](https://baike.baidu.com/item/数据链路层/4329290)能够确定发送的一个帧的最大长度称为最大传输单元。在Ethernet中，MTU为1500字节;在FDDI中，MTU为4352字节;在 IP over ATM中，MTU为9180字节。 [3] 

如果要发送的IP数据报比数据链路层的MTU大，则无法发送该数据报。对于来自于上一层的IP协议，当要求发送的IP数据报比数据链路层的MTU大时，必把该数据报分割成多个IP数据报才能发送。另外，在进行通信的各台主机之间，存在着MTU不同的数据链路;在发送的过程中，也有MTU缩小的情况发生。当出现上述情况时，在发送过程中必须有一台能够进行分片处理的路由器。 [3] 

接收端主机必须对经过分片处理后的IP数据报进行还原处理。在[中继路由器](https://baike.baidu.com/item/中继路由器/14489697)中，虽然路由器进行了分片处理，但并不进行还原处理。另外，经分片处理的IP数据报只有经过还原处理后才能还原成原来的IP数据报，才可以向上一层的模块传递数据。 [3]