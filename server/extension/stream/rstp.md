# stream protocol


## base
### stream
流（Streaming）是近年在Internet上出现的新概念，其定义非常广泛，主要是指通过网络传输多媒体数据的技术总称。

流式传输分为两种

顺序流式传输 (Progressive Streaming)
实时流式传输 (Real time Streaming)


实时流式传输是实时传送，特别适合现场事件。“实时”（real time）是指在一个应用中数据的交付必须与数据的产生保持精确的时间关系，这需要相应的协议支持，这样RTP和RTCP就相应的出现了

## RTSP group

### RTSP
RTSP（Real Time Streaming Protocol），RFC2326，实时流传输协议，是TCP/IP协议体系中的一个应用层协议，由哥伦比亚大学、网景和RealNetworks公司提交的IETF RFC标准。该协议定义了一对多应用程序如何有效地通过IP网络传送多媒体数据。RTSP在体系结构上位于RTP和RTCP之上，它使用TCP或UDP完成数据传输。


参考文档 RFC2326

是由Real Networks和Netscape共同提出的。该协议定义了一对多应用程序如何有效地通过IP网络传送多媒体数据。RTSP提供了一个可扩展框架，使实时数据，如音频与视频的受控、点播成为可能。数据源包括现场数据与存储在剪辑中的数据。该协议目的在于控制多个数据发送连接，为选择发送通道，如UDP、多播UDP与TCP提供途径，并为选择基于RTP上发送机制提供方法。

RTSP（Real Time Streaming Protocol）是用来控制声音或影像的多媒体串流协议，并允许同时多个串流需求控制，传输时所用的网络通讯协定并不在其定义的范围内，服务器端可以自行选择使用TCP或UDP来传送串流内容，它的语法和运作跟HTTP 1.1类似，但并不特别强调时间同步，所以比较能容忍网络延迟。而前面提到的允许同时多个串流需求控制（Multicast），除了可以降低服务器端的网络用量，更进而支持多方视讯会议（Video Conference）。 因为与HTTP1.1的运作方式相似，所以代理服务器《Proxy》的快取功能《Cache》也同样适用于RTSP，并因RTSP具有重新导向功能，可视实际负载情况来转换提供服务的服务器，以避免过大的负载集中于同一服务器而造成延迟。

### RTP
Real-time Transport Protocol或简写RTP，它是由IETF的多媒体传输工作小组1996年在RFC 1889中公布的。RTP协议详细说明了在互联网上传递音频和视频的标准数据包格式。它是创建在UDP协议上的。
### RTCP
Real-time Transport Control Protocol或RTP Control Protocol或简写RTCP）是实时传输协议（RTP）的一个姐妹协议。RTCP由RFC 3550定义（取代作废的RFC 1889）。RTP 使用一个 偶数 UDP port ；而RTCP 则使用 RTP 的下一个 port，也就是一个奇数 port。RTCP与RTP联合工作，RTP实施实际数据的传输，RTCP则负责将控制包送至电话中的每个人。其主要功能是就RTP正在提供的服务质量做出反馈。

### RSVP
资源预留协议RSVP(Resource Reserve Protocol)

### SRTP
参考文档 RFC3711
安全实时传输协议（Secure Real-time Transport Protocol或SRTP）是在实时传输协议（Real-time Transport Protocol或RTP）基础上所定义的一个协议，旨在为单播和多播应用程序中的实时传输协议的数据提供加密、消息认证、完整性保证和重放保护。它是由David Oran（思科）和Rolf Blom（爱立信）开发的，并最早由IETF于2004年3月作为RFC3711发布。
### SRTCP
由于实时传输协议和可以被用来控制实时传输协议的会话的实时传输控制协议（RTP Control Protocol或RTCP）有着紧密的联系，安全实时传输协议同样也有一个伴生协议，它被称为安全实时传输控制协议（Secure RTCP或SRTCP）；安全实时传输控制协议为实时传输控制协议提供类似的与安全有关的特性，就像安全实时传输协议为实时传输协议提供的那些一样。

在使用实时传输协议或实时传输控制协议时，使不使用安全实时传输协议或安全实时传输控制协议是可选的；但即使使用了安全实时传输协议或安全实时传输控制协议，所有它们提供的特性（如加密和认证）也都是可选的，这些特性可以被独立地使用或禁用。唯一的例外是在使用安全实时传输控制协议时，必须要用到其消息认证特性。


### SIP
SIP（Session Initiation Protocol，会话初始协议）是由IETF（Internet Engineering Task Force，因特网工程任务组）制定的多媒体通信协议。

它是一个基于文本的应用层控制协议，用于创建、修改和释放一个或多个参与者的会话。SIP 是一种源于互联网的IP 语音会话控制协议，具有灵活、易于实现、便于扩展等特点。SIP协议用于两个或多个端点之间的互联网电话和多媒体分发。例如，一个人可以使用SIP发起对另一个人的电话呼叫，或者有人可以与许多参与者建立电话会议。SIP协议的设计非常简单，配置有限的命令。它也是基于文本的，所以任何人都可以读取SIP会话中的端点之间传递的SIP消息。

