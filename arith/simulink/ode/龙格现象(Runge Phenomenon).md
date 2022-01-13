# 龙格现象(Runge Phenomenon)

[![MathICU](https://pic2.zhimg.com/v2-fdfe785c8ce9fb9163aceb95fbb96a27_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/sslchi)

[MathICU](https://www.zhihu.com/people/sslchi)



浙江大学 计算数学博士



113 人赞同了该文章

原问题为

[用matlab怎么实现对一组离散数据进行拉格朗日插值及龙格现象，求代码？24 赞同 · 5 评论回答![img](https://pic3.zhimg.com/v2-e295e513a9aca23f6827f859f8ce4a26_180x120.jpg)](https://www.zhihu.com/question/393112547/answer/1206435513)



## **龙格现象**

在科学计算领域，龙格现象（Runge）指的是对于某些函数，使用均匀节点构造高次多项式差值时，在插值区间的边缘的误差可能很大的现象。它是由Runge在研究多项式差值的误差时发现的，这一发现很重要，因为它表明，并不是插值多项式的阶数越高，效果就会越好。

最经典的一个例子是在均匀节点上对龙格函数

![[公式]](https://www.zhihu.com/equation?tex=f%28x%29+%3D+%5Cfrac%7B1%7D%7B1%2B25x%5E2%7D%2C%5C+x%5Cin%5B-1%2C1%5D+%5C%5C)

进行插值(效果如下图)，







## **产生原因**

对于以均匀节点为插值节点的插值函数![[公式]](https://www.zhihu.com/equation?tex=I_u%28f%29)，插值区间为![[公式]](https://www.zhihu.com/equation?tex=%5B-1%2C1%5D)时，只有被插值函数在下图这个区域内解析时，插值函数![[公式]](https://www.zhihu.com/equation?tex=I_u%28f%29)才会在插值节点的个数趋近于无穷时趋近于被插值函数![[公式]](https://www.zhihu.com/equation?tex=f%28x%29).

![img](https://pic4.zhimg.com/80/v2-f247f9de401dc00f829be088fe7c0963_1440w.jpg)

所以造成Runge现象的根本原因是，被插值函数的解析区域过小。上面的龙格函数虽然在实数域上有任意阶导数，但在![[公式]](https://www.zhihu.com/equation?tex=x%3D%5Cpm+0.2i) 处是不解析的，因此造成了龙格现象。关于这部分的内容，可以参考LNT的新书[Approximation Theory and Approximation Practice, Extended Edition](https://link.zhihu.com/?target=http%3A//people.maths.ox.ac.uk/trefethen/ATAP)(SIAM 2020)，这本书的全部内容可以由m文件差生，所有的m文件可以从网上下载到网址是：

[Approximation Theory and Approximation Practicepeople.maths.ox.ac.uk/trefethen/ATAP/](https://link.zhihu.com/?target=http%3A//people.maths.ox.ac.uk/trefethen/ATAP/)

下面这个例子，我们使用均匀节点对正弦函数![[公式]](https://www.zhihu.com/equation?tex=%5Csin%28%5Cpi+x%29)进行插值，可以看到插值多项式的次数越高，插值效果越好。







## **插值节点选取**

不同的插值节点，对被插值函数的要求不一样。比如，使用高斯节点或者切比雪夫节点作为插值节点进行插值，效果就会好的多。下面的图就是以第二类切比雪夫点为插值节点对龙格函数进行多项式插值的效果，可以看到龙格现象消失了，这是因为，使用切比雪夫点作为插值节点，只需要函数在包含插值区间的区域内解析就可以了。





## **代码**

[代码在点这里github.com/mathknow/code/blob/master/runge.m](https://link.zhihu.com/?target=https%3A//github.com/mathknow/code/blob/master/runge.m)





[参考文献]：[Approximation Theory and Approximation Practice, Extended Edition](https://link.zhihu.com/?target=http%3A//people.maths.ox.ac.uk/trefethen/ATAP)(SIAM 2020)



发布于 2020-05-07 15:14

数值分析

插值

数值计算