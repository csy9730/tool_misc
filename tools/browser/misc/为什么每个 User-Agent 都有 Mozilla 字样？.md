# 为什么每个 User-Agent 都有 Mozilla 字样？

[2016-05-01](https://hexingxing.cn/user-agent-mozilla/) • [臻选推荐](https://hexingxing.cn/iv/) • [4 条评论](https://hexingxing.cn/user-agent-mozilla/#comments)

在何星星解释 “为什么每个浏览器的 User-Agent 都有 Mozilla 字样？” 之前先贴一段目前常见的浏览器 User-Agent 。

 

> Chrome｜谷歌浏览器
> Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36

> Firefox｜火狐浏览器
> Mozilla/5.0 (Windows NT 6.1; WOW64; rv:46.0) Gecko/20100101 Firefox/46.0

> Opera｜欧朋浏览器
> Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.87 Safari/537.36 OPR/37.0.2178.32

> Safari｜苹果浏览器
> Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2

> 微软 Edge 浏览器
> Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Safari/537.36 Edge/13.10586

> Internet Explorer 11 浏览器
> Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko

 

 

从以上的浏览器 User-Agent 确实可以看去都带有 Mozilla ，那么为会这样呢？请往下看。

故事还得从头说起，最初的主角叫 NCSA Mosaic ，简称 Mosaic（马赛克），是 1992 年末位于伊利诺伊大学厄巴纳-香槟分校的国家超级计算机应用中心（National Center for Supercomputing Applications，简称 NCSA）开发，并于 1993 年发布的一款浏览器。它自称 “NCSA_Mosaic/2.0（Windows 3.1）”，Mosaic 可以同时展示文字和图片，从此浏览器变得有趣多了。

然而很快就出现了另一个浏览器，这就是著名的 Mozilla ，中文名称摩斯拉。一说 Mozilla = Mosaic + Killer，意为 Mosaic 杀手，也有说法是 Mozilla = Mosaic & Godzilla，意为马赛克和哥斯拉，而 Mozilla 最初的吉祥物是只绿色大蜥蜴，后来更改为红色暴龙，跟哥斯拉长得一样。

但 Mosaic 对此非常不高兴，于是后来 Mozilla 更名为 Netscape ，也就是网景。Netscape 自称 “Mozilla/1.0(Win3.1)” ，事情开始变得更加有趣。网景支持框架（frame），由于大家的喜欢框架变得流行起来，但是 Mosaic 不支持框架，于是网站管理员探测 User-Agent ，对 Mozilla 浏览器发送含有框架的页面，对非 Mozilla 浏览器发送没有框架的页面。

后来网景拿微软寻开心，称微软的 Windows 是 “没有调试过的硬件驱动程序”。微软很生气，后果很严重。此后微软开发了自己的浏览器，这就是 Internet Explorer ，并希望它可以成为 Netscape Killer 。IE 同样支持框架，但它不是 Mozilla ，所以它总是收不到含有框架的页面。微软很郁闷很快就沉不住气了，它不想等到所有的网站管理员都了解 Internet Explorer 并且给 Internet Explorer 发送含有框架的页面，它选择宣布 IE 是兼容 Mozilla ，并且模仿 Netscape 称 Internet Explorer 为 “Mozilla/1.22(compatible; MSIE 2.0; Windows 95)” ，于是 Internet Explorer 可以收到含有框架的页面了，所有微软的人都嗨皮了，但是网站管理员开始晕了。

因为微软将 Internet Explorer 和 Windows 捆绑销售，并且把 Internet Explorer 做得比 Netscape 更好，于是第一次浏览器血腥大战爆发了，结果是 Netscape 以失败退出历史舞台，微软更加嗨皮。但没想到 Netscape 居然又以 Mozilla 的名义重生了（为什么要用 “又”，因为在成立 Netscape 之前就是 Mozilla ，意为 Mosaic 杀手，当时的创立网络浏览模式的 Mosaic 对此非常不高兴，于是后来 Mozilla 更名为 Netscape，现在又绕回来了。 ），并且开发了 Gecko ，这次它自称为 “Mozilla/5.0(Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826”。

Gecko 是一款渲染引擎并且很出色。Mozilla 后来变成了现在我们熟知的 Firefox，并自称 “Mozilla/5.0 (Windows; U; Windows NT 5.1; sv-SE; rv:1.7.5) Gecko/20041108 Firefox/1.0”。Firefox 性能很出色，Gecko 也开始攻城略地，其他新的浏览器使用了它的代码，并且将它们自己称为 “Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.2) Gecko/20040825 Camino/0.8.1”，以及 “Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.8) Gecko/20071008 SeaMonkey/1.0”，每一个都将自己装作 Mozilla ，而它们全都使用 Gecko 。

