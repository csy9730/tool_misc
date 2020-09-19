# GitHub网络问题

## GitHub网络问题
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

### raw.githubusercontent.com

由于某不存在的wall，raw.githubusercontent.com 域名解析被污染。



查询真实IP

通过IPAddress.com首页,输入raw.githubusercontent.com查询到真实IP地址

```
199.232.68.133 raw.githubusercontent.com
140.82.112.3 www.github.com
```


## github.io 和 github.com 
**Q**: github.io 和 github.com 有什么区别？

**A**: 
如果使用相同的域名，是可以在此域名下任意地“读”和“写”cookie，这是很危险的，比如“cookie劫持”或者“cookie注入攻击”。

以前没有http://github.io的时候，代码仓库和pages服务都在http://github.com域名下，而pages是可以由用户自由编写的。

只需要简单地几行js代码，就可以通过pages进行与cookie有关的攻击，而且由于域名相同，这可以影响到仓库下的内容，造成用户代码／数据的损失。

有了http://github.io之后，pages服务则独立地运行在http://github.io域名下，cookie有关的攻击被限制在http://github.io域名下，这就变得安全了很多。


## mirror

https://github.com.cnpmjs.org
https://hub.fastgit.org


1. GitHub 镜像访问

这里提供两个最常用的镜像地址：

    https://github.com.cnpmjs.org
    https://hub.fastgit.org

也就是说上面的镜像就是一个克隆版的Github，你可以访问上面的镜像网站，网站的内容跟Github是完整同步的镜像，然后在这个网站里面进行下载克隆等操作。
2. GitHub文件加速

利用 Cloudflare Workers 对 github release 、archive 以及项目文件进行加速，部署无需服务器且自带CDN.

https://gh.api.99988866.xyz
https://g.ioiox.com

以上网站为演示站点，如无法打开可以查看开源项目：gh-proxy-GitHub 文件加速自行部署。
3. Github 加速下载

只需要复制当前 GitHub 地址粘贴到输入框中就可以代理加速下载！

地址：http://toolwa.com/github/

4. 加速你的 Github

https://github.zhlh6.cn

输入 Github 仓库地址，使用生成的地址进行 git ssh 操作即可
5. 谷歌浏览器GitHub加速插件(推荐)

谷歌浏览器Github加速插件.crx 下载

百度网盘: https://pan.baidu.com/s/1qGiIUzqNlN1ZczTNFbPg0A,提取码：stsv

如果可以直接访问谷歌商店，可以访问GitHub 加速谷歌商店安装。

6. GitHub raw 加速

GitHub raw 域名并非 github.com 而是 raw.githubusercontent.com，上方的 GitHub 加速如果不能加速这个域名，那么可以使用 Static CDN 提供的反代服务。

将 raw.githubusercontent.com 替换为 raw.staticdn.net 即可加速。
7. GitHub + Jsdelivr

jsdelivr 唯一美中不足的就是它不能获取 exe 文件以及 Release 处附加的 exe 和 dmg 文件。

也就是说如果 exe 文件是附加在 Release 处但是没有在 code 里面的话是无法获取的。所以只能当作静态文件 cdn 用途，而不能作为 Release 加速下载的用途。
8. 通过Gitee中转fork仓库下载

网上有很多相关的教程，这里简要的说明下操作。

    访问gitee网站： https://gitee.com/ 并登录，在顶部选择“从GitHub/GitLab导入仓库”