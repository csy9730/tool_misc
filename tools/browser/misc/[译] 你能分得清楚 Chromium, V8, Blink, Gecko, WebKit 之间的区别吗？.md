# [译] 你能分得清楚 Chromium, V8, Blink, Gecko, WebKit 之间的区别吗？

> 原文链接：[Browser Engines… Chromium, V8, Blink? Gecko? WebKit?](https://link.juejin.cn/?target=https%3A%2F%2Fmedium.com%2F%40jonbiro%2Fbrowser-engines-chromium-v8-blink-gecko-webkit-98d6b0490968)，by Jonathan Biro
> 译注：有些开发者（比如我😂 ）可能对浏览器和浏览器引擎的区分还不是很清晰，这篇文章就来帮助大家答疑解惑。



![0_I-8CPuSMOLxXmCTB.png](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2020/2/2/17003ae0c8d7ee8f~tplv-t2oaga2asx-watermark.awebp)





## 简史及其他

微软基于 Google 的 Chromium 开发的新版 Microsoft Edge 浏览器已经正式发布。这显示了 JavaScript 引擎世界正在进行整合。



![image.png](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2020/2/2/17003ae0c8d6837c~tplv-t2oaga2asx-watermark.awebp)



世界上第一款 JavaScript 引擎是伴随第一个能运行 JavaScript 程序的浏览器出现的，也就是 Netscape Navigator。从那以后，包括微软在内的多家浏览器厂商开始制作它们自己的用来解释和编译 JavaScript 的引擎，当时的市场竞争还是良性的。

有一段时间，Internet Explorer 6 垄断了市场，几乎没有人使用任何其他浏览器。但是 Internet Explorer 不兼容标准，并且实现 JavaScript 的新功能速度很慢，导致开发者一直在这种只具备中等水平引擎的中等浏览器上做设计开发工作。

幸运的是，微软在浏览器大战中的胜利是短暂的。虽然 Netscape Navigator 浏览器失败了，但随后也出现了一些 Internet Explorer 很好的替代品，来帮助改善网络环境。

Mozilla 的 Firefox 是第一个试图淘汰微软公司几乎要被废弃的浏览器的主要竞争对手。与 Firefox 一道的，还有包括使用 WebKit 引擎的 Safari 浏览器（隶属于苹果公司）、先使用 Presto 引擎后使用 Blink 引擎的 Opera 浏览器（隶属于 Opera 公司）、最后是先使用 WebKit 引擎后使用 Blink 引擎的 Chrome 浏览器（隶属于 Google 公司）。

所有这些浏览器引擎不仅负责管理网页的布局，同时还包括一个 JavaScript 引擎、用于解释和编译 JavaScript 代码。在这些 JavaScript 引擎中，最受欢迎的是 V8，V8 不是仅被用在了 Chrome 浏览器中。

由 GitHub 开发和维护的用于创建跨平台桌面程序的 Electron，底层就是由 V8 引擎驱动的。

不仅如此，Node.js 运行时系统也是由 V8 引擎驱动的。这使得 Node.js 可以不断受益于 V8 的开发和改进，并提供出色而快速的服务器体验。由于 V8 是用 C++ 编写的，因此能够将 JavaScript 编译为本地机器代码，而不是实时解释它，这使的 Node.js 在服务器市场中如此快速的占据一定的竞争力。



## 三个主要的浏览器引擎

现在，微软基于 Chromium 开发的新版 Edge 浏览器已经发布 ，包括 Opera 在内的其他浏览器厂商也已经进行了转换。当前市场上只有 3 个主要的浏览器引擎：Mozilla 的 Gecko、Google 的 Blink、还有苹果的的 WebKit（Blink 的近亲）。

等等，Blink 是怎么回事？Blink 是 Google Chrome 浏览器的渲染引擎，V8 是 Blink 内置的 JavaScript 引擎。Chromium 是 Google 公司一个开源浏览器项目，使用 Blink 渲染引擎驱动。Chromium 和 Google Chrome 的关系，可以理解为：Chromium + 集成 Google 产品 = Google Chrome。

> 译注：可以理解为 Google Chrome 是个商业项目，而 Chromium 是一个中立、无立场的（理论上）的开源项目。

V8 对 DOM（文档对象模型）一无所知，因为它仅用于处理 JavaScript。Blink 内置的布局引擎负责处理网页布局和展示。因为 Node.js 不需要使用 DOM，所以 Node.js 只使用了 V8 引擎，而没有把整个 Blink 引擎都搬过来用。



## 三个主要的 JavaScript 引擎

3 个主要的浏览器引擎下，是 3 个不同的 JavaScript 引擎。也就是说现在市场上只有 3 个主要的 JavaScript 引擎。Chromium 市场份占据 65％，再加上从 Edge 和 Internet Explorer 吸收的大约 15％ 的市场份额，后面还会继续扩大。当前，Web 开发人员正在最流行的浏览器引擎上构建能够发挥最佳性能的网站。但是 Chromium 最后有没有可能重蹈 Internet Explorer 6 的覆辙呢？不过还是希望 Chromium 仍能继续跟进标准的步子，并且随着来自 Firefox 和 Safari 的竞争，相信未来的发展也会更加明朗和积极。希望 Google 不会减慢 Chromium 的开发速度，并在如此高的市场份额下继续保持竞争力。

下面做一个总结：

- [**V8**](https://link.juejin.cn/?target=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FV8_(JavaScript_engine))——开源，由 Google 开发，使用 C++ 编写
- **SpiderMonkey**——第一个 JavaScript 引擎，该引擎过去驱动 Netscape Navigator，如今驱动 Firefox 浏览器。
- **JavaScriptCore**——开源，苹果公司为 Safair 浏览器开发的



![1_VqHSZhJ93Vhijkm_VCjHsw.gif](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2020/2/2/17003ae0ca28dd7a~tplv-t2oaga2asx-watermark.awebp)



这里有一个有趣的花边趣事：Blink 从一开始就不支持 HTML 的 `<blink>` 标签。看看下面的效果就知道为啥了：



![0_I9Rl7iW4N_cEHk_D.gif](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2020/2/2/17003ae0ca46ca72~tplv-t2oaga2asx-watermark.awebp)



真是个恼人的效果呢。



## 拓展阅读

1. [Microsoft Edge: Making the web better through more open source collaboration](https://link.juejin.cn/?target=https%3A%2F%2Fblogs.windows.com%2Fwindowsexperience%2F2018%2F12%2F06%2Fmicrosoft-edge-making-the-web-better-through-more-open-source-collaboration%2F)
2. [浏览器市场份额报告](https://link.juejin.cn/?target=https%3A%2F%2Fnetmarketshare.com%2Fbrowser-market-share.aspx%3Foptions%3D%7B%22filter%22%3A%7B%22%24and%22%3A%5B%7B%22deviceType%22%3A%7B%22%24in%22%3A%5B%22Desktop%2Flaptop%22%5D%7D%7D%5D%7D%2C%22dateLabel%22%3A%22Trend%22%2C%22attributes%22%3A%22share%22%2C%22group%22%3A%22browser%22%2C%22sort%22%3A%7B%22share%22%3A-1%7D%2C%22id%22%3A%22browsersDesktop%22%2C%22dateInterval%22%3A%22Monthly%22%2C%22dateStart%22%3A%222019-01%22%2C%22dateEnd%22%3A%222019-12%22%2C%22segments%22%3A%22-1000%22%7D)
3. [Cheat Sheet: What you need to know about Edge on Chromium](https://link.juejin.cn/?target=https%3A%2F%2Fwww.onmsft.com%2Fhow-to%2Fcheat-sheet-what-you-need-to-know-about-edge-on-chromium)
4. [Microsoft guy: Mozilla should give up on Firefox and go with Chromium too](https://link.juejin.cn/?target=https%3A%2F%2Fwww.zdnet.com%2Farticle%2Fmicrosoft-guy-mozilla-should-give-up-on-firefox-and-go-with-chromium-too%2F)

（正文完）