# HTML显示PDF文件内容——pdf.js

[![历尘](https://pic1.zhimg.com/v2-df44d0d4e142208bc02d2f3c21532b48_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/li-chen-67-98-37)

[历尘](https://www.zhihu.com/people/li-chen-67-98-37)





8 人赞同了该文章

## 前言

目前显示pdf内容的解决方案其实不少，个人这边接触到的前端常用的可以使用FireFox火狐的PDF.js库，后端可以使用Itext框架等。本文主要介绍PDF.js库的实现方案，至于有朋友对Itext（这里做一个简单说明，目前最新的是itext7，同时itext5和7是不兼容的哦）的实现方案感兴趣的欢迎留言私信，后续也会推出相应的的说明文章。

## 一、显示pdf内容的几种方式

这里简单说以下几种方式，分为官方在线以及自己本地搭建两种方式：

- 官方在线预览

官方在线预览使用这个地址即可实现文件查看，同时官方提供了一套简单的ui供操作[http://mozilla.github.io/pdf.js/web/viewer.html](https://link.zhihu.com/?target=http%3A//mozilla.github.io/pdf.js/web/viewer.html)?file=xxx/xxx/xxx.pdf

- 本地或者服务端自行搭建

这种方式其实依然可以利用源码中的viewer.html如上述方式实现预览查看，同时也可以通过代码读取文件内容渲染查看（关于源码编译的方式后文有相应介绍）

## 二、获取pdf.js库文件

获取方式有两种~

**第一种：直接使用官方编译好的文件进行使用，注意es5和es6两种版本，根据自己的实际情况选择性使用~**

**第二种：使用官方源码进行编译产生库文件使用。**

**2.1 直接下载官方库文件**

官方下载地址：[Getting Started](https://link.zhihu.com/?target=http%3A//mozilla.github.io/pdf.js/getting_started/%23download)

![img](https://pic1.zhimg.com/80/v2-de04cb29635ba1bf12b956889f753b30_720w.jpg)官方截图

**2.2 源码编译**

由于官方源码在github上开源，因此下载编译最好使用git进行，官方也推荐使用git，关于git如何安装使用可自行百度，如果不清楚也可以直接下载压缩包文件使用。

下载方式：

```text
git clone https://github.com/mozilla/pdf.js.git
```

编译：

```text
// 进入源码文件夹
cd pdf.js

// 安装gulp脚手架
npm install -g gulp-cli

// 安装项目依赖
npm install

// 编译es6版本
gulp generic

// 编译es5版本
gulp generic-es5
```

注意：

- 以上需要使用到npm命令，需要自行安装node和npm支持
- 源码下载路径如果是window用户，建议不要在c盘进行
- 使用命令时最好使用管理员身份进行操作，以免权限干扰导致无法编译成功

![img](https://pic3.zhimg.com/80/v2-6cb4c95fdf6422bd624a75775566a8d2_720w.jpg)编译pdf.js库

使用上述方式编译成功后会在build文件夹中出现generic文件夹，里面正是如官方下载后的库文件，使用方式相同。

![img](https://pic3.zhimg.com/80/v2-1a666f7eefdc592dd7a2297ad44ef60a_720w.png)编译后产生的文件

## 三、使用PDF.js显示pdf文件内容

（这里显示方式不包括上文提到的官方在线连接显示方式）

**3.1 使用viewer.html显示**

使用类似路径即可查看xxxx/[web/viewer.html](https://link.zhihu.com/?target=http%3A//mozilla.github.io/pdf.js/web/viewer.html)?file=xxx/xxx/xxx.pdf

**3.2 使用代码方式自行读取显示**

- 在代码中引入pdf.js库

```js
<script src="./build/pdf.js"></script>
<script src="./build//pdf.worker.js"></script>
```

- 使用一个canvas接收需要读取到的pdf内容进行显示

```html
<canvas id="myCanvas"></canvas>
```

- 创建读取对象

```js
var loadingTask = pdfjsLib.getDocument(data)
```

以上代码中data可以是pdf文件对应的Base64字符串，也可以是文件所在相对或者绝对路径，也可以是一个在线文件url地址。

```js
loadingTask.promise.then(function (pdf) {
                for (var i = 1; i <= pdf.numPages; i++) {
                    pdf.getPage(1).then(function (page) {
                        var scale = 2
                        var viewport = page.getViewport({ scale: scale })

                        var canvas = document.getElementById('myCanvas')
                        var context = canvas.getContext('2d')
                        canvas.height = viewport.height
                        canvas.width = viewport.width

                        var renderContext = {
                            canvasContext: context,
                            viewport: viewport,
                        };
                        page.render(renderContext);
                    })
                }
            });
```

## 四、总结

在读取显示PDF文件的应用中，可以根据实际情况作出调整，比如文件显示的方法缩小、文件显示后再上面累加一些控件，并实现相应交互效果等等，授人以鱼+渔，这里提供一个我之前写的demo供大家参考，[No.N/pdfViewer](https://link.zhihu.com/?target=https%3A//gitee.com/No.N/pdf-viewer)



发布于 2021-02-09 16:34

PDF

HTML