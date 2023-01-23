# [webkit、cef、nwjs、electron、 miniblink浏览器内核优缺点](https://www.cnblogs.com/xbzhu/p/10645754.html)



市面上作为嵌入的组件的可用的浏览器内核，不外乎这几个：webkit、cef、nwjs、electron。

1、cef：优点是由于集成的chromium内核，所以对H5支持的很全，同时因为使用的人也多，各种教程、示例，资源很多。但缺点很明显，太大了。最新的cef已经夸张到了100多M，还要带一堆的文件。同时新的cef已经不支持xp了（chromium对应版本是M49）。而且由于是多进程架构，对资源的消耗也很夸张。如果只是想做个小软件，一坨文件需要带上、超大的安装包，显然不能忍受。 

2、nwjs，或者最近大火的electron：和cef内核类似，都是chromium内核。缺点和cef一模一样。优点是由于可以使用nodejs的资源，同时又自带了各种api的绑定，所以可以用的周边资源非常丰富；而基于js的开发方案，使得前端很容易上手。所以最近N多项目都是基于nwjs或electron来实现。例如vscode，atom等等。 

原版webkit：现在官网还在更新windows port，但显然漫不在心，而且最新的webkit也很大了，超过20几M。最关键的是，周边资源很少，几乎没人再基于webkit来做开发。同时由于windows版的saferi已经停止开发了，所以用webkit就用不了他的dev tools了。这是个大遗憾。 

3、WKE：这是个很老的webkit内核的裁剪版了。小是小，但bug太多了。

4、miniblink是什么？

Miniblink是一个追求极致小巧的浏览器内核项目，全世界第三大流行的浏览器内核控件。

其基于chromium最新版内核，去除了chromium所有多余的部件，只保留最基本的排版引擎blink。

Miniblink保持了10M左右的极简大小，是所有同类产品最小的体积，同时支持windows xp、npapi。

首先，miniblink对大小要求非常严格。原版chromium、blink里对排版渲染没啥大用的如音视频全都被砍了，只专注于网页的排版和渲染。甚至为了裁剪大小，我不惜使用vc6的crt来跑mininblink(见我上篇文章)。这个也算前无古人后无来者了。

其次，miniblink紧跟最新chromium，这意味着chromium相关的资源都可以利用。在未来的规划里，我是打算把electron的接口也加上的，这样可以无缝替换electron。使用miniblink的话，开发调试时用原版electron，发布的时候再替换掉那些dll，直接可以无缝切换，非常方便。 

miniblink如何使用？

Miniblink导出了electron、WKE的接口，可以直接无缝替换现有的electron、WKE项目。

早期miniblink还导出了CEF接口，不过现在已被废弃。 

miniblink有个小demo，从demo里可以看到，brackct这个基于cef的开源编辑器，已经顺利由miniblink跑起来了。现在electron的接口已做好，vscode跑起来了。 

这个比较复杂了。主要就是把blink从chromium抽离了出来，同时补上了cc层（硬件渲染层）。现在的blink，已经不是当年的那个webkit了，渲染部分全走cc层，复杂无比。我这大半年都在重写他那个蛋疼又复杂的cc层。 

和webkit比，miniblink架构有什么优势

现在的webkit版本，已经比miniblink落后太多了。blink一直在加入各种极富创造力和想象力的功能、组件。例如，blink早就加入多线程解析html token、blink gc回收器、多线程录制回放渲染机制。这些能让blink的解析渲染速度极大提升。下一次，我会先开源出blink gc组件，这东西很有意思，在c++里硬是搞出了一个垃圾回收机制，能让你像写java一样写c++。
\---------------------
作者：jlzw2018
来源：CSDN
原文：https://blog.csdn.net/jlzw2018/article/details/84317197
版权声明：本文为博主原创文章，转载请附上博文链接！



标签: [cef](https://www.cnblogs.com/xbzhu/tag/cef/), [nodejs](https://www.cnblogs.com/xbzhu/tag/nodejs/)