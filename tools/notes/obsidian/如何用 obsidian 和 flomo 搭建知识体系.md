# 如何用 obsidian 和 flomo 搭建知识体系

[![Seyee](https://picx.zhimg.com/v2-273e6b57c09517e96ea342709ead6cb3_l.jpg?source=32738c0c)](https://www.zhihu.com/people/schuckshu-ke)

[Seyee](https://www.zhihu.com/people/schuckshu-ke)

一个手机上有 800+ 个 App 的效率工具爱好者

最近看了好几篇文章都提倡一个观点，要建立自己的系统，把想做的事融入到日常生活中，变成一种习惯。我打算实践一下，开始构建自己的系统。系统有很多种分类，有一种可以是理论与行动。而知识体系是理论的基石，我选择用 obsidian 搭建知识体系的主要结构，flomo 作为快速输入和短文字的部分填充枝叶（以前的文章里介绍过 [flomo](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzAxMzIyNjgyOQ%3D%3D%26mid%3D2488505100%26idx%3D1%26sn%3D0d42157c0bd892d36ee75bc9e7e1a620%26chksm%3D8a02f52ebd757c3823833bd6865aca931a9562e76c60bbbc7c4e84b824ddba6d6f86560a6f57%26scene%3D21%23wechat_redirect)），后续我还会分享关于行动的部分。



![img](https://pic4.zhimg.com/80/v2-ec350b4d6f5158ce4d2caec045d1b9a7_1440w.webp)

linlin:D 的 obsidian 界面

刚开始写知识体系这个主题的时候我是只打算写 obsidian 的，实践的过程中使用 obsidian 做笔记时排版和移动端的流畅度上不如 flomo ，最终我发现两者配合使用更好。

这篇文章主要分成两个部分：

1. 为什么是 obsidian
2. 我的使用案例分享。这部分我会介绍如何搭配 flomo 使用。

### 为什么是 obsidian

所有数据都以 markdown 等通用格式离线保存在本地

这个好处只用一个词形容就是，放心。

你可以放心地写搭建自己的永久知识库，不用担心软件倒闭后笔记石沉大海，只要自己做好备份，这些笔记就一直在你的设备上，不依赖于软件服务器。如果对 obsidian 不满意还可以随时把文件夹导入到别的笔记软件里跑路。

![img](https://pic2.zhimg.com/80/v2-3dde57792acef35fa7027329cd11a4dd_1440w.webp)

强大的双链

虽然这两年双链笔记有很多，但是 obsidian 好像是最强大的，不仅有一般的引用：在当前文本里用双括号把页面名包起来，就可以从 [[页面名]] 点击跳转到那个页面，也可以再回到跳转前的页面。

而且有出链功能，也叫潜在链接。它会根据你当前笔记的内容判断可能跟哪些页面有关系。比如你有一篇笔记里内容有「双链」这个关键词，同时你又有一篇笔记命名为「双链」，则潜在链接里会显示提及「双链」的部分可以建立一个引用。

流畅轻便的交互

我对 App 交互的流畅度特别敏感，用了很多同类软件，obsidian 是比较顺手的了，而且性能很强，看到测评说打开 10 万字的文档也不会卡。以前每次编辑和预览都要来回切换不方便，现在有了 live preview 实时预览模式，虽然还不够完善，但是对我来说够用了。

丰富的插件

这个特点对于有些用户想上手即用的也不一定友好，但是我觉得考虑到本地笔记这个优点，一定的设置成本是可以接受的，而且如果没有高级需求，obsidian 其实也有简单的用法，只要学会使用 [[ ]] 建立双链就可以了。

上次看到同事有做工作日志的习惯，我给他推荐了 obsidian，推荐理由是：本地笔记、日历、看板。



![img](https://pic2.zhimg.com/80/v2-097116a5350785c386701dfffb4bc8a5_1440w.webp)

左侧是看板，右侧是日历插件，日期上有小圆点说明当天存在日记


推荐看板的原因是因为同事可以用来看哪些项目正在进行中，哪些是待跟进。点击日历插件则可以快速建立或跳转到以当天日期命名的笔记，比如我的命名格式是 2022-01-24 Mon。

良好的社区生态

obsidian、滴答清单、cubox 的用户群应该是我现在最爱的三个社群了，里面有很好的交流氛围，在群里提问会有用户帮忙解答，还可以自由交流各自的工具流，即使讨论竞品也可以。效率软件当然是希望可以长久使用，我觉得如果开发团队能有这样的格局和包容性，也是很大的加分项。

obsidian 的社群是用户自己建的，群主是 bon，知乎是 ID 是 AllinBon，他还自学开发了两个插件，一个是 memos，一个是 big calendar。



![img](https://pic2.zhimg.com/80/v2-050cb005712658f736626e17c847bd15_1440w.webp)

左边是big calendar，右边是 memos，都基于中间的日记文件

因为我没有买 obsidian 的官方同步，用 icloud 同步有时候手机会有同步延迟，而且在移动端操作还是有点不方便，我需要更流畅的移动端输入场景，所以没有使用，但是群里很多小伙伴都用了，而且最近开发更新特别快，bon 太肝了。

### 我的使用案例

制作 MOC 并和 flomo 联动

自从开始搭建自己的体系，发现 flomo 用久了，有一些标签容易被遗忘，我现在有两百多个标签，也不够结构化。前段时间出了 flomo to notion 的功能，体验下来却不是很满意。因为同步到 notion 里的标签是多级标签一起，比如 book/《卡片笔记写作法》，虽然可以用公式解决一部分的标签拆解问题，但是一方面很繁琐，notion 不是很流畅，笔记多了以后同步的数据库有点卡顿，另一方面 notion 里的笔记命名里会存在一堆 # 看着特别不舒服。

为了解决不够结构化的问题，我尝试在 flomo 里建索引，建到一半觉得这条笔记有点太长了，每次滑到都要滑好几屏页面，于是先搁置了。当时把这条做到一半的笔记分享给朋友看才知道这种方式叫 MOC，Map of Contents，我理解为索引。



![img](https://pic4.zhimg.com/80/v2-d16a483cf280860f2ccfec6e867e5193_1440w.webp)

flomo 里自建的索引



因为我的工作是 web 前端开发，于是我在 obsidian 上也尝试做了前端知识体系的 MOC 页面，在 obsidian 上做有一个好处就是，MOC 页面上的每一个关键词都是一个页面，通过前面提到的 obsidian 双链里的 unlink 功能，可以发现哪些页面里出现了这些关键词，这样我就可以把 [cubox](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzAxMzIyNjgyOQ%3D%3D%26mid%3D2488505061%26idx%3D1%26sn%3Dc4a577507f3e27fad2189507780c5ba9%26chksm%3D8a02f4c7bd757dd1a781a053305efa80c38ff3f362428cc22e92fffb44ae5ec788b9b2ba3113%26scene%3D21%23wechat_redirect) 里存的技术文章下载到 obsidian，按知识点查看相关的文章。



![img](https://pic4.zhimg.com/80/v2-5efc1421e1d59fb2db2e1e6222499af7_1440w.webp)

点击左边的每个知识点会跳转到右边的页面，下面会有包含页面名称的文章

也可以做其他方面的 MOC 页面，比如读书的主题、喜欢的博主等等，你也可以换成自己感兴趣的主题。

写这篇文章的过程中我重读了《卡片笔记写作法》这本书，里面提到的了四种索引，分别是：

1. 主题索引
2. 位置相近的卡片涉及的主题概览
3. 当前卡片相关的前一条、后一条
4. 笔记之间的链接

看到这段我发现在 obsidian 里做的 MOC，不就是第一种主题索引吗？flomo 里的批注则是第四种。

这里还要说明一下我对卡片笔记相关文章里常常提到的「用自己的话总结」这个观点的看法。

我认为，这一方法是需要按场景使用的，不能一概而论，比如，MOC 、双链笔记等概念我们真的需要做一张卡片笔记去解释什么叫 MOC 吗？重要的还是大概知道它是干什么的，如何使用就够了。现在这个时代真的没必要整理一个自己的 wiki 出来，只需要有个印象，知道它大概指的是什么，需要完整的解释的时候直接去搜就好了。

如果刻意去做「用自己的话总结」，好像是从收藏囤积怪变成了强行复述怪，都是一种形式主义的陷阱。这也是我觉得 MOC 很符合我的需求的原因，即整理的主体都是关键词，后续我都打算用做 MOC 的方式来完成知识体系。

在 obsidian 上写笔记有一个痛点，我总是忍不住纠结排版好不好看，浪费时间去调整样式，而且这类软件的通病还有移动端不够友好。有天我突然想到，为什么不把两者结合在一起呢？完整的 MOC 在 obsidian 里做，短文字和读书笔记依然在 flomo 里完成，在 flomo 里建的索引依然保留，但是按主题拆分成一条一条的，这样就不会每次划到索引的卡片就需要滑好几屏了。在 obsidian 里的索引关键词如果在 flomo 里也有，就把 flomo 的链接放到后面，这样就可以在 obsidian 里点击跳转到 flomo 去查看相关的卡片笔记啦。



![img](https://pic3.zhimg.com/80/v2-907d6a515de9b5176e2cb88533621812_1440w.webp)



如何拿到 flomo 某个标签下内容的链接？在 web 版的 flomo 里按标签查看时，网址里会带上标签的参数，如 [https://flomoapp.com/mine?tag=](https://link.zhihu.com/?target=https%3A//flomoapp.com/mine%3Ftag%3D)标签名。

obsidian 和 flomo 里各自的索引，我不打算刻意去做 100% 的同步。因为我能想到的同步方法只有手工完成，刻意追求这个就一定会陷入整理的陷阱，期待有大佬能实现自动同步。

如果对移动端的要求没有那么高，也可以选择用 bon 的 memos 插件直接在 obsidian 里完成 flomo 的部分。

另外，因此发现，还是希望 flomo 能把标签下的笔记数量和按标签排序做出来，这样才知道我最关心哪些关键词，哪些标签只有一条被遗忘了。

闪卡制作

因为打算用闪卡背面试题，在社群里咨询后得知 obsidian 里就有 anki 插件 spaced repetition，可以直接在 obsidian 里做闪卡，在手机上使用起来也还算方便。

网上已经有一些教程了我就不详细介绍了，可以看：

使用 Obsidian 插件 Spaced Repetition ([https://ithelp.ithome.com.tw/articles/10280788?sc=iThomeR#/](https://link.zhihu.com/?target=https%3A//ithelp.ithome.com.tw/articles/10280788%3Fsc%3DiThomeR%23/))

还可以在网上下载整理好的面经文章，再用 Note Refactor 插件按 markdown 的标题分成一张张卡片后再做成 anki 卡片。如果你有考研等需要背题的需求，也可以在 obsidian 里制作相关闪卡。

其它插件

**Title Serial Number Plugin**

做 MOC 的时候，我想要知道每篇文档的子标题数量，如果用有序列表操作起来不方便，手动设置序号在顺序变化的时候又要反复修改，后面发现有这个插件，可以一键设置和需要标题前的数字，可以参考这篇教程：[Obsidian插件介绍二](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzU4MzgxNjczMA%3D%3D%26mid%3D2247484626%26idx%3D1%26sn%3D264719c95bb2119880191ba6a1ef21dc%26chksm%3Dfda207a7cad58eb16bf903cb5cb7ef47a8294ee56b4428a3a3c37069309a0435c1160f0a7926%26scene%3D21%23wechat_redirect)



**![动图封面](https://pic2.zhimg.com/v2-e3ebe53e17d2a2c177bce0551664a745_b.jpg)**



**cmenu**

如果写笔记的时候不习惯用键盘的命令操作，可以使用 cmenu，上面的动图里点击的菜单就是这个插件。开启后在输入页面的下方会展示一个选择菜单，可以把一些常用命令设置为按钮，用鼠标替代键盘的快捷键。

obsidian 的其它用法我还没上手实践，每天在群里看群友们的用法都感慨太强了，也可以看这个链接了解更多 obsidian 的相关信息：[Obsidian优质内容合集](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzI4NjIwOTg3Nw%3D%3D%26mid%3D2650157191%26idx%3D1%26sn%3D811bc26447e7a4dc544b786b0aa6ade7%26chksm%3Df3e2f2bdc4957bab6f80b2840ce7b420e55e7e3cfc079cf2ef957da90c0b1cf0627093d2f17d%26scene%3D21%23wechat_redirect)。这个系列我应该还会更新，这篇就先介绍到这里，下次更新再见

编辑于 2022-02-02 14:54

[Obsidian](https://www.zhihu.com/topic/21349840)

[知识体系](https://www.zhihu.com/topic/19581102)

[flomo](https://www.zhihu.com/topic/21790462)