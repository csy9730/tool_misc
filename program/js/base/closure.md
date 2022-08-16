# closure 闭包
相当于有状态/有私有成员变量的函数，相当于一个只有一个方法的紧凑对象
和对象成员函数的区别是，闭包是函数本位，对象成员函数是对象本位。
jsvascript中，闭包在作用域内，可以自由捕获自由变量，获得捕获变量的副本，无需显式声明。php中函数需要通过use显式声明捕获的变量。
解释器在解释执行时，发现函数引用了非当前域的变量，就复制了那些变量生成了闭包？
注意： 闭包域和函数的定义位置相关，与调用位置无关。


而对象只能访问自己的成员变量。

#### closure demo
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


#### object demo
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

