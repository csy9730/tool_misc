# jQuery对url参数的获取与拼接

1、url参数的获取

通过window.location.search可以获得参数。如url为：http://xxx.htm?test1=1&test2=2,使用window.location.search后，将获取到：?test1=1&test2=2，不过即使这样，如果我们想提取里面的参数还不是很方便。下面提供一个正则匹配的方法：

```javascript
function getUrlParam(name) {
 var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
 var r = window.location.search.substr(1).match(reg); //匹配目标参数
 if (r != null) return unescape(r[2]); return null; //返回参数值
}
```

2、参数拼接

如果我们有这样一些参数：

{"test1":"1","test2":"2"},如果想把k，v变成`?test1=1&test2=2`方式，可以用下面方法：

```javascript
var d = {"test1":"1","test2":2,"test3":true,"test4":false, "test5":null};
var url = rootUrl()+"api/menu";
return $http({
    method:"Get",
    url:url,
    data:jQuery.param(d),//ajax方式
    headers: {'Content-Type': 'application/x-www-form-urlencoded'}
})
// "test1=1&test2=2&test3=true&test4=false&test5="
```

 

github 的高级搜索生成的字符串：

[https://github.com/search?q=dnn+tf+created%3A%3E2015-01-01+stars%3A%3E10+language%3APython&type=Repositories&ref=advsearch&l=Python&l=](https://github.com/search?q=dnn+tf+created%3A%3E2015-01-01+stars%3A%3E10+language%3APython&type=Repositories&ref=advsearch&l=Python&l=)

