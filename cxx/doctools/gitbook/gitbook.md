# gitbook

[TOC]



GitBook 是一个基于 Node.js 的命令行工具，可以从markdown格式文档生成pdf文档/html文档。

## 安装


1. 安装 node.js 和npm
2. npm install -g gitbook-cli
3. gitbook -V 
5. 安装calibrate (用于导出pdf/epub格式)



nodejs安装完成之后，你可以使用下面的命令来检验是否安装成功。下面显示的是nodejs版本号

```bash
$ node -v
v7.7.1
```

gitbook 安装完成之后，你可以使用下面的命令来检验是否安装成功。

``` bash
$ gitbook -V
CLI version: 2.3.2
GitBook version: 3.2.3
```



## demo

进入一个markdown文档目录

`gitbook init`创建 README.md 和 SUMMARY.md 这两个文件，README.md 就是说明文档，而 SUMMARY.md 其实就是书的章节目录。

 `gitbook serve` 命令，然后在浏览器地址栏中输入 `http://localhost:4000` 便可预览书籍。该命令后会在书籍的文件夹中生成一个 `_book` 文件夹, 里面的内容即为生成的 html 文件。

`gitbook build`可以生成网页而不开启服务器。

`gitbook pdf .`可以生成book.pdf文件。

`gitbook epub .`可以生成book.epub文件。

` gitbook install`可以安装从book.json文件中安装插件

``` bash
gitbook init
gitbook server
gitbook install 
gitbook pdf .
gitbook epub .
```



## 目录结构

GitBook 基本的目录结构如下所示：

``` bash
.
├── book.json
├── README.md
├── SUMMARY.md
├── chapter-1/
|   ├── README.md
|   └── something.md
└── chapter-2/
    ├── README.md
    └── something.md
```



## 配置

在目录创建book.json，可以对gitbook进行配置。

常见配置项:

* title: 本书标题
* author：作者
* description：描述
* language：语言

```json
{
    "title": "Blankj's Glory",
    "author": "Blankj",
    "description": "select * from learn",
    "language": "zh-hans",
    "gitbook": "3.2.3",
    "styles": {
        "website": "./styles/website.css"
    },
    "structure": {
        "readme": "README.md"
    },
    "plugins": [
        "-sharing",
        "splitter",
        "expandable-chapters-small",
        "anchors",

        "github",
        "github-buttons",
        "donate",
        "sharing-plus",
        "anchor-navigation-ex",
        "favicon"
    ],
    "pluginsConfig": {
        "github": {
            "url": "https://github.com/Blankj"
        },
        "github-buttons": {
            "buttons": [{
                "user": "Blankj",
                "repo": "glory",
                "type": "star",
                "size": "small",
                "count": true
                }
            ]
        },
        "donate": {
            "alipay": "./source/images/donate.png",
            "title": "",
            "button": "赞赏",
            "alipayText": " "
        },
        "sharing": {
            "douban": false,
            "facebook": false,
            "google": false,
            "hatenaBookmark": false,
            "instapaper": false,
            "line": false,
            "linkedin": false,
            "messenger": false,
            "pocket": false,
            "qq": false,
            "qzone": false,
            "stumbleupon": false,
            "twitter": false,
            "viber": false,
            "vk": false,
            "weibo": false,
            "whatsapp": false,
            "all": [
                "google", "facebook", "weibo", "twitter",
                "qq", "qzone", "linkedin", "pocket"
            ]
        },
        "anchor-navigation-ex": {
            "showLevel": false
        },
        "favicon":{
            "shortcut": "./source/images/favicon.jpg",
            "bookmark": "./source/images/favicon.jpg",
            "appleTouch": "./source/images/apple-touch-icon.jpg",
            "appleTouchMore": {
                "120x120": "./source/images/apple-touch-icon.jpg",
                "180x180": "./source/images/apple-touch-icon.jpg"
            }
        }
    }
}
```

## misc



**Q** : Error: ENOENT: no such file or directory, stat 'C:\Users\CSY_AC~1\AppData\Local\
Temp\tmp-1397236171qco2SJ6\gitbook\gitbook-plugin-highlight\ebook.css'

**A** :打开C:\Users\admin\.gitbook\versions\3.2.3\copyPluginAssets.js，替换所有`confirm: true` 为 `confirm: false`

