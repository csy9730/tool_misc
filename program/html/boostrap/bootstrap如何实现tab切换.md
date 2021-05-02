# bootstrap如何实现tab切换

2020-11-21 10:10:25分类：[前端框架](https://www.html.cn/framework/) / [Bootstrap 教程](https://www.html.cn/framework/bootstrap/)阅读(623)评论(0)



![img](https://img.html.cn/upload/article/000/000/004/5fb8763e08c00162.jpg)



**bootStrap实现tab页切换**

bootStrap可以简单方便的实现tab页面的切换

用法

通过data属性

可以无需写任何JavaScript来激活标签式或圆角式的导航, 只需在元素上简单的指定 data-toggle=”tab” 或 data-toggle=”pill”. 在标签 ul 添加 nav 和 nav-tabs 属性, 将应用Bootstrap标签样式.

![c8cd5bd34c945e262123d8c33033310.png](https://img.html.cn/upload/image/759/211/307/1605924471327862.png)

```
<ul class="nav nav-tabs">
  <li><a href="#home" data-toggle="tab">首页</a></li>
  <li><a href="#profile" data-toggle="tab">介绍</a></li>
  <li><a href="#messages" data-toggle="tab">消息</a></li>
  <li><a href="#settings" data-toggle="tab">设置</a></li>
</ul>
```

通过JavaScript

通过JavaScript启用可切换标签 (每个标签都需要单独激活):

```
$('#myTab a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
})
```

以多种方式激活标签:

```
$('#myTab a[href="#profile"]').tab('show'); // 通过名字选择
$('#myTab a:first').tab('show'); // 选择第一个标签
$('#myTab a:last').tab('show'); // 择最后一个标签
$('#myTab li:eq(2) a').tab('show'); // 选择第三个标签
```

方法

$().tab

激活一个标签页元素和内容容器。标签页应该含有 data-target 或 href 属性以指向dom中的某个容器节点。

举个栗子

![2452e0da28fbec51071186c8ddc9069.png](https://img.html.cn/upload/image/794/598/675/1605924503474971.png)

```
<ul class="nav nav-tabs" id="myTab">
  <li class="active"><a href="#home">首页</a></li>
  <li><a href="#profile">介绍</a></li>
  <li><a href="#messages">消息</a></li>
  <li><a href="#settings">设置</a></li>
</ul>
<div class="tab-content">
  <div class="tab-pane active" id="home">.首页内容..</div>
  <div class="tab-pane" id="profile">介绍内容...</div>
  <div class="tab-pane" id="messages">.消息内容..</div>
  <div class="tab-pane" id="settings">.设置内容..</div>
</div>
<script>
  $(function () {
    $('#myTab a:last').tab('show');
  })
  $('#myTab a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
})
</script>
```

事件

![beedb4269780a6e09b468178588f3d5.png](https://img.html.cn/upload/image/269/187/521/1605924520576683.png)

```
$('a[data-toggle="tab"]').on('shown', function (e) {
  e.target // 当前活动的标签
  e.relatedTarget // 上一个选择的标签
})
```

以上就是bootstrap如何实现tab切换的详细内容，更多请关注html中文网其它相关文章！