Gecko 很出色，而 Internet Explorer 完全跟不上它，因此 User-Agent 探测规则变了，使用 Gecko 的浏览器被发送了更好的代码，而其他浏览器则没有这种待遇。Linux 的追随者对此很难过，因为他们编写了 Konqueror ，它的引擎是 KHTML ，他们认为 KHTML 和 Gecko 一样出色，但却因为不是 Gecko 而得不到好的页面，于是 Konqueror 为得到更好的页面开始将自己伪装成 “like Gecko”，并自称为 “Mozilla/5.0 (compatible; Konqueror/3.2; FreeBSD) (KHTML, like Gecko)”。自此 User-Agent 变得更加混乱。

这时更有 Opera 跳出来说，“毫无疑问，我们应该让用户来决定他们想让我们伪装成哪个浏览器。” ，于是 Opera 干脆创建了菜单项让用户自主选择让 Opera 浏览器变成 “Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; en) Opera 9.51” ，或者 “Mozilla/5.0 (Windows NT 6.0; U; en; rv:1.8.1) Gecko/20061208 Firefox/2.0.0 Opera 9.51” ， 或者 “Opera/9.51 (Windows NT 5.1; U; en)” 。

后来苹果开发了 Safari 浏览器，并使用 KHTML 作为渲染引擎，但苹果加入了许多新的特性，于是苹果从 KHTML 另辟分支称之为 WebKit ，但它又不想抛弃那些为 KHTML 编写的页面，于是 Safari 自称为 “Mozilla/5.0 (Macintosh; U; PPC Mac OS X; de-de) AppleWebKit/85.7 (KHTML, like Gecko) Safari/85.5”，增加了 AppleWebKit/… 字段，这进一步加剧了 User-Agent 的混乱局面。

因为微软十分忌惮 Firefox ，于是 Internet Explorer 重装上阵，这次它自称为 “Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0) ”，并且渲染效果同样出色，但是需要网站管理员的指令它这么做才行。

再后来，谷歌开发了 Chrome 浏览器，Chrome 使用 Webkit 作为渲染引擎，和 Safari 之前一样，它想要那些为 Safari 编写的页面，于是它伪装成了 Safari 。于是 Chrome 使用 WebKit ，并将自己伪装成 Safari，WebKit 伪装成 KHTML ，KHTML 伪装成 Gecko ，最后所有的浏览器都伪装成了 Mozilla ，这就是为什么所有的浏览器 User-Agent 里都有 Mozilla 。Chrome 自称为 “Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.27 Safari/525.13”。

因为以上这段历史，现在的 User-Agent 字符串变得一团糟，几乎根本无法彰显它最初的意义。追根溯源，微软可以说是这一切的始作俑者，但后来每一个人都在试图假扮别人，最终把 User-Agent 搞得混乱不堪。

一句话结论：因为网站开发者可能会因为你是某浏览器（这里是 Mozilla），所以输出一些特殊功能的程序代码（这里指好的特殊功能），所以当其它浏览器也支持这种好功能时，就试图去模仿 Mozilla 浏览器让网站输出跟 Mozilla 一样的内容，而不是输出被阉割功能的程序代码。大家都为了让网站输出最好的内容，都试图假装自己是 Mozilla 一个已经不存在的浏览器……

  

| **各大浏览器诞生年表** |                     |                    |
| ---------------------- | ------------------- | ------------------ |
| **浏览器**             | **发布时间**        | **所属公司**       |
| Mosaic                 | 1993 年 1 月 23 日  | NCSA               |
| Netscape               | 1994 年 12 月       | Mozilla            |
| Opera                  | 1995 年 4 月        | Opera Software ASA |
| Internet Explorer      | 1995 年 8 月 16 日  | Microsoft          |
| Kongqueror             | 1996 年 10 月 14 日 | Kongqueror         |
| Safari                 | 2003 年 1 月 7 日   | Apple              |
| Firefox                | 2004 年 11 月 8 日  | Mozilla            |
| Chrome                 | 2008 年 9 月 2 日   | Google             |



原创文章转载请注明：转载自：[为什么每个 User-Agent 都有 Mozilla 字样？ - 何星星](https://hexingxing.cn/user-agent-mozilla/)

