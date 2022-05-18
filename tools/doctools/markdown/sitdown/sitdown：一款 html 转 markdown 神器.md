# sitdown：一款 html 转 markdown 神器

[![FFFF](https://pic2.zhimg.com/v2-824bb3f896903ea749324bda44da40bf_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/xu-yun-feng-32)

[FFFF](https://www.zhihu.com/people/xu-yun-feng-32)

前端



26 人赞同了该文章

## **前言**

markdown 是一款非常强大且语法简洁的标记语言。我们**（特别是技术人员）**更加青睐它，用它来写文档、博客、文章等。

有些平台，比如掘金、csdn，技术人员使用较多，所以他们的编辑器支持 markdown，而有的平台，例如微信、知乎，则对 markdown 用户不太友好。

某些工具可以将 markdown 解析成这些平台兼容的 html，比如 **mdnice**。

但对于已经发布的文章，而你又不是原文作者，你想转发或者借鉴一段时，排版问题也许又会让你挠头不已。要是有一款兼容各大平台的 html 的转换器该多好呀！

基于此问题，我们调研了一些 html 转 markdown 工具，实际用起来发现效果并不尽人意，所以我们自己开发了 **sitdown** 。

## **用法**

### **非开发环境**

如果你只是想快速达成目的，可以直接进入我们的 **Demo 页**。

![img](https://pic3.zhimg.com/80/v2-b5c249d31df6740016d10fcd94bc8066_720w.jpg)

1. 将源 html 粘贴到左边的输入框中。

![img](https://pic1.zhimg.com/80/v2-13c02faa4c0764af3eb0ac4be3bf28ac_720w.jpg)



1. 选择 html 来源的平台。

![img](https://pic1.zhimg.com/80/v2-a974037627bf93251b18c3b088bd131c_720w.png)



1. 点击 transform。转换的 markdown 就生成在了右边的框中，并同时复制到了你的剪贴板。

![img](https://pic2.zhimg.com/80/v2-207c91bf7aa5de2fb215a7e273a19e7d_720w.jpg)



### **开发环境**

```text
// Node
var { Sitdown } = require('sitdown')

var sitdown = new Sitdown()
var markdown = sitdown.HTMLToMD('你的 html')
// ES
import { Sitdown } from 'sitdown/src.esm'

var sitdown = new Sitdown()
var markdown = sitdown.HTMLToMD('你的 html')
```

如果想转换某个平台的 html，可以使用**插件**：

例如：

```text
import { Sitdown } from 'sitdown/src.esm';
import { applyJuejinRule } from '@sitdown/juejin/src.esm';

let sitdown = new Sitdown({
      keepFilter: ['style'],
      codeBlockStyle: 'fenced',
      bulletListMarker: '-',
      hr: '---',
});
sitdown.use(applyJuejinRule);
```

### **搭配 mdnice 使用**

**mdnice**，是一款 markdown 转 html 的神器。markdown 经过它的转换，可以生成各种主题的微信 html 和知乎 html。

![img](https://pic1.zhimg.com/80/v2-230ed15fb65d429d79f240b47c9fbf48_720w.jpg)



它直接集成了 sitdown：

![img](https://pic1.zhimg.com/80/v2-38d7a09cdd57ce916b26fed7e70fb9d0_720w.jpg)



![img](https://pic3.zhimg.com/80/v2-2f03805331099f1b1737746089b03d0e_720w.jpg)

## **结语**

本库也是借鉴了开源界的思想和某些代码库，在一些细节上还需要完善和改进。所以也是 MIT 协议，如果大家对 mdnice 相关项目有兴趣，欢迎提供 pr 贡献。

发布于 2020-03-02 09:36

Markdown

Markdown语法