# 科普 TLS 1.3 — 新特性与开启方式

[![又拍云](https://pica.zhimg.com/v2-14a910987675bd81d6bed9e949ca8da4_xs.jpg?source=172ae18b)](https://www.zhihu.com/org/you-pai-yun-4)

[又拍云](https://www.zhihu.com/org/you-pai-yun-4)[](https://www.zhihu.com/question/48510028)

已认证账号

关注

9 人赞同了该文章

TLS 1.3 协议针对安全强化及效率提升等方面进行了大量修改，相继推出 20 多个草案版本，即将完成最终的标准化。标准完成后，OpenSSL 组织将推出 OpenSSL 1.1.1 版本，对 TLS1.3 协议标准提供支持。

本文主要讲解 TLS 1.3 版本的相关特性以及如何在你的服务器上启用 TLS 1.3 的支持。

在谈 TLS 1.3 之前，我们先来看下 TLS 1.2 的工作模式，如图所示是 TLS 1.2 [客户端](https://www.zhihu.com/search?q=客户端&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A34232163})和服务端交互的过程，如图所示:

![img](https://pic1.zhimg.com/80/v2-84dd5581d55db2a862c40f795afc8e24_1440w.jpg)

我们也可以通过 Wireshark 抓包得到的数据

![img](https://pic2.zhimg.com/80/v2-33275fe996615790c1f9889a2504cdc1_1440w.jpg)

以 ECDHE [密钥交换算法](https://www.zhihu.com/search?q=密钥交换算法&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A34232163})为例，TLS1.2 协议完整的SSL握手过程如下:

- 第一步，首先客户端发送 ClientHello 消息，该消息中主要包括客户端支持的协议版本、加密套件列表及握手过程需要用到的 ECC 扩展信息；
- 第二步，服务端回复 ServerHello，包含选定的加密套件和 ECC 扩展；发送证书给客户端；选用客户端提供的参数生成 ECDH 临时公钥，同时回复 ServerKeyExchange 消息；
- 第三步，客户端接收 ServerKeyExchange 后，使用证书公钥进行签名验证，获取服务器端的 ECDH 临时公钥，生成会话所需要的共享密钥；生成 ECDH 临时公钥和 ClientKeyExchange 消息发送给服务端；
- 第四步，服务器处理 ClientKeyExchange 消息，获取客户端 ECDH 临时公钥；服务器生成会话所需要的共享密钥；发送密钥协商完成消息给客户端；
- 第五步，双方使用生成的共享密钥对消息加密传输，保证消息安全。

可以看到，TLS1.2 协议中需要加密套件协商、密钥信息交换、ChangeCipherSpec 协议通告等过程，需要消耗 2-RTT 的握手时间，这也是造成 HTTPS 协议慢的一个重要原因之一。

我们来看下 TLS 1.3 的的交互过程，如图所示:

![img](https://pic3.zhimg.com/80/v2-45d463ae0c49aa52936a9d804fbf7d2a_1440w.jpg)

其抓包得到的数据流如下:

![img](https://pic1.zhimg.com/80/v2-1a7abce6db173fa9a468fc42eeac188c_1440w.jpg)

在 TLS 1.3 中，客户端首先不仅发送 ClientHello 支持的密码列表，而且还猜测服务器将选择哪种密钥协商算法，并发送密钥共享,这可以节省很大一部分的开销，从而提高了速度。

TLS1.3 提供 1-RTT 的握手机制，还是以 ECDHE 密钥交换过程为例，握手过程如下。将客户端发送 ECDH 临时公钥的过程提前到 ClientHello，同时删除了 ChangeCipherSpec 协议简化握手过程，使第一次握手时只需要 1-RTT，来看具体的流程:

- 客户端发送 ClientHello 消息，该消息主要包括客户端支持的协议版本、DH 密钥交换参数列表 KeyShare；
- 服务端回复 ServerHello，包含选定的加密套件；发送证书给客户端；使用证书对应的私钥对握手消息签名，将结果发送给客户端；选用客户端提供的参数生成 ECDH 临时公钥，结合选定的 DH 参数计算出用于加密 HTTP 消息的共享密钥；服务端生成的临时[公钥](https://www.zhihu.com/search?q=公钥&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A34232163})通过 KeyShare 消息发送给客户端；
- 客户端接收到 KeyShare 消息后，使用证书公钥进行签名验证，获取服务器端的 ECDH 临时公钥，生成会话所需要的共享密钥；
- 双方使用生成的共享密钥对消息加密传输，保证消息安全。

如果客户端之前已经连接，我们有办法在 1.2 中进行 1-RTT 连接，而在 TLS 1.3 中允许我们执行 0-RTT 连接，如图所示:

![img](https://pic4.zhimg.com/80/v2-20c9f7758b7e0541ee25a4a7cc670ef7_1440w.jpg)

需要说明的是，如需查看 TLS 1.3 的报文，需要使用 2.5 版本的 wireshark，可以去 [https://www.wireshark.org/download/automated/](https://link.zhihu.com/?target=https%3A//www.wireshark.org/download/automated/) 下载

## TLS 1.3 的新特性

1.废除不支持前向安全性的 RSA 以及具有 CVE-2016-0701 漏洞的 DH 密钥交换算法；

2.MAC 只使用 AEAD 算法；

3.禁用 RC4 / SHA1 等不安全的算法；

4.加密握手消息；

5.减少往返时延 RTT，支持 0-RTT；

6.兼容中间设备 TLS 1.2；

7.加密握手消息：

TLS1.2 及之前版本的协议中各种扩展信息在 ServerHello 中以明文方式发送，但是 TLS 1.3 协议要求 ServerHello 消息之后的握手信息都需要加密。



![img](https://pic2.zhimg.com/80/v2-7764e77fd056f3fd10fb29a65e4dcf2d_1440w.jpg)△ TLS1.2

![img](https://pic2.zhimg.com/80/v2-5fce69732af4f7a5f644d3ebd0015325_1440w.jpg)△ TLS1.3

## 浏览器支持 TLS 1.3

目前最新的 Chrome 和 Firefox 都支持 TLS 1.3，但需要手动开启：

Chrome 中需要将 chrome://flags/ 中的 Maximum TLS [version enabled](https://www.zhihu.com/search?q=version+enabled&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A34232163}) 改为 TLS 1.3（Chrome 62 中需要将 TLS 1.3 改为 Enabled (Draft)

![img](https://pic4.zhimg.com/80/v2-064b200293d7f0c720d4a83b03d61e9f_1440w.jpg)

Firefox 中，将 about:config 中的 security.tls.version.max 改为 4；

![img](https://pic3.zhimg.com/80/v2-30388d5497aa0e06f88895b785a5cafe_1440w.jpg)

## Web 服务器支持 TLS 1.3

首先，需要下载 openssl 开发版，目前 TLS 1.3 还处于 [draft](https://link.zhihu.com/?target=https%3A//tools.ietf.org/html/draft-ietf-tls-tls13-23) 版，所以要克隆其分支进行编译。

```
git clone -b tls1.3-draft-18 --single-branchhttps://github.com/openssl/openssl.gitopenssl
```

注意: github 的最新版本 [tls1.3-draft-19](https://www.zhihu.com/search?q=tls1.3-draft-19&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A34232163}) 编译后并不会有效果

以 nginx 1.13.8 为例(自 1.13.0 开始 nginx 开始支持 TLSv1.3)，在编译的时候加上

```
--with-openssl=../openssl --with-openssl-opt='enable-tls1_3 enable-weak-ssl-ciphers'
```

例如我的编译参数

```text
./configure --prefix=/usr/local/nginx --user=www --group=www --with-pcre=/opt/nginx/pcre-8.41 --with-http_ssl_module --with-zlib=/opt/nginx/zlib-1.2.11 --with-http_v2_module --add-module=../nginx-ct-1.3.2 --add-module=../ngx_brotli --with-openssl=../openssl --with-openssl-opt='enable-tls1_3 enable-weak-ssl-ciphers' --with-http_v2_module --with-http_ssl_module --with-http_gzip_static_module
```

编译完成停止你的 nginx 进程，在 nginx 目录执行如下命令

```text
cp -rf ./objs/nginx /usr/local/nginx/sbin/
```

在你的 nginx 配置文件中添加如下配置

```text
ssl_protocols              TLSv1.2 TLSv1.3; #增加 TLSv1.3重启 nginx 服务。
ssl_ciphers                TLS13-AES-256-GCM-SHA384:TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-128-GCM-SHA256:TLS13-AES-128-CCM-8-SHA256:TLS13-AES-128-CCM-SHA256:EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
CDN 支持 TLS 1.3
```

目前，又拍云的 CDN 网络已经率先支持 TLS 1.3，你可以在又拍云的控制台中开启。

开启路径：CDN → 功能配置 → HTTPS → TLS1.3

![img](https://pic1.zhimg.com/80/v2-6bed45ade71e3832eaba097fdd3c515c_1440w.jpg)

开启后通过浏览器访问可以看到协议版本。

![img](https://pic4.zhimg.com/80/v2-3ba39269e6268d08c03038ebf98dfb4b_1440w.jpg)



**快速入口：**

**[又拍云 TLS 1.3 极速开启](https://link.zhihu.com/?target=https%3A//console.upyun.com/services/zwj3123/httpsFile/)**

**[免费 SSL 证书申请（Let's Encrypt 和 TrustAsia 任你挑选）](https://link.zhihu.com/?target=https%3A//console.upyun.com/toolbox/createCertificate/)**



**推荐阅读：**

[从 HTTP 到 HTTPS 再到 HSTStech.upyun.com/article/242/%E4%BB%8E%20HTTP%20%E5%88%B0%20HTTPS%20%E5%86%8D%E5%88%B0%20HSTS.html](https://link.zhihu.com/?target=https%3A//tech.upyun.com/article/242/%E4%BB%8E%20HTTP%20%E5%88%B0%20HTTPS%20%E5%86%8D%E5%88%B0%20HSTS.html)

[一文读懂 HTTP/2 特性tech.upyun.com/article/227/%E4%B8%80%E6%96%87%E8%AF%BB%E6%87%82%20HTTP%2F2%20%E7%89%B9%E6%80%A7.html](https://link.zhihu.com/?target=https%3A//tech.upyun.com/article/227/%E4%B8%80%E6%96%87%E8%AF%BB%E6%87%82%20HTTP%2F2%20%E7%89%B9%E6%80%A7.html)







编辑于 2018-06-27 16:53

[SSL](https://www.zhihu.com/topic/19567919)

[前端开发](https://www.zhihu.com/topic/19550901)

[程序员](https://www.zhihu.com/topic/19552330)

赞同 9