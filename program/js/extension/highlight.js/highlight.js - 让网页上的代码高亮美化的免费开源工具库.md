# highlight.js - 让网页上的代码高亮美化的免费开源工具库

[![那些免费的砖](https://pic1.zhimg.com/v2-c5fc73274b6e3a520ffedc8a0c766346_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/weyman)

[那些免费的砖](https://www.zhihu.com/people/weyman)

常年收集免费商用/开源资源，博客 thosefree.com



1 人赞同了该文章

一行代码就能让我的网站支持代码高亮的工具库，也支持在 Vue 中使用，强烈推荐给大家。

## 关于 highlight.js

highlight.js 是一款使用 [javascript](https://link.zhihu.com/?target=https%3A//www.thosefree.com/tag/javascript) 开发代码高亮工具库，能够让网页上的代码显示接近我们使用的代码编辑器的高亮样式，从而看起来更舒服，增强阅读体验。

![img](https://pic4.zhimg.com/80/v2-2c54c9434da625f79a8ce36c01ece1e3_720w.jpg)highlight.js 官网截图

## highlight.js 的技术特性

- 支持 197 种开发语言和 246 种代码高亮风格主题
- 自动开发语言检测
- 支持多种语言混合代码同时高亮
- 支持任何 HTML 标签，不仅仅是<code></code>
- 支持 npm 安装，可以在 [Vue.js](https://link.zhihu.com/?target=https%3A//www.thosefree.com/tag/vue) 中使用，也可以在 node.js 中使用
- 无依赖，与任何 js 框架兼容

## 为什么要用 highlight.js

常来我网站的小伙伴都知道，我的文章有一个栏目是“前端”，主要推荐一些实用的前端开源项目或者组件库，写技术类文章免不了要贴代码，我的网站基于 wordpress 搭建，此前我一直为找一款代码高亮插件烦恼，但大部分 wordpress 的代码高亮插件实在太臃肿，出来的样式又不美观。大多时候是截图 VsCode 的代码界面，甚至还用过 [codepng](https://link.zhihu.com/?target=https%3A//www.thosefree.com/codepng) 这个工具把代码变成图片贴在文章中，但这样做是美观了，但也存在2个问题：

- 长代码图片会缩放，阅读体验不佳
- 搜索引擎不识别，对 SEO 不友好

最终还是找到了 highlight.js，完美解决了上面两个问题，而且配置简单，演示漂亮，定制化简单。不禁感叹：用纯前端的方式解决，才能精准控制，实现想要的效果。

## 使用教程：为我的网站添加代码高亮功能

下面以我的网站为例，展示将 highlight.js 用在我们的项目的方法。首先 highlight.js 支持 cdn 直接引入和 npm 安装，我的网站基于 wordpress 开发，主题是自己写的，最简单的方式就是在文章详情页引入 highlight.js 和主题样式。

虽然 highlight.js 支持几百种开发语言，但为了将文件体积控制到最小，我们可以点击“get version”按钮进入下载页，通过勾选我们需要的开发语言，来构建最轻量的库。

![img](https://pic4.zhimg.com/80/v2-a31451c31f0db74e11f85d6a07c394bf_720w.jpg)选择支持的开发语言

下载解压后得到的 highlight.min.js 就是我们需要引入的 js 文件，主题样式都在 style 文件夹里，我选择了一个比较喜欢的 monokai-sublime 主题，只需要一个 css 文件，然后初始化：

```text
<link href="/js/monokai-sublime.min.css" rel="stylesheet" type="text/css">
<script src="/js/highlight.min.js"></script>
<script>
   hljs.highlightAll();
</script>
```

就是这么简单，highlight.js 会自动将文章中的 <pre><code></code></pre> 代码进行识别语言并且高亮，一切就是这么简单。为了让代码显示更协调，我用几行 css 控制了包裹层的圆角以及背景颜色、字体大小等，大功告成。

```text
.post-content .wp-block-code {
   background-color: #F6F8FF;
   border-radius: 16px;
   font-size: 16px;
   padding: 22px 22px 22px 38px;
   margin-top: 22px;
   margin-bottom: 22px;
}
.post-content .wp-block-code {
   line-height: 1.2;
   font-size: 15px;
   padding: 10px;
   overflow-x: auto;
}
.post-content .wp-block-code code {
   position: relative;
   background-color: unset !important;
}
```

当然 highlight.js 也能在 vue 项目中使用，安装：

```text
npm install highlight.js
```

在 Vue 文件中使用 (通过 highlight.js for Vue ) ：

```text
<div id="app">
  <!-- bind to a data property named `code` -->
  <highlightjs autodetect :code="code" />
  <!-- or literal code works as well -->
  <highlightjs language='javascript' code="var x = 5;" />
</div>
```

需要注意的是，自动识别模式不能100%识别出代码所属的开发语言，识别错误会导致高亮样式是别的语言的，这种情况下可以手动设置一个 class 来精准控制：

```text
<pre><code class="language-javascript">...</code></pre>
```

官网提供了详尽的使用文档，有更多代码高亮的控制，但不足的就是 highlight.js 没有显示行号的支持，需要通过再引入一个库 (highlightjs-line-numbers.js) 或者自行实现。

## 免费开源说明

highlight.js 是一款基于 [BSD 许可证](https://link.zhihu.com/?target=https%3A//github.com/highlightjs/highlight.js/blob/main/LICENSE)开源的 [javascript](https://link.zhihu.com/?target=https%3A//www.thosefree.com/tag/javascript) 工具库，任何个人和公司都可以免费下载用于自己的项目，包括商用项目。

## 相关网址

[https://highlightjs.org/](https://link.zhihu.com/?target=https%3A//highlightjs.org/)

本专栏持续分享高质量的免费开源、免费商用的资源，欢迎关注。

发布于 2022-05-22 15:27

开源

JavaScript