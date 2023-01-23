# 通过修改hosts访问GitHub


最近办公网络从 GitHub 上拉取代码速度巨慢，很多时候都是直接连接错误。

百度了一下，说是 Github 的某些域名的 DNS 解析被污染了。解决方案就是挂代理（VPN），或者直接修改 hosts，绕过 DNS 解析。

### 域名查询


#### ipaddress.com
打开 ，查询一下网站
https://ipaddress.com/website/github.com

https://ipaddress.com/website/assets-cdn.github.com

https://ipaddress.com/website/github.global.ssl.fastly.net


##### chinaz
[http://ip.tool.chinaz.com/](http://ip.tool.chinaz.com/)

#### 查询结果
查询真实IP

通过IPAddress.com首页,输入github.com查询到真实IP地址
```
140.82.114.3 github.com
185.199.108.153 assets-cdn.github.com
146.75.77.194 fastly.net
```

更新于20220615

###  访问GitHub很慢的问题


最近办公网络从 GitHub 上拉取代码速度巨慢，很多时候都是直接连接错误。

百度了一下，说是 Github 的某些域名的 DNS 解析被污染了。解决方案就是挂代理（VPN），或者直接修改 hosts，绕过 DNS 解析。

我用了 VPN 之后，还是会出现访问很慢的问题，于是试了第二种方案，目前是可以正常访问的。

具体方法就是将下面代码直接写入 hosts 文件里。Mac 的 hosts 文件路径为 /etc/hosts 。Windows 的是 C:\Windows\System32\Drivers\etc\hosts 。

```
# GitHub Start
192.30.253.112 github.com
192.30.253.119 gist.github.com
151.101.100.133 assets-cdn.github.com
151.101.100.133 raw.githubusercontent.com
151.101.100.133 gist.githubusercontent.com
151.101.100.133 cloud.githubusercontent.com
151.101.100.133 camo.githubusercontent.com
151.101.100.133 avatars0.githubusercontent.com
151.101.100.133 avatars1.githubusercontent.com
151.101.100.133 avatars2.githubusercontent.com
151.101.100.133 avatars3.githubusercontent.com
151.101.100.133 avatars4.githubusercontent.com
151.101.100.133 avatars5.githubusercontent.com
151.101.100.133 avatars6.githubusercontent.com
151.101.100.133 avatars7.githubusercontent.com
151.101.100.133 avatars8.githubusercontent.com
# GitHub End
```

### github about

#### raw.githubusercontent.com

由于某不存在的wall，raw.githubusercontent.com 域名解析被污染。

查询真实IP

通过IPAddress.com首页,输入raw.githubusercontent.com查询到真实IP地址

```
199.232.68.133 raw.githubusercontent.com
140.82.112.3 www.github.com
```

#### github.io 和 github.com 
**Q**: github.io 和 github.com 有什么区别？

**A**: 
如果使用相同的域名，是可以在此域名下任意地“读”和“写”cookie，这是很危险的，比如“cookie劫持”或者“cookie注入攻击”。

以前没有[http://github.io](http://github.io)的时候，代码仓库和pages服务都在[http://github.com](http://github.com)域名下，而pages是可以由用户自由编写的。

只需要简单地几行js代码，就可以通过pages进行与cookie有关的攻击，而且由于域名相同，这可以影响到仓库下的内容，造成用户代码／数据的损失。

有了http://github.io之后，pages服务则独立地运行在[http://github.io](http://github.io)域名下，cookie有关的攻击被限制在http://github.io域名下，这就变得安全了很多。

