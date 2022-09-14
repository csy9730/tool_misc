# html中通过点击button标签实现页面跳转的三种方法



方法1：使用onclick事件

``` html
<input type="button" value="按钮"onclick="javascrtpt:window.location.href='http://www.baidu.com/'" />
```

或者直接使用button标签

``` html
<button onclick="window.location.href = 'https://www.baidu.com/'">百度</button>
```

（推荐教程：html教程）

方法2：在button标签外套一个a标签

``` html
<a href="http://www.baidu.com/">    <button>百度</button></a>
```

或使用

``` html
<a href="http://www.baidu.com/"><input type="button" value='百度'></a>
```

方法3：使用JavaScript函数

``` html
<script>
    function jump(){ window.location.href="http://www.baidu.com/";}
</script>
<input type="button" value="百度" onclick=javascrtpt:jump() />// 或者
<input type="button" value="百度" onclick="jump()" />// 或者
<button onclick="jump()">百度</button>
```

