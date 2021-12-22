# SRS、EasyDarwin、ZLMediaKit、Monibuca对比分析

2021-02-08阅读 4.2K0



**目录**

[前言](https://cloud.tencent.com/developer/article/write?from=10680#%E5%89%8D%E8%A8%80)

[正文](https://cloud.tencent.com/developer/article/write?from=10680#%E6%AD%A3%E6%96%87)

[SRS](https://cloud.tencent.com/developer/article/write?from=10680#SRS)

​    [使用步骤](https://cloud.tencent.com/developer/article/write?from=10680#%E4%BD%BF%E7%94%A8%E6%AD%A5%E9%AA%A4)

​    [主要功能](https://cloud.tencent.com/developer/article/write?from=10680#%E4%B8%BB%E8%A6%81%E5%8A%9F%E8%83%BD)

[EasyDarwin](https://cloud.tencent.com/developer/article/write?from=10680#EasyDarwin)

​    [使用步骤](https://cloud.tencent.com/developer/article/write?from=10680#%E4%BD%BF%E7%94%A8%E6%AD%A5%E9%AA%A4)

​    [主要功能 ](https://cloud.tencent.com/developer/article/write?from=10680#%E4%B8%BB%E8%A6%81%E5%8A%9F%E8%83%BD%C2%A0)

[ZLMediaKit](https://cloud.tencent.com/developer/article/write?from=10680#ZLMediaKit)

​    [使用步骤](https://cloud.tencent.com/developer/article/write?from=10680#%E4%BD%BF%E7%94%A8%E6%AD%A5%E9%AA%A4)

​    [主要功能](https://cloud.tencent.com/developer/article/write?from=10680#%E4%B8%BB%E8%A6%81%E5%8A%9F%E8%83%BD)

[Monibuca](https://cloud.tencent.com/developer/article/write?from=10680#Monibuca)

​    [使用步骤](https://cloud.tencent.com/developer/article/write?from=10680#%E4%BD%BF%E7%94%A8%E6%AD%A5%E9%AA%A4)

​    [主要功能](https://cloud.tencent.com/developer/article/write?from=10680#%E4%B8%BB%E8%A6%81%E5%8A%9F%E8%83%BD)

[结尾](https://cloud.tencent.com/developer/article/write?from=10680#%E7%BB%93%E5%B0%BE)

[对比图表 ](https://cloud.tencent.com/developer/article/write?from=10680#%E5%AF%B9%E6%AF%94%E5%9B%BE%E8%A1%A8%C2%A0)

------

## 前言

目前市面上有很多开源的流媒体服务器解决方案，常见的有SRS、EasyDarwin、ZLMediaKit和Monibuca等，我们应该怎么选择呢？

## 正文

今天这篇文章主要介绍SRS、EasyDarwin、ZLMediaKit和Monibuca的一些对比情况，可以作为日后调研选型的参考文档。

## SRS

**SRS**目前已经更新到3.0，功能和稳定性较之前的版本都有非常大的提升，新入门的同学可以考虑直接从3.0上手。接下来，我们从使用、配置、功能几个方面介绍SRS。

### 使用步骤

我们自己可以非常方便的搭建一套SRS服务器，具体的配置步骤如下：

\1. 获取源码

地址：<https://github.com/ossrs/srs>

具体命令如下：

> git clone https://gitee.com/winlinvip/srs.oschina.git srs && cd srs/trunk && git remote set-url origin https://github.com/ossrs/srs.git && git pull

\2. 编译

> ./configure && make 

其中，configure文件是支持可配置的。 

\3. 运行

> ./objs/srs -c conf/srs.conf 

其中，srs.conf文件是支持可配置的，针对不同功能模块，还有单独对应的配置文件。比如，rtmp模块对应的配置文件是rtmp.conf。

另外，我们还可以直接运行现有的docker镜像，命令：

> docker run -p 1935:1935 -p 1985:1985 -p 8080:8080 registry.cn-hangzhou.aliyuncs.com/ossrs/srs:3

### 主要功能

SRS作为当前非常普遍的运营级解决方案，具备非常全面的功能，包括集群、协议网关、CDN功能等，主要功能如下：

\1. SRS定位是运营级的互联网直播服务器集群，追求更好的概念完整性和最简单实现的代码。

\2. SRS提供了丰富的接入方案将RTMP流接入SRS， 包括推送RTMP到SRS、推送RTSP/UDP/FLV到SRS、拉取流到SRS。 SRS还支持将接入的RTMP流进行各种变换，譬如将RTMP流转码、流截图、 转发给其他服务器、转封装成HTTP-FLV流、转封装成HLS、 转封装成HDS、转封装成DASH、录制成FLV/MP4。

\3. SRS包含支大规模集群如CDN业务的关键特性， 譬如RTMP多级集群、源站集群、VHOST虚拟服务器 、 无中断服务Reload、HTTP-FLV集群。

\4. SRS还提供丰富的应用接口， 包括HTTP回调、安全策略Security、HTTP API接口、 RTMP测速。

\5. SRS在源站和CDN集群中都得到了广泛的应用Applications。

## EasyDarwin

**EasyDarwin**是由国内开源流媒体团队维护和迭代的一整套开源流媒体视频平台框架，Golang开发，从2012年12月创建并发展至今，包含有单点服务的开源流媒体服务器，和扩展后的流媒体云平台架构的开源框架，开辟了诸多的优质开源项目，能更好地帮助广大流媒体开发者和创业型企业快速构建流媒体服务平台，更快、更简单地实现最新的移动互联网(安卓、iOS、H5、微信)流媒体直播与点播的需求，尤其是安防行业与互联网行业的衔接。

### 使用步骤

运行EasyDarwin也非常方便，具体的配置步骤如下：

\1. 获取源码

地址：<https://github.com/EasyDarwin/EasyDarwin>

具体命令如下：

> mkdir EasyDarwin && cd EasyDarwin git clone https://github.com/EasyDarwin/EasyDarwin.git --depth=1 EasyDarwin

\2. 以开发模式运行

> npm run dev 

\3. 以开发模式运行前端

>  npm run dev:www

### 主要功能 

\1. 基于Golang语言开发维护。

\2. 支持Windows、Linux、macOS三大系统平台部署。

\3. 支持RTSP推流分发（推模式转发）。

\4. 支持RTSP拉流分发（拉模式转发）。

\5. 服务端录像、检索、回放。

\6. 支持关键帧缓存、秒开画面。

\7. Web后台管理。

\8. 分布式负载均衡。

## ZLMediaKit

**ZLMediaKit**是一套高性能的流媒体服务框架，目前支持rtmp、rtsp、hls、http-flv等流媒体协议，支持linux、macos、windows三大PC平台和ios、android两大移动端平台。

### 使用步骤

\1. 获取源码。

地址：<https://github.com/xia-chu/ZLMediaKit>

具体命令如下：

> \#国内用户推荐从同步镜像网站gitee下载  git clone --depth 1 https://gitee.com/xia-chu/ZLMediaKit cd ZLMediaKit #千万不要忘记执行这句命令 git submodule update --init

\2. 编译（这里以linux和mac OS系统为例）

> cd ZLMediaKit mkdir build cd build #macOS下可能需要这样指定openss路径：cmake .. -DOPENSSL_ROOT_DIR=/usr/local/Cellar/openssl/1.0.2j/ cmake .. make -j4

\3. 运行

> cd ZLMediaKit/release/linux/Debug #通过-h可以了解启动参数 ./MediaServer -h #以守护进程模式启动 ./MediaServer -d &

### 主要功能

\1. 基于C++11开发，避免使用裸指针，代码稳定可靠，性能优越。

\2. 支持多种协议(RTSP/RTMP/HLS/HTTP-FLV/WebSocket-FLV/GB28181/HTTP-TS/WebSocket-TS/HTTP-fMP4/WebSocket-fMP4/MP4),支持协议互转。

\3. 使用多路复用/多线程/异步网络IO模式开发，并发性能优越，支持海量客户端连接。

\4. 代码经过长期大量的稳定性、性能测试，已经在线上商用验证已久。

\5. 支持linux、macos、ios、android、windows全平台。

\6. 支持画面秒开、极低延时(500毫秒内，最低可达100毫秒)。

\7. 提供完善的标准C API,可以作SDK用，或供其他语言调用。

\8. 提供完整的MediaServer服务器，可以免开发直接部署为商用服务器。

\9. 提供完善的restful api以及web hook，支持丰富的业务逻辑。

\10. 打通了视频监控协议栈与直播协议栈，对RTSP/RTMP支持都很完善。

\11. 全面支持H265/H264/AAC/G711/OPUS。

## Monibuca

**Monibuca**是一个开源的Go语言实现的流媒体服务器开发框架，采取了引擎+插件(s)的方式，实现了定制化流媒体服务器的功能。

架构图：



### 使用步骤

\1. 源码地址

地址：<https://github.com/Monibuca>

\2. 以monica为例进行介绍，monica是一个实例管理器，用于创建Monibuca的实例工程目录文件，以及控制实例的更新和重启等。

2.1 安装monica

> go get github.com/Monibuca/monica

2.2 指定端口运行，默认是8000

> monica -port 8001 

### 主要功能

\1. 针对流媒体服务器独特的性质进行的优化，充分利用Golang的goroutine的性质对大量的连接的读写进行合理的分配计算资源，以及尽可能的减少内存Copy操作。使用对象池减少Golang的GC时间。

\2. 专为二次开发而设计，基于Golang语言，开发效率更高；独创的插件机制，可以方便用户定制个性化的功能组合，更高效率的利用服务器资源。

\3. 功能强大的仪表盘可以直观的看到服务器运行的状态、消耗的资源、以及其他统计信息。用户可以利用控制台对服务器进行配置和控制。点击右上角菜单栏里面的演示，可以看到演示控制台界面。

\4. 纯Go编写，不依赖cgo，不依赖FFMpeg或者其他运行时，部署极其方便，对服务器的要求极为宽松。

## 结尾

最后附上它们四个的对比图表，这样更加的直观形象。

### 对比图表 

|            | 热度 | 语言  | 扩展性                                         | 性能                           |
| :--------- | :--- | :---- | :--------------------------------------------- | :----------------------------- |
| SRS        | 3.4k | C++   | 高，C++为主要工具语言，有一定开发难度          | 较高，企业级应用               |
| EasyDarwin | 1.8k | Go+JS | 较高，go+js架构，难度较低，扩展也比较方便      | 一般                           |
| ZLMediaKit | 735  | C++   | 高，基于C++11扩展                              | 高                             |
| Monibuca   | 48   | Go    | 非常高，支持自定义插件形式，扩展新功能非常方便 | 充分利用go特性，具有较高的性能 |

PS：上述数据截止到发稿前。

原创声明，本文系作者授权云+社区发表，未经许可，不得转载。

如有侵权，请联系 yunjia_community@tencent.com 删除。