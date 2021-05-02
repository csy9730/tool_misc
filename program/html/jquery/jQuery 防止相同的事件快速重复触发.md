# [jQuery 防止相同的事件快速重复触发](https://www.cnblogs.com/pyspang/p/9766293.html)



重复触发就是防止用户重复点击提交数据了，我们一般都是点击之后没反应会再次点击了，这个不但要从用户体验上来做好，还在要js或php程序脚本上做好，让用户知道点击是己提交服务器正在处理，下面我就整理从脚本上来处理此重复触发的问题。

很多时候事件会被快速重复触发，比如 click，这样就会执行两次代码，造成很多后果。现在有比较多的解决方法，但几乎都有局限性，比如一个 Ajax 表单，如果防止用户一次点好多下可以在第一次点击的时候冻结提交按钮，直到允许再次点击的时候再放开。很多人都这样干，但在其他的情况就不是很有效了。

 

下面推荐一个不错的方法，首先丢一个函数进去。

```
var _timer = {};
function delay_till_last(id, fn, wait) {
    if (_timer[id]) {
        window.clearTimeout(_timer[id]);
        delete _timer[id];
    }
 
    return _timer[id] = window.setTimeout(function() {
        fn();
        delete _timer[id];
    }, wait);
}
```

使用方法:

```
$dom.on('click', function() {
    delay_till_last('id', function() {//注意 id 是唯一的
        //响应事件
    }, 300);
});
```

上面的代码可以让点击之后等待 300 毫秒，如果在 300 毫秒内又发生了这个事件则废除上一次点击，重新计时，反复如此，直到完全等待了 300 毫秒再响应事件。

 

这个函数很有用的，比如验证输入或者根据输入的邮箱实时拉去头像而不用等到必须失焦再拉取。

 

例子

按钮BUTTON类
a标签类

对于第一类情况，button有一个属性是disabled控制其是否可以点击,看代码

```
<input type="button" value="Click" id="subBtn"/>
<script type="text/javascript">
function myFunc(){
    //code
    //执行某段代码后可选择移除disabled属性，让button可以再次被点击
    $("#subBtn").removeAttr("disabled");
}
$("#subBtn").click(function(){
    //让button无法再次点击
    $(this).attr("disabled","disabled");
    //执行其它代码，比如提交事件等
    myFunc();
});
</script>
```

 

在此，我用过第二种方法，简单可行！！

 

你的坚持 ------ 终将美好 ~



分类: [js](https://www.cnblogs.com/pyspang/category/1042874.html)