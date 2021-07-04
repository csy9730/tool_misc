## HTML 文本格式化标签

| 标签                                                | 描述         |
| :-------------------------------------------------- | :----------- |
| [](https://www.runoob.com/tags/tag-b.html)          | 定义粗体文本 |
| [](https://www.runoob.com/tags/tag-em.html)         | 定义着重文字 |
| [](https://www.runoob.com/tags/tag-i.html)          | 定义斜体字   |
| [](https://www.runoob.com/tags/tag-small.html)      | 定义小号字   |
| [](https://www.runoob.com/tags/tag-strong.html)     | 定义加重语气 |
| [](https://www.runoob.com/tags/tag-sub.html)        | 定义下标字   |
| [](https://www.runoob.com/html/m/tags/tag-sup.html) | 定义上标字   |
| [](https://www.runoob.com/tags/tag-ins.html)        | 定义插入字   |
| [](https://www.runoob.com/tags/tag-del.html)        | 定义删除字   |

## HTML "计算机输出" 标签







## HTML <link> 元素

<link> 标签定义了文档与外部资源之间的关系。

<link> 标签通常用于链接到样式表:

```
<head>
<link rel="stylesheet" type="text/css" href="mystyle.css">
</head>
```







百度获取经纬度的例子（各浏览器适用，含IE5）：

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title></title>
    <!--引入百度 API，"ak=" 后面一串码是密钥，最好自己申请-->
    <script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=7a6QKaIilZftIMmKGAFLG7QT1GLfIncg"></script>
</head>
<body>
    <input type="button" onclick="getLocation()" value="确认" />
    <div id="position"></div>
    <script type="text/javascript">
    var x = document.getElementById('position');
    function getLocation() {
        // 创建百度地理位置实例，代替 navigator.geolocation
        var geolocation = new BMap.Geolocation();
        geolocation.getCurrentPosition(function(e) {
            if(this.getStatus() == BMAP_STATUS_SUCCESS){
                // 百度 geolocation 的经纬度属性不同，此处是 point.lat 而不是 coords.latitude
                x.innerHTML = '纬度：' + e.point.lat + '<br/>经度：' + e.point.lng;
            } else {
                x.innerHTML = 'failed' + this.getStatus();
            }
        });
    }
    </script>
</body>
</html>