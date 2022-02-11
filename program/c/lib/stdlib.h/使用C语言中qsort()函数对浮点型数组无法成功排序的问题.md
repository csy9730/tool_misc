# [使用C语言中qsort()函数对浮点型数组无法成功排序的问题](https://www.cnblogs.com/laizhenghong2012/p/8509938.html)


## 本节内容

本节主要内容是有关C语言中qsort()函数的探讨。

``` c
void qsort(void* base, size_t num, size_t size,int (*compar)(const void*,const void*));
```

## **二 问题和相应解决方法**

qsort()是C标准库中的一个通用的排序函数。它既能对整型数据进行排序也能对浮点型数据进行排序。今天在写C语言程序时遇到了一个奇怪的事情。在使用qsort()对double型数据排序时，我发现qsort()竟然没有排序成功，数组中的数据仍然是乱序的！比如下图所示的这个程序。

![img](https://images2018.cnblogs.com/blog/1333489/201803/1333489-20180305165359529-671311793.png)

上面这个程序的输出结果为：1.72 1.78 1.61 1.65 1.70 1.56。和原始输入数据顺序一致。也就是说qsort()函数根本没有起到应有的作用。这是为什么呢？



后来才发现，这个问题出在了比较函数Compare()上了。qsort()要求Compare()函数的返回值必须是int类型。如上图所示，Compare()函数的返回值竟然不是int而是double类型。因此，将上述程序改写成下面的样子，问题解决。

![img](https://images2018.cnblogs.com/blog/1333489/201803/1333489-20180305165438574-160994052.png)

 



分类: [程序调试](https://www.cnblogs.com/laizhenghong2012/category/1193432.html)

标签: [C语言](https://www.cnblogs.com/laizhenghong2012/tag/C语言/), [qsort()](https://www.cnblogs.com/laizhenghong2012/tag/qsort()/), [出错](https://www.cnblogs.com/laizhenghong2012/tag/出错/)