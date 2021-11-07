# Google Go Agent是什么工具？GoAgent有什么风险？

狂人 2021年04月21日 11:42:08 3463 0

GoAgent使用跨平台语言Python开发和Google App EngineSDK编写，是一个基于Google Appengine的，全面兼容IE、FireFox、chrome的代理工具，程序可以在Microsoft Windows、Mac、Linux、Android、iPod Touch、iPhone、iPad、webOS、OpenWrt、Maemo上使用。

googleagent

GoAgent分为两个部分，一部分是需要部署到GAE上的服务器端软件，另一部分是用户电脑上运行的客户端软件。用户需要将服务器端软件上传到GAE中，然后通过客户端软件与其连接，获取内容。早在2015年8月之后，GoAgent已停止更新维护，并被开发者删除。

## 一、Google GoAgent的使用方法

如何部署和使用GoAgent，以Windows为例（简单步骤描述，详情见参考资料）

1、申请GoogleAppengine并创建appid。
2、修改local\proxy.ini中的[gae]下的appid=你的appid（多appid请用 | 隔开）。
3、双击server\uploaderbat，上传成功后即可使用了（地址127.0.0.1:8087）。
4、chrome请安装SwitchySharp插件，然后导入这个设置，需要导入CA证书。
5、firefox请安装FoxyProxy，或是AutoProxy插件，Firefox需要导入证书。

## 二、Google GoAgent的其他特性

1、支持作为本地DNS服务器使用。
2、支持代理自动配置（PAC）。
3、支持在数据发送过程中采用HTTPS加密连接。
4、支持Google App Engine，PHP和PaaS三种模式。
5、自2.1.17版本起支持在通信时加入混淆数据以避免数据包在传输时受到特征过滤 。
6、GoAgent自3.0.6版开始可选支持RC4加密选项。

## 三、Google GoAgent的安全问题

GoAgent的数据传输中没有进行加密。GoAgent因为GoogleAppEngine的一些限制不能原生支持HTTPS安全协议。网上已经有方法暂时解决GoAgent的SSL证书错误问题。使用GAE托管程序的GoAgent一般是使用谷歌提供的IP地址。对安全性有更高要求的使用者可以考虑使用其他免费云平台，如APJP。用HTTPS联接安全性会提高，但上网速度会相应变慢。

## 四、Google GoAgent的证书风险

GoAgent 在启动时会尝试自动往系统的可信根证书中导入一个名为“GoAgent CA”的证书。由于这个证书的私钥是公开的，导致任何人都可以利用这个私钥来伪造任意网站的证书进行 HTTPS 中间人攻击。即使在不开启 GoAgent 时，这种攻击的风险仍然存在。换而言之，一旦这个证书被导入，攻击者可以用此绕过几乎所有网站的 HTTPS 保护（在GoAgent 3.2.1版本之后这个漏洞得以修复）。

GoAgent 本身对 TLS 证书的认证存在问题，而且默认时不对证书进行检查，这导致在使用 GoAgent 时存在 HTTPS 中间人攻击的风险。

本文地址： http://www.krseo.com/zixun/200.html
版权声明：除非特别标注，否则均为本站原创文章，转载时请以链接形式注明文章出处。

