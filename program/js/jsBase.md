# javaScript

## 基础

* 变量类型
* 函数
* math库

js 的域访问控制非常弱，只有全局域(global scope)，函数域(block scope)，知道ES6开始才有块级作用域(block scope)
###  function


函数定义的多种方法

函数声明
匿名函数
匿名函数 表达式
#### IIFE

立即调用函数 IIFE(immediately invoked function expression)
由于没有块级作用域，通常用IIFE提供函数域代替，防止污染全局命名空间。
``` js
function foo(){
    var a=10;
    console.log(a);
}
foo(); // no IIFE 

// use IIFE
(function foo(){
    var a=10;
    console.log(a);
})();

```


Function的内置属性方法
由于js是 面向对象的，所有的函数都是成员函数，都有一个this指针，全局函数的this指针指向一个全局默认对象，（web浏览器中指向windows对象）

call 和apply 的使用方法？
call 的输入是 参数数组。
apply的输入是 单个数组输入。
``` js
function myFunction(a,b){
    return a*b;
}
var myObject = myFunction.call(null,10,2);
var myObject2 = myFunction.apply(null,[10,2]);
```

``` js
function myFunction2(a){
    return a+this.b;
}
var obj={b:3,a:2};
var v3 = myFunction2.call(obj,10);

```

箭头函数



## 进阶
* 匿名函数
* filter

closure 闭包
相当于有状态/有私有成员变量的函数，相当于一个只有一个方法的紧凑对象
和对象成员函数的区别是，闭包是函数本位，对象成员函数是对象本位。
jsvascript中，闭包在作用域内，可以自由捕获自由变量，获得捕获变量的副本，无需显式声明。php中函数需要通过use显式声明捕获的变量。
解释器在解释执行时，发现函数引用了非当前域的变量，就复制了那些变量生成了闭包？
注意： 闭包域和函数的定义位置相关，与调用位置无关。



而对象只能访问自己的成员变量。
``` JS
function f1(){
    var a = 0;
    return function inc(){
        console.log(a++);
    }
}
var _inc = f1();
_inc();
_inc();
var _inc2 = f1();
_inc2();

```

``` js
var obj = {
    count:0,
    inc:function(){
        return ++this.count;
    }
}
obj.inc();
obj.inc();
```

通过以上的例子对比可以发现，两者效果相当，而闭包的写法更为紧凑，毕竟`inc()`比  `obj.inc()`短
如果使用链式调用，闭包简短的特点会更加显著。
### let


``` js
for (var i=1;i<=5;i++){
    setTimeout(function timer(){
        console.log(i);
    },i*1000);
}

for (let i=1;i<=5;i++){
    setTimeout(function timer(){
        console.log(i);
    },i*1000); 
}

```



## misc

如何执行js代码？

* 浏览器url栏执行js，`javascript:alert('hello from address bar :)');`,需要显式添加javascript:到行首。
* 打开chrome devTools，选择console页面，可以以交互式输入执行代码



安卓手机浏览器Yandex可以通过油猴插件安装JS脚本，从而实现高速下载百度云文件、破解B站限定港澳台番剧观看和免费观看腾讯、爱奇艺VIP视频等功能。

data:text/html, <html contenteditable>

javascript 有 ECMAScript ，DOM，BOM组成，
BOM 是浏览器对象，DOM 是文档对象，BOM对象嵌入了DOM对象


##  scope
domain
scope
context
environment
