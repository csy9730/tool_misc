# [Bootstrap3基础 list-inline 无序列表横向显示](https://www.cnblogs.com/kemingli/p/10545398.html)



 

| 内容        | 参数                      |
| ----------- | ------------------------- |
| OS          | Windows 10 x64            |
| browser     | Firefox 65.0.2            |
| framework   | Bootstrap 3.3.7           |
| editor      | Visual Studio Code 1.32.1 |
| typesetting | Markdown                  |

 

## code

```html
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <!-- IE将使用最新的引擎渲染网页 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- 页面的宽度与设备屏幕的宽度一致
         初始缩放比例 1:1 -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Demo</title>
    <meta name="author" content="www.cnblogs.com/kemingli">

    <!-- 引入外部bootstrap的css文件(压缩版)，版本是3.3.7 -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">

    <!-- HTML5 shim 和 Respond.js 是为了让 IE8 支持 HTML5 元素和媒体查询（media queries）功能 -->
    <!-- 警告：通过 file:// 协议（就是直接将 html 页面拖拽到浏览器中）访问页面时 Respond.js 不起作用 -->
    <!--[if lt IE 9]>
        <script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>
    <![endif]-->
</head>

<body>

    <!-- start : demo -->
    <div class="container" style="background-color:darkseagreen;">
        <!-- list-unstyled:去掉原有的格式 -->
        <ul class="list-unstyled">
            <li>水仙</li>
            <li>人参</li>
            <li>丹参</li>
            <li>知母</li>
            <li>牡丹</li>
            <li>山姜</li>
            <li>郁金</li>
            <li>香附子</li>
        </ul>

        <!-- 无序列表纵向变横向 -->
        <ul class="list-unstyled list-inline">
            <li>夏枯草</li>
            <li>干地黄</li>
            <li>苍耳</li>
            <li>山豆根</li>
            <li>大黄</li>
            <li>山葡萄</li>
            <li>大枣</li>
            <li>栗</li>
        </ul>
    </div>
    <!-- end : demo -->

    <!-- NO.1 加载框架依赖的jQuery文件(压缩版)，版本是1.12.4 -->
    <script src="bootstrap/js/jquery.min.js"></script>
    <!-- NO.2 加载Bootstrap的所有JS插件，版本是3.3.7 -->
    <script src="bootstrap/js/bootstrap.min.js"></script>
</body>

</html>
```

 

## result

![img](https://img2018.cnblogs.com/blog/940935/201903/940935-20190317090808296-2123043186.png)

 

## resource

- [ 文档 ] getbootstrap.com/docs/3.3
- [ 源码 ] github.com/twbs/bootstrap
- [ 源码 ] archive.mozilla.org/pub/firefox/releases/65.0/source/
- [ 平台 ] www.cnblogs.com
- [ 平台 ] github.com
- [ 扩展 - 平台] www.bootcss.com
- [ 扩展 - 浏览器 ] www.mozilla.org/zh-CN/firefox/developer

 

------

Bootstrap是前端开源框架，优秀，值得学习。
博文讲述的是V3版本，更为先进的是V4版本。学有余力的话，可作简单地了解。
Firefox是开源的浏览器，优秀，值得关注。
面对开源框架，分析、领悟与应用，能对其进行加减裁化，随心所欲而不逾矩。
博文的质量普通，仅供参考。盲目复制，处处是坑。Think twice before you act(三思而后行)！

**初学指路**：善于发现他人的优点和身边的美丽，以此来塑造匠心。
**学习总纲**：人法地，地法天，天法道，道法自然。



分类: [Bootstrap3基础](https://www.cnblogs.com/kemingli/category/1421352.html)

标签: [Bootstrap3](https://www.cnblogs.com/kemingli/tag/Bootstrap3/)