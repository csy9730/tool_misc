# html5



所有浏览器都支持 <meta> 标签。

定义和用法
<meta> 元素可提供有关页面的元信息（meta-information），比如针对搜索引擎和更新频度的描述和关键词。

<meta> 标签位于文档的头部，不包含任何内容。<meta> 标签的属性定义了与文档相关联的名称/值对。
## base

``` html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>菜鸟教程(runoob.com)</title>
</head>
<body>
 
<h1>我的第一个标题</h1>
 
<p>我的第一个段落。</p>
 
</body>
</html>
```

* <!DOCTYPE html> 声明为 HTML5 文档
* <html> 元素是 HTML 页面的根元素
* <head> 元素包含了文档的元（meta）数据，如 <meta charset="utf-8"> 定义网页编码格式为 utf-8。
* <title> 元素描述了文档的标题
* <body> 元素包含了可见的页面内容
* <h1> 元素定义一个大标题
* <p> 元素定义一个段落
注：在浏览器的页面上使用键盘上的 F12 按键开启调试模式，就可以看到组成标签。

只有 <body> 区域, 才会在浏览器主体中显示。
head 区域，会显示在浏览器标题栏

目前在大部分浏览器中，直接输出中文会出现中文乱码的情况，这时候我们就需要在头部将字符声明为 UTF-8 或 GBK。

## 

下面列出了适用于大多数 HTML 元素的属性：

| 属性  | 描述                                                         |
| :---- | :----------------------------------------------------------- |
| class | 为html元素定义一个或多个类名（classname）(类名从样式文件引入) |
| id    | 定义元素的唯一id                                             |
| style | 规定元素的行内样式（inline style）                           |
| title | 描述了元素的额外信息 (作为工具条使用)                        |

更多标准属性说明： [HTML 标准属性参考手册](https://www.runoob.com/tags/ref-standardattributes.html).


## main
element

### text
``` html
<h1>这是一个标题</h1>
<h2>这是一个标题</h2>
<h3>这是一个标题</h3>

<p>这是一个段落。</p>
<p>这是另外一个段落。</p>

<hr> 
<p>标签在 HTML 页面中创建水平线。</p>

<br>
<!-- 这是一个注释 -->

<a href="https://www.runoob.com">这是一个链接</a>

<img loading="lazy" src="/images/logo.png" width="258" height="39" />
```
### link
HTML <base> 元素
<base> 标签描述了基本的链接地址/链接目标，该标签作为HTML文档中所有的链接标签的默认链接:
``` html
<head>
<base href="http://www.runoob.com/images/" target="_blank">
</head>
```

### table

### div/span

### form

### iframe

### img
### ul



### HTML <meta> 元素

meta标签描述了一些基本的元数据。

<meta> 标签提供了元数据.元数据也不显示在页面上，但会被浏览器解析。

META 元素通常用于指定网页的描述，关键词，文件的最后修改时间，作者，和其他元数据。

元数据可以使用于浏览器（如何显示内容或重新加载页面），搜索引擎（关键词），或其他Web服务。

<meta> 一般放置于 <head> 区域

为搜索引擎定义关键词:

```
<meta name="keywords" content="HTML, CSS, XML, XHTML, JavaScript">
```

为网页定义描述内容:

```
<meta name="description" content="免费 Web & 编程 教程">
```

定义网页作者:

```
<meta name="author" content="Runoob">
```

每30秒钟刷新当前页面:

```
<meta http-equiv="refresh" content="30">
```



### HTML <script> 元素