有一些实体帮助SIP创建其网络。在SIP中，每个网元由SIP URI（统一资源标识符）来标识，它像一个地址。以下是网络元素

* 用户代理
* 代理服务器
* 注册服务器
* 重定向服务器
* 位置服务器

### SDP
SDP协议
SDP（Session Description Protocol）是一个用来描述多媒体会话的应用层控制协议，它是一个基于文本的协议，用于会话建立过程中的媒体类型和编码方案的协商等。


### RTCP流程
SIP SDP RTSP RTP RTCP，就像他们出现的顺序一样，他们在实际应用中的启用也是这个顺序： SIP（一般基于tcp）用于设备或用户(准确的说是 Internet endpoints)地址管理、设备发现并初始化一个Session，并负责传输SDP包；而SDP(是一个资源描述协议，与传输无关，大多数时候只能包含到其它协议中作为资源描述，更像是一个规范)包中描述了一个Session中包含哪些媒体数据，邀请的人等等；当需要被邀请的人都通过各自的终端设备被通知到后，就可以使用RTSP(串流协议，一般基于tcp传送，主要作用是使用sdp来描述流而非设备的信息)来控制特定Media的通信; 最后，若RTSP控制信息要求开始Video的播放，那么就开始使用 RTP（或者TCP）实时传输数据，


## RTMP Group
### RTMP 
RTMP(Real Time Messaging Protocol)实时消息传送协议是Adobe Systems公司为Flash播放器和服务器之间音频、视频和数据传输 开发的开放协议。
它有三种变种：

1. 工作在TCP之上的明文协议，使用端口1935；
2. RTMPT封装在HTTP请求之中，可穿越防火墙；
3. RTMPS类似RTMPT，但使用的是HTTPS连接；
 

RTMP协议(Real Time Messaging Protocol)是被Flash用于对象,视频,音频的传输.这个协议建立在TCP协议或者轮询HTTP协议之上.

RTMP协议就像一个用来装数据包的容器,这些数据既可以是AMF格式的数据,也可以是FLV中的视/音频数据.一个单一的连接可以通过不同的通道传输多路网络流.这些通道中的包都是按照固定大小的包传输的.
### RTMPT
### RTMPS

## MMS
MMS (Microsoft Media Server Protocol)，中文“微软媒体服务器协议”，用来访问并流式接收 Windows Media 服务器中 .asf 文件的一种协议。MMS 协议用于访问 Windows Media 发布点上的单播内容。MMS 是连接 Windows Media 单播服务的默认方法。若观众在 Windows Media Player 中键入一个 URL 以连接内容，而不是通过超级链接访问内容，则他们必须使用MMS 协议引用该流。MMS的预设埠（端口）是1755

当使用 MMS 协议连接到发布点时，使用协议翻转以获得最佳连接。“协议翻转”始于试图通过 MMSU 连接客户端。 MMSU 是 MMS 协议结合 UDP 数据传送。如果 MMSU 连接不成功，则服务器试图使用 MMST。MMST 是 MMS 协议结合 TCP 数据传送。

如果连接到编入索引的 .asf 文件，想要快进、后退、暂停、开始和停止流，则必须使用 MMS。不能用 UNC 路径快进或后退。若您从独立的 Windows Media Player 连接到发布点，则必须指定单播内容的 URL。若内容在主发布点点播发布，则 URL 由服务器名和 .asf 文件名组成。例如：mms://windows_media_server/sample.asf。其中 windows_media_server 是 Windows Media 服务器名，sample.asf 是您想要使之转化为流的  .asf 文件名。

若您有实时内容要通过广播单播发布，则该 URL 由服务器名和发布点别名组成。例如：mms://windows_media_server/LiveEvents。这里 windows_media_server 是 Windows Media 服务器名，而 LiveEvents 是发布点名

## HLS
HTTP Live Streaming（HLS）是苹果公司(Apple Inc.)实现的基于HTTP的流媒体传输协议，可实现流媒体的直播和点播，主要应用在iOS系统，为iOS设备（如iPhone、iPad）提供音视频直播和点播方案。HLS点播，基本上就是常见的分段HTTP点播，不同在于，它的分段非常小。

相对于常见的流媒体直播协议，例如RTMP协议、RTSP协议、MMS协议等，HLS直播最大的不同在于，直播客户端获取到的，并不是一个完整的数据流。HLS协议在服务器端将直播数据流存储为连续的、很短时长的媒体文件（MPEG-TS格式），而客户端则不断的下载并播放这些小文件，因为服务器端总是会将最新的直播数据生成新的小文件，这样客户端只要不停的按顺序播放从服务器获取到的文件，就实现了直播。由此可见，基本上可以认为，HLS是以点播的技术方式来实现直播。由于数据通过HTTP协议传输，所以完全不用考虑防火墙或者代理的问题，而且分段文件的时长很短，客户端可以很快的选择和切换码率，以适应不同带宽条件下的播放。不过HLS的这种技术特点，决定了它的延迟一般总是会高于普通的流媒体直播协议。　