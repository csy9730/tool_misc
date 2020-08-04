#  ChromiumEmbeddedFramework



市面上作为嵌入的组件的可用的浏览器内核，不外乎这几个：webkit、cef、nwjs、electron。

1、cef：优点是由于集成的chromium内核，所以对H5支持的很全，同时因为使用的人也多，各种教程、示例，资源很多。但缺点很明显，太大了。最新的cef已经夸张到了100多M，还要带一堆的文件。同时新的cef已经不支持xp了（chromium对应版本是M49）。而且由于是多进程架构，对资源的消耗也很夸张。如果只是想做个小软件，一坨文件需要带上、超大的安装包，显然不能忍受。 对应一个libcef.dll文件。

2、nwjs，或者最近大火的electron：和cef内核类似，都是chromium内核。缺点和cef一模一样。优点是由于可以使用nodejs的资源，同时又自带了各种api的绑定，所以可以用的周边资源非常丰富；而基于js的开发方案，使得前端很容易上手。所以最近N多项目都是基于nwjs或electron来实现。例如vscode，atom等等。 

原版webkit：现在官网还在更新windows port，但显然漫不在心，而且最新的webkit也很大了，超过20几M。最关键的是，周边资源很少，几乎没人再基于webkit来做开发。同时由于windows版的saferi已经停止开发了，所以用webkit就用不了他的dev tools了。这是个大遗憾。 

3、WKE：这是个很老的webkit内核的裁剪版了。小是小，但bug太多了。

4、miniblink是什么？

Miniblink是一个追求极致小巧的浏览器内核项目，全世界第三大流行的浏览器内核控件。

其基于chromium最新版内核，去除了chromium所有多余的部件，只保留最基本的排版引擎blink。

Miniblink保持了10M左右的极简大小，是所有同类产品最小的体积，同时支持windows xp、npapi。

首先，miniblink对大小要求非常严格。原版chromium、blink里对排版渲染没啥大用的如音视频全都被砍了，只专注于网页的排版和渲染。

其次，miniblink紧跟最新chromium，这意味着chromium相关的资源都可以利用。

Miniblink导出了electron、WKE的接口，可以直接无缝替换现有的electron、WKE项目。



The Chromium Embedded Framework (CEF) is a project that turns Chromium into a library, and provides stable APIs based on Chromium's codebase. Very early versions of Atom editor and NW.js used CEF.

To maintain a stable API, CEF hides all the details of Chromium and wraps Chromium's APIs with its own interface. So when we needed to access underlying Chromium APIs, like integrating Node.js into web pages, the advantages of CEF became blockers.

So in the end both Electron and NW.js switched to using Chromium's APIs directly.



## Electron VS NW.js

Electron 以前被称为 Atom Shell。

NW.js (previously known as node-webkit)

比较NW.js和Electron之前，先要明白虽然是用javascript+html写的app，但是都会跑两部分的js runtime，分别是node-runtime和chromium-runtime。

功能上看，2者差不多，主要的区别是入口方式。

Electron是基于node的，入口是类似node module的index.js，这是因为Electron是基于node的event-loop将chromium的功能和event全部整合app，Electron的开发跟其他的node应用没区别。

NW.js像一个跑在node-platform上的浏览器，所以他的入口是index.html，NW.js将自己的功能都整合进了chromium-runtime，因此更接近一个前端的应用开发方式。NW.js也可以用到node的api，这是通过binding到chromium-runtime来调用的。

进一步说，NW把2套js-runtime环境整合到了一起，Electron则是保持2套js-runtime彼此独立。因此NW的app中的js代码可以使用所有的API（这不见得是好事）。electron的app中的js是可以分前后端的。（传说中的full-stack）

个人小结：

- 两个框架看似功能一样，但其实可以用前后端的差别来看待彼此。(网络请求，I/O操作, etc.)
- 用node module在web端是没有的，有Electron需要其实是需要关闭nodeIntegeration来兼容web资源的依赖加载。
- NW.js对库的整合更深，某种意义上说，对chromium和Node有更深入的理解（新功能要用，必须把源码拿来build进去）。
- Electron对chromium和node的整合更灵活，更新一些新功能完成度会更方便(chromium社区是很活跃的，有新版可以随时拿来)，可以把开发的精力放在其他地方。
- Electron对其他Node的应用，可以有更好的整合。因为他本身也是一个node应用。NW只能用node.js的API
- 从license上来看，Electron是Github的，NW.js则是Intel。







