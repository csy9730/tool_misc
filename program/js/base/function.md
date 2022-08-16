# function


